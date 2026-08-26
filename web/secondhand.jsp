<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/base.css">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/secondhand.css">
    <title>CTCP · 二手交易</title>
</head>
<body class="app-page app-page--secondhand">
<div class="app-layout">
    <jsp:include page="sidebar.jsp" />

    <main class="workspace market-workspace">
        <header class="workspace__topbar market-topbar">
            <div>
                <span class="workspace__kicker">SECOND-HAND · CAMPUS MARKET</span>
                <h1>二手交易 <span class="heading-note">让闲置再次发光</span></h1>
            </div>
            <div class="workspace__actions">
                <div class="market-counter">
                    <strong>06</strong>
                    <span>今日好物</span>
                </div>
                <a class="profile-chip market-publish-button" href="product-publish.jsp">
                    <span class="plus-symbol" aria-hidden="true">＋</span>
                    <span>发布商品</span>
                </a>
            </div>
        </header>

        <section class="market-content" aria-label="二手商品展示区域">
            <div class="market-banner">
                <div class="banner-copy">
                    <span class="banner-label">校园闲置小集 · CAMPUS MARKET</span>
                    <h2>好物不闲置，<br><em>刚好遇见你。</em></h2>
                    <p>把用不到的物品留给下一位需要它的同学，轻松、友好，就在校园里完成交易。</p>
                    <div class="banner-meta">
                        <span>● 校园内见面交易</span>
                        <span>● 价格仅作信息记录</span>
                    </div>
                </div>
                <div class="banner-art" aria-hidden="true">
                    <div class="art-ring art-ring--large"></div>
                    <div class="art-ring art-ring--small"></div>
                    <div class="art-card art-card--book">📚</div>
                    <div class="art-card art-card--ball">🏀</div>
                    <span class="art-spark art-spark--one">✦</span>
                    <span class="art-spark art-spark--two">✧</span>
                    <span class="art-dot art-dot--one"></span>
                    <span class="art-dot art-dot--two"></span>
                </div>
            </div>

            <div class="market-tools">
                <div class="market-search">
                    <span class="search-icon" aria-hidden="true">⌕</span>
                    <input type="search" placeholder="搜索商品标题或描述" aria-label="搜索商品标题或描述">
                </div>
                <div class="market-sort" aria-label="商品排序">
                    <span class="tool-label">排序</span>
                    <a class="sort-pill sort-pill--active" href="#!">最新发布</a>
                    <a class="sort-pill" href="#!">最早发布</a>
                    <a class="sort-pill" href="#!">价格低 → 高</a>
                    <a class="sort-pill" href="#!">价格高 → 低</a>
                </div>
            </div>

            <div class="category-row" aria-label="商品分类">
                <span class="tool-label">分类</span>
                <a class="category-chip category-chip--active" href="#!">全部</a>
                <a class="category-chip" href="#!">图书教材</a>
                <a class="category-chip" href="#!">电子数码</a>
                <a class="category-chip" href="#!">生活日用</a>
                <a class="category-chip" href="#!">服饰鞋帽</a>
                <a class="category-chip" href="#!">运动户外</a>
                <a class="category-chip" href="#!">其他</a>
            </div>

            <div class="listing-head">
                <div>
                    <h2>校园好物</h2>
                    <p>已审核的闲置物品，会在这里与同学见面</p>
                </div>
                <span class="listing-count">共 4 件</span>
            </div>

            <div class="product-grid">
                <article class="product-card product-card--book">
                    <a class="product-card__link" href="product-detail.jsp?productId=1" aria-label="查看考研数学复习全书">
                        <div class="product-visual product-visual--mint">
                            <span class="visual-label">图书教材</span>
                            <span class="product-emoji" aria-hidden="true">📚</span>
                            <span class="visual-doodle visual-doodle--book" aria-hidden="true">✦</span>
                        </div>
                        <div class="product-info">
                            <div class="product-tags">
                                <span class="category-tag">图书教材</span>
                                <span class="condition-tag">几乎全新</span>
                            </div>
                            <h3>考研数学复习全书</h3>
                            <p class="product-description">只做了前三章，其余全新，无笔记无划线。</p>
                            <div class="product-meta">
                                <span>⌖ 紫金公寓 2 号楼下</span>
                                <span>5 天前</span>
                            </div>
                            <div class="product-footer">
                                <div class="product-price"><small>￥</small><strong>35</strong></div>
                                <span class="seller-name">小艾发布</span>
                            </div>
                        </div>
                    </a>
                </article>

                <article class="product-card product-card--sold">
                    <a class="product-card__link" href="product-detail.jsp?productId=2" aria-label="查看罗技无线鼠标 M170">
                        <div class="product-visual product-visual--sky">
                            <span class="visual-label">电子数码</span>
                            <span class="product-emoji" aria-hidden="true">🖱️</span>
                            <span class="sale-badge">已售出</span>
                        </div>
                        <div class="product-info">
                            <div class="product-tags">
                                <span class="category-tag">电子数码</span>
                                <span class="condition-tag">成色良好</span>
                            </div>
                            <h3>罗技无线鼠标 M170</h3>
                            <p class="product-description">用了半年，功能完好，送一节新电池。</p>
                            <div class="product-meta">
                                <span>⌖ 计算机实验楼门口</span>
                                <span>4 天前</span>
                            </div>
                            <div class="product-footer">
                                <div class="product-price"><small>￥</small><strong>45</strong></div>
                                <span class="seller-name">小博发布</span>
                            </div>
                        </div>
                    </a>
                </article>

                <article class="product-card product-card--sports">
                    <a class="product-card__link" href="product-detail.jsp?productId=5" aria-label="查看斯伯丁篮球">
                        <div class="product-visual product-visual--peach">
                            <span class="visual-label">运动户外</span>
                            <span class="product-emoji" aria-hidden="true">🏀</span>
                            <span class="visual-doodle visual-doodle--ball" aria-hidden="true">↗</span>
                        </div>
                        <div class="product-info">
                            <div class="product-tags">
                                <span class="category-tag">运动户外</span>
                                <span class="condition-tag">成色良好</span>
                            </div>
                            <h3>斯伯丁篮球</h3>
                            <p class="product-description">打了几次，气足，室外场耐磨款。</p>
                            <div class="product-meta">
                                <span>⌖ 体育馆篮球场</span>
                                <span>1 天前</span>
                            </div>
                            <div class="product-footer">
                                <div class="product-price"><small>￥</small><strong>60</strong></div>
                                <span class="seller-name">小博发布</span>
                            </div>
                        </div>
                    </a>
                </article>

                <article class="product-card product-card--clothing">
                    <a class="product-card__link" href="product-detail.jsp?productId=6" aria-label="查看冬季加厚外套 全新">
                        <div class="product-visual product-visual--lemon">
                            <span class="visual-label">服饰鞋帽</span>
                            <span class="product-emoji" aria-hidden="true">🧥</span>
                            <span class="visual-doodle visual-doodle--coat" aria-hidden="true">♡</span>
                        </div>
                        <div class="product-info">
                            <div class="product-tags">
                                <span class="category-tag">服饰鞋帽</span>
                                <span class="condition-tag condition-tag--new">全新</span>
                            </div>
                            <h3>冬季加厚外套 · 全新</h3>
                            <p class="product-description">买大了一码，吊牌还在，L 码。</p>
                            <div class="product-meta">
                                <span>⌖ 紫金公寓 7 号楼下</span>
                                <span>5 小时前</span>
                            </div>
                            <div class="product-footer">
                                <div class="product-price"><small>￥</small><strong>80</strong></div>
                                <span class="seller-name">小卡发布</span>
                            </div>
                        </div>
                    </a>
                </article>
            </div>
        </section>
    </main>
</div>
</body>
</html>
