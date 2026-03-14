<template>
    <div class="list-page-container">
        <div class="breadcrumb">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item :to="{ path: '/index/home' }">首页</el-breadcrumb-item>
                <el-breadcrumb-item>社区公告</el-breadcrumb-item>
            </el-breadcrumb>
        </div>

        <el-card class="list-card" shadow="hover">
            <template #header>
                <div class="list-header">
                    <span class="header-title"><i class="el-icon-message-solid"></i> 社区公告列表</span>
                </div>
            </template>
            
            <el-table :data="list" style="width: 100%" @row-click="goDetail" stripe class="custom-table">
                <el-table-column prop="title" label="公告标题" min-width="500">
                    <template #default="scope">
                        <span class="notice-title-link">{{ scope.row.title }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="publisher" label="发布单位" width="200" align="center">
                    <template #default="scope">
                        <el-tag type="info" size="medium">{{ scope.row.publisher }}</el-tag>
                    </template>
                </el-table-column>
                <el-table-column prop="addtime" label="发布时间" width="200" align="center"></el-table-column>
            </el-table>
            
            <div class="pagination-box">
                <el-pagination 
                    background 
                    layout="total, prev, pager, next, jumper" 
                    :total="total" 
                    :page-size="limit" 
                    @current-change="pageChange">
                </el-pagination>
            </div>
        </el-card>
    </div>
</template>

<script setup>
import { ref, onMounted, getCurrentInstance } from 'vue';
import { useRouter } from 'vue-router';
const context = getCurrentInstance()?.appContext.config.globalProperties;
const router = useRouter();

const list = ref([]);
const total = ref(0);
const page = ref(1);
const limit = ref(10);

const getList = () => {
    context.$http({
        url: 'gonggao/list',
        method: 'get',
        params: { 
            page: page.value, 
            limit: limit.value, 
            sort: 'addtime', 
            order: 'desc' 
        }
    }).then(res => {
        list.value = res.data.data.list;
        total.value = Number(res.data.data.total);
    })
}

const pageChange = (val) => { 
    page.value = val; 
    getList(); 
}

const goDetail = (row) => { 
    router.push({ path: '/index/gonggaoDetail', query: { id: row.id } }); 
}

onMounted(() => { 
    getList(); 
})
</script>

<style lang="scss" scoped>
/* 强制外层容器撑开并居中 */
.list-page-container {
    width: 1200px;
    margin: 30px auto;
    min-height: 70vh;
}

.breadcrumb {
    margin-bottom: 20px;
    padding-left: 10px;
}

.list-card {
    border-radius: 8px;
    border: none;
    box-shadow: 0 4px 16px rgba(0,0,0,0.05);
}

.list-header {
    display: flex;
    align-items: center;
    
    .header-title {
        font-size: 22px;
        font-weight: bold;
        color: #333;
        display: flex;
        align-items: center;
        
        i {
            color: #E6A23C;
            margin-right: 10px;
            font-size: 26px;
        }
    }
}

/* 表格样式美化 */
.custom-table {
    border-radius: 4px;
    margin-top: 10px;
}

.notice-title-link {
    cursor: pointer;
    color: #333;
    font-size: 16px;
    transition: all 0.3s;
    display: block;
    width: 100%;
}

.notice-title-link:hover {
    color: #409EFF;
}

.pagination-box {
    margin-top: 40px;
    text-align: center;
    padding-bottom: 20px;
}
</style>