<template>
	<div class="list-page modern-order-page">
        <el-card shadow="hover" class="breadcrumb-card">
            <div class="breadcrumb-wrapper">
                <el-breadcrumb separator="/" class="breadcrumb">
                    <el-breadcrumb-item :to="{ path: `/index/${sessionTable}Center` }">个人中心</el-breadcrumb-item>
                    <el-breadcrumb-item>{{formName}}</el-breadcrumb-item>
                </el-breadcrumb>
                <div class="back_view">
                    <el-button class="back_btn" @click="backClick" icon="el-icon-back" round size="small">返回</el-button>
                </div>
            </div>
        </el-card>

        <div class="status-tabs-wrapper">
            <el-radio-group v-model="orderStatus" @change="statusChange" size="large" class="modern-tabs">
                <el-radio-button label="">全部订单</el-radio-button>
                <el-radio-button v-if="btnAuth('orders/未支付','查看')" label="未支付">未支付</el-radio-button>
                <el-radio-button label="已支付">待发货</el-radio-button>
                <el-radio-button label="已发货">已发货</el-radio-button>
                <el-radio-button label="已完成">已完成</el-radio-button>
                <el-radio-button label="已退款">已退款</el-radio-button>
                <el-radio-button label="已取消">已取消</el-radio-button>
            </el-radio-group>
		</div>

        <div class="order-container" v-loading="listLoading">
            <el-empty v-if="!list.length" description="暂无符合条件的订单记录" :image-size="120"></el-empty>

            <el-card v-for="(item, index) in list" :key="index" class="order-card" shadow="hover">
                <div class="order-header">
                    <div class="header-left">
                        <span class="order-time">{{item.addtime}}</span>
                        <span class="order-id">订单号：{{item.orderid}}</span>
                    </div>
                    <div class="header-right">
                        <el-tag :type="getStatusColor(item.status)" effect="dark" round size="small">
                            {{item.status}}
                        </el-tag>
                    </div>
                </div>

                <div class="order-body" @click="toDetailClick(item)">
                    <div class="good-img-box">
                        <img v-if="item.picture" :src="item.picture.substring(0,4)=='http' ? item.picture.split(',')[0] : $config.url+item.picture.split(',')[0]" class="good-img">
                        <div v-else class="no-img">无图片</div>
                    </div>
                    
                    <div class="good-info">
                        <div class="good-name">{{item.goodname}}</div>
                        <div class="good-attr">
                            单价：<span v-if="item.type!=2">¥</span>{{item.price}} <span v-if="item.type==2">积分</span>
                            <span style="margin: 0 10px; color: #ddd;">|</span>
                            数量：x{{item.buynumber}}
                        </div>
                        <div class="delivery-info">
                            <i class="el-icon-location-outline"></i> {{item.consignee}} - {{item.tel}} - {{item.address}}
                        </div>
                        <div class="remark-info" v-if="item.remark">
                            <el-tag size="mini" type="info" effect="plain">备注：{{item.remark}}</el-tag>
                        </div>
                    </div>

                    <div class="order-total-box">
                        <div class="total-label">实付款</div>
                        <div class="total-price">
                            <span v-if="item.type!=2" style="font-size: 14px;">¥</span>{{item.total}}
                            <span v-if="item.type==2" style="font-size: 14px;">积分</span>
                        </div>
                    </div>
                </div>

                <div class="order-footer">
                    <el-button v-if="item.status=='未支付'" type="primary" round @click="payClick(item)">立即支付</el-button>
                    <el-button v-if="item.status=='未支付'" type="info" plain round @click="cancelClick(item)">取消订单</el-button>
                    <el-button v-if="item.status=='已支付'" type="warning" plain round @click="refundPriceClick(item)">申请退款</el-button>
                    
                    <template v-if="!item.sfsh || item.sfsh=='否'">
                        <el-button v-if="item.status=='已完成' && item.sfsh!='否'" type="danger" plain round @click="refundGoodClick(item)">申请退货</el-button>
                        <el-button v-else-if="item.sfsh=='否'" type="danger" round @click="refundGoodClick(item)">
                            <el-tooltip :content="item.shhf">
                                <i class="el-icon-warning-outline"></i>
                            </el-tooltip>
                            重新退货
                        </el-button>
                    </template>
                    <el-button v-else-if="item.sfsh=='待审核'" type="info" plain disabled round>退货审核中</el-button>

                    <el-button v-if="item.logistics" type="success" plain round @click="logisticsClick(item)">查看物流</el-button>
                    <el-button v-if="item.status=='已发货'" type="success" round @click="confirmGoodClick(item)">确认收货</el-button>
                    <el-button v-if="item.status=='已完成'" type="primary" plain round @click="toDetailClick(item)">再去逛逛</el-button>
                </div>
            </el-card>
        </div>

        <div class="pagination-wrapper">
			<el-pagination
				background 
				:layout="layouts.join(',')"
				:total="total" 
				:page-size="listQuery.limit"
				v-model:current-page="listQuery.page"
				@size-change="sizeChange"
				@current-change="currentChange" />
		</div>

        <el-dialog v-model="logisticsVisible" title="📦 配送物流信息" width="50%" center>
			<div class="logistics-content" v-html="logisticsText"></div>
            <template #footer>
                <el-button type="primary" round @click="logisticsVisible = false">关闭</el-button>
            </template>
		</el-dialog>
	</div>
