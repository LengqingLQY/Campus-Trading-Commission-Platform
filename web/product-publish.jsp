<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/base.css">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/product.css">
    <title>CTCP · 发布商品</title>
</head>
<body class="app-page app-page--secondhand">
<div class="app-layout">
    <jsp:include page="sidebar.jsp" />

    <main class="workspace product-page-workspace">
        <header class="workspace__topbar product-page-topbar">
            <div>
                <span class="workspace__kicker">SECOND-HAND · LIST AN ITEM</span>
                <h1>发布一件二手好物</h1>
            </div>
            <div class="workspace__actions">
                <a class="back-link" href="secondhand.jsp">← 返回商品列表</a>
            </div>
        </header>

        <section class="publish-layout" aria-label="发布商品内容">
            <section class="publish-card">
                <div class="section-heading">
                    <span class="section-heading__number">01</span>
                    <div>
                        <h2>填写商品信息</h2>
                        <p>把物品的真实情况告诉下一位同学</p>
                    </div>
                </div>

                <form class="publish-form">
                    <div class="publish-form-grid">
                        <div class="form-field form-field--full">
                            <label for="product-title">商品标题</label>
                            <input type="text" id="product-title" name="title" placeholder="例如：九成新高等数学教材">
                        </div>

                        <div class="form-field">
                            <label for="product-category">商品分类</label>
                            <select id="product-category" name="category">
                                <option value="book">图书教材</option>
                                <option value="electronic">电子数码</option>
                                <option value="daily">生活日用</option>
                                <option value="clothing">服饰鞋帽</option>
                                <option value="sports">运动户外</option>
                                <option value="other">其他</option>
                            </select>
                        </div>

                        <div class="form-field">
                            <label for="product-condition">商品成色</label>
                            <select id="product-condition" name="condition">
                                <option value="new">全新</option>
                                <option value="almost_new">几乎全新</option>
                                <option value="good" selected>成色良好</option>
                                <option value="fair">有使用痕迹</option>
                            </select>
                        </div>

                        <div class="form-field">
                            <label for="product-price">商品价格 <span>元</span></label>
                            <div class="field-with-prefix">
                                <span>￥</span>
                                <input type="number" id="product-price" name="price" placeholder="0.00" step="0.01" min="0">
                            </div>
                        </div>

                        <div class="form-field">
                            <label for="product-location">交易地点</label>
                            <input type="text" id="product-location" name="location" placeholder="例如：紫金公寓 2 号楼下">
                        </div>

                        <div class="form-field form-field--full">
                            <label for="product-contact">联系方式</label>
                            <input type="text" id="product-contact" name="contact" placeholder="QQ、微信或其他方便联系的方式">
                        </div>

                        <div class="form-field form-field--full">
                            <label for="product-description">商品描述</label>
                            <textarea id="product-description" name="description" rows="5" placeholder="介绍使用情况、尺寸、配件和需要特别说明的地方"></textarea>
                        </div>
                    </div>

                    <div class="publish-hint">
                        <span class="publish-hint__icon" aria-hidden="true">✦</span>
                        <p><strong>发布小提示</strong><br><span>请如实描述商品。提交后会进入待审核状态，审核通过后才会展示在二手交易列表。</span></p>
                    </div>

                    <label class="publish-agreement" for="publish-agreement">
                        <input type="checkbox" id="publish-agreement" name="agreement">
                        <span>我确认发布内容真实有效，并同意在线下完成交易交接</span>
                    </label>

                    <div class="publish-actions">
                        <a class="secondary-action" href="secondhand.jsp">取消</a>
                        <button class="primary-action" type="button">
                            <span>提交审核</span>
                            <span aria-hidden="true">→</span>
                        </button>
                    </div>
                </form>
            </section>

            <aside class="publish-aside">
                <div class="publish-preview-card">
                    <div class="publish-preview-card__head">
                        <span>发布预览</span>
                        <span class="preview-dots" aria-hidden="true">•••</span>
                    </div>
                    <div class="publish-preview-visual">
                        <span class="publish-preview-visual__emoji" aria-hidden="true">✿</span>
                        <span class="publish-preview-visual__hint">商品视觉展示位</span>
                    </div>
                    <span class="preview-tag">待填写分类</span>
                    <h3>你的商品标题</h3>
                    <p>填写描述后，这里会显示商品简介。</p>
                    <div class="preview-footer">
                        <strong>￥ 0.00</strong>
                        <span>待审核</span>
                    </div>
                </div>

                <div class="publish-process">
                    <h3>发布流程</h3>
                    <ol>
                        <li><span>01</span><p>填写商品基本信息</p></li>
                        <li><span>02</span><p>提交后等待管理员审核</p></li>
                        <li><span>03</span><p>审核通过后展示为在售</p></li>
                    </ol>
                </div>
            </aside>
        </section>
    </main>
</div>
</body>
</html>
