(function () {
    "use strict";

    const api = window.CTCP;
    const root = document.querySelector("[data-task-detail]");
    if (!root) return;

    const taskId = Number(new URLSearchParams(location.search).get("taskId"));
    const statusNames = {
        open: "待接取",
        accepted: "已接取",
        delivered: "已送达",
        completed: "已完成"
    };
    const statusClass = {
        open: "availability-badge waiting",
        accepted: "availability-badge ongoing",
        delivered: "availability-badge ongoing",
        completed: "availability-badge done"
    };
    let task = null;
    let currentUser = null;

    function render() {
        const statusText = statusNames[task.status] || task.status;
        const cls = statusClass[task.status] || "availability-badge";
        const isOwner = currentUser && Number(currentUser.id) === Number(task.publisherId);

        let actionHtml = "";
        if (task.status === "open" && currentUser && !isOwner) {
            actionHtml = `
                <div class="detail-actions">
                    <button class="primary-action" type="button" data-action="accept">🤝 接取任务</button>
                    <a class="secondary-action" href="task-hall.jsp">再看看</a>
                </div>
                <p class="detail-footnote">💡 发布者本人看不到「接取」按钮 · 接取后变为「标记送达」</p>`;
        } else if (task.status === "accepted" && currentUser && !isOwner) {
            actionHtml = `
                <div class="detail-actions">
                    <button class="primary-action" type="button" style="background:#faad14;" data-action="deliver">🚚 标记送达</button>
                    <a class="secondary-action" href="task-hall.jsp">返回列表</a>
                </div>
                <p class="detail-footnote">💡 送达后等待发布者确认完成</p>`;
        } else if (task.status === "delivered" && currentUser && isOwner) {
            actionHtml = `
                <div class="detail-actions">
                    <button class="primary-action" type="button" style="background:#52c41a;" data-action="complete">✅ 确认完成</button>
                    <a class="secondary-action" href="task-hall.jsp">返回列表</a>
                </div>
                <p class="detail-footnote">💡 确认后任务将变为「已完成」</p>`;
        } else if (task.status === "completed") {
            actionHtml = `
                <div class="detail-actions">
                    <button class="primary-action" type="button" disabled style="background:#d9d9d9;color:#999;">✅ 已完成</button>
                    <a class="secondary-action" href="task-hall.jsp">返回列表</a>
                </div>`;
        } else if (task.status === "open" && isOwner) {
            actionHtml = `
                <div class="detail-actions">
                    <button class="primary-action" type="button" disabled style="background:#d9d9d9;color:#999;">⏳ 等待接取</button>
                    <a class="secondary-action" href="task-hall.jsp">返回列表</a>
                </div>
                <p class="detail-footnote">💡 你发布了这个任务，等待其他同学接取</p>`;
        } else if (!currentUser) {
            const next = encodeURIComponent(`task-detail.jsp?taskId=${taskId}`);
            actionHtml = `
                <div class="detail-actions">
                    <a class="primary-action" href="${api.pageUrl(`index.jsp?next=${next}`)}">登录后接取 →</a>
                    <a class="secondary-action" href="task-hall.jsp">返回列表</a>
                </div>`;
        } else {
            actionHtml = `
                <div class="detail-actions">
                    <button class="primary-action" type="button" disabled style="background:#d9d9d9;color:#999;">当前状态不可操作</button>
                    <a class="secondary-action" href="task-hall.jsp">返回列表</a>
                </div>`;
        }

        root.innerHTML = `
            <div class="detail-media-column">
                <div class="detail-media detail-media--task">
                    <span class="detail-media__label">跑腿任务</span>
                    <span class="detail-media__emoji" aria-hidden="true">📦</span>
                    <span class="detail-media__spark detail-media__spark--one" aria-hidden="true">✦</span>
                    <span class="detail-media__spark detail-media__spark--two" aria-hidden="true">✧</span>
                    <span class="detail-media__circle detail-media__circle--one" aria-hidden="true"></span>
                    <span class="detail-media__circle detail-media__circle--two" aria-hidden="true"></span>
                </div>
                <div class="detail-note">
                    <span class="detail-note__icon">☼</span>
                    <p><strong>校园互助</strong><br><span>接取后请及时联系发布者</span></p>
                </div>
            </div>
            <article class="detail-panel">
                <div class="detail-status-row">
                    <span class="detail-tag detail-tag--category">跑腿</span>
                    <span class="${cls}">● ${statusText}</span>
                </div>
                <h2>${api.escapeHtml(task.title)}</h2>
                <p class="detail-subtitle">发布者：${api.escapeHtml(task.publisherName || "校园同学")} · 发布时间：${api.shortTime(task.createdAt)}</p>
                <div class="detail-price"><small>￥</small><strong>${api.money(task.amount)}</strong><span>跑腿费 · 仅作信息记录</span></div>
                <div class="detail-divider"></div>
                <dl class="detail-facts">
                    <div><dt>📍 取件地点</dt><dd>${api.escapeHtml(task.pickup || "待定")}</dd></div>
                    <div><dt>📍 送达地点</dt><dd>${api.escapeHtml(task.delivery || "待定")}</dd></div>
                    <div><dt>⏰ 截止时间</dt><dd>${task.deadline ? api.shortTime(task.deadline) : "无截止时间"}</dd></div>
                    <div><dt>💰 跑腿金额</dt><dd style="color:#f5222d;">${api.money(task.amount)} 元</dd></div>
                    <div><dt>📞 联系方式</dt><dd>${api.escapeHtml(task.contact || "未填写")}</dd></div>
                    <div><dt>发布者</dt><dd class="seller-detail"><span class="avatar avatar--tiny">${api.initial(task.publisherName)}</span>${api.escapeHtml(task.publisherName || "校园同学")}</dd></div>
                </dl>
                <div class="detail-description">
                    <h3>📝 任务说明</h3>
                    <p>${api.escapeHtml(task.description || "暂无任务说明")}</p>
                </div>
                ${actionHtml}
            </article>`;

        const acceptBtn = root.querySelector("[data-action='accept']");
        if (acceptBtn) acceptBtn.addEventListener("click", () => accept());

        const deliverBtn = root.querySelector("[data-action='deliver']");
        if (deliverBtn) deliverBtn.addEventListener("click", () => deliver());

        const completeBtn = root.querySelector("[data-action='complete']");
        if (completeBtn) completeBtn.addEventListener("click", () => complete());
    }

    async function accept() {
        const button = root.querySelector("[data-action='accept']");
        if (!confirm(`确认接取“${task.title}”吗？\n接取后请及时联系发布者。`)) return;
        api.setLoading(button, true, "正在接取...");
        try {
            await api.request(`/tasks/${taskId}/accept`, { method: "POST" });
            api.toast("接取成功！", "success");
            await load();
        } catch (error) {
            api.toast(error.message || "接取失败，请稍后重试", "error");
            api.setLoading(button, false);
        }
    }

    async function deliver() {
        const button = root.querySelector("[data-action='deliver']");
        if (!confirm(`确认已送达“${task.title}”吗？\n送达后将等待发布者确认完成。`)) return;
        api.setLoading(button, true, "正在确认送达...");
        try {
            await api.request(`/tasks/${taskId}/deliver`, { method: "PUT" });
            api.toast("已标记送达！", "success");
            await load();
        } catch (error) {
            api.toast(error.message || "操作失败，请稍后重试", "error");
            api.setLoading(button, false);
        }
    }

    async function complete() {
        const button = root.querySelector("[data-action='complete']");
        if (!confirm(`确认完成“${task.title}”吗？\n确认后任务将变为已完成。`)) return;
        api.setLoading(button, true, "正在确认完成...");
        try {
            await api.request(`/tasks/${taskId}/complete`, { method: "PUT" });
            api.toast("任务已完成！", "success");
            await load();
        } catch (error) {
            api.toast(error.message || "操作失败，请稍后重试", "error");
            api.setLoading(button, false);
        }
    }

    async function load() {
        if (!Number.isInteger(taskId) || taskId < 1) {
            root.innerHTML = `<div class="empty-state empty-state--error"><h3>任务编号无效</h3><a href="${api.pageUrl("task-hall.jsp")}">返回任务列表</a></div>`;
            return;
        }
        try {
            const [taskResult, userResult] = await Promise.all([
                api.request(`/public/tasks/${taskId}`),
                api.currentUser().catch(() => null)
            ]);
            task = taskResult;
            currentUser = userResult;
            render();
        } catch (error) {
            root.innerHTML = `<div class="empty-state empty-state--error"><span>!</span><h3>任务详情加载失败</h3><p>${api.escapeHtml(error.message)}</p><a href="${api.pageUrl("task-hall.jsp")}">返回任务列表</a></div>`;
        }
    }

    load();
})();