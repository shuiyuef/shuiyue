<template>
    <div class="list-page">
        <el-card shadow="hover" class="list_search_card">
            <div class="breadcrumb-wrapper">
                <el-breadcrumb separator="/">
                    <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
                    <el-breadcrumb-item v-for="(item,index) in breadList" :key="index">{{item.name}}</el-breadcrumb-item>
                </el-breadcrumb>
            </div>
            
            <el-form :inline="true" :model="searchQuery" class="list_search">
                <div class="search_view">
                    <el-input class="search_inp" v-model="searchQuery.caipinmingcheng" placeholder="想吃点什么？搜索菜品..." clearable prefix-icon="el-icon-search"></el-input>
                </div>
                <div class="search_btn_view">
                    <el-button type="primary" @click="searchClick" round icon="el-icon-search">搜索</el-button>
                    <el-button type="success" v-if="btnAuth('caipinxinxi','新增')" @click="addClick" round>新增菜品</el-button>
                </div>
            </el-form>
        </el-card>

        <div class="modern-dish-grid" v-loading="listLoading">
            <el-row :gutter="24">
                <el-col :xs="24" :sm="12" :md="8" :lg="6" v-for="(item, index) in list" :key="index" style="margin-bottom: 24px;">
                    <el-card shadow="hover" class="dish-card" @click="tableDetailClick(item)" :body-style="{ padding: '0px' }">
                        <div class="img-wrapper">
                            <img v-if="item.caipintupian" :src="item.caipintupian.substring(0,4)=='http' ? item.caipintupian.split(',')[0] : $config.url + item.caipintupian.split(',')[0]" class="dish-img" />
                            <div v-else class="no-img">暂无图片</div>
                        </div>
                        <div class="dish-content">
                            <h3 class="dish-title">{{item.caipinmingcheng}}</h3>
                            <div class="dish-tags">

                                <el-tag v-if="item.healthTag" type="success" effect="dark" size="small">
                                    {{ item.healthTag }}
                                 </el-tag>

                                <el-tag size="small" type="warning" effect="light" round v-if="item.kouwei">{{item.kouwei}}</el-tag>
                                <el-tag size="small" type="info" effect="plain" round v-if="item.caipinfenlei" style="margin-left: 5px;">{{item.caipinfenlei}}</el-tag>
                            </div>
                            <div class="dish-footer">
                                <span class="price">¥ {{item.price || item.danjia || '0.00'}}</span>
                                <div class="admin-actions" v-if="btnAuth('caipinxinxi','修改') || btnAuth('caipinxinxi','删除')">
                                    <el-button v-if="btnAuth('caipinxinxi','修改')" type="primary" link icon="el-icon-edit" @click.stop="editClick(item.id)"></el-button>
                                    <el-button v-if="btnAuth('caipinxinxi','删除')" type="danger" link icon="el-icon-delete" @click.stop="delClick(item.id)"></el-button>
                                </div>
                            </div>
                        </div>
                    </el-card>
                </el-col>
            </el-row>
            <el-empty v-if="list.length === 0" description="未找到相关菜品" />
        </div>

        <div class="pagination-wrapper">
            <el-pagination background :layout="layouts.join(',')" :total="total" :page-size="listQuery.limit" v-model:current-page="listQuery.page" @size-change="sizeChange" @current-change="currentChange" />
        </div>
    </div>
</template>

<script setup>
	import { ref, getCurrentInstance, nextTick, computed, inject } from 'vue';
	import { useRoute, useRouter } from 'vue-router';
	import { useStore } from 'vuex';
	const store = useStore()
	const user = computed(()=>store.getters['user/session'])
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const router = useRouter()
	const route = useRoute()
	//基础信息
	const tableName = 'caipinxinxi'
	const formName = '菜品信息'
	const breadList = ref([{ name: formName }])
	const list = ref([])
	const listQuery = ref({ page: 1, limit: 12 }) // 卡片布局建议改成12或16个一页
	const total = ref(0)
	const listLoading = ref(false)
	//权限验证
	const btnAuth = (e,a)=>{
		if(centerType.value){
			return context?.$toolUtil.isBackAuth(e,a)
		}else{
			return context?.$toolUtil.isAuth(e,a)
		}
	}
	const addClick = () => {
		router.push('/index/caipinxinxiAdd')
	}
	//判断是否从个人中心跳转
	const centerType = ref(false)
	//返回
	const backClick = () => {
		router.push(`/index/${context?.$toolUtil.storageGet('frontSessionTable')}Center`)
	}
	//搜索
	const searchQuery = ref({})
	const searchClick = () => {
		listQuery.value.page = 1
		getList()
	}
	//分页
	const layouts = ref(["total","prev","pager","next","jumper"])
	const sizeChange = (size) => {
		listQuery.value.limit = size
		getList()
	}
	const currentChange = (page) => {
		listQuery.value.page = page
		getList()
	}
	//列表
	const getList = () => {
		listLoading.value = true
		let params = JSON.parse(JSON.stringify(listQuery.value))
		if(searchQuery.value.caipinmingcheng && searchQuery.value.caipinmingcheng != ''){
			params.caipinmingcheng = '%' + searchQuery.value.caipinmingcheng + '%'
		}
		context?.$http({
			url: `${tableName}/${centerType.value?'page':'list'}`,
			method: 'get',
			params: params
		}).then(res => {
			listLoading.value = false
			list.value = res.data.data.list
			total.value = Number(res.data.data.total)
		})
	}
	const tableDetailClick = (row) => {
		router.push(`${tableName}Detail?id=` + row.id + (centerType.value?'&&centerType=1':''))
	}
	const editClick = (id) => {
		router.push('caipinxinxiAdd?id=' + id + (centerType.value?'&centerType=1':''))
	}
	const delClick = (id) => {
		context?.$confirm('是否确认删除?', '提示', {
			confirmButtonText: '确定',
			cancelButtonText: '取消',
			type: 'warning'
		}).then(()=>{
			context?.$http({
				url: `caipinxinxi/delete`,
				method: 'post',
				data: [id]
			}).then(res=>{
				context?.$message.success('删除成功')
				getList()
			})
		})
	}
	const init = async() => {
		if(route.query.centerType){
			centerType.value = true
		}
		if(context.$toolUtil.storageGet('frontToken') && !user.value.id){
			await store.dispatch("user/getSession")
		}
		getList()
	}
	init()
