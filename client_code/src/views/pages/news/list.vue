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
					<div class="five_top_item animation_box" v-if="index<3" @click.stop="newsDetail(item.id)">
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
					<div class="five_bottom_item animation_box" v-if="index>2" @click.stop="newsDetail(item.id)">
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
		
		
		<formModel ref="formModelRef"></formModel>
	</div>
</template>

<script setup>
	import moment from 'moment'
	import formModel from './formModel'
	import {
		ref,
		nextTick,
		getCurrentInstance
	} from 'vue';
	import {
		ElMessageBox
	} from 'element-plus'
	import {
		useRoute,
		useRouter
	} from 'vue-router'
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	//基础信息
	const tableName = 'news'
	const formName = '健康资讯'
	const router = useRouter()
	const route = useRoute()
	//基础信息
    const breadList = ref([{
        name: formName
    }])
	//权限验证
	const btnAuth = (e, a) => {
		return context?.$toolUtil.isAuth(e, a)
	}
	const list = ref([])
	const listLoading = ref(false)
	const listQuery = ref({
		page: 1,
		limit: 20,
		sort: 'addtime',
		order: 'desc'
	})
	const searchQuery = ref({})
	//分页
	const layouts = ref(["total","prev","pager","next","sizes","jumper"])
	const total = ref(0)
	const sizeChange = (size) => {
		listQuery.value.limit = size
		getList()
	}
	const currentChange = (page) => {
		listQuery.value.page = page
		getList()
	}
	//分页
	const searchClick = () => {
		listQuery.value.page = 1
		getList()
	}
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
	//判断是否从个人中心跳转
	const centerType = ref(false)
	//返回
	const backClick = () => {
		router.push(`/index/${context?.$toolUtil.storageGet('frontSessionTable')}Center`)
	}
	const init = () => {
		if (route.query.centerType) {
			centerType.value = true
		}
		getList()
        nextTick(()=>{
            if(route.query.id){
                newsDetail(route.query.id)
            }
        })
	}
	//定义弹窗
	const formModelRef = ref(null)
	const newsDetail = (id = null) => {
		if (id) {
			formModelRef.value.init(id)
		}
	}
	init()
</script>

<style lang="scss" scoped>
	// 返回盒子
	.back_view {
		// 返回按钮
		.back_btn {
		}
		// 返回按钮-悬浮
		.back_btn:hover {
		}
	}
	//搜索
	.list_search {
		.search_view {
			.search_label {
			}
			.search_box {
				// 输入框
				:deep(.search_inp) {

				}
			}
		}
		.search_btn_view {
			// 搜索按钮
			.search_btn {
			}
			// 搜索按钮-悬浮
			.search_btn:hover {
			}
		}
	}
	.news_list_five {
		.news_top {
			.five_top_item{
				.img_box {
					img {
					}
				}
				.content{
					.news_title{
					}
					.news_text{
					}
				}
			}
		}
		.news_bottom {
			.five_bottom_item {
				.time_box {
					.year{
					}
					.date{
					}
				}
				.content {
					.news_title {
					}
					.news_text{
					}
				}
			}
		}
	}
	// animation
	.animation_box {
		transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
		z-index: initial;
	}
	.animation_box:hover {
	}
	.animation_box img {
		transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
		z-index: initial;
	}
	.animation_box img:hover {
	}
	// animation
	// 分页器
	.el-pagination {
		// 总页码
		:deep(.el-pagination__total) {
		}
		// 上一页
		:deep(.btn-prev) {
		}
		// 下一页
		:deep(.btn-next) {
		}
		// 上一页禁用
		:deep(.btn-prev:disabled) {
		}
		// 下一页禁用
		:deep(.btn-next:disabled) {
		}
		// 页码
		:deep(.el-pager) {
			// 数字
			.number {
			}
			// 数字悬浮
			.number:hover {
			}
			// 选中
			.number.is-active {
			}
		}
		// sizes
		:deep(.el-pagination__sizes) {
			.el-select {
				//去掉默认样式
				.select-trigger{
					height: 100%;
					.el-input{
						height: 100%;

					}
				}
			}
		}
		// 跳页
		:deep(.el-pagination__jump) {
			// 输入框
			.el-input {

			}
		}
	}
</style>
<style>

.news-page {
    padding: 20px calc(50% - 600px);
    width: 100%;
    background: rgba(247, 247, 247, 1);
    position: relative;
    display: flex;
    flex-wrap: wrap;
}


