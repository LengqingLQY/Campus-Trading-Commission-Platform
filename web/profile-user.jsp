<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/base.css">
    <link rel="stylesheet" href="css/main.css">
    <title>个人空间 · CTCP</title>
</head>
<body class="app-page app-page--profile">
<div class="app-layout">
    <jsp:include page="sidebar.jsp" />

    <main class="workspace">
        <header class="workspace__topbar">
            <div>
                <span class="workspace__kicker">PROFILE · PERSONAL SPACE</span>
                <h1>个人空间</h1>
            </div>
            <div class="workspace__actions">
                <button class="profile-chip" type="button">
                    <span class="avatar avatar--small">A</span>
                    <span>我的空间</span>
                </button>
            </div>
        </header>

        <section class="profile-content">

            <!-- ===== 个人信息卡片 ===== -->
            <div class="profile-info-card">
                <div class="profile-avatar-row">
                    <span class="avatar avatar--large">A</span>
                    <div>
                        <strong class="profile-name">爱丽丝</strong>
                        <span class="profile-role">普通用户</span>
                        <p class="profile-contact">QQ：10001 &nbsp;|&nbsp; 微信：wx_alice &nbsp;|&nbsp; 电话：138****0001</p>
                    </div>
                </div>

                <form class="profile-edit-form">
                    <div class="form-row">
                        <div class="form-field">
                            <label for="edit-username">用户名</label>
                            <input type="text" id="edit-username" value="爱丽丝">
                        </div>
                        <div class="form-field">
                            <label for="edit-qq">QQ</label>
                            <input type="text" id="edit-qq" value="10001">
                        </div>
                        <div class="form-field">
                            <label for="edit-wechat">微信</label>
                            <input type="text" id="edit-wechat" value="wx_alice">
                        </div>
                        <div class="form-field">
                            <label for="edit-phone">电话</label>
                            <input type="text" id="edit-phone" value="13800000001">
                        </div>
                        <div class="form-field form-field--full">
                            <label for="edit-password">重置密码</label>
                            <input type="password" id="edit-password" placeholder="输入新密码（不填则不修改）">
                        </div>
                    </div>
                    <div class="form-actions">
                        <button class="primary-action" type="button">💾 保存修改</button>
                        <a class="secondary-action" href="#!">取消</a>
                    </div>
                    <p class="security-hint">🔒 密码使用哈希存储，不显示明文</p>
                </form>
            </div>

            <!-- ===== 我的记录 ===== -->
            <div class="profile-records-card">
                <div class="records-header">
                    <h2>📋 我的记录</h2>
                    <span>我发布的 · 我接取的 · 我购买的</span>
                </div>

                <div class="records-tabs">
                    <a class="tab active" href="#!">📦 我发布的</a>
                    <a class="tab" href="#!">🏃 我接取的</a>
                    <a class="tab" href="#!">🛒 我购买的</a>
                </div>

                <!-- ===== Tab 1：我发布的 ===== -->
                <div class="records-list">

                    <div class="record-section-label">📌 跑腿任务</div>

                    <div class="record-item">
                        <div>
                            <span class="record-title">帮取南区快递</span>
                            <span class="status-tag">已接取</span>
                            <p class="record-meta">接取人：鲍勃 · 金额：5.00 元</p>
                        </div>
                        <span class="record-date">2026-08-24</span>
                    </div>

                    <div class="record-item">
                        <div>
                            <span class="record-title">图书馆送奶茶</span>
                            <span class="status-tag status-tag--pending">审核中</span>
                            <p class="record-meta">暂无接取人 · 金额：8.00 元</p>
                        </div>
                        <span class="record-date">2026-08-25</span>
                    </div>

                    <div class="record-item">
                        <div>
                            <span class="record-title">代拿药品（校医院）</span>
                            <span class="status-tag status-tag--done">已完成</span>
                            <p class="record-meta">接取人：鲍勃 · 金额：6.00 元</p>
                        </div>
                        <span class="record-date">2026-08-23</span>
                    </div>

                    <div class="record-section-label">📌 二手商品</div>

                    <div class="record-item">
                        <div>
                            <span class="record-title">考研数学复习全书</span>
                            <span class="status-tag status-tag--done">已售出</span>
                            <p class="record-meta">购买人：卡罗尔 · 价格：35.00 元</p>
                        </div>
                        <span class="record-date">2026-08-23</span>
                    </div>

                    <div class="record-item">
                        <div>
                            <span class="record-title">宿舍护眼小台灯</span>
                            <span class="status-tag status-tag--pending">审核中</span>
                            <p class="record-meta">价格：15.00 元</p>
                        </div>
                        <span class="record-date">2026-08-25</span>
                    </div>

                </div>

                <div class="records-footer">
                    <span>📊 共 5 条记录</span>
                    <span>点击记录可跳转详情</span>
                </div>

                <!-- 其他 Tab 占位说明 -->
                <div class="records-tab-hint">
                    <span>💡 Tab2「我接取的」：展示 accepter_id = 当前用户 的任务</span>
                    <span>💡 Tab3「我购买的」：展示 buyer_id = 当前用户 的商品</span>
                </div>
            </div>

        </section>
    </main>
</div>
</body>
</html>