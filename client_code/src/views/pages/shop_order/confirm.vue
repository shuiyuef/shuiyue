<template>
	<div class="list-page modern-confirm-page">
		<div class="header-banner">
            <h2>确认您的订单信息</h2>
            <el-button @click="backClick" round icon="el-icon-back">返回修改</el-button>
		</div>

        <el-card class="section-card" shadow="hover">
            <template #header>
                <div class="card-header">
                    <span style="font-size:18px; font-weight:bold; color:#333;"><i class="el-icon-location"></i> 请选择配送/联系地址</span>
                    <el-button type="primary" plain round size="small" @click="addressAddClick">新增地址</el-button>
                </div>
            </template>
            
            <div class="address-list">
                <div v-for="(item, index) in addressList" :key="index" 
                     class="address-item" :class="{'active': addressIndex === index}"
                     @click="addressIndex = index">
                    <div class="addr-icon">
                        <i class="el-icon-check" v-if="addressIndex === index"></i>
                    </div>
                    <div class="addr-info">
                        <div class="addr-top">
                            <span class="addr-name">{{item.name}}</span>
                            <span class="addr-phone">{{item.phone}}</span>
                            <el-tag size="small" type="success" effect="dark" v-if="item.isdefault == '是'">默认地址</el-tag>
                        </div>
                        <div class="addr-bottom">{{item.address}}</div>
                    </div>
                </div>
                <el-empty v-if="!addressList || addressList.length === 0" description="暂无地址，请先添加配送地址" :image-size="80"></el-empty>
            </div>
		</el-card>

        <el-card class="section-card" shadow="hover">
            <template #header>
                <div class="card-header">
                    <span style="font-size:18px; font-weight:bold; color:#333;"><i class="el-icon-food"></i> 菜品明细清单</span>
                </div>
            </template>
            
            <div class="goods-list">
                <div class="good-item" v-for="(item, index) in list" :key="index">
                    <img :src="getPicture(item.picture)" class="good-img" />
                    <div class="good-info">
                        <div class="good-name">{{item.goodname}}</div>
                        <div class="good-price">
                            单价: <span>¥ {{item.price}}</span>
                        </div>
                    </div>
                    <div class="good-count">x {{item.buynumber}}</div>
                    <div class="good-subtotal">¥ {{(item.price * item.buynumber).toFixed(2)}}</div>
                </div>
            </div>
            
            <div style="padding: 20px 0; border-bottom: 1px solid #ebeef5;">
                <el-input v-model="remark" placeholder="如果有特殊口味要求（如少盐、不要香菜），请在此备注" maxlength="100" show-word-limit type="textarea" :rows="2"></el-input>
            </div>

            <div class="checkout-bar">
                <div class="total-text">
                    共计支付: <span class="total-money">¥ {{totalPrice.toFixed(2)}}</span>
                </div>
                <el-button type="success" class="pay-btn" round @click="payClick">确认支付并下单</el-button>
            </div>
        </el-card>
	</div>
</template>

