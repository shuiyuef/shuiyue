<template>
	<div>
		<div class="home_box">
			<!-- 关于我们 -->
			<div class="aboutUs_view">
				<div class="aboutUs_title"><span>{{aboutUsDetail.title}}</span></div>
				<div class="aboutUs_subtitle"><span>{{aboutUsDetail.subtitle}}</span></div>
				<div class="aboutUs_content"><div v-html="aboutUsDetail.content"></div></div>
				<div class="aboutUs_img_box">
					<img class="aboutUs_img1" :src="aboutUsDetail.picture1?$config.url + aboutUsDetail.picture1:''" alt="">
					<img class="aboutUs_img2" :src="aboutUsDetail.picture2?$config.url + aboutUsDetail.picture2:''" alt="">
					<img class="aboutUs_img3" :src="aboutUsDetail.picture3?$config.url + aboutUsDetail.picture3:''" alt="">
				</div>
				<div class="aboutUs_default1"></div>
				<div class="aboutUs_default2"></div>
				<div class="aboutUs_default3"></div>
				<div class="aboutUs_default4"></div>
			</div>
			<!-- 系统简介 -->
			<div class="systemInfo_view">
				<div class="systemInfo_title"><span>{{systemInfoDetail.title}}</span></div>
				<div class="systemInfo_subtitle"><span>{{systemInfoDetail.subtitle}}</span></div>
				<div class="systemInfo_content"><div v-html="systemInfoDetail.content"></div></div>
				<div class="systemInfo_img_box">
					<img class="systemInfo_img1" :src="systemInfoDetail.picture1?$config.url + systemInfoDetail.picture1:''" alt="">
					<img class="systemInfo_img2" :src="systemInfoDetail.picture2?$config.url + systemInfoDetail.picture2:''" alt="">
					<img class="systemInfo_img3" :src="systemInfoDetail.picture3?$config.url + systemInfoDetail.picture3:''" alt="">
				</div>
				<div class="systemInfo_default1"></div>
				<div class="systemInfo_default2"></div>
				<div class="systemInfo_default3"></div>
				<div class="systemInfo_default4"></div>
			</div>
			<!-- 菜品信息推荐 -->
			<div class="recomList_view">
				<div class="recomList_title">
                    <span>菜品信息推荐</span>
                </div>
				<div class="recommend_list_two">
					<mySwiper :data="caipinxinxiRecomList" :type="3"
						:loop="true"
						:navigation="false"
						:pagination="false"
						:paginationType="1"
						:scrollbar="false"
						:slidesPerView="5"
						:spaceBetween="20"
						:autoHeight="false"
						:centeredSlides="false"
						:freeMode="false"
						:effectType="2"
						:direction="horizontal"
						:autoplay="false"
						:slidesPerColumn="1">
						<template #default="scope">
							<div class="recommend_item animation_box" @click="detailClick('caipinxinxi',scope.row.id)">
								<div class="recommend_img_box">
									<img class="recommend_img" v-if="isHttp(scope.row.caipintupian)" :src="scope.row.caipintupian.split(',')[0]" alt="">
									<img class="recommend_img" v-else :src="scope.row.caipintupian?$config.url + scope.row.caipintupian.split(',')[0]:''" alt="">
								</div>
								<div class="recommend_content">
									<div class='recommend_title'>
										{{scope.row.caipinmingcheng}}
									</div>
									<div class="recommend_price">
										￥{{scope.row.price}}
									</div>
									<div class="recommend_bottom">
										<div class="recommend_like" v-if="scope.row.thumbsupNumber">
											<span class="iconfont icon-thumb-up-line1 like_icon"></span>
											<div class="num">{{scope.row.thumbsupNumber}}</div>
										</div>
										<div class="recommend_collect" v-if="scope.row.storeupNumber">
											<el-icon><StarFilled /></el-icon>
											<div class="num">{{scope.row.storeupNumber}}</div>
										</div>
										<div class="recommend_clickNum" v-if="scope.row.clickNumber">
											<el-icon><View /></el-icon>
											<div class="num">{{scope.row.clickNumber}}</div>
										</div>
									</div>
								</div>
							</div>
						</template>
					</mySwiper>
				</div>
				<div class="recommend_more_view" @click="moreClick('caipinxinxi')">
					<span class="recommend_more_text">查看更多</span>
				</div>
			</div>
			<!-- 健康资讯 -->
			<div class="newsList_view">
				<div class="ntitle"><div class="n1">健康资讯</div></div>
				
				    <div class="nlist">
				         <ul> 
				        <li v-for="(item,index) in newsList" :key="index" @click="newsDetailClick(item)">
				          
				          <div class="tim"><div class="t1">{{moment(item.addtime).format('DD')}}</div><div class="t2">{{moment(item.addtime).format('YYYY-MM-DD')}}</div></div>
				          
				          <div class="infobox">
				            <div class="nam">{{item.title}}</div>
				            <div class="info">{{item.introduction}}</div>
				          </div>
				          
				        </li>
				         </ul> 
				    </div>
				
				<div class="nmore" @click="moreClick('news')" style="cursor: pointer">查看更多</div>
			</div>

		</div>
		<formModel ref="newsFormModelRef"></formModel>
	</div>
