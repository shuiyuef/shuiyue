<template>
	<div class="modern-detail-page">
		<div class="breadcrumb-wrapper">
			<el-breadcrumb separator="/">
				<el-breadcrumb-item :to="{ path: '/index/home' }">首页</el-breadcrumb-item>
				<el-breadcrumb-item :to="{ path: '/index/caipinxinxiList' }">营养大厅</el-breadcrumb-item>
				<el-breadcrumb-item>菜品详情</el-breadcrumb-item>
			</el-breadcrumb>
			<el-button @click="$router.go(-1)" round size="small" icon="el-icon-back">返回</el-button>
		</div>

		<el-card class="detail-card" shadow="hover">
			<div class="top-section">
				<div class="img-box">
					<el-image 
						class="main-img"
						:src="detail.caipintupian ? ($config.url + detail.caipintupian.split(',')[0]) : ''" 
						fit="cover"
						:preview-src-list="detail.caipintupian ? [$config.url + detail.caipintupian.split(',')[0]] : []"
					></el-image>
				</div>
				
				<div class="info-box">
					<h1 class="good-name">{{ detail.caipinmingcheng }}</h1>
					<div class="tags-row">
						<el-tag type="success" effect="plain" v-if="detail.kouwei"><i class="el-icon-magic-stick"></i> {{ detail.kouwei }}</el-tag>
						<el-tag type="warning" effect="light" v-if="detail.caipinfenlei"><i class="el-icon-food"></i> {{ detail.caipinfenlei }}</el-tag>
					</div>
					
					<div class="price-panel">
						<div class="price-item">
							<span class="label">惠老价</span>
							<span class="price-val">¥ {{ detail.price || detail.danjia || '0.00' }}</span>
						</div>
						<div class="stock-item" v-if="detail.alllimittimes">
							<span class="label">今日厨房余量:</span>
							<span class="val">{{ detail.alllimittimes }} 份</span>
						</div>
					</div>
					
					<div class="buy-panel">
						<div class="num-selector">
							<span class="label">份数选择：</span>
							<el-input-number v-model="buyNumber" :min="1" :max="detail.alllimittimes || 99" size="large"></el-input-number>
						</div>
						
						<div class="action-btns">
							<el-button type="warning" class="cart-btn" round icon="el-icon-shopping-cart-2" @click="addCart">加入购物车</el-button>
							<el-button type="danger" class="buy-btn" round icon="el-icon-goods" @click="buyNow">立即下单</el-button>
						</div>
					</div>
				</div>
			</div>
		</el-card>

        <el-card class="desc-card" shadow="hover">
			<template #header>
				<div class="desc-header">
                    <i class="el-icon-reading" style="color:#4A90E2; margin-right:8px;"></i> 
                    餐品营养与原料介绍
                </div>
			</template>
            
            <div class="rich-text-content" v-if="detail.yingyangchengfen || detail.caipinxiangqing">
                
                <div v-if="detail.yingyangchengfen" class="content-section">
                    <div class="section-title"><i class="el-icon-first-aid-kit" style="color:#67C23A"></i> 营养成分指标</div>
                    <div class="html-wrap" v-html="detail.yingyangchengfen"></div>
                </div>

                <el-divider v-if="detail.yingyangchengfen && detail.caipinxiangqing" border-style="dashed"></el-divider>

                <div v-if="detail.caipinxiangqing" class="content-section">
                    <div class="section-title"><i class="el-icon-dish" style="color:#E6A23C"></i> 菜品详细介绍</div>
                    <div class="html-wrap" v-html="detail.caipinxiangqing"></div>
                </div>

            </div>

            <div class="rich-text-content empty-state" v-else>
                <div class="empty-tip">
                    <i class="el-icon-info"></i> 主厨太忙了，暂时没有写详细介绍哦~
                </div>
            </div>
		</el-card>
        </div>
</template>

<script setup>
import { ref, getCurrentInstance } from 'vue';
import { useRoute, useRouter } from 'vue-router';

const context = getCurrentInstance()?.appContext.config.globalProperties;
const route = useRoute();
const router = useRouter();
const detail = ref({});
const buyNumber = ref(1);
const tablename = 'caipinxinxi';

const getDetail = () => {
	context?.$http.get(`${tablename}/detail/${route.query.id}`).then(res => {
		detail.value = res.data.data;
	})
}
getDetail();

