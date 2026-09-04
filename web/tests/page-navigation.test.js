"use strict";

const assert = require("node:assert/strict");
const fs = require("node:fs");
const path = require("node:path");
const vm = require("node:vm");

const webRoot = path.resolve(__dirname, "..");
const read = (file) => fs.readFileSync(path.join(webRoot, file), "utf8");
const navigationPages = [
    "product-detail.jsp", "task-detail.jsp", "product-order.jsp",
    "product-publish.jsp", "task-publish.jsp"
];

for (const page of navigationPages) {
    const header = read(page).match(/<header\b[^>]*>[\s\S]*?<\/header>/);
    assert.ok(header, `${page} 应保留页面标题`);
    assert.doesNotMatch(header[0], /back-link|data-detail-back|返回/, `${page} 不应重复显示右上角返回入口`);
}

for (const [kind, listPage] of [["product", "secondhand.jsp"], ["task", "task-hall.jsp"]]) {
    const detail = read(`${kind}-detail.jsp`);
    assert.ok(detail.includes(`href="${kind}-publish.jsp"`), "详情页仍应保留发布入口");
    const script = read(`js/${kind}-detail.js`);
    assert.match(script, /class="secondary-action" data-detail-back/, "详情内容区应保留来源返回按钮");
    assert.ok(script.includes("returnContext.url"), "返回按钮仍应使用来源地址");
    assert.match(script, /<div class="detail-actions">[\s\S]*?returnLink\(\)/, "详情页应在操作区渲染返回按钮");
    const publish = read(`${kind}-publish.jsp`);
    assert.ok(publish.includes(`class="secondary-action" href="${listPage}">取消</a>`), "发布页应保留表单取消入口");
}

assert.match(read("js/product-order.js"), /class="secondary-action"[^>]+>返回发现首页<\/a>/, "交易页应保留内容区返回入口");
const profileHtml = read("profile-user.jsp");
assert.doesNotMatch(profileHtml, /data-profile-name|data-profile-avatar[\s>]/, "个人空间不应再显示右上角姓名按钮");
assert.match(profileHtml, /data-profile-avatar-lg/, "个人资料中的头像应保留");
assert.match(profileHtml, /data-profile-username/, "个人资料中的用户名应保留");

async function verifyProfileLoad() {
    // 仅为 JSP 中实际存在的 data-* 节点提供桩；已删除的顶部节点必须返回 null。
    const elements = new Map();
    for (const [attribute] of profileHtml.matchAll(/\bdata-[\w-]+/g)) {
        elements.set(`[${attribute}]`, {
            textContent: "", value: "", innerHTML: "", style: {},
            addEventListener() {},
            querySelector(selector) { return elements.get(selector) || null; },
            querySelectorAll() { return []; }
        });
    }
    const user = {username: "测试同学", qq: "10001", wechat: "test-wechat", phone: ""};
    const toasts = [];
    const api = {
        requireUser: async () => user,
        initial: (name) => name.charAt(0),
        escapeHtml: (value) => String(value ?? ""),
        query: (params) => "?" + new URLSearchParams(params),
        request: async () => ({list: [], total: 0}),
        toast: (message) => toasts.push(message)
    };
    const context = vm.createContext({
        window: {CTCP: api},
        location: {search: ""},
        URLSearchParams,
        document: {
            readyState: "complete",
            querySelector: (selector) => elements.get(selector) || null,
            querySelectorAll: () => []
        }
    });
    vm.runInContext(read("js/profile.js"), context, {filename: "profile.js"});
    await new Promise(setImmediate);
    assert.deepEqual(toasts, [], "删除顶部节点后，个人资料加载不应报错");
    assert.equal(elements.get("[data-profile-loading]").style.display, "none");
    assert.equal(elements.get("[data-profile-content]").style.display, "block");
    assert.equal(elements.get("[data-profile-username]").textContent, user.username);
    assert.equal(elements.get("[data-profile-input-username]").value, user.username);
    assert.equal(elements.get("[data-avatar-letter]").textContent, "测");
    assert.equal(elements.get("[data-profile-qq]").textContent, user.qq);
    assert.match(elements.get("[data-record-list]").innerHTML, /你还没有发布过任何任务/, "个人记录也应正常完成加载");
}

verifyProfileLoad().then(() => {
    console.log("页面导航测试通过：5 个页面无重复顶部返回、内容区入口保留、个人空间正常加载");
}).catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