</template>

<script setup>
	import {
		ref,
		getCurrentInstance
	} from 'vue';
	import moment from 'moment'
	import {
		useRouter
	} from 'vue-router';
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const router = useRouter()
	//关于我们
	const aboutUsDetail = ref({})
	const getAboutUs = () => {
		context?.$http({
			url: 'aboutus/detail/1',
			method: 'get',
		}).then(res=>{
			aboutUsDetail.value = res.data.data
		})
	}
	//系统简介
	const systemInfoDetail = ref({})
	const getSystemInfo = () => {
		context?.$http({
			url: 'systemintro/detail/1',
			method: 'get',
		}).then(res=>{
			systemInfoDetail.value = res.data.data
		})
	}
	//菜品信息推荐
	const caipinxinxiRecomList = ref([])
	const getcaipinxinxiRecomList = () => {
		let autoSortUrl = 'caipinxinxi/autoSort'
		if(context?.$toolUtil.storageGet('frontToken')){
			autoSortUrl = "caipinxinxi/autoSort2"
		}
		let params = {
			page: 1,
			limit: 14
		}
		context?.$http({
			url: autoSortUrl,
			method: 'get',
			params: params
		}).then(res => {
			caipinxinxiRecomList.value = res.data.data.list
			caipinxinxiRecomList.value.forEach(item=>{
				if(!isHttp(item.caipintupian)){
					item.imgUrls = item.caipintupian.split(',').map(item=>context.$config.url+item)
				}
			})
		})
	}
	//健康资讯弹窗
	import formModel from './news/formModel'
	const newsFormModelRef = ref(null)
	//健康资讯
	const newsList = ref([])
	const getNewsList = () => {
		context?.$http({
			url: 'news/list',
			method: 'get',
			params:{
				page:1,
				limit: 4,
                sort:'id',
                order:'desc',
			}
		}).then(res=>{
			newsList.value = res.data.data.list
			newsList.value.forEach(item=>{
				if(!isHttp(item.picture)){
					item.imgUrl=context.$config.url+item.picture.split(',')[0]
				}
			})
		})
	}
	const newsDetailClick = (item) => {
		if (item && item.id){
			newsFormModelRef.value.init(item.id)
		}
	}
	//判断图片链接是否带http
	const isHttp = (str) => {
        return str && str.substr(0,4)=='http';
    }
	//跳转详情
	const detailClick = (table,id) => {
		router.push(`/index/${table}Detail?id=${id}`)
	}
	const moreClick = (table) => {
		router.push(`/index/${table}List`)
	}
	const init = () => {
		getAboutUs()
		getSystemInfo()
		//菜品信息推荐
		getcaipinxinxiRecomList()
		//健康资讯
		getNewsList()
	}
	init()
</script>

