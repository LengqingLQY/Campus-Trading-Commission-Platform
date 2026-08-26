<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/base.css">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/product.css">
    <title>CTCP · 商品详情</title>
</head>
<body class="app-page app-page--secondhand">
<div class="app-layout">
    <jsp:include page="sidebar.jsp" />

    <main class="workspace product-page-workspace">
        <header class="workspace__topbar product-page-topbar">
            <div>
                <span class="workspace__kicker">SECOND-HAND · PRODUCT DETAIL</span>
                <h1>商品详情</h1>
            </div>
            <div class="workspace__actions">
                <a class="back-link" href="secondhand.jsp">← 返回商品列表</a>
                <a class="profile-chip market-publish-button" href="product-publish.jsp">
                    <span aria-hidden="true">＋</span>
                    <span>发布商品</span>
                </a>
            </div>
        </header>

        <section class="product-detail-layout" aria-label="商品详情内容">
            <div class="detail-media-column">
                <div class="detail-media detail-media--book">
                    <span class="detail-media__label">图书教材</span>
                    <span class="detail-media__emoji" aria-hidden="true">📚</span>
                    <span class="detail-media__spark detail-media__spark--one" aria-hidden="true">✦</span>
                    <span class="detail-media__spark detail-media__spark--two" aria-hidden="true">✧</span>
                    <span class="detail-media__circle detail-media__circle--one" aria-hidden="true"></span>
                    <span class="detail-media__circle detail-media__circle--two" aria-hidden="true"></span>
                </div>

                <div class="detail-note">
                    <span class="detail-note__icon" aria-hidden="true">☼</span>
                    <p><strong>校园友好交易</strong><br><span>建议在公共区域当面交接</span></p>
                </div>
            </div>

            <article class="detail-panel">
                <div class="detail-status-row">
                    <span class="detail-tag detail-tag--category">图书教材</span>
                    <span class="availability-badge">在售</span>
                </div>

                <h2>考研数学复习全书</h2>
                <p class="detail-subtitle">认真整理过的复习资料，留给下一位正在努力的同学。</p>

                <div class="detail-price"><small>￥</small><strong>35</strong><span>价格仅作信息记录</span></div>

                <div class="detail-divider"></div>

                <dl class="detail-facts">
                    <div>
                        <dt>商品成色</dt>
                        <dd><span class="detail-tag detail-tag--condition">几乎全新</span></dd>
                    </div>
                    <div>
                        <dt>交易地点</dt>
                        <dd>⌖ 紫金公寓 2 号楼下</dd>
                    </div>
                    <div>
                        <dt>发布时间</dt>
                        <dd>2026-08-21 14:30</dd>
                    </div>
                    <div>
                        <dt>联系方式</dt>
                        <dd>QQ：10001</dd>
                    </div>
                    <div>
                        <dt>卖家</dt>
                        <dd class="seller-detail"><span class="avatar avatar--tiny">艾</span>小艾</dd>
                    </div>
                </dl>

                <div class="detail-description">
                    <h3>商品描述</h3>
                    <p>只做了前三章，其余全新，无笔记无划线。适合准备考研数学的同学使用。</p>
                </div>

                <div class="detail-actions">
                    <button class="primary-action" type="button">
                        <span>立即购买</span>
                        <span aria-hidden="true">→</span>
                    </button>
                    <a class="secondary-action" href="secondhand.jsp">再看看</a>
                </div>
                <p class="detail-footnote">购买后由买卖双方在线下联系和交接，本页面暂不接入真实支付。</p>
            </article>
        </section>
    </main>
</div>
</body>
</html>
