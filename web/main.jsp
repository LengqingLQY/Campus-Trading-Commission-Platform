<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/base.css">
    <link rel="stylesheet" href="css/main.css">
    <title>CTCP · 跑腿任务</title>
</head>
<body class="app-page app-page--task">
<div class="app-layout">
    <jsp:include page="sidebar.jsp" />

    <main class="workspace">
        <header class="workspace__topbar">
            <div>
                <span class="workspace__kicker">ERRAND · CAMPUS SERVICE</span>
                <h1>跑腿任务</h1>
            </div>
            <div class="workspace__actions">
                <span class="weather-chip"><span aria-hidden="true">☼</span> 晴朗 · 26°C</span>
                <button class="profile-chip" type="button">
                    <span class="avatar avatar--small">小</span>
                    <span>我的空间</span>
                </button>
            </div>
        </header>

        <!-- 后续页面功能统一放在这个白色内容区域内 -->
        <section class="workspace__canvas" aria-label="主要页面内容区域"></section>
    </main>
</div>
</body>
</html>