.news-page .list_search{
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 20px auto;
    background: none;
    width: 100%;
    background: #fff;
    box-shadow: 0px 3px 7px 0px rgba(0,0,0,0.3);
    height: 60px;
}
.news-page .list_search.el-form .search_view .search_box .search_inp {
    border: none;
}
.news-page .list_search .search_view{
    display: flex;
    align-items: center;
    justify-content: center;
    font-size:16px;
    
    flex: 1;
}
.news-page .list_search .search_view .search_label{
    white-space:nowrap;
    padding-left: 20px;
}
.news-page .list_search .search_view .search_box .el-input .el-input__inner{
    border:1px solid #ddd;
    padding:0 10px;
    height:38px;
    line-height:38px;
    background: #fff;
    border: none;
}
.news-page .list_search .search_btn_view{
    margin-left:10px;
}
.news-page .list_search.el-form .search_btn_view .search_btn{
    background:var(--theme);
    border:0px solid var(--theme);
    height: 60px;
    border-radius: 0;
    width: 120px;
    font-size: 18px;
}
.news-page .list_search .search_btn_view .search_btn:hover{
    opacity: 0.8;
}


.news-page .categorys{
    font-size:16px;
    background: rgba(66, 66, 66, 1);
    padding: 10px 20px;
    width: 150px;
    
    display: flex;
    width: 100%;
}

.news-page .categorys .category{
    font-size:16px;
    border:0px solid #ddd;
    padding:0 10px;
    height:38px;
    line-height:38px;
    margin-right:10px;
    min-width:120px;
    text-align: center;
    color: #fff;
    
    border-radius: 6px;
}


.news-page .news_list_one{
    width: 100%;
    height: auto;
    background: none;
    padding: 0px;
    display: grid;
    grid-template-columns: 585px 585px;
    grid-gap: 22px 30px;
    margin-bottom: 30px;
}
.news-page .news_list_one .list-item{
    width: 100%;
    display: flex;
    margin: 0px;
    height: 120px;
    justify-content: space-between;
    padding: 10px;
    cursor: pointer;
    background: #fff;
    border-radius: 6px;
}

.news-page .news_list_one .list-item .news_img_box{
    width: 230px;
    height: 160px;
    order: 1;
    display: none;
    flex-shrink: 0;
}
.news-page .news_list_one .list-item .news_img_box .news_img{
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 6px;
    position: relative;
    top: -60px;
}

.news-page .news_list_one .list-item .news_content{
    width: calc(100% - 170px);
    display: flex;
    flex-direction: column;
}
.news-page .news_list_one .list-item .news_content .news_title{
    padding: 0px;
    line-height: 24px;
    color: rgb(51, 51, 51);
    font-size: 16px;
    width: 100%;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    font-weight: 600;
}
.news-page .news_list_one .list-item .news_content .news_intro{
    padding: 0px;
    line-height: 22px;
    color: rgb(102, 102, 102);
    font-size: 14px;
    overflow: hidden;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
}
.news-page .news_list_one .list-item .news_content .news_time{
    padding: 4px;
    line-height: 16px;
    color: #fff;
    font-size: 12px;
    box-sizing: border-box;
    background: var(--theme);
    width: 74px;
    text-align: center;
    margin-top: auto;
}


.news-page .news_detail{
    width: 100%;
}
.news-page .news_detail .news_detail_title{
    font-size: 24px;
    font-weight: bold;
    color: rgb(0, 0, 0);
}
.news-page .news_detail .news_detail_time{
    text-align: right;
    font-size: 16px;
    color: rgb(153, 153, 153);
    padding: 20px 0px 0px;
}
.news-page .news_detail .news_detail_content{
    margin-top:20px;
    text-align: left;
    font-size: 16px;
    line-height:1.8;
}


.news-page .news_top {
    display: flex;
    column-gap: 30px;
}


.news-page .five_top_item {flex: 1;border-radius: 8px;padding: 18px;top: 0;position: relative;transition: top 0.3s;cursor: pointer;}

.news-page .img_box {
    width: 100%;
    height: 240px;
}

.news-page img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.news-page .five_top_item .news_title {
    font-size: 18px;
    line-height: 30px;
}

.news-page .five_top_item .content {
    margin-top: 20px;
}

.news-page .news_text {display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;overflow: hidden;text-overflow: ellipsis;}

.news-page .news_bottom {
    display: grid;
    grid-template-columns: 1fr 1fr;
    margin-top: 30px;
    gap: 30px;
}

.news-page .five_bottom_item:hover {
    background: var(--theme);
    color: #fff;
    cursor: pointer;
}

.news-page .five_bottom_item {
    background: rgba(235, 241, 248, 1);
    padding: 0;
    display: flex;
    border-radius: 0px;
    align-items: center;
    box-shadow: 0px 3px 7px 0px rgba(0,0,0,0.3);
}