<style lang="scss">
	.home_box {
	}

	.aboutUs_view {
		.aboutUs_title {
		}

		.aboutUs_subtitle {
		}
		.aboutUs_content {
		}
		.aboutUs_img_box {
			.aboutUs_img1 {
			}

			.aboutUs_img2 {
			}

			.aboutUs_img3 {
			}
		}
		// 自定义盒子一
		.aboutUs_default1 {
			margin: 0 auto;
			background: #d5a1b1;
			display: none;
			width: 100px;
			height: 100px;
		}
		// 自定义盒子二
		.aboutUs_default2 {
			margin: 0 auto;
			background: #d5a1b1;
			display: none;
			width: 100px;
			height: 100px;
		}
		// 自定义盒子三
		.aboutUs_default3 {
			margin: 0 auto;
			background: #d5a1b1;
			display: none;
			width: 100px;
			height: 100px;
		}
		// 自定义盒子四
		.aboutUs_default4 {
			margin: 0 auto;
			background: #d5a1b1;
			display: none;
			width: 100px;
			height: 100px;
		}
	}
	.systemInfo_view {
		.systemInfo_title {
		}

		.systemInfo_subtitle {
		}
		.systemInfo_content {
		}
		.systemInfo_img_box {
			.systemInfo_img1 {
			}

			.systemInfo_img2 {
			}

			.systemInfo_img3 {
			}
		}
		// 自定义盒子一
		.systemInfo_default1 {
			margin: 0 auto;
			background: #d5a1b1;
			display: none;
			width: 100px;
			height: 100px;
		}
		// 自定义盒子二
		.systemInfo_default2 {
			margin: 0 auto;
			background: #d5a1b1;
			display: none;
			width: 100px;
			height: 100px;
		}
		// 自定义盒子三
		.systemInfo_default3 {
			margin: 0 auto;
			background: #d5a1b1;
			display: none;
			width: 100px;
			height: 100px;
		}
		// 自定义盒子四
		.systemInfo_default4 {
			margin: 0 auto;
			background: #d5a1b1;
			display: none;
			width: 100px;
			height: 100px;
		}
	}
	// 推荐
	.recomList_view {
		.recomList_title {
		}
		// list
		.recommend_list_two {
			.recommend_item {
				.recommend_img_box {
					.recommend_img {
					}
				}
				.recommend_content {
					.recommend_title {
					}
					.recommend_price {
					}
					.recommend_bottom {
						.recommend_like {
							.like_icon {
							}
							.num {
							}
						}
						.recommend_collect {
							.el-icon {
							}
							.num {
							}
						}
						.recommend_clickNum {
							.el-icon {
							}
							.num {
							}
						}
					}
				}
			}
		}
		// list
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
		// 更多
		.recommend_more_view {
			.recommend_more_text {
			}
		}
	}
	// 推荐
	// 新闻资讯
	.newsList_view {

		.newsList_title {
		}
		// list
		.news_list_one {
			display: flex;
			flex-wrap: wrap;
			.news_item {
				box-shadow: 0 4px 6px rgba(0,0,0,.3);
				margin: 0 10px 10px;
				background: #fff;
				display: flex;
				width: calc(33% - 20px);
				align-items: center;
				.news_img_box {
					width: 40%;
					font-size: 0;
					.news_img {
						object-fit: cover;
						width: 100%;
						height: 200px;
					}
				}
				.news_content {
					margin: 0 0 0 20px;
					width: calc(60% - 20px);
					.news_title {
						font-weight: bold;
						font-size: 20px;
					}
					.news_text {
						font-size: 14px;
						line-height: 1.5;
					}
					.news_time {
						color: #999;
						width: 100%;
						text-align: right;
					}
				}
			}
		}
		// list
		// animation
		.animation_box {
			transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			z-index: initial;
		}
		.animation_box:hover {
			transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			-webkit-perspective: 1000px;
			perspective: 1000px;
			transition: 0.3s;
		}
		.animation_box img {
			transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			z-index: initial;
		}
		.animation_box img:hover {
			transform: rotate(0deg) scale(1) skew(0deg, 0deg) translate3d(0px, 0px, 0px);
			-webkit-perspective: 1000px;
			perspective: 1000px;
			transition: 0.3s;
		}
		// animation
		// 更多
		.news_more_view {
			.news_more_text {
			}
			.el-icon {
			}
		}
	}
	// 新闻资讯
	// 首页展示
	.homeList_view {

		.homeList_title {
		}
		// list
		// list
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
		// 更多
		.homeList_more_view {
			.homeList_more_text {
			}
		}
	}
	// 首页展示
</style>
<style>
.home_box {
    display: flex;
    flex-direction: column;
}

.homeList_view {
    order: 2;
}

.aboutUs_view {
    order: 5;
}

.recomList_view {
    order: 3;
}

.friendLink {
    order: 4;
}

.newsList_view {
    order: 6;
}

.systemInfo_view {
    order: 8;
}

.onlineMessage {
    order: 7;
}
/* 总盒子 */
.aboutUs_view {
    width: 100%;
    padding: 30px calc(50% - 500px);
    background-size: 100% 100%;
    position: relative;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    background: url(http://clfile.zggen.cn/20250103/29f03471183a4fb5a147f0cea0272387.webp);
    background-size: 100% 100%;
}
/* 标题 */
.aboutUs_view .aboutUs_title{
    width: 100%;
    text-align: center;
}
/* 副标题 */
.aboutUs_view .aboutUs_subtitle{
    width: 100%;
    display: none;
    font-size: 16px;
    color: var(--theme);
    text-align: center;
}
/* 内容 */
.aboutUs_view .aboutUs_content{
    padding: 0px;
    border: 0px solid rgb(238, 238, 238);
    font-size: 16px;
    color: #333;
    line-height: 2.5em;
    text-indent: 2em;
    padding: 20px;
    align-items: center;
    display: flex;
    flex: 1;
}
.aboutUs_view .aboutUs_img_box{
    margin: 0;
    align-items: center;
    display: grid;
    grid-template-columns: 1fr 1fr;
    width: 360px;
    grid-gap: 20px;
}
/* 自定义盒子 */
.aboutUs_view .aboutUs_default1{
    width: 100px;
    height: 100px;
    background: rgb(213, 161, 177);
    margin: 0px auto;
    display: none;
}


.aboutUs_view .more {
    border: var(--theme);
    width: 149px;
    height: 43px;
    background: rgba(24, 88, 232, 0.10);
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--theme);
    border-radius: 6px;
}

