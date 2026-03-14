<template>
    <div class="news-detail-page">
        <el-card shadow="never" class="news-card">
            <div class="breadcrumb-wrapper">
                <el-breadcrumb separator="/">
                    <el-breadcrumb-item :to="{ path: '/index/home' }">首页</el-breadcrumb-item>
                    <el-breadcrumb-item :to="{ path: '/index/newsList' }">社区资讯</el-breadcrumb-item>
                    <el-breadcrumb-item>资讯详情</el-breadcrumb-item>
                </el-breadcrumb>
                <el-button @click="$router.go(-1)" size="small" round icon="el-icon-back">返回上页</el-button>
            </div>
            
            <div class="news-header">
                <h1 class="title">{{ detail.title }}</h1>
                <div class="meta-info">
                    <span class="meta-item"><i class="el-icon-time"></i> 发布时间：{{ detail.addtime }}</span>
                    <span class="meta-item"><i class="el-icon-user"></i> 来源：社区养老服务中心</span>
                </div>
            </div>
            
            <el-divider></el-divider>
            
            <div class="cover-box" v-if="detail.picture">
                <img :src="$config.url + detail.picture.split(',')[0]" class="cover-img" />
            </div>

            <div class="news-content" v-html="detail.content || '<p style=\'text-align:center;color:#999\'>暂无详细内容</p>'"></div>
        </el-card>
    </div>
</template>

<script setup>
import { ref, getCurrentInstance } from 'vue';
import { useRoute } from 'vue-router';

const context = getCurrentInstance()?.appContext.config.globalProperties;
const route = useRoute();
const detail = ref({});

// 根据传入的 id 获取资讯详情
const getDetail = () => {
    if(!route.query.id) return;
    context?.$http.get(`news/detail/${route.query.id}`).then(res => {
        detail.value = res.data.data;
    })
}
getDetail();
</script>

<style lang="scss" scoped>
.news-detail-page {
    width: 1000px;
    margin: 30px auto 60px;
    font-family: "Microsoft YaHei", sans-serif;
}
.news-card {
    border-radius: 16px;
    border: none;
    box-shadow: 0 10px 30px rgba(0,0,0,0.05);
    padding: 20px;
}
.breadcrumb-wrapper {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
}
.news-header {
    text-align: center;
    margin: 40px 0 20px;
    .title {
        font-size: 28px;
        color: #333;
        font-weight: bold;
        margin-bottom: 20px;
        line-height: 1.4;
    }
    .meta-info {
        color: #909399;
        font-size: 14px;
        .meta-item {
            margin: 0 15px;
        }
    }
}
.cover-box {
    width: 100%;
    max-height: 400px;
    overflow: hidden;
    border-radius: 12px;
    margin: 30px 0;
    text-align: center;
    .cover-img {
        max-width: 100%;
        max-height: 400px;
        object-fit: contain;
    }
}
.news-content {
    padding: 0 40px;
    line-height: 2;
    font-size: 16px;
    color: #444;
    :deep(img) {
        max-width: 100%;
        height: auto;
        border-radius: 8px;
        margin: 20px 0;
    }
}
</style>