.news-page .five_bottom_item .time_box {
    
    color: rgba(66, 66, 66, 1);
    width: 100px;
    height: 100px;
    flex-shrink: 0;
    margin-right: 6px;
    font-size: 12px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    row-gap: 6px;
    border-radius: 0px;
    box-shadow: 0px 3px 7px 0px rgba(0,0,0,0.3);
}

.news-page .five_bottom_item:hover .time_box {
    background: #fff;
    color: var(--theme);
}

.news-page .five_bottom_item:hover .news_text {
    color: #fff;
}

.news-page .five_bottom_item .content {
    
    padding-left: 10px;
}

.news-page .five_bottom_item .news_text {
    margin-top: 10px;
}

.news-page .five_top_item:hover {
    top: -10px;
}
.news-page .news_list_one .list-item:nth-child(1),.news-page .news_list_one .list-item:nth-child(2),.news-page .news_list_one .list-item:nth-child(3),.news-page .news_list_one .list-item:nth-child(4) {margin-top: 50px;}
.news-page .news_list_one .list-item:nth-child(1) .news_img_box,.news-page .news_list_one .list-item:nth-child(2) .news_img_box,.news-page .news_list_one .list-item:nth-child(3) .news_img_box,.news-page .news_list_one .list-item:nth-child(4) .news_img_box {
    display: block;
}


.news-page .news_list_six {
    flex: 1;
}

.news-page .categorys .category.active,.news-page .categorys .category:hover {
    background: #fff;
    color: var(--theme);
}

.news-page .six_item {
    width: 100%;
    display: flex;
    margin: 0px 0px 10px;
    border-width: 1px;
    border-style: solid;
    border-color: rgba(239, 236, 227, 1);
    border-image: initial;
    padding: 14px 0px;
    background: rgba(239, 236, 227, 1);
    cursor: pointer;
}

.news-page .time_box {
    width: 120px;
    height: 90px;
    
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    color: rgba(54, 49, 53, 1);
}

.news-page .year {
}

.news-page .date {
    font-size: 30px;
    font-weight: 700;
}

.news-page .content {
    width: calc(100% - 100px);
    margin: 0;
}

.news-page .news_title {}

.news-page .news_text {
    padding: 10px 0px 0px;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    -webkit-line-clamp: 2;
}

.news-page .six_item:hover {
    border: 1px solid var(--theme);
}

.news-page .six_item:hover .time_box {
    background: var(--theme);
    color: #fff;
}

.news-page .six_item:hover .content {
    color: var(--theme);
}


.news-page .search_box {
    flex: 1;
}

.news-page .hot_view{
    background-size: 100% 100%;
    position: relative;
    padding: 20px 0;
    margin-top: 30px;
    width: 100%;
}
.news-page .hot_view .hot_title{text-align: center;}
.news-page .hot_view .hot_title span{color: var(--theme);text-align: center;font-size: 24px;padding: 10px 40px;border: 2px solid rgba(66, 66, 66, 1);display: inline-block;margin-bottom: 30px;position: relative;}

.news-page .hot_view .hot_list{
    width: 100%;
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
    margin: 20px 0px 0px;
    grid-gap: 20px 14px;
}

.news-page .hot_view .hot_list .hot{
    width: 100%;
    margin: 0;
    background: #fff;
    padding: 16px;
    box-sizing: border-box;
    cursor: pointer;
    display: flex;
    align-items: center;
    border-radius: 4px;
}
.news-page .hot_view .hot_list .hot .hot_img_view .hot_img{
    width: 100%;
    height: 80px;
}
.news-page .hot_view .hot_list .hot .hot_img_view .hot_img .el-image__inner{
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.news-page .hot_view .hot_list .hot .hot_content{
    width: 100%;
}
.news-page .hot_view .hot_list .hot .hot_content .hot_text{
    width: 100%;
    font-size: 16px;
    color: rgb(51, 51, 51);
    line-height: 2;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
}

.news-page .hot_view .hot_title span:before {
    position: absolute;
    content: '';
    width: 80px;
    height: 2px;
    background: var(--theme);
    left: -66px;
    top: 50%;
}
.news-page .hot_view .hot_title span:after {
    position: absolute;
    content: '';
    width: 80px;
    height: 2px;
    background: var(--theme);
    right: -66px;
    top: 50%;
}

.news-page .hot_img_view {
    width: 100px;
    display: flex;
    flex-shrink: 0;
    margin-right: 16px;
}

.news-page .news_list_five {
    background: #fff;
    padding: 20px 20px 50px;
}
</style>