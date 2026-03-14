<template>
    <div class="formal-detail-page">
        <div class="breadcrumb">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item :to="{ path: '/index/home' }">首页</el-breadcrumb-item>
                <el-breadcrumb-item :to="{ path: '/index/gonggaoList' }">社区公告</el-breadcrumb-item>
                <el-breadcrumb-item>公告详情</el-breadcrumb-item>
            </el-breadcrumb>
        </div>

        <el-card class="notice-card" shadow="never">
            <div class="notice-header">
                <h1 class="notice-title">{{ detail.title }}</h1>
                <div class="meta-info">
                    <div class="meta-item">
                        <i class="el-icon-office-building"></i> 发布单位：{{ detail.publisher }}
                    </div>
                    <span class="separator">|</span>
                    <div class="meta-item">
                        <i class="el-icon-date"></i> 发布时间：{{ detail.addtime }}
                    </div>
                </div>
            </div>

            <el-divider></el-divider>

            <div class="notice-content-wrapper">
                <div class="notice-body rich-text-content" v-html="detail.content"></div>
                
                <div class="notice-signature">
                    <p class="signer-name">社区居委会</p>
                    <p class="sign-date">{{ detail.addtime ? detail.addtime.split(' ')[0] : '' }}</p>
                </div>
                </div>

            <div class="notice-footer">
                <el-button type="primary" plain icon="el-icon-back" @click="$router.go(-1)">返回公告列表</el-button>
            </div>
        </el-card>
    </div>
</template>

<script setup>
import { ref, onMounted, getCurrentInstance } from 'vue';
import { useRoute } from 'vue-router';

// 获取全局属性
const context = getCurrentInstance()?.appContext.config.globalProperties;
const route = useRoute();

// 公告详情数据
const detail = ref({});

// 获取公告详情
const getDetail = () => {
    // 根据路由中的 id 参数获取详情
    context?.$http({
        url: `gonggao/detail/${route.query.id}`,
        method: 'get'
    }).then(res => {
        detail.value = res.data.data;
    })
}

// 页面加载时获取数据
onMounted(() => {
    getDetail();
})
</script>

<style lang="scss" scoped>
.formal-detail-page {
    width: 1200px;
    margin: 30px auto;
    min-height: 70vh;
    font-family: "Microsoft YaHei", sans-serif;
}

/* 面包屑导航 */
.breadcrumb {
    margin-bottom: 25px;
    padding-left: 10px;
}

/* 公告卡片 */
.notice-card {
    border-radius: 8px;
    border: 1px solid #ebeef5;
    background-color: #fff;
    padding: 20px 0; /* 增加上下内边距 */
    
    :deep(.el-card__header) {
        border-bottom: none; /* 去掉自带的头部分割线，我们用 el-divider */
        padding: 0 50px;
    }
    
    :deep(.el-card__body) {
        padding: 0 50px;
    }
}

/* 公告头部 */
.notice-header {
    text-align: center;
    padding-bottom: 10px;
    
    .notice-title {
        font-size: 30px; /* 超大标题，彰显正式 */
        color: #2c3e50;
        margin: 0 0 20px 0;
        font-weight: bold;
        letter-spacing: 1px;
    }
    
    .meta-info {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 15px;
        color: #7f8c8d;
        font-size: 15px;
        
        .meta-item {
            display: flex;
            align-items: center;
            i { margin-right: 6px; font-size: 17px; color: #409EFF; }
        }
        
        .separator {
            color: #dcdfe6;
            margin: 0 5px;
        }
    }
}

/* 分割线样式 */
.el-divider--horizontal {
    margin: 30px 0;
    background-color: #dcdfe6;
    height: 1px;
}

/* 正文容器，用于定位落款 */
.notice-content-wrapper {
    position: relative;
    padding-bottom: 100px; /* 为落款留出空间 */
}

/* 公告正文 */
.notice-body {
    font-size: 18px; /* 适老化大字体，阅读清晰 */
    line-height: 2; /* 宽行距，防止串行 */
    color: #333;
    min-height: 400px;
    text-align: justify; /* 两端对齐，更美观 */
    word-wrap: break-word;
    word-break: break-all;
    
    /* 针对富文本内容的样式调整 */
    :deep(p) {
        margin-bottom: 1.2em;
        text-indent: 2em; /* 首行缩进 */
    }
    :deep(img) {
        max-width: 100%;
        height: auto;
        display: block;
        margin: 20px auto;
        border-radius: 4px;
    }
}

/* --- 正式落款样式 --- */
.notice-signature {
    position: absolute;
    bottom: 0;
    right: 0;
    text-align: right;
    padding-right: 20px;
    
    .signer-name {
        font-size: 18px;
        font-weight: bold;
        color: #333;
        margin: 0 0 8px 0;
        letter-spacing: 2px; /* 增加落款名称字间距 */
    }
    
    .sign-date {
        font-size: 16px;
        color: #666;
        margin: 0;
    }
}

/* 底部操作按钮 */
.notice-footer {
    text-align: center;
    margin-top: 50px;
    padding-bottom: 20px;
    border-top: 1px dashed #ebeef5;
    padding-top: 30px;
}
</style>