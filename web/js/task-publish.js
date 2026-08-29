(function () {
    "use strict";

    const api = window.CTCP;
    const form = document.querySelector("[data-task-publish]");
    if (!form) return;

    const button = form.querySelector("button[type='submit']");
    const feedback = form.querySelector("[data-feedback]");

    function updatePreview() {
        const data = new FormData(form);
        const title = String(data.get("title") || "").trim() || "你的任务标题";
        const description = String(data.get("description") || "").trim() || "填写说明后，这里会显示任务简介。";
        const amount = Number(data.get("amount") || 0);
        const deadline = String(data.get("deadline") || "").trim();
        const layout = form.closest(".publish-layout");
        layout.querySelector("[data-preview-title]").textContent = title;
        layout.querySelector("[data-preview-description]").textContent = description;
        layout.querySelector("[data-preview-amount]").textContent = `￥ ${api.money(amount)}`;
        layout.querySelector("[data-preview-deadline]").textContent = deadline ? api.shortTime(deadline.replace("T", " ")) : "时间待定";
    }

    form.addEventListener("input", updatePreview);
    form.addEventListener("change", updatePreview);

    form.addEventListener("submit", async (event) => {
        event.preventDefault();
        api.setFeedback(feedback, "");

        const data = new FormData(form);
        const title = String(data.get("title") || "").trim();
        const pickup = String(data.get("pickup") || "").trim();
        const delivery = String(data.get("delivery") || "").trim();

        if (!title) {
            api.setFeedback(feedback, "请填写任务标题");
            form.querySelector("[name='title']").focus();
            return;
        }
        if (!pickup) {
            api.setFeedback(feedback, "请填写取件地点");
            form.querySelector("[name='pickup']").focus();
            return;
        }
        if (!delivery) {
            api.setFeedback(feedback, "请填写送达地点");
            form.querySelector("[name='delivery']").focus();
            return;
        }
        if (!data.get("agreement")) {
            api.setFeedback(feedback, "请确认发布内容真实有效");
            return;
        }

        let deadline = String(data.get("deadline") || "").trim();
        if (deadline) {
            deadline = deadline.replace("T", " ") + ":00";
        }

        api.setLoading(button, true, "正在发布...");
        try {
            await api.requireUser();
            const result = await api.request("/tasks", {
                method: "POST",
                body: {
                    title: title,
                    description: String(data.get("description") || "").trim(),
                    pickup: pickup,
                    delivery: delivery,
                    deadline: deadline || null,
                    amount: Number(data.get("amount") || 0),
                    contact: String(data.get("contact") || "").trim()
                }
            });
            api.toast("任务已发布！", "success");
            location.href = api.pageUrl(`task-detail.jsp?taskId=${result.id}`);
        } catch (error) {
            if (error.status !== 401) {
                api.setFeedback(feedback, error.message || "发布失败，请稍后重试");
            }
        } finally {
            api.setLoading(button, false);
        }
    });

    api.requireUser().catch(() => {});
    updatePreview();
})();