</script>

<style lang="scss" scoped>
.list-page { 
    margin: 0 auto; 
    padding: 30px 0 50px; 
    width: 1200px; 
}

/* 融合式的顶部控制台（把面包屑和搜索框整合到一个卡片里） */
.list_search_card { 
    border-radius: 16px; 
    margin-bottom: 30px; 
    border: none;
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.04);
}
.list_search_card :deep(.el-card__body) {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 30px;
}

/* 隐藏单独的面包屑背景，让它融入环境 */
.breadcrumb-wrapper { 
    background: transparent;
    padding: 0;
    box-shadow: none;
    margin-bottom: 0;
}
:deep(.el-breadcrumb) {
    font-size: 15px;
}
:deep(.el-breadcrumb__inner) {
    font-weight: bold !important;
    color: #606266;
}

/* 搜索区域更紧凑 */
.list_search {
    display: flex;
    align-items: center;
    margin: 0;
}
.search_view { 
    display: flex; 
    align-items: center; 
    margin-right: 15px; 
}
.search_label { 
    display: none; /* 隐藏啰嗦的文字标签 */
}
:deep(.el-input__inner) { 
    border-radius: 20px !important; 
    background: #f5f7fa !important; 
    border: 1px solid #ebeef5 !important;
    width: 260px;
    height: 40px;
    line-height: 40px;
    transition: all 0.3s;
}
:deep(.el-input__inner):focus { 
    background: #fff !important; 
    border-color: #4A90E2 !important;
    width: 300px; /* 聚焦时稍微变长，增加交互感 */
    box-shadow: 0 0 0 2px rgba(74, 144, 226, 0.2) !important;
}
.search_btn_view {
    display: flex;
    align-items: center;
}
.search_btn_view .el-button {
    font-weight: bold;
    padding: 10px 20px;
}

/* ================== 菜品卡片网格样式 ================== */
.modern-dish-grid {
    margin-top: 10px;
}
.dish-card {
    border-radius: 16px;
    overflow: hidden;
    border: none;
    box-shadow: 0 8px 16px rgba(0,0,0,0.05);
    cursor: pointer;
    transition: all 0.3s ease;
}
.dish-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 16px 32px rgba(0,0,0,0.12) !important;
}

.img-wrapper {
    width: 100%;
    height: 220px;
    overflow: hidden;
    background: #f8f9fa;
    position: relative;
}
.dish-img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}
.dish-card:hover .dish-img {
    transform: scale(1.08); /* 鼠标悬浮时图片轻微放大 */
}

.no-img {
    width: 100%; 
    height: 100%; 
    display: flex; 
    align-items: center; 
    justify-content: center; 
    color: #999;
}

/* 卡片文字内容区 */
.dish-content {
    padding: 20px;
    background: #fff;
}
.dish-title {
    margin: 0 0 12px 0;
    font-size: 18px;
    color: #303133;
    font-weight: bold;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
.dish-tags { 
    margin-bottom: 15px; 
    display: flex;
    gap: 8px;
}

.dish-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-top: 1px dashed #ebeef5;
    padding-top: 15px;
}
.price {
    color: #F56C6C;
    font-size: 22px;
    font-weight: bold;
}
.price::before {
    content: '¥';
    font-size: 14px;
    margin-right: 2px;
}
.admin-actions {
    display: flex;
    gap: 10px;
}

/* 分页器居中展示 */
.pagination-wrapper { 
    margin-top: 40px; 
    display: flex; 
    justify-content: center; 
}
:deep(.el-pagination.is-background .el-pager li:not(.disabled).is-active) {
    background-color: #4A90E2;
}

/* 修复搜索框双层包裹感 */
:deep(.search_inp .el-input__wrapper) {
    border-radius: 20px;
    box-shadow: 0 0 0 1px #ebeef5 inset;
    background: #f5f7fa;
    transition: all 0.3s;
}
:deep(.search_inp .el-input__wrapper.is-focus) {
    box-shadow: 0 0 0 2px #4A90E2 inset !important;
    background: #fff;
}
:deep(.search_inp .el-input__inner) {
    border: none !important; /* 核心：干掉内部边框 */
    height: 38px;
    line-height: 38px;
    background: transparent !important;
}

</style>