const addCart = () => {
	context?.$http.get('cart/list', {
		params: { userid: context?.$toolUtil.storageGet('frontUserid'), tablename: tablename, goodid: detail.value.id }
	}).then(res => {
		if (res.data.data.list.length > 0) {
			let cart = res.data.data.list[0];
			cart.buynumber = cart.buynumber + buyNumber.value;
			context?.$http.post('cart/update', cart).then(() => { context?.$message.success('已为您添加到购物车！'); });
		} else {
			context?.$http.post('cart/add', {
				tablename: tablename, goodid: detail.value.id, goodname: detail.value.caipinmingcheng,
				picture: detail.value.caipintupian, buynumber: buyNumber.value, userid: context?.$toolUtil.storageGet('frontUserid'),
				price: detail.value.price || detail.value.danjia, discountprice: detail.value.price || detail.value.danjia
			}).then(() => { context?.$message.success('已为您添加到购物车！'); });
		}
	})
}

const buyNow = () => {
	let data = [{
		tablename: tablename, goodid: detail.value.id, goodname: detail.value.caipinmingcheng,
		picture: detail.value.caipintupian, buynumber: buyNumber.value,
		price: detail.value.price || detail.value.danjia, discountprice: detail.value.price || detail.value.danjia,
	}]
	context?.$toolUtil.storageSet('orders_good', JSON.stringify(data));
	context?.$toolUtil.storageSet('orders_type', 'good');
	router.push('/index/order_confirm');
}
</script>

<style lang="scss" scoped>
.modern-detail-page { width: 1200px; margin: 30px auto 60px; font-family: "Microsoft YaHei", sans-serif; }
.breadcrumb-wrapper { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
.detail-card { border-radius: 16px; border: none; box-shadow: 0 8px 24px rgba(0,0,0,0.04); margin-bottom: 30px; :deep(.el-card__body) { padding: 40px; } }
.top-section { display: flex; gap: 50px; }
.img-box { width: 450px; height: 450px; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.08); flex-shrink: 0; }
.main-img { width: 100%; height: 100%; transition: transform 0.3s; cursor: zoom-in; }
.main-img:hover { transform: scale(1.03); }
.info-box { flex: 1; display: flex; flex-direction: column; }
.good-name { font-size: 32px; color: #303133; margin: 0 0 20px 0; font-weight: bold; }
.tags-row { margin-bottom: 30px; .el-tag { margin-right: 15px; font-size: 14px; padding: 0 12px; height: 28px; line-height: 26px; } }
.price-panel { background: #fdfaf4; border: 1px solid #f2e6d9; border-radius: 12px; padding: 25px; margin-bottom: 40px; .price-item { display: flex; align-items: center; margin-bottom: 15px; .label { width: 100px; color: #909399; font-size: 15px; } .price-val { color: #F56C6C; font-size: 36px; font-weight: bold; } } .stock-item { display: flex; align-items: center; .label { width: 100px; color: #909399; font-size: 15px; } .val { color: #333; font-size: 15px; } } }
.buy-panel { margin-top: auto; .num-selector { display: flex; align-items: center; margin-bottom: 30px; .label { width: 100px; color: #606266; font-size: 15px; font-weight: bold;} } .action-btns { display: flex; gap: 20px; .cart-btn, .buy-btn { padding: 15px 40px; font-size: 18px; font-weight: bold; box-shadow: 0 4px 12px rgba(0,0,0,0.15); } .cart-btn { background: #E6A23C; border-color: #E6A23C; color: #fff;} .cart-btn:hover { background: #e39521; } } }

/* 底部图文卡片样式 */
.desc-card { 
    border-radius: 16px; border: none; box-shadow: 0 8px 24px rgba(0,0,0,0.04); 
    .desc-header { font-size: 20px; font-weight: bold; color: #333; } 
    .rich-text-content { 
        padding: 10px 20px;
    }
    .content-section {
        margin: 20px 0;
        .section-title {
            font-size: 18px;
            font-weight: bold;
            color: #303133;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .html-wrap {
            line-height: 1.8;
            font-size: 16px;
            color: #444;
            :deep(img) { max-width: 100%; border-radius: 8px; margin: 15px 0; }
        }
    }
    .empty-state {
        display: flex; justify-content: center; align-items: center; height: 150px;
        .empty-tip { color: #909399; font-size: 16px; display: flex; align-items: center; gap: 10px; i { font-size: 24px; } }
    }
}
</style>