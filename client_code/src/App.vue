<template>
	<router-view />
</template>
<script>
	const debounce = (fn, delay) => {
		let timer = null;
		return function() {
			let context = this;
			let args = arguments;
			clearTimeout(timer);
			timer = setTimeout(function() {
				fn.apply(context, args);
			}, delay);
		}
	}
	const _ResizeObserver = window.ResizeObserver;
	window.ResizeObserver = class ResizeObserver extends _ResizeObserver {
		constructor(callback) {
			callback = debounce(callback, 16);
			super(callback);
		}
	}
</script>
<style lang="scss">
	/* ================= 核心亮度：全局现代 UI 变量 ================= */
	:root {
		--theme: #4A90E2; /* 覆盖旧版本的刺眼主题色 */
		--el-color-primary: #4A90E2; /* 沉稳的适老蓝 */
		--el-color-success: #67C23A; /* 健康绿 */
		--el-color-warning: #E6A23C; /* 活力橘 */
		--el-color-danger:  #F56C6C; /* 警示红 */
		--el-border-radius-base: 8px; /* 全局圆角 */
		--el-border-radius-round: 20px;
	}

	body {
		margin: 0;
		background-color: #F4F7F9; /* 极其柔和的页面底色，让白色卡片更凸显 */
		font-family: 'Microsoft YaHei', 'PingFang SC', -apple-system, sans-serif;
		color: #333;
	}
	* {
		box-sizing: border-box;
	}

	/* 现代化的优美滚动条 */
	::-webkit-scrollbar {
		width: 8px;
		height: 8px;
	}
	::-webkit-scrollbar-thumb {
		background: #c0c4cc;
		border-radius: 4px;
	}
	::-webkit-scrollbar-thumb:hover {
		background: #909399;
	}
	::-webkit-scrollbar-track {
		background: #f1f3f5;
	}
</style>