.aboutUs_view .aboutUs_img_box img {
    height: 200px;
    object-fit: cover;
    width: 100%;
}

.aboutUs_view .aboutUs_title span {color: var(--theme);text-align: center;font-size: 24px;padding: 10px 40px;border: 2px solid rgba(66, 66, 66, 1);display: inline-block;margin-bottom: 30px;position: relative;}

.aboutUs_view .aboutUs_title span:before {
    position: absolute;
    content: '';
    width: 80px;
    height: 2px;
    background: var(--theme);
    left: -66px;
    top: 50%;
}
.aboutUs_view .aboutUs_title span:after {
    position: absolute;
    content: '';
    width: 80px;
    height: 2px;
    background: var(--theme);
    right: -66px;
    top: 50%;
}

img.aboutUs_img3 {
    width: 100%;
    grid-column: 1/-1;
}
/* 总盒子 */
.systemInfo_view {
    width: 100%;
    display: flex;
    flex-wrap: wrap;
    padding: 30px calc(50% - 600px);
    position: relative;
    min-height: 500px;
    background: url(http://clfile.zggen.cn/20250103/29f03471183a4fb5a147f0cea0272387.webp);
}
/* 标题 */
.systemInfo_view .systemInfo_title{text-align: center;width: 100%;}
/* 副标题 */
.systemInfo_view .systemInfo_subtitle{
    width: 100%;
    display: block;
    font-size: 16px;
    color: rgb(153, 153, 153);
    text-align: center;
    line-height: 40px;
    display: none;
}
/* 内容 */
.systemInfo_view .systemInfo_content{
    border: 0px solid rgb(238, 238, 238);
    font-size: 16px;
    color: rgb(102, 102, 102);
    line-height: 2.5em;
    text-indent: 2em;
    display: flex;
    /* align-items: center; */
    /* background: #fff; */
    padding: 20px;
    order: 4;
    /* width: 500px; */
    flex: 1;
}
/* 图片 样式一 盒子 */
.systemInfo_view .systemInfo_img_box{
    padding: 0px;
    display: grid;
    grid-gap: 20px;
    height: calc(100% - 30px);
    width: 400px;
    grid-template-columns: 1fr 1fr;
}
.systemInfo_view .systemInfo_img_box .systemInfo_img1{
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-radius: 0;
    margin-top: auto;
}
.systemInfo_view .systemInfo_img_box .systemInfo_img2{
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-radius: 0;
    margin-top: auto;
}
.systemInfo_view .systemInfo_img_box .systemInfo_img3{
    width: 100%;
    height: 200px;
    object-fit: cover;
    margin-top: auto;
    border-radius: 0;
}


.systemInfo_view img.systemInfo_img {
    width: 500px;
    height: 400px;
    position: relative;
}

.systemInfo_view .systemInfo_title span {color: var(--theme);text-align: center;font-size: 24px;padding: 10px 40px;border: 2px solid rgba(66, 66, 66, 1);display: inline-block;margin-bottom: 30px;position: relative;}

.systemInfo_view .systemInfo_title span:before {
    position: absolute;
    content: '';
    width: 80px;
    height: 2px;
    background: var(--theme);
    left: -66px;
    top: 50%;
}
.systemInfo_view .systemInfo_title span:after {
    position: absolute;
    content: '';
    width: 80px;
    height: 2px;
    background: var(--theme);
    right: -66px;
    top: 50%;
}

img.systemInfo_img3 {
    grid-column: 1/-1;
}
.recomList_view {
    padding: 30px 0;
    position: relative;
    /* background: var(--theme); */
    text-align: center;
    background: rgba(228, 228, 228, 1);
}

.recomList_view .recomList_title {
    color: var(--theme);
    text-align: center;
    font-size: 24px;
    padding: 10px 40px;
    border: 2px solid rgba(66, 66, 66, 1);
    display: inline-block;
    margin-bottom: 30px;
    position: relative;
}

.recomList_view .recomList_title:before {
    position: absolute;
    content: '';
    width: 80px;
    height: 2px;
    background: var(--theme);
    left: -66px;
    top: 50%;
}
.recomList_view .recomList_title:after {
    position: absolute;
    content: '';
    width: 80px;
    height: 2px;
    background: var(--theme);
    right: -66px;
    top: 50%;
}

.recomList_view .recommend_item {
    padding: 15px;
    width: 100%;
    background: #fff;
    border-radius: 4px;
}

.recomList_view img.recommend_img {
    height: 14vw;
    width: 100%;
    object-fit: cover;
}

.recomList_view .recommend_title {
    padding: 10px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.recomList_view .recommend_price {
    color: rgba(150, 0, 0, 1);
    padding: 6px;
}

.recomList_view .recommend_bottom {
    display: flex;
    justify-content: space-around;
    padding: 12px;
}

.recomList_view .recommend_like {
    display: flex;
    color: var(--theme);
}

.recomList_view .recommend_collect {
    display: flex;
    color: rgba(95, 179, 168, 1);
}

.recomList_view .recommend_clickNum {
    color: rgba(68, 130, 180, 1);
    display: flex;
}

.recomList_view .recommend_more_view {
    color: #fff;
    background: var(--theme);
    display: inline-block;
    padding: 6px 20px;
    margin-top: 20px;
}
/* 总盒子 */
.newsList_view {
    width: 100%;
    margin:0;
    padding: 60px 0;
    background: url(http://clfile.zggen.cn/20250103/4ea4277d4feb4995a0e542d8ed7b4425.webp);
    overflow: hidden;
    position:relative;
    display:block;
}
/* 自定义 start*/
.newsList_view .ntitle{
    width: 1200px;
    margin:0 auto;
    background:url(http://clfile.zggen.cn/20241016/d6fe1c51711a4cb5a8c5256a338f33fc.png) no-repeat center bottom;
    text-align: center;
    padding: 0 0 20px;
}
.newsList_view .ntitle .n1{
    color: var(--theme);
    text-align: center;
    font-size: 24px;
    padding: 10px 40px;
    border: 2px solid rgba(66, 66, 66, 1);
    display: inline-block;
    margin-bottom: 30px;
    position: relative;
}
.newsList_view .ntitle .n1:before{
    position: absolute;
    content: '';
    width: 80px;
    height: 2px;
    background: var(--theme);
    left: -66px;
    top: 50%;
}
.newsList_view .ntitle .n1:after{
    position: absolute;
    content: '';
    width: 80px;
    height: 2px;
    background: var(--theme);
    right: -66px;
    top: 50%;
}
.newsList_view .nlist{
    width: 1200px;
    margin:30px auto 0;
}
.newsList_view .nlist ul{
    margin:0;
    padding:0;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    justify-content: space-between;
}
.newsList_view .nlist ul li{
    width: 48%;
    text-align: left;
    background: none;
    border: 0px dashed #aaa;
    cursor:pointer;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    justify-content: space-between;
    margin:0 0 30px;
}
.newsList_view .nlist ul li:last-child{
    border-bottom: none;
}
.newsList_view .nlist ul li .imgbox{
    width: 100px;
    height: 100px;
}
.newsList_view .nlist ul li .imgbox img{
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.newsList_view .nlist ul li .tim {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 100px;
    box-shadow: 0px 3px 7px 0px rgba(0,0,0,0.3);
    height: 100px;
}
.newsList_view .nlist ul li .tim .t1 {
    width: 100%;
    text-align: center;
    font-size: 48px;
    color: #ddd;
}
.newsList_view .nlist ul li .tim .t2 {
    width: 100%;
    text-align: center;
    line-height: 30px;
    color: #ddd;
}
.newsList_view .nlist ul li .infobox {
    width: calc(100% - 110px);
    flex: 1;
    padding: 0 20px;
}
.newsList_view .nlist ul li .infobox .nam {
    color: #000;
    font-size: 16px;
    font-weight: 600;
}
.newsList_view .nlist ul li .infobox .info {
    color: #888;
    font-size: 15px;
    line-height: 24px;
    height:48px;
    overflow:hidden;
    margin-top: 5px;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
}
/* 更多 */
.newsList_view .nmore{
    width: 120px;
    margin: 10px auto;
    display: block;
    color: #fff;
    border:1px solid #ffffff50;
    padding:10px;
    clear:both;
    text-align:center;
    background: var(--theme);
}
/* 自定义 end*/


.newsList_view .nlist ul li:hover {
    box-shadow: 0px 3px 7px 0px rgba(0,0,0,0.3);
}

.newsList_view .nlist ul li:hover .nam {
    color: var(--theme);
}
</style>