<template>
	<div class="list-page modern-cart-page">
        <div class="breadcrumb-wrapper">
            <el-button class="back_btn" @click="backClick" round icon="el-icon-back">返回菜品大厅</el-button>
            <div class="section_title">{{formName}}</div>
        </div>
        
        <el-card class="cart-card" shadow="hover">
            <div class="cart-header">
                <el-checkbox v-model="allSelected" @change="handleAllSelect" style="margin-left:15px; font-weight: bold;">全选菜品</el-checkbox>
                <el-button type="danger" plain round size="small" :disabled="!multipleSelection.length" @click="delClick(null)" icon="el-icon-delete">
                    批量删除选中
                </el-button>
            </div>

            <el-divider></el-divider>

            <div class="cart-items" v-loading="listLoading">
                <el-empty v-if="!list || list.length === 0" description="您的购物车空空如也，快去挑点好吃的吧！"></el-empty>
                
                <div class="cart-item" v-for="(item, index) in list" :key="item.id">
                    <div class="item-checkbox">
                        <el-checkbox v-model="item.selected" @change="handleItemSelect(item)"></el-checkbox>
                    </div>
                    
                    <div class="item-img-wrapper" @click="listChange(item)">
                        <img :src="item.picture?($config.url + item.picture):''" class="item-img" />
                    </div>
                    
                    <div class="item-info">
                        <div class="item-name" @click="listChange(item)">{{item.goodname}}</div>
                        <div class="item-price">¥ {{item.price}}</div>
                    </div>
                    
                    <div class="item-actions">
                        <el-input-number class="item-stepper" v-model="item.buynumber" :min="1" :max="99" size="small" @change="(val) => updateCart(item, val)"></el-input-number>
                        <el-button type="danger" link class="delete-btn" @click="delClick(item.id)">
                            <i class="el-icon-delete"></i>
                        </el-button>
                    </div>
                </div>
            </div>

            <div class="cart-footer">
                <div class="footer-left">
                    已选 <span class="highlight-text">{{multipleSelection.length}}</span> 份餐品
                </div>
                <div class="footer-right">
                    <div class="total-price">
                        合计: <span class="price-num">¥ {{totalPrice.toFixed(2)}}</span>
                    </div>
                    <el-button type="primary" class="checkout-btn" round :disabled="!multipleSelection.length" @click="payClick">
                        立即结算
                    </el-button>
                </div>
            </div>
		</el-card>
	</div>
</template>

<script setup>
	import { ref, getCurrentInstance, nextTick, computed } from 'vue';
	import { useRoute, useRouter } from 'vue-router';
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const router = useRouter()
	const route = useRoute()
	const tableName = 'cart'
	const formName = '我的购物车'
	const list = ref([])
	const listLoading = ref(false)
	const multipleSelection = ref([])
    const allSelected = ref(false)

	const totalPrice = computed(() => {
		let total = 0;
		multipleSelection.value.forEach(item => {
			total += item.price * item.buynumber;
		});
		return total;
	});

	const backClick = () => { router.push(`/index/caipinxinxiList`) }

	const getList = () => {
		listLoading.value = true
		context?.$http({
			url: `${tableName}/page`,
			method: 'get',
			params: { page: 1, limit: 100 }
		}).then(res => {
			listLoading.value = false
            let dataList = res.data.data.list;
            dataList.forEach(item => item.selected = false);
			list.value = dataList;
            updateSelection();
		})
	}
    
    const handleAllSelect = (val) => {
        list.value.forEach(item => item.selected = val);
        updateSelection();
    }
    
    const handleItemSelect = () => {
        allSelected.value = list.value.every(item => item.selected);
        updateSelection();
    }
    
    const updateSelection = () => {
        multipleSelection.value = list.value.filter(item => item.selected);
    }

	const updateCart = (row, val) => {
		context?.$http({
			url: `cart/update`,
			method: 'post',
			data: row
		}).then(res => {
			context?.$message.success('已更新数量')
		})
	}

	const delClick = (id) => {
		let ids = id ? [id] : multipleSelection.value.map(item => item.id)
        if(!ids.length) return;
        
		context?.$confirm('确定要从购物车移除这些菜品吗?', '确认提示', {
			confirmButtonText: '确定',
			cancelButtonText: '取消',
			type: 'warning'
		}).then(()=>{
			context?.$http({
				url: `cart/delete`,
				method: 'post',
				data: ids
			}).then(res=>{
				context?.$message.success('删除成功')
                multipleSelection.value = []
                allSelected.value = false
				getList()
			})
		})
	}
    
	const listChange = (row) => {
		router.push(`caipinxinxiDetail?id=` + row.goodid)
	}
    
	const payClick = () => {
		let data = multipleSelection.value
		if (!data.length) {
			context?.$message.error('请先选择要结算的菜品')
			return
		}
		context?.$toolUtil.storageSet('orders_good', JSON.stringify(data))
		context?.$toolUtil.storageSet('orders_type', 'cart')
		router.push('/index/order_confirm')
	}

	const init = () => { getList() }
	init()