</template>

<script setup>
	import { ref, getCurrentInstance, nextTick } from 'vue';
	import { ElMessageBox } from 'element-plus'
	import { useRoute, useRouter } from 'vue-router';

	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const router = useRouter()
	const route = useRoute()
    const sessionTable = ref(context?.$toolUtil.storageGet('frontSessionTable'))

	const tableName = 'orders'
	const formName = '商品订单'
	const list = ref([])
	const listLoading = ref(false)
	const listQuery = ref({
		page: 1,
		limit: 10,
		userid: context?.$toolUtil.storageGet('frontUserid'),
		sort:'addtime', // 建议按时间倒序
		order:'desc'
	})
    
    const orderStatus = ref('')
    if(['未支付','已支付','已发货','已完成','已退款','已取消'].includes(route.query.menuJump)){
        orderStatus.value = route.query.menuJump
    }

    const btnAuth = (e,a)=>{
        return context?.$toolUtil.isBackAuth(e,a)
    }

    const backClick = () => {
        router.push(`/index/${sessionTable.value}Center`)
    }

    // 状态颜色映射器
    const getStatusColor = (status) => {
        const map = {
            '未支付': 'danger',
            '已支付': 'warning',
            '已发货': 'primary',
            '已完成': 'success',
            '已退款': 'info',
            '已取消': 'info'
        };
        return map[status] || 'primary';
    }

	const getList = () => {
		listLoading.value = true
		let params = JSON.parse(JSON.stringify(listQuery.value))
		if (orderStatus.value) {
			params['status'] = orderStatus.value
		}
		context?.$http({
            // ================= 核心修复 =================
			url: 'orders/page', // 把 list 强制改为 page，启动后端 Token 数据隔离！
            // ============================================
			method: 'get',
			params: params
		}).then(res => {
			listLoading.value = false
			list.value = res.data.data.list
			total.value = Number(res.data.data.total)
		})
	}

	const layouts = ref(["total","prev","pager","next"])
	const total = ref(0)
	const sizeChange = (size) => { listQuery.value.limit = size; getList(); }
	const currentChange = (page) => { listQuery.value.page = page; getList(); }

	const statusChange = () => {
		listQuery.value.page = 1
		getList()
	}

    // =============== 原汁原味的业务逻辑区 ===============
	const payClick = (row) => {
		ElMessageBox.confirm(`是否确定支付该订单？`, '支付确认', {
			confirmButtonText: '确定支付',
			cancelButtonText: '暂不支付',
			type: 'warning',
		}).then(() => {
			context?.$http({
				url: `${row.tablename}/info/${row.goodid}`,
				method: 'get'
			}).then(res => {
				let data = res.data.data
				if (Number(userinfo.value.money) < Number(row.total)) {
					context?.$toolUtil.message('余额不足，请先去个人中心充值', 'error')
					return
				}
				if (data.jf) {
					userinfo.value.jf = parseInt(userinfo.value.jf || 0) + parseInt(row.total)
				}
				userinfo.value.money = (parseFloat(userinfo.value.money) - parseFloat(row.total)).toFixed(2)
				if (data.alllimittimes) {
					data.alllimittimes = parseInt(data.alllimittimes) - parseInt(row.buynumber)
				}
                context?.$http.post(`${row.tablename}/update`,data)

				context?.$http({
					url: `${sessionTable.value}/update`,
					method: 'post',
					data: userinfo.value
				}).then(obj => {
					row.status = '已支付'
					context?.$http({
						url: 'orders/update',
						method: 'post',
						data: row
					}).then(res1 => {
                        context.$message.success('支付成功，厨房马上为您准备！')
                        getSession()
                        statusChange()
					})
				})
			})
		}).catch(_ => {})
	}

	const cancelClick = (row) => {
		ElMessageBox.confirm(`确定要取消这个订单吗？`, '提示', {
			confirmButtonText: '确定取消',
			cancelButtonText: '点错了',
			type: 'warning',
		}).then(() => {
			row.status = '已取消'
			context?.$http({
				url: 'orders/update',
				method: 'post',
				data: row
			}).then(res1 => {
                context.$message.success('订单已取消')
                getSession()
                statusChange()
			})
		}).catch(_ => {})
	}

    const returnLimit = async (order)=>{
        let res = await context.$http.get(`${order.tablename}/info/${order.goodid}`)
        let data = res.data.data
        if(data.alllimittimes){ 
            data.alllimittimes = parseInt(data.alllimittimes) + parseInt(order.buynumber)
            context.$http.post(`${order.tablename}/update`,data)
        }
        return data
    }

	const refundPriceClick = (row) => {
		ElMessageBox.confirm(`是否对该订单进行退款操作？`, '退款确认', {
			confirmButtonText: '确认退款',
			cancelButtonText: '再想想',
			type: 'warning',
		}).then(async () => {
            let data = await returnLimit(row)
            row.status = '已退款'
            if (row.type == 2) {
                userinfo.value.jf = parseInt(userinfo.value.jf || 0) + parseInt(row.total)
            } else {
                if (data.jf) {
                    userinfo.value.jf = parseInt(userinfo.value.jf || 0) - parseInt(row.total)
                }
                userinfo.value.money = (parseFloat(userinfo.value.money) + parseFloat(row.total)).toFixed(2)
            }
            context.$http.post('orders/update',row)
            context.$http.post(`${sessionTable.value}/update`,userinfo.value).then(res=>{
                context.$message.success("退款成功，金额已返回您的账户")
                getSession()
                statusChange()
            })
		}).catch(_ => {})
	}

	const refundGoodClick = (row) => {
		ElMessageBox.confirm(`${row.sfsh=='否'?'被驳回，确定要重新提交退货申请吗？':'确定要申请退货吗？'}`, '售后服务', {
			confirmButtonText: '提交申请',
			cancelButtonText: '取消',
			type: 'warning',
		}).then(() => {
            row.sfsh = '待审核'
            context.$http.post("orders/update",row).then(res=>{
                if(res.data.code==0){
                    context.$message.warning("退货申请已提交，等待管理员审核")
                }
            })
		}).catch(()=>{})
	}

	const confirmGoodClick = (row) => {
		ElMessageBox.confirm(`您确认已经收到餐品了吗？`, '确认收货', {
			confirmButtonText: '确认收货',
			cancelButtonText: '还未收到',
			type: 'warning',
		}).then(() => {
			row.status = '已完成'
			context?.$http({
				url: 'orders/update',
				method: 'post',
				data: row
			}).then(res1 => {
                context.$message.success('确认收货成功，祝您用餐愉快！')
                getSession()
                statusChange()
			})
		}).catch(_ => {})
	}

	const logisticsVisible = ref(false)
	const logisticsText = ref('')
	const logisticsClick = (row) => {
		logisticsText.value = row.logistics || '暂无物流信息'
		logisticsVisible.value = true
	}

	const toDetailClick = (row) => {
        // 如果是点击详情或者评价，直接跳到菜品页即可
		router.push(`/index/caipinxinxiDetail?id=${row.goodid}`)
	}

	const userinfo = ref({})
	const getSession = () => {
		context?.$http({
			url: `${sessionTable.value}/session`,
			method: 'get'
		}).then(res => {
			userinfo.value = res.data.data
		})
	}

	const init = () => {
		getSession()
		getList()
	}
	init()
