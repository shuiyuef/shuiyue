<template>
	<div class="modern-home-page">
		<div class="shortcut-area">
			<div class="shortcut-item health-item" @click="$router.push('/index/jiankangjianceAdd')">
				<div class="icon-box"><i class="el-icon-medal"></i></div>
				<span class="shortcut-text">健康打卡</span>
				<p class="shortcut-desc">每日记录您的健康指标</p>
			</div>
			<div class="shortcut-item doc-item" @click="$router.push('/index/jiankangjianceList')">
				<div class="icon-box"><i class="el-icon-document"></i></div>
				<span class="shortcut-text">健康档案</span>
				<p class="shortcut-desc">一键下载体检与食谱</p>
			</div>
			<div class="shortcut-item food-item" @click="$router.push('/index/caipinxinxiList')">
				<div class="icon-box"><i class="el-icon-food"></i></div>
				<span class="shortcut-text">营养大厅</span>
				<p class="shortcut-desc">浏览社区全部健康膳食</p>
			</div>
			<div class="shortcut-item feedback-item" @click="$router.push('/index/fankuiyujianyiAdd')">
				<div class="icon-box"><i class="el-icon-chat-line-square"></i></div>
				<span class="shortcut-text">意见反馈</span>
				<p class="shortcut-desc">倾听您的每一个建议</p>
			</div>
		</div>

		<div v-if="gonggaoList.length" class="gonggao-bar-modern">
			<div class="gonggao-label">
				<i class="el-icon-message-solid"></i> 社区广播
			</div>
			<el-carousel height="40px" direction="vertical" :autoplay="true" indicator-position="none" class="gonggao-carousel">
				<el-carousel-item v-for="(item, index) in gonggaoList" :key="index">
					<div class="gonggao-content" @click="toGonggaoDetail(item.id)">
						<span class="gonggao-tag">【{{ item.publisher }}】</span>
						<span class="gonggao-title">{{ item.title }}</span>
						<span class="gonggao-time">{{ item.addtime ? item.addtime.split(' ')[0] : '' }}</span>
					</div>
				</el-carousel-item>
			</el-carousel>
			<div class="gonggao-more" @click="toGonggaoList">
				更多公告 <i class="el-icon-arrow-right"></i>
			</div>
		</div>

		<div class="recommend-section" v-if="recommendList && recommendList.length > 0">
			<div class="section-header">
				<div class="title-left">
                    <i class="el-icon-magic-stick" style="color: #67C23A; font-size: 28px; margin-right: 10px;"></i>
                    <h2 class="title">专属健康膳食推荐</h2>
                </div>
				<p class="subtitle">系统依据您最新的【血压、血糖】档案，由算法为您精选以下易消化、均衡营养餐品。</p>
			</div>
			<div class="recommend-grid">
				<el-row :gutter="24">
					<el-col :xs="24" :sm="12" :md="8" :lg="6" v-for="(item, index) in recommendList" :key="index">
						<el-card shadow="hover" class="food-card" @click="$router.push(`/index/caipinxinxiDetail?id=${item.id}`)">
							<div class="food-img-wrapper">
								<img :src="item.caipintupian ? ($config.url + item.caipintupian.split(',')[0]) : ''" class="food-img" />
							</div>
							<div class="food-info">
								<h3 class="food-name">{{item.caipinmingcheng}}</h3>
								<div class="food-tags">
									<el-tag size="small" type="success" effect="plain" round v-if="item.kouwei">{{item.kouwei}}</el-tag>
									<el-tag size="small" type="warning" effect="light" round v-if="item.caipinfenlei" style="margin-left:5px">{{item.caipinfenlei}}</el-tag>
								</div>
								<div class="food-bottom">
									<span class="food-price">¥ {{item.price || item.danjia || '0.00'}}</span>
									<el-button type="primary" circle icon="el-icon-plus" size="small" class="add-btn"></el-button>
								</div>
							</div>
						</el-card>
					</el-col>
				</el-row>
			</div>
		</div>

        <div class="home-module" v-if="caipinxinxiList && caipinxinxiList.length > 0">
            <div class="module-header">
                <h2 class="module-title"><i class="el-icon-dish" style="color: #E6A23C; margin-right: 8px;"></i> 社区热门菜品</h2>
                <el-button type="primary" link @click="$router.push('/index/caipinxinxiList')">查看全部菜单 <i class="el-icon-arrow-right"></i></el-button>
            </div>
            <el-row :gutter="24">
                <el-col :xs="24" :sm="12" :md="8" :lg="6" v-for="(item, index) in caipinxinxiList.slice(0, 8)" :key="index" style="margin-bottom: 24px;">
                    <el-card shadow="hover" class="hot-food-card" @click="$router.push(`/index/caipinxinxiDetail?id=${item.id}`)">
                        <div class="img-zoom">
                            <img :src="item.caipintupian ? ($config.url + item.caipintupian.split(',')[0]) : ''" class="hot-img" />
                        </div>
                        <div class="hot-info">
                            <h3 class="hot-name">{{item.caipinmingcheng}}</h3>
                            <div class="hot-bottom">
                                <span class="hot-price">¥ {{item.price || item.danjia || '0.00'}}</span>
                                <span class="hot-sales" v-if="item.alllimittimes">今日余量: {{item.alllimittimes}}</span>
                            </div>
                        </div>
                    </el-card>
                </el-col>
            </el-row>
        </div>

        <div class="home-module" v-if="newsList && newsList.length > 0">
            <div class="module-header">
                <h2 class="module-title"><i class="el-icon-reading" style="color: #409EFF; margin-right: 8px;"></i> 社区动态与健康资讯</h2>
                <el-button type="primary" link @click="$router.push('/index/newsList')">更多资讯 <i class="el-icon-arrow-right"></i></el-button>
            </div>
            <div class="news-list">
                <el-row :gutter="30">
                    <el-col :span="12" v-for="(item, index) in newsList.slice(0, 6)" :key="index" style="margin-bottom: 20px;">
                        <div class="news-card" @click="$router.push(`/index/newsDetail?id=${item.id}`)">
                            <img :src="item.picture ? ($config.url + item.picture.split(',')[0]) : ''" class="news-img" />
                            <div class="news-content">
                                <h4 class="news-title">{{item.title}}</h4>
                                <p class="news-desc">{{item.introduction || '点击查看资讯详情...'}}</p>
                                <div class="news-time"><i class="el-icon-time"></i> {{item.addtime}}</div>
                            </div>
                        </div>
                    </el-col>
                </el-row>
            </div>
        </div>

	</div>

	<div class="home-module system-intro-section" v-if="systemInfoDetail && systemInfoDetail.title">
            <div class="module-header" style="border-bottom: none; margin-bottom: 20px;">
                <h2 class="module-title" style="font-size: 28px; color: #303133;">
                    <i class="el-icon-office-building" style="color: #4A90E2; margin-right: 10px;"></i> 
                    {{ systemInfoDetail.title || '系统简介' }}
                </h2>
                <span class="subtitle" style="font-size: 18px; color: #666;" v-if="systemInfoDetail.subtitle">{{ systemInfoDetail.subtitle }}</span>
            </div>
            
            <div class="intro-content-wrapper">
                <div class="intro-images" v-if="systemInfoDetail.picture1 || systemInfoDetail.picture2 || systemInfoDetail.picture3">
                    <div class="img-item" v-if="systemInfoDetail.picture1">
                        <img :src="systemInfoDetail.picture1.startsWith('http') ? systemInfoDetail.picture1.split(',')[0] : $config.url + systemInfoDetail.picture1.split(',')[0]" class="intro-img" />
                    </div>
                    <div class="img-item" v-if="systemInfoDetail.picture2">
                        <img :src="systemInfoDetail.picture2.startsWith('http') ? systemInfoDetail.picture2.split(',')[0] : $config.url + systemInfoDetail.picture2.split(',')[0]" class="intro-img" />
                    </div>
                    <div class="img-item" v-if="systemInfoDetail.picture3">
                        <img :src="systemInfoDetail.picture3.startsWith('http') ? systemInfoDetail.picture3.split(',')[0] : $config.url + systemInfoDetail.picture3.split(',')[0]" class="intro-img" />
                    </div>
                </div>
                
                <div class="intro-right">
                    <div class="rich-text-content elder-text" v-html="systemInfoDetail.content"></div>
                </div>
            </div>
        </div>

