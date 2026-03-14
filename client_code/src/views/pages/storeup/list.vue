<template>
	<div class="list-page modern-storeup-page">
        <el-card shadow="hover" class="breadcrumb-card">
            <div class="breadcrumb-wrapper">
                <el-breadcrumb separator="/" class="breadcrumb">
                    <el-breadcrumb-item :to="{ path: `/index/${sessionTable}Center` }">个人中心</el-breadcrumb-item>
                    <el-breadcrumb-item>我的收藏夹</el-breadcrumb-item>
                </el-breadcrumb>
                <div class="back_view" v-if="centerType">
                    <el-button class="back_btn" @click="backClick" icon="el-icon-back" round size="small">返回</el-button>
                </div>
            </div>
        </el-card>

        <el-card shadow="hover" class="search-card">
            <el-form :inline="true" :model="searchQuery" class="list_search">
                <div class="search_view">
                    <el-input class="search_inp" v-model="searchQuery.name" placeholder="搜索我收藏的商品..." clearable prefix-icon="el-icon-search"></el-input>
                </div>
                <div class="search_btn_view">
                    <el-button type="primary" @click="searchClick" round icon="el-icon-search">检索</el-button>
                </div>
            </el-form>
        </el-card>

        <div class="storeup-grid" v-loading="listLoading">
            <el-row :gutter="24" v-if="list.length > 0">
                <el-col :xs="24" :sm="12" :md="8" :lg="6" v-for="(item, index) in list" :key="index" style="margin-bottom: 24px;">
                    <el-card class="storeup-card" shadow="hover" :body-style="{ padding: '0px' }" @click="toDetailClick(item)">
                        <div class="img-wrapper">
                            <img v-if="item.picture" :src="item.picture.substring(0,4)=='http' ? item.picture.split(',')[0] : $config.url + item.picture.split(',')[0]" class="item-img" />
                            <div v-else class="no-img">暂无图片</div>
                            
                            <div class="heart-badge">
                                <i class="el-icon-star-on"></i>
                            </div>
                        </div>
                        
                        <div class="item-content">
                            <h3 class="item-title">{{item.name}}</h3>
                            <div class="item-footer" @click.stop>
                                <span class="time-text">收藏于系统</span>
                                <el-button type="danger" plain round size="small" icon="el-icon-delete" @click="delClick(item.id)">取消收藏</el-button>
                            </div>
                        </div>
                    </el-card>
                </el-col>
            </el-row>
            <el-empty v-else description="您的收藏夹空空如也，快去逛逛吧" :image-size="120"></el-empty>
		</div>

        <div class="pagination-wrapper">
            <el-pagination background :layout="layouts.join(',')" :total="total" :page-size="listQuery.limit" v-model:current-page="listQuery.page" @size-change="sizeChange" @current-change="currentChange" />
        </div>
	</div>
</template>

<script setup>
	import { ref, getCurrentInstance } from 'vue';
	import { ElMessageBox } from 'element-plus'
	import { useRoute, useRouter } from 'vue-router'

	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const router = useRouter()
	const route = useRoute()
	const tableName = 'storeup'
	const sessionTable = context?.$toolUtil.storageGet('frontSessionTable')

	const list = ref([])
	const listLoading = ref(false)
	const listQuery = ref({
		page: 1,
		limit: 12,
		userid: context?.$toolUtil.storageGet('userid')
	})
	const searchQuery = ref({})
	const total = ref(0)
	const layouts = ref(["total", "prev", "pager", "next"])

	const searchClick = () => { listQuery.value.page = 1; getList(); }
	const sizeChange = (size) => { listQuery.value.limit = size; getList(); }
	const currentChange = (page) => { listQuery.value.page = page; getList(); }

	const getList = () => {
		listLoading.value = true
		let params = JSON.parse(JSON.stringify(listQuery.value))
		if (searchQuery.value.name) {
			params.name = '%' + searchQuery.value.name + '%'
		}
		context?.$http({
			url: `storeup/list`,
			method: 'get',
			params: params
		}).then(res => {
			listLoading.value = false
			list.value = res.data.data.list
			total.value = res.data.data.total
		})
	}

	const delClick = (id = null) => {
		ElMessageBox.confirm(`确定要取消收藏该内容吗？`, '提示', {
			confirmButtonText: '确定取消',
			cancelButtonText: '点错了',
			type: 'warning',
		}).then(() => {
			context?.$http({
				url: `storeup/delete`,
				method: 'post',
				data: [id]
			}).then(res => {
				context?.$toolUtil.message('已取消收藏', 'success', () => { getList() })
			})
		}).catch(() => {})
	}

	const centerType = ref(false)
	const backClick = () => {
		router.push(`/index/${context?.$toolUtil.storageGet('frontSessionTable')}Center`)
	}

    // 跳转到原商品详情页
	const toDetailClick = (item) => {
        if(item.tablename === 'news') {
            router.push(`/index/newsDetail?id=${item.refid}`)
        } else {
            router.push(`/index/${item.tablename}Detail?id=${item.refid}`)
        }
	}

	const init = () => {
		if (route.query.centerType) { centerType.value = true }
		getList()
	}
	init()
</script>

<style lang="scss" scoped>
.modern-storeup-page { width: 1200px; margin: 0 auto; padding: 30px 0 60px; }
.breadcrumb-card { border-radius: 12px; border: none; margin-bottom: 25px; box-shadow: 0 4px 12px rgba(0,0,0,0.03); :deep(.el-card__body) { padding: 18px 25px; } }
.breadcrumb-wrapper { display: flex; justify-content: space-between; align-items: center; }

/* 搜索卡片 */
.search-card { border-radius: 12px; border: none; margin-bottom: 30px; box-shadow: 0 4px 16px rgba(0,0,0,0.03); :deep(.el-card__body) { padding: 20px 25px; } }
.list_search { display: flex; align-items: center; margin: 0; }
.search_view { flex: 1; margin-right: 20px; }
:deep(.el-input__inner) { border-radius: 20px !important; background: #f5f7fa !important; border: 1px solid #ebeef5 !important; height: 42px; line-height: 42px; transition: all 0.3s; }
:deep(.el-input__inner):focus { background: #fff !important; border-color: #4A90E2 !important; box-shadow: 0 0 0 2px rgba(74, 144, 226, 0.2) !important; }

/* 收藏卡片 */
.storeup-card { border-radius: 16px; border: none; cursor: pointer; transition: all 0.3s; position: relative; }
.storeup-card:hover { transform: translateY(-8px); box-shadow: 0 16px 32px rgba(0,0,0,0.12) !important; }
.img-wrapper { width: 100%; height: 200px; overflow: hidden; position: relative; background: #f8f9fa; }
.item-img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.6s ease; }
.storeup-card:hover .item-img { transform: scale(1.08); }
.no-img { width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; color: #999; }

/* 悬浮红心 */
.heart-badge { position: absolute; top: 15px; right: 15px; width: 36px; height: 36px; background: rgba(255,255,255,0.9); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: #F56C6C; font-size: 20px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); backdrop-filter: blur(4px); }

/* 卡片内容 */
.item-content { padding: 20px; }
.item-title { margin: 0 0 15px 0; font-size: 18px; color: #303133; font-weight: bold; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.item-footer { display: flex; justify-content: space-between; align-items: center; border-top: 1px dashed #ebeef5; padding-top: 15px; }
.time-text { font-size: 13px; color: #909399; }

.pagination-wrapper { margin-top: 40px; display: flex; justify-content: center; }
</style>