</script>

<style lang="scss" scoped>
.modern-order-page {
    width: 1000px;
    margin: 0 auto;
    padding: 30px 0 60px;
    font-family: "Microsoft YaHei", sans-serif;
}

/* 顶部卡片 */
.breadcrumb-card {
    border-radius: 12px;
    border: none;
    margin-bottom: 25px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.03);
    :deep(.el-card__body) { padding: 15px 25px; }
}
.breadcrumb-wrapper {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

/* 状态栏按钮（现代化大药丸风格） */
.status-tabs-wrapper {
    text-align: center;
    margin-bottom: 30px;
}
.modern-tabs :deep(.el-radio-button__inner) {
    border-radius: 20px;
    border: 1px solid #ebeef5;
    background: #fff;
    color: #606266;
    margin: 0 10px;
    box-shadow: none !important;
    padding: 10px 25px;
    font-weight: bold;
    transition: all 0.3s;
}
.modern-tabs :deep(.el-radio-button__original-radio:checked + .el-radio-button__inner) {
    background-color: #4A90E2;
    border-color: #4A90E2;
    color: #fff;
    box-shadow: 0 4px 12px rgba(74, 144, 226, 0.3) !important;
}

/* 卡片式订单容器 */
.order-container {
    min-height: 400px;
}
.order-card {
    border-radius: 16px;
    border: 1px solid #f0f2f5;
    margin-bottom: 20px;
    transition: all 0.3s;
    :deep(.el-card__body) { padding: 0; }
}
.order-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 24px rgba(0,0,0,0.06) !important;
}