</script>

<style lang="scss" scoped>
.modern-cart-page { width: 1100px; margin: 0 auto; padding: 30px 0; }
.breadcrumb-wrapper { display: flex; align-items: center; justify-content: space-between; margin-bottom: 25px; }
.section_title { font-size: 24px; font-weight: bold; color: #333; letter-spacing: 2px; }
.cart-card { border-radius: 16px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.05); :deep(.el-card__body) { padding: 0; } }
.cart-header { display: flex; justify-content: space-between; align-items: center; padding: 20px 30px; background: #fbfbfc; border-radius: 16px 16px 0 0; }
:deep(.el-divider--horizontal) { margin: 0; }
.cart-items { padding: 10px 30px; min-height: 300px; }
.cart-item { display: flex; align-items: center; padding: 20px 0; border-bottom: 1px dashed #ebeef5; transition: all 0.3s; }
.cart-item:last-child { border-bottom: none; }
.cart-item:hover { background: #fcfdfe; }
.item-checkbox { width: 50px; display: flex; justify-content: center; }
.item-img-wrapper { width: 110px; height: 110px; border-radius: 12px; overflow: hidden; cursor: pointer; box-shadow: 0 4px 12px rgba(0,0,0,0.05); margin-right: 25px; }
.item-img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.3s; }
.item-img-wrapper:hover .item-img { transform: scale(1.05); }
.item-info { flex: 1; display: flex; flex-direction: column; justify-content: space-around; height: 90px; }
.item-name { font-size: 18px; font-weight: bold; color: #333; cursor: pointer; transition: color 0.3s; }
.item-name:hover { color: #4A90E2; }
.item-price { font-size: 22px; color: #F56C6C; font-weight: bold; }
.item-actions { display: flex; align-items: center; gap: 30px; }
:deep(.el-input-number) { width: 120px; }
.delete-btn { font-size: 18px; color: #c0c4cc; }
.delete-btn:hover { color: #F56C6C; }
.cart-footer { display: flex; justify-content: space-between; align-items: center; padding: 20px 30px; background: #fafafa; border-top: 1px solid #ebeef5; border-radius: 0 0 16px 16px; }
.footer-left { font-size: 15px; color: #606266; }
.highlight-text { color: #4A90E2; font-weight: bold; font-size: 18px; margin: 0 5px; }
.footer-right { display: flex; align-items: center; gap: 25px; }
.total-price { font-size: 16px; color: #333; font-weight: bold; }
.price-num { color: #F56C6C; font-size: 26px; margin-left: 10px; }
.checkout-btn { padding: 12px 35px; font-size: 18px; letter-spacing: 2px; box-shadow: 0 6px 16px rgba(74, 144, 226, 0.3); }
</style>