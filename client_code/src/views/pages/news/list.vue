<template>
	<div class="list-page news-page" :style='{}'>
        <div class="breadcrumb-wrapper" style="width: 100%;">
            <div class="bread_view">
                <el-breadcrumb separator="—" class="breadcrumb">
                    <el-breadcrumb-item class="first_breadcrumb" :to="{ path: '/' }">首页</el-breadcrumb-item>
                    <el-breadcrumb-item class="second_breadcrumb" v-for="(item,index) in breadList" :key="index">{{item.name}}</el-breadcrumb-item>
                </el-breadcrumb>
            </div>
        </div>
		<el-form inline :model="searchQuery" class="list_search">
			<div class="search_view">
				<div class="search_label">
					标题：
				</div>
				<div class="search_box">
					<el-input class="search_inp" v-model="searchQuery.title" placeholder="标题" clearable></el-input>
				</div>
			</div>
			<div class="search_btn_view">
				<el-button class="search_btn" type="primary" @click="searchClick">搜索</el-button>
			</div>
		</el-form>
		<div class="news_list_five">
			<div class="news_top">
				<template v-for="(item,index) in list" :key="index">
                    <div class="five_top_item animation_box" v-if="index<3" @click.stop="$router.push(`/index/newsDetail?id=${item.id}`)">
						<div class="img_box">
							<img :src="item.picture?$config.url + item.picture.split(',')[0] :''" alt="">
						</div>
						<div class="content">
							<div class="news_title"><span>{{item.title}}</span></div>
							<div class="news_text">{{item.introduction}}</div>
						</div>
					</div>
				</template>
			</div>
			<div class="news_bottom">
				<template v-for="(item,index) in list" :key="index">
                    <div class="five_bottom_item animation_box" v-if="index>2" @click.stop="$router.push(`/index/newsDetail?id=${item.id}`)">
						<div class="time_box">
							<div class="date">{{item.addtime.split(' ')[0].split('-')[2]}}</div>
							<div class="year">{{item.addtime.split(' ')[0].split('-')[0]}}-{{item.addtime.split(' ')[0].split('-')[1]}}</div>
						</div>
						<div class="content">
							<div class="news_title"><span>{{item.title}}</span></div>
							<div class="news_text">{{item.introduction}}</div>
						</div>
					</div>
				</template>
			</div>
		</div>
		<el-pagination
			background 
			:layout="layouts.join(',')"
			:total="total" 
			:page-size="listQuery.limit"
            v-model:current-page="listQuery.page"
			prev-text="上一页"
			next-text="下一页"
			:hide-on-single-page="false"
			:style='{}'
			@size-change="sizeChange"
			@current-change="currentChange"/>
	</div>
</template>

<script setup>
	import moment from 'moment'
	import { ref, nextTick, getCurrentInstance } from 'vue';
	import { useRoute, useRouter } from 'vue-router'
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const tableName = 'news'
	const formName = '健康资讯'
	const router = useRouter()
	const route = useRoute()
    const breadList = ref([{ name: formName }])
	
	const list = ref([])
	const listLoading = ref(false)
	const listQuery = ref({ page: 1, limit: 20, sort: 'addtime', order: 'desc' })
	const searchQuery = ref({})
	const layouts = ref(["total","prev","pager","next","sizes","jumper"])
	const total = ref(0)
	
	const sizeChange = (size) => { listQuery.value.limit = size; getList() }
	const currentChange = (page) => { listQuery.value.page = page; getList() }
	const searchClick = () => { listQuery.value.page = 1; getList() }
	
	const getList = () => {
		listLoading.value = true
		let params = JSON.parse(JSON.stringify(listQuery.value))
		if (searchQuery.value.title && searchQuery.value.title != '') {
			params['title'] = `%${searchQuery.value.title}%`
		}
		context?.$http({
			url: `news/list`,
			method: 'get',
			params: params
		}).then(res => {
			listLoading.value = false
			list.value = res.data.data.list
			total.value = res.data.data.total
		})
	}
	
	const centerType = ref(false)
	const backClick = () => { router.push(`/index/${context?.$toolUtil.storageGet('frontSessionTable')}Center`) }
	
	const init = () => {
		if (route.query.centerType) { centerType.value = true }
		getList()
	}
	init()
</script>

<style lang="scss" scoped>
/* 样式保留原版，仅去除弹窗依赖 */
.news_list_five .news_top .five_top_item .img_box img { width: 100%; height: 100%; object-fit: cover; }
.news_list_five .news_top .five_top_item .news_title { font-size: 18px; line-height: 30px; margin-top: 15px; font-weight: bold;}
.news_list_five .news_top .five_top_item .news_text { display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; color: #666; margin-top: 10px;}
.news_list_five .news_bottom .five_bottom_item { background: #fdfdfd; padding: 0; display: flex; align-items: center; box-shadow: 0 4px 12px rgba(0,0,0,0.05); border-radius: 8px; overflow: hidden; transition: all 0.3s;}
.news_list_five .news_bottom .five_bottom_item:hover { transform: translateY(-3px); box-shadow: 0 8px 20px rgba(0,0,0,0.1); }
.news_list_five .news_bottom .time_box { background: #4A90E2; color: #fff; width: 100px; height: 100px; display: flex; flex-direction: column; align-items: center; justify-content: center; }
.news_list_five .news_bottom .time_box .date { font-size: 28px; font-weight: bold; }
.news_list_five .news_bottom .content { padding: 15px 20px; flex: 1; }
.news_list_five .news_bottom .news_title { font-size: 16px; font-weight: bold; color: #333; }
.news_list_five .news_bottom .news_text { margin-top: 8px; color: #666; font-size: 14px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; }
</style>
<style>
.news-page { padding: 30px calc(50% - 600px); width: 100%; background: #f7f8fa; min-height: 800px;}
.news-page .list_search { display: flex; align-items: center; justify-content: center; margin: 0 auto 30px; background: #fff; box-shadow: 0 4px 12px rgba(0,0,0,0.05); border-radius: 8px; height: 70px; padding: 0 20px;}
.news-page .list_search .search_view { display: flex; align-items: center; flex: 1; }
.news-page .list_search .search_inp { border: none !important; }
.news-page .list_search .search_btn { background: #4A90E2; border: none; height: 40px; border-radius: 20px; width: 100px; font-size: 16px; }
.news-page .news_top { display: flex; gap: 30px; margin-bottom: 30px;}
.news-page .five_top_item { flex: 1; border-radius: 12px; padding: 20px; background: #fff; box-shadow: 0 4px 12px rgba(0,0,0,0.05); transition: all 0.3s; cursor: pointer; }
.news-page .five_top_item:hover { transform: translateY(-5px); box-shadow: 0 12px 24px rgba(0,0,0,0.1); }
.news-page .img_box { width: 100%; height: 220px; border-radius: 8px; overflow: hidden; }
.news-page .news_bottom { display: grid; grid-template-columns: 1fr 1fr; gap: 30px; margin-top: 30px; }
</style>