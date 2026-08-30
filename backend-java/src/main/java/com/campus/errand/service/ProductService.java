package com.campus.errand.service;

import com.campus.errand.dao.ProductDAO;
import com.campus.errand.dao.ProductOrderDAO;
import com.campus.errand.dto.PageResult;
import com.campus.errand.dto.ProductCreateDTO;
import com.campus.errand.exception.BizException;
import com.campus.errand.pojo.Product;
import com.campus.errand.pojo.ProductOrder;
import com.campus.errand.pojo.ProductOrderDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;
import java.util.Set;

/**
 * 二手商品业务逻辑。结构与任务平行。
 */
@Service
public class ProductService {

    /** 排序白名单（设计说明书 §3.7）。 */
    private static final Map<String, String> PRODUCT_ORDER = Map.of(
            "time_desc",  "t.created_at DESC",
            "time_asc",   "t.created_at ASC",
            "price_desc", "t.price DESC",
            "price_asc",  "t.price ASC"
    );

    /** 分类 / 成色枚举（数据字典，接口传英文码）。 */
    private static final Set<String> CATEGORIES =
            Set.of("book", "electronic", "daily", "clothing", "sports", "other");
    private static final Set<String> CONDITIONS =
            Set.of("new", "almost_new", "good", "fair");

    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private ProductOrderDAO productOrderDAO;

    public PageResult<Product> listProducts(String keyword, String sort, int page, int size) {
        if (page < 1) {
            throw new BizException(400, "page 不能小于 1");
        }
        if (size < 1 || size > 50) {
            throw new BizException(400, "size 需在 1~50 之间");
        }
        String orderBy = PRODUCT_ORDER.getOrDefault(sort, "t.created_at DESC");
        int offset = (page - 1) * size;
        return new PageResult<>(
                productDAO.findPublic(keyword, orderBy, offset, size),
                productDAO.countPublic(keyword),
                page, size);
    }

    /**
     * 商品详情。卖家本人额外返回 auditStatus/auditRemark。
     */
    public Product getProduct(int id, Integer currentUserId) {
        Product product = productDAO.findPublicDetail(id);
        if (product == null) {
            throw new BizException(404, "商品不存在");
        }
        if (currentUserId == null || !currentUserId.equals(product.getSellerId())) {
            product.setAuditStatus(null);
            product.setAuditRemark(null);
        }
        return product;
    }

    /**
     * 发布商品。sellerId 从 session 取得，落库 audit_status='approved'、status='on_sale'。
     */
    public int createProduct(ProductCreateDTO dto, int sellerId) {
        if (dto.getTitle() == null || dto.getTitle().trim().isEmpty()) {
            throw new BizException(400, "标题不能为空");
        }

        String category = dto.getCategory() == null ? "other" : dto.getCategory();
        if (!CATEGORIES.contains(category)) {
            throw new BizException(400, "分类不合法");
        }
        String condition = dto.getCondition() == null ? "good" : dto.getCondition();
        if (!CONDITIONS.contains(condition)) {
            throw new BizException(400, "成色不合法");
        }
        Double price = dto.getPrice();
        if (price != null && price < 0) {
            throw new BizException(400, "价格不能为负数");
        }

        Product product = new Product();
        product.setSellerId(sellerId);
        product.setTitle(dto.getTitle());
        product.setDescription(dto.getDescription() == null ? "" : dto.getDescription());
        product.setCategory(category);
        product.setCondition(condition);
        product.setPrice(price == null ? 0.0 : price);
        product.setLocation(dto.getLocation() == null ? "" : dto.getLocation());
        product.setContact(dto.getContact() == null ? "" : dto.getContact());
        return productDAO.insert(product);
    }

    /**
     * 购买商品（三层防护，事务内）：校验可见且非自己发布 →
     * UPDATE ... WHERE status='on_sale' → INSERT 购买记录（UNIQUE/CHECK 兜底）。
     */
    @Transactional
    public int buyProduct(int productId, int currentUserId) {
        Product product = productDAO.findById(productId);
        if (product == null || (product.getIsDeleted() != null && product.getIsDeleted() == 1)
                || !"approved".equals(product.getAuditStatus())) {
            throw new BizException(404, "商品不存在");
        }
        if (product.getSellerId() != null && product.getSellerId() == currentUserId) {
            throw new BizException(403, "不能购买自己的商品");
        }

        int rows = productDAO.markSold(productId);
        if (rows == 0) {
            throw new BizException(409, "商品已售出");
        }
        return productOrderDAO.insert(productId, product.getSellerId(), currentUserId, product.getPrice());
    }

    /**
     * 查看二手订单：仅订单买家和卖家，viewerRole 由 session 判定（契约 §8.5）。
     */
    public ProductOrderDetail getProductOrder(int orderId, int currentUserId) {
        ProductOrderDetail detail = productOrderDAO.findDetail(orderId);
        if (detail == null) {
            throw new BizException(404, "订单不存在");
        }
        if (detail.getSellerId() != null && detail.getSellerId() == currentUserId) {
            detail.setViewerRole("seller");
        } else if (detail.getBuyerId() != null && detail.getBuyerId() == currentUserId) {
            detail.setViewerRole("buyer");
        } else {
            throw new BizException(403, "无权限查看该订单");
        }
        return detail;
    }

    /**
     * 卖家确认交付（事务内）：仅卖家、且订单 created -> delivered。
     * 带状态条件的 UPDATE，行数 0 时返回 409。
     */
    @Transactional
    public void deliverProductOrder(int orderId, int currentUserId) {
        ProductOrder order = productOrderDAO.findById(orderId);
        if (order == null) {
            throw new BizException(404, "订单不存在");
        }
        if (order.getSellerId() == null || order.getSellerId() != currentUserId) {
            throw new BizException(403, "只有卖家可以确认交付");
        }
        int rows = productOrderDAO.markDelivered(orderId, currentUserId);
        if (rows == 0) {
            throw new BizException(409, "当前状态不允许该操作");
        }
    }

    /**
     * 买家确认收货（事务内）：仅买家、且订单 delivered -> completed，
     * 同时商品 sold -> completed。订单与商品任一更新失败都整体回滚。
     */
    @Transactional
    public void completeProductOrder(int orderId, int currentUserId) {
        ProductOrder order = productOrderDAO.findById(orderId);
        if (order == null) {
            throw new BizException(404, "订单不存在");
        }
        if (order.getBuyerId() == null || order.getBuyerId() != currentUserId) {
            throw new BizException(403, "只有买家可以确认收货");
        }
        int rows = productOrderDAO.markCompleted(orderId, currentUserId);
        if (rows == 0) {
            throw new BizException(409, "当前状态不允许该操作");
        }
        productDAO.markCompleted(order.getProductId());
    }

    /**
     * 个人空间：我的商品。type=published（默认）/bought，非法值返回 400。
     */
    public PageResult<Product> myProducts(int userId, String type, int page, int size) {
        if (page < 1) {
            throw new BizException(400, "page 不能小于 1");
        }
        if (size < 1 || size > 50) {
            throw new BizException(400, "size 需在 1~50 之间");
        }
        int offset = (page - 1) * size;
        String t = type == null ? "published" : type;
        if ("published".equals(t)) {
            return new PageResult<>(
                    productDAO.findPublishedByUser(userId, offset, size),
                    productDAO.countPublishedByUser(userId), page, size);
        }
        if ("bought".equals(t)) {
            return new PageResult<>(
                    productDAO.findBoughtByUser(userId, offset, size),
                    productDAO.countBoughtByUser(userId), page, size);
        }
        throw new BizException(400, "type 不合法");
    }
}