</template>

<script setup>
    // 1. 顶部集中所有 Import，防止重复引入
	import { ref, getCurrentInstance, onMounted } from 'vue';
	import moment from 'moment';
	import { useRouter } from 'vue-router';
	import formModel from './news/formModel';

	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const router = useRouter();

    // ================== 公告数据及方法 ==================
	const gonggaoList = ref([]); // 存公告列表的坑位
    
    // 去后端拿公告
    const getGonggaoList = () => {
        context?.$http({
            url: 'gonggao/list', // 我们后端的公告接口
            method: 'get',
            params: {
                page: 1,
                limit: 5, // 只拿最新的 5 条
                sort: 'addtime', // 按时间排序
                order: 'desc' // 倒序，最新的在最前面
            }
        }).then(res => {
            if(res.data && res.data.data && res.data.data.list) {
                gonggaoList.value = res.data.data.list;
            }
        })
    };

    // 跳转到公告详情
    const toGonggaoDetail = (id) => {
        router.push({
            path: '/index/gonggaoDetail', // 前台公告详情页路径（你可根据实际路由名修改）
            query: { id: id }
        });
    };
    // 跳转到公告列表
    const toGonggaoList = () => {
        router.push('/index/gonggaoList'); // 前台公告列表页路径
    };

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

// ================= 新增的金刚区和推荐区逻辑 =================
	const recommendList = ref([])
	
	const getSmartRecommend = () => {
		let account = localStorage.getItem('frontSessionTable') === 'laoren' ? localStorage.getItem('frontName') || localStorage.getItem('adminName') : '';
		if (!account) return; 

		context?.$http({
			url: `caipinxinxi/smartRecommend?laorenzhanghao=${account}`,
			method: "get"
		}).then(res => {
			if (res.data && res.data.code === 0) {
				recommendList.value = res.data.data;
			}
		});
	}
	
	const quickNavigate = (path) => {
		let token = localStorage.getItem('frontToken');
		if (!token) {
			context?.$message.error("请先登录系统！");
			router.push('/login');
			return;
		}
		router.push(path);
	}
	
	const scrollToRecommend = () => {
		let target = document.getElementById('smart-recommend');
		if (target) {
			target.scrollIntoView({ behavior: 'smooth', block: 'center' });
		} else {
			let token = localStorage.getItem('frontToken');
			if (!token) {
				context?.$message.warning("请先登录系统！");
			} else {
				context?.$message.warning("请先完成一次健康打卡，系统才能为您推荐！");
			}
		}
	}
	// ==========================================================

    // 初始化合集：只在一个地方统一下发请求，保证不冲突
	const init = () => {
		getAboutUs()
		getSystemInfo()
		getcaipinxinxiRecomList()
		getNewsList()
        getGonggaoList() // 触发公告获取
        getSmartRecommend()
	}
	init()