<script setup>
	import { ref, getCurrentInstance, computed } from 'vue';
	import { useRoute, useRouter } from 'vue-router';
	import moment from 'moment';

	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const router = useRouter()
	
	const list = ref([])
	const addressList = ref([])
	const addressIndex = ref(-1)
    const user = ref({})
    const remark = ref('')
    const payType = ref(1) // 1代表余额支付
    
	const init = () => {
        // 先获取用户的最新余额和信息
        context.$http.get(`${context.$toolUtil.storageGet('frontSessionTable')}/session`).then(res => {
			user.value = res.data.data
		})

		let data = context?.$toolUtil.storageGet('orders_good')
		list.value = data ? JSON.parse(data) : []
        
        // 构建原版需要的价格计算属性
        list.value.forEach(item => {
            item.realPrice = Number(item.price);
            item.realPay = Number(item.price) * Number(item.buynumber);
        });
		
		context?.$http({
			url: `address/page`,
			method: 'get',
			params: { page: 1, limit: 100 }
		}).then(res => {
			addressList.value = res.data.data.list
			for (let i = 0; i < addressList.value.length; i++) {
				if (addressList.value[i].isdefault == '是') {
					addressIndex.value = i
				}
			}
            // 如果只有一个地址，默认选中它
            if(addressIndex.value == -1 && addressList.value.length > 0) {
                addressIndex.value = 0;
            }
		})
	}
	init()

    const getPicture = (picture) => {
        if(!picture) return '';
        if(picture.startsWith('http')) return picture.split(',')[0];
        return context?.$config.url + picture.split(',')[0];
    }

	const totalPrice = computed(() => {
		let total = 0;
		list.value.forEach(item => {
			total += Number(item.price) * Number(item.buynumber);
		});
		return total;
	});

	const backClick = () => { router.go(-1) }
	const addressAddClick = () => { router.push('addressAdd') }

    const createOrder = () => { return moment().format('YYYYMMDDHHmmssSSS')+Math.random().toString().slice(2, 5); }

    // ================= 原汁原味的复杂支付与扣费逻辑 =================
    const payClick = async () => {
		if (addressIndex.value == -1 || addressList.value.length === 0) {
			context.$toolUtil.message('请选择收货地址', 'error')
			return false
		}
        
        let orders = []
        for(let i in list.value){
            let item = list.value[i]
            // 查询商品最新库存
            let res = await context.$http.get(`${item.tablename || 'caipinxinxi'}/info/${item.goodid}`)
            let data = res.data.data
            let orderid = createOrder()
            
            orders.push({
                orderid: orderid,
                tablename: item.tablename || 'caipinxinxi',
                userid: user.value.id,
                role: context.$toolUtil.storageGet('frontSessionTable'),
                goodid: item.goodid,
                goodname: item.goodname,
                picture: item.picture,
                buynumber: item.buynumber,
                discountprice: item.realPrice,
                discounttotal: Number(item.realPay.toFixed(2)),
                price: item.realPrice,
                total: Number(item.realPay.toFixed(2)),
                type: payType.value,
                address: addressList.value[addressIndex.value].address,
                tel: addressList.value[addressIndex.value].phone,
                consignee: addressList.value[addressIndex.value].name,
                remark: remark.value,
                status: '未支付',
                goods: data
            })
        }
        
        // 批量下单请求
        Promise.all(orders.map(order=>{ 
            return context.$http.post('orders/add', order)
        })).then(resArr=>{
            let total = 0
            orders.forEach(order=>{
                total += Number(order.total)
            })
            
            // 校验 1：判断用户余额是否充足
            if(Number(user.value.money) < Number(total.toFixed(2))){
                context.$toolUtil.message(`您的账户余额不足，请先前往个人中心充值`,'error',()=>{
                    router.push(`/index/${context.$toolUtil.storageGet('frontSessionTable')}Center`)
                })
                return false
            }
            
            // 校验 2：减去用户余额并更新用户表
            user.value.money = (parseFloat(user.value.money) - parseFloat(total)).toFixed(2)
            context.$http.post(`${context.$toolUtil.storageGet('frontSessionTable')}/update`, user.value)

            orders.forEach(order=>{
                // 校验 3：如果商品有库存字段，减去对应库存
                if(order.goods.hasOwnProperty('alllimittimes')){
                    order.goods.alllimittimes = order.goods.alllimittimes - order.buynumber
                }
                context.$http.post(`${order.tablename}/update`, order.goods)
                
                // 校验 4：更新订单状态为已支付
                context.$http.get('orders/list', { params:{ page:1, limit:1, orderid: order.orderid } }).then(res=>{
                    if(res.data.data.list.length > 0) {
                        res.data.data.list[0].status = '已支付'
                        context.$http.post('orders/update', res.data.data.list[0])
                    }
                })
            })
            
            // 校验 5：清理购物车
            list.value.forEach(item=>{
                if(item.id){
                    context.$http({url:'cart/delete', method:'post', data:[item.id]})
                }
            })
            
            // 全部完成，完美撒花！
            context.$toolUtil.message('订单支付成功，厨房正在为您准备餐品！','success',()=>{
                router.push('/index/ordersList') 
            })
        }).catch(err => {
            context.$toolUtil.message('网络拥堵，订单提交异常', 'error')
            console.error(err)
        })
	}
</script>

<style lang="scss" scoped>
.modern-confirm-page { width: 1000px; margin: 0 auto; padding: 40px 0; }
.header-banner { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; h2 { color: #333; margin: 0; font-size: 26px; letter-spacing: 2px; } }
.section-card { border-radius: 16px; border: none; box-shadow: 0 8px 25px rgba(0,0,0,0.04); margin-bottom: 25px; }
.card-header { display: flex; justify-content: space-between; align-items: center; }
.address-list { display: flex; flex-wrap: wrap; gap: 20px; }
.address-item { width: calc(50% - 10px); border: 2px solid #ebeef5; border-radius: 12px; padding: 20px; display: flex; cursor: pointer; transition: all 0.3s; background: #fff; }
.address-item:hover { border-color: #a0cfff; box-shadow: 0 4px 12px rgba(74, 144, 226, 0.1); }
.address-item.active { border-color: #4A90E2; background: #f4f9ff; }
.addr-icon { width: 30px; color: #4A90E2; font-size: 20px; font-weight: bold; display: flex; align-items: center; }
.addr-info { flex: 1; }
.addr-top { margin-bottom: 10px; display: flex; align-items: center; }
.addr-name { font-size: 16px; font-weight: bold; color: #333; margin-right: 15px; }
.addr-phone { font-size: 15px; color: #666; margin-right: 10px; }
.addr-bottom { font-size: 14px; color: #888; line-height: 1.5; }
.goods-list { padding-bottom: 20px; border-bottom: 1px solid #ebeef5; }
.good-item { display: flex; align-items: center; padding: 15px 0; border-bottom: 1px dashed #f0f2f5; }
.good-item:last-child { border: none; }
.good-img { width: 80px; height: 80px; border-radius: 8px; object-fit: cover; margin-right: 20px; border: 1px solid #ebeef5; }
.good-info { flex: 1; }
.good-name { font-size: 16px; font-weight: bold; color: #333; margin-bottom: 10px; }
.good-price span { color: #F56C6C; font-weight: bold; }
.good-count { width: 100px; text-align: center; font-size: 16px; color: #666; font-weight: bold; }
.good-subtotal { width: 150px; text-align: right; font-size: 18px; color: #F56C6C; font-weight: bold; }
.checkout-bar { display: flex; justify-content: flex-end; align-items: center; padding-top: 25px; }
.total-text { font-size: 16px; color: #333; margin-right: 30px; }
.total-money { color: #F56C6C; font-size: 28px; font-weight: bold; margin-left: 10px; }
.pay-btn { padding: 12px 40px; font-size: 18px; letter-spacing: 2px; box-shadow: 0 6px 16px rgba(103, 194, 58, 0.3); }
</style>