/* 订单头部 */
.order-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 25px;
    background: #fafafa;
    border-bottom: 1px solid #f0f2f5;
    .order-time { font-size: 14px; color: #606266; margin-right: 15px; font-weight: bold; }
    .order-id { font-size: 13px; color: #909399; }
}

/* 订单主体内容 */
.order-body {
    display: flex;
    padding: 20px 25px;
    cursor: pointer;
}
.good-img-box {
    width: 90px;
    height: 90px;
    border-radius: 8px;
    overflow: hidden;
    margin-right: 20px;
    border: 1px solid #f0f2f5;
    .good-img { width: 100%; height: 100%; object-fit: cover; }
    .no-img { width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; background: #f5f7fa; color: #c0c4cc; font-size: 12px; }
}

.good-info {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
    .good-name { font-size: 18px; font-weight: bold; color: #303133; margin-bottom: 8px; }
    .good-attr { font-size: 14px; color: #606266; margin-bottom: 8px; }
    .delivery-info { font-size: 13px; color: #909399; }
    .remark-info { margin-top: 5px; }
}

.order-total-box {
    width: 120px;
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    justify-content: center;
    border-left: 1px dashed #ebeef5;
    padding-left: 20px;
    .total-label { font-size: 13px; color: #909399; margin-bottom: 5px; }
    .total-price { font-size: 24px; font-weight: bold; color: #F56C6C; }
}

/* 底部操作区 */
.order-footer {
    display: flex;
    justify-content: flex-end;
    padding: 15px 25px;
    border-top: 1px solid #f0f2f5;
    gap: 15px;
    .el-button { margin: 0; }
}

/* 分页 */
.pagination-wrapper { margin-top: 40px; display: flex; justify-content: center; }

/* 物流弹窗 */
.logistics-content {
    padding: 20px;
    line-height: 2;
    color: #606266;
    font-size: 15px;
    background: #f5f7fa;
    border-radius: 8px;
}
</style>