</script>

<style lang="scss" scoped>
.modern-home-page {
    width: 1200px;
    margin: 30px auto;
    font-family: "Microsoft YaHei", sans-serif;
}

/* 现代金刚区 */
.shortcut-area {
    display: flex;
    justify-content: space-between;
    gap: 24px;
    margin-bottom: 50px;
}
.shortcut-item {
    flex: 1;
    border-radius: 16px;
    padding: 30px 20px;
    text-align: center;
    cursor: pointer;
    transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
    box-shadow: 0 8px 20px rgba(0,0,0,0.04);
    background: #fff;
    position: relative;
    overflow: hidden;
    z-index: 1;
}
.shortcut-item::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0; height: 100%;
    z-index: -1;
    opacity: 0.05;
    transition: opacity 0.3s;
}
.shortcut-item:hover {
    transform: translateY(-8px);
    box-shadow: 0 16px 32px rgba(0,0,0,0.1);
}
.shortcut-item:hover::before { opacity: 0.15; }

.health-item::before { background: #E6A23C; }
.health-item .icon-box { background: linear-gradient(135deg, #fdfbfb 0%, #ebedee 100%); color: #E6A23C; border: 2px solid #E6A23C; }

.doc-item::before { background: #67C23A; }
.doc-item .icon-box { background: linear-gradient(135deg, #fdfbfb 0%, #ebedee 100%); color: #67C23A; border: 2px solid #67C23A; }

.food-item::before { background: #F56C6C; }
.food-item .icon-box { background: linear-gradient(135deg, #fdfbfb 0%, #ebedee 100%); color: #F56C6C; border: 2px solid #F56C6C; }

.feedback-item::before { background: #409EFF; }
.feedback-item .icon-box { background: linear-gradient(135deg, #fdfbfb 0%, #ebedee 100%); color: #409EFF; border: 2px solid #409EFF; }

.icon-box {
    width: 70px;
    height: 70px;
    border-radius: 50%;
    margin: 0 auto 15px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 32px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
}
.shortcut-text { display: block; font-size: 20px; font-weight: bold; color: #333; margin-bottom: 8px; }
.shortcut-desc { margin: 0; font-size: 13px; color: #909399; }

/* 智能推荐专区 */
.recommend-section {
    background: #fff;
    border-radius: 20px;
    padding: 30px 40px;
    box-shadow: 0 8px 24px rgba(0,0,0,0.03);
    margin-bottom: 50px;
}
.section-header { margin-bottom: 30px; border-bottom: 1px solid #f0f2f5; padding-bottom: 15px; }
.title-left { display: flex; align-items: center; }
.section-header .title { margin: 0; font-size: 24px; font-weight: bold; color: #303133; letter-spacing: 1px; }
.section-header .subtitle { margin: 10px 0 0 38px; color: #909399; font-size: 15px; }

/* 卡片通用样式 */
.food-card { border-radius: 16px; border: none; background: #fcfdfe; cursor: pointer; transition: all 0.3s; :deep(.el-card__body) { padding: 0; } }
.food-card:hover { transform: translateY(-6px); box-shadow: 0 16px 32px rgba(103, 194, 58, 0.15) !important; }
.food-img-wrapper { width: 100%; height: 190px; overflow: hidden; }
.food-img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s; }
.food-card:hover .food-img { transform: scale(1.06); }
.food-info { padding: 20px; }
.food-name { margin: 0 0 10px 0; font-size: 18px; color: #333; font-weight: bold; }
.food-tags { margin-bottom: 15px; }
.food-bottom { display: flex; justify-content: space-between; align-items: center; border-top: 1px dashed #ebeef5; padding-top: 15px; }
.food-price { color: #F56C6C; font-size: 22px; font-weight: bold; }

/* ================= 底部新增模块样式 ================= */
.home-module { margin-bottom: 50px; }
.module-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 2px solid #f0f2f5; padding-bottom: 15px; }
.module-title { font-size: 24px; font-weight: bold; color: #333; margin: 0; letter-spacing: 1px; }

/* 热门菜品卡片 */
.hot-food-card { border-radius: 12px; border: none; cursor: pointer; transition: all 0.3s; :deep(.el-card__body) { padding: 0; } }
.hot-food-card:hover { transform: translateY(-5px); box-shadow: 0 12px 24px rgba(0,0,0,0.08) !important; }
.img-zoom { width: 100%; height: 180px; overflow: hidden; background: #f8f9fa; }
.hot-img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s; }
.hot-food-card:hover .hot-img { transform: scale(1.05); }
.hot-info { padding: 15px 20px; }
.hot-name { font-size: 18px; margin: 0 0 10px 0; color: #303133; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; font-weight: bold;}
.hot-bottom { display: flex; justify-content: space-between; align-items: center; }
.hot-price { color: #F56C6C; font-size: 20px; font-weight: bold; }
.hot-sales { color: #909399; font-size: 13px; }

/* 资讯卡片 (横向图文) */
.news-card { display: flex; background: #fff; border-radius: 12px; padding: 15px; box-shadow: 0 4px 12px rgba(0,0,0,0.03); cursor: pointer; transition: all 0.3s; border: 1px solid transparent; }
.news-card:hover { box-shadow: 0 8px 20px rgba(0,0,0,0.06); border-color: #e4e7ed; transform: translateY(-3px); }
.news-img { width: 140px; height: 100px; border-radius: 8px; object-fit: cover; margin-right: 20px; border: 1px solid #f0f2f5;}
.news-content { flex: 1; display: flex; flex-direction: column; justify-content: space-between; }
.news-title { margin: 0 0 8px 0; font-size: 17px; color: #333; font-weight: bold; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; }
.news-desc { margin: 0; font-size: 14px; color: #666; line-height: 1.5; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
.news-time { font-size: 13px; color: #999; margin-top: 8px; }

/* 系统简介专区样式（适老化大字版 + 三图排版） */
.system-intro-section {
    background: #fff;
    border-radius: 16px;
    padding: 40px 50px;
    box-shadow: 0 8px 24px rgba(0,0,0,0.04);
    margin-bottom: 60px;
}
.intro-content-wrapper {
    display: flex;
    flex-direction: column; /* 改为上下排列，给文字留出更大空间 */
    gap: 30px;
}
.intro-images {
    display: flex;
    gap: 20px;
    justify-content: space-between;
    width: 100%;
}
.img-item {
    flex: 1;
    height: 220px;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0,0,0,0.06);
}
.intro-img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.4s;
}
.intro-img:hover {
    transform: scale(1.05);
}
.intro-right {
    width: 100%;
    background: #fdfaf4; /* 给文字加一个温馨的暖色背景 */
    padding: 30px;
    border-radius: 12px;
    border: 1px solid #f2e6d9;
}

/* 核心：适老化大字体排版 */
.elder-text {
    font-size: 20px !important; /* 超大号字体，老花眼也能看清 */
    line-height: 2.2 !important; /* 更宽的行距，防止串行 */
    color: #222; /* 加深文字颜色，提高对比度 */
    letter-spacing: 1.5px; /* 增加字间距 */
}
.elder-text :deep(p) {
    margin-bottom: 1em;
    text-indent: 2em; /* 首行缩进，符合传统阅读习惯 */
}
.elder-text :deep(img) {
    max-width: 100%;
    border-radius: 8px;
    margin: 20px 0;
    display: block;
}

/* --- 优化后的公告条样式 --- */
.gonggao-bar-modern {
    display: flex;
    align-items: center;
    background: #fff;
    border-radius: 8px;
    padding: 0 20px;
    margin-bottom: 30px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    border: 1px solid #f0f2f5;
    height: 60px;

    .gonggao-label {
        font-size: 16px;
        font-weight: bold;
        color: #E6A23C;
        margin-right: 20px;
        display: flex;
        align-items: center;
        i { font-size: 20px; margin-right: 5px; }
    }

    .gonggao-carousel {
        flex: 1;
        cursor: pointer;
        
        .gonggao-content {
            height: 40px;
            line-height: 40px;
            display: flex;
            align-items: center;
            font-size: 16px;
            color: #555;
            
            .gonggao-tag { color: #409EFF; margin-right: 10px; font-weight: bold;}
            .gonggao-title { flex: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; transition: color 0.3s;}
            .gonggao-time { color: #999; font-size: 14px; margin-left: 20px; }
            
            &:hover .gonggao-title { color: #E6A23C; text-decoration: underline; }
        }
    }

    .gonggao-more {
        margin-left: 20px;
        font-size: 14px;
        color: #999;
        cursor: pointer;
        transition: color 0.3s;
        &:hover { color: #E6A23C; }
    }
}

/* 公告滚动动画定义 */
@keyframes scrollGonggao {
    0% { transform: translateX(0); }
    100% { transform: translateX(-50%); } // 滚动过半，实现无缝对接
}

</style>