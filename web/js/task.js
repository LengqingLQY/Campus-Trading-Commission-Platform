(function () {
    "use strict";

    const api = window.CTCP;
    const root = document.querySelector("[data-task-grid]");
    if (!root) return;

    const statusNames = {
        open: "待接取",
        accepted: "已接取",
        delivered: "已送达",
        completed: "已完成"
    };
    const statusClass = {
        open: "",
        accepted: "",
        delivered: "",
        completed: "done"
    };
    const state = { keyword: "", sort: "time_desc", status: "", requestId: 0 };

    function card(item, index) {
        const statusText = statusNames[item.status] || item.status;
        const cls = statusClass[item.status] || "";
        return `
            <article class="product-card product-card--task">
                <a class="product-card__link" href="${api.pageUrl(`task-detail.jsp?taskId=${item.id}`)}">
                    <div class="product-visual product-visual--${["mint", "sky", "peach", "lemon"][index % 4]}">
                        <span class="visual-label">跑腿任务</span>
                        <span class="product-emoji" aria-hidden="true">${index % 2 ? "🏃" : "📦"}</span>
                        <span class="visual-doodle visual-doodle--task" aria-hidden="true">✦</span>
                    </div>
                    <div class="product-info">
                        <div class="product-tags">
                            <span class="category-tag">跑腿</span>
                            <span class="condition-tag ${cls}">${api.escapeHtml(statusText)}</span>
                        </div>
                        <h3>${api.escapeHtml(item.title)}</h3>
                        <p class="product-description">${api.escapeHtml(item.description || "暂无任务说明")}</p>
                        <div class="product-meta">
                            <span>⌖ ${api.escapeHtml(item.pickup || "待定")} → ${api.escapeHtml(item.delivery || "待定")}</span>
                            <span>${item.deadline ? "截止 " + api.shortTime(item.deadline) : "时间待定"}</span>
                        </div>
                        <div class="product-footer">
                            <div class="product-price"><small>￥</small><strong>${api.money(item.amount)}</strong></div>
                            <span class="seller-name">${api.escapeHtml(item.publisherName || "校园同学")}发布</span>
                        </div>
                    </div>
                </a>
            </article>`;
    }

    async function load() {
        const id = ++state.requestId;
        root.innerHTML = `<div class="loading-state"><span class="button-spinner"></span><p>正在加载跑腿任务...</p></div>`;
        try {
            const data = await api.request(`/public/tasks${api.query({
                keyword: state.keyword,
                sort: state.sort,
                page: 1,
                size: 50
            })}`);
            if (id !== state.requestId) return;
            let items = data.list || [];
            if (state.status) {
                items = items.filter((item) => item.status === state.status);
            }
            const total = items.length;
            const openCount = items.filter((item) => item.status === "open").length;
            document.querySelector("[data-task-count-label]").textContent = `共 ${total} 件`;
            document.querySelector("[data-task-count]").textContent = String(openCount).padStart(2, "0");
            root.innerHTML = items.length
                ? items.map(card).join("")
                : `<div class="empty-state"><span>⌕</span><h3>没有匹配的任务</h3><p>换个关键词或状态试试看。</p></div>`;
        } catch (error) {
            if (id !== state.requestId) return;
            root.innerHTML = `<div class="empty-state empty-state--error"><span>!</span><h3>任务暂时加载失败</h3><p>${api.escapeHtml(error.message)}</p><button type="button" data-retry>重新加载</button></div>`;
            const retry = root.querySelector("[data-retry]");
            if (retry) retry.addEventListener("click", load);
        }
    }

    let searchTimer = null;
    const searchInput = document.querySelector("[data-task-search]");
    if (searchInput) {
        searchInput.addEventListener("input", function () {
            clearTimeout(searchTimer);
            searchTimer = setTimeout(() => {
                state.keyword = this.value.trim();
                load();
            }, 320);
        });
    }

    document.querySelectorAll("[data-sort]").forEach((button) => {
        button.addEventListener("click", function (event) {
            event.preventDefault();
            document.querySelectorAll("[data-sort]").forEach((node) => node.classList.remove("sort-pill--active"));
            this.classList.add("sort-pill--active");
            state.sort = this.dataset.sort;
            load();
        });
    });

    document.querySelectorAll("[data-status]").forEach((button) => {
        button.addEventListener("click", function (event) {
            event.preventDefault();
            document.querySelectorAll("[data-status]").forEach((node) => node.classList.remove("category-chip--active"));
            this.classList.add("category-chip--active");
            state.status = this.dataset.status;
            load();
        });
    });

    load();
})();