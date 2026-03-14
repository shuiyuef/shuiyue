<template>
	<div class="modern-center-page">
		<div class="profile-header">
            <div class="profile-bg"></div>
            <div class="profile-card">
                <el-avatar :size="100" class="user-avatar" 
                    :src="user.touxiang ? $config.url + user.touxiang.split(',')[0] : 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png'">
                </el-avatar>
                <div class="user-info">
                    <h2 class="user-name">{{user.laorenxingming || user.laorenzhanghao}}</h2>
                    <p class="user-desc">社区养老助餐服务尊享会员</p>
                    <div class="user-tags">
                        <el-tag size="small" type="success" effect="dark" round>联系电话: {{user.shouji || '暂无'}}</el-tag>
                    </div>
                </div>
            </div>
        </div>

        <div class="center-body">
            <el-card class="nav-sidebar" shadow="never">
                <div class="nav-title">系统服务</div>
                <div class="usersTabView">
                    <div class="usersTab" :class="tabIndex=='center'?'usersTabActive':''" @click="tabClick({tableName:'center'})">
                        <i class="el-icon-user"></i> 基本资料
                    </div>
                    <div class="usersTab" :class="tabIndex=='updatePassword'?'usersTabActive':''" @click="tabClick({tableName:'updatePassword'})">
                        <i class="el-icon-lock"></i> 修改密码
                    </div>
                    <template v-for="(item,index) in menuList" :key="index">
                        <div v-if="item.child.length>1" class="usersTab">
                            <i class="el-icon-folder-opened"></i> {{item.menu}}
                        </div>
                        <div v-else-if="hasBack(item.child[0])" class="usersTab" @click="tabClick(item.child[0])">
                            <i class="el-icon-document"></i> {{item.child[0].menu}}
                        </div>
                    </template>
                    <div class="usersTab" @click="tabClick({tableName:'orders'})">
    <i class="el-icon-s-order"></i> 我的订单
</div>
<div class="usersTab" @click="tabClick({tableName:'address'})">
    <i class="el-icon-location"></i> 地址管理
</div>
                    <div class="usersTab" @click="tabClick({tableName:'storeupList'})">
                        <i class="el-icon-star-on"></i> 我的收藏
                    </div>
                </div>
            </el-card>

            <el-card class="content-panel" shadow="hover">
                <div class="panel-header">
                    <span>{{formName || '个人资料管理'}}</span>
                </div>
                
                <div class="panel-body">
                    <el-form class="center_form" ref="userFormRef" :model="user" :rules="rules" label-width="120px" v-if="tabIndex=='center'">
                        <el-form-item label="老人账号" prop="laorenzhanghao">
                            <el-input v-model="user.laorenzhanghao" readonly disabled></el-input>
                        </el-form-item>
                        <el-form-item label="老人姓名" prop="laorenxingming">
                            <el-input v-model="user.laorenxingming" placeholder="请输入姓名"></el-input>
                        </el-form-item>
                        <el-form-item label="头像" prop="touxiang">
                            <uploads action="file/upload" tip="点击上传头像" :limit="1" :fileUrls="user.touxiang?user.touxiang:''" @change="touxiangUploadSuccess"></uploads>
                        </el-form-item>
                        
                        <el-form-item label="账户余额" prop="money">
                            <div style="display: flex; align-items: center; gap: 20px;">
                                <span style="font-size: 20px; color: #F56C6C; font-weight: bold; background: #fff1f0; padding: 5px 15px; border-radius: 8px; border: 1px solid #fbc4c4;">
                                    ¥ {{user.money || '0.00'}}
                                </span>
                                <el-button type="success" icon="el-icon-wallet" round @click="chongzhiClick">立即充值</el-button>
                            </div>
                        </el-form-item>
                        <el-form-item label="性别" prop="xingbie">
                            <el-select v-model="user.xingbie" placeholder="请选择性别">
                                <el-option label="男" value="男"></el-option>
                                <el-option label="女" value="女"></el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="年龄" prop="nianling">
                            <el-input v-model="user.nianling" placeholder="请输入年龄"></el-input>
                        </el-form-item>
                        <el-form-item label="手机" prop="shouji">
                            <el-input v-model="user.shouji" placeholder="请输入手机号"></el-input>
                        </el-form-item>
                        <el-form-item>
                            <el-button type="primary" class="save-btn" @click="onSubmit" round>保存修改</el-button>
                        </el-form-item>
                    </el-form>

                    <el-form class="center_form" ref="passwordFormRef" :model="passwordForm" :rules="passwordRules" label-width="120px" v-if="tabIndex=='updatePassword'">
                        <el-form-item label="原密码" prop="password">
                            <el-input type="password" v-model="passwordForm.password" placeholder="请输入原密码"></el-input>
                        </el-form-item>
                        <el-form-item label="新密码" prop="newpassword">
                            <el-input type="password" v-model="passwordForm.newpassword" placeholder="请输入新密码"></el-input>
                        </el-form-item>
                        <el-form-item label="确认密码" prop="repassword">
                            <el-input type="password" v-model="passwordForm.repassword" placeholder="请再次输入新密码"></el-input>
                        </el-form-item>
                        <el-form-item>
                            <el-button type="primary" class="save-btn" @click="updatePassword" round>修改密码</el-button>
                        </el-form-item>
                    </el-form>
                </div>
            </el-card>
        </div>

        <el-dialog title="账户余额充值" v-model="dialogFormVisibleMoney" width="450px" center custom-class="recharge-dialog" destroy-on-close>
            <div class="recharge-header">
                <i class="el-icon-coin" style="font-size: 40px; color: #E6A23C; margin-bottom: 10px;"></i>
                <div style="color: #666; font-size: 14px;">当前余额: ¥{{user.money || '0.00'}}</div>
            </div>
            <el-form :model="chongzhiForm">
                <el-form-item label="充值金额">
                    <el-input v-model="chongzhiForm.money" type="number" placeholder="请输入你要充值的金额 (元)"></el-input>
                </el-form-item>
                <el-form-item label="支付方式">
                    <el-radio-group v-model="chongzhiForm.radio">
                        <el-radio label="微信支付"><img src="https://img.icons8.com/color/48/000000/weixing.png" style="width:20px;vertical-align:middle;margin-right:5px;"/>微信</el-radio>
                        <el-radio label="支付宝"><img src="https://img.icons8.com/color/48/000000/alipay.png" style="width:20px;vertical-align:middle;margin-right:5px;"/>支付宝</el-radio>
                    </el-radio-group>
                </el-form-item>
            </el-form>
            <template #footer>
                <span class="dialog-footer">
                    <el-button @click="dialogFormVisibleMoney = false" round>暂不充值</el-button>
                    <el-button type="primary" @click="chongzhi" round style="box-shadow: 0 4px 10px rgba(74, 144, 226, 0.3);">确认支付</el-button>
                </span>
            </template>
        </el-dialog>
        </div>
</template>

<script setup>
	import { ref, getCurrentInstance, watch, onUnmounted, onMounted } from 'vue';
	import { useRoute, useRouter } from 'vue-router';
	import menu from '@/utils/menu'
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const route = useRoute()
	const router = useRouter()
	const formName = ref('个人中心')
    
// 基础数据与校验规则（修复手机号保存Bug）
	const user = ref({})
	const rules = ref({
		laorenzhanghao: [{ required: true, message: '请输入老人账号', trigger: 'blur' }],
		mima: [{ required: true, message: '请输入密码', trigger: 'blur' }],
        // 废弃容易卡死的 toolUtil 校验，采用最标准的原生正则校验
		shouji: [{ 
            pattern: /^1[3-9]\d{9}$/, 
            message: '请输入正确的11位手机号码', 
            trigger: ['blur', 'change'] 
        }],
	})
	// 菜单与路由控制
	const tabIndex = ref('center')
	const menuList = ref([])
	const sessionTable = ref('')
	
	const getMenu = () => {
		let params = { page: 1, limit: 1, sort: 'id', }
		context?.$http({ url: "laoren/session", method: "get" }).then(res => {
			user.value = res.data.data
		})
		sessionTable.value = context?.$toolUtil.storageGet('frontSessionTable')
		let menus = menu.list()
		for (let i = 0; i < menus.length; i++) {
			if (menus[i].tableName == sessionTable.value) {
				menuList.value = menus[i].frontMenu
				break;
			}
		}
	}
	getMenu()

	// 校验路由判断当前高亮的 Tab
	const checkUrl = () => {
		if(route.query.centerType){
			tabIndex.value = route.query.centerType
			if(route.query.centerType == 'center'){
				formName.value = '个人资料'
			}else if(route.query.centerType == 'updatePassword'){
				formName.value = '修改密码'
			}else{
				formName.value = '系统服务'
			}
		}
	}

    // ================= 核心修复：屏蔽全局轮播图 =================
	onMounted(() => {
		// 自动寻找并隐藏全局的轮播图元素
		let banners = document.querySelectorAll('.swiper, .swiper-container, .el-carousel, .banner-wrapper');
		banners.forEach(el => el.style.display = 'none');
	})

	onUnmounted(() => {
		// 离开个人中心时，将其恢复原状，不影响其他页面
		let banners = document.querySelectorAll('.swiper, .swiper-container, .el-carousel, .banner-wrapper');
		banners.forEach(el => el.style.display = '');
	})
	// =========================================================

	checkUrl()
	watch(() => route.query.centerType, () => { checkUrl() })
	
	const hasBack = (menu) => {
        if(menu.tableName == 'storeup'){
            return false;
        }
        return true;
    }

	// 菜单点击跳转
	const tabClick = (item) => {
    if (item.tableName == 'center') {
        router.push(`/index/${sessionTable.value}Center?centerType=center`)
    } else if (item.tableName == 'updatePassword') {
        router.push(`/index/${sessionTable.value}Center?centerType=updatePassword`)
    } else {
        // --- 核心修复逻辑 ---
        let path = ''
        if (item.tableName == 'orders') {
            path = 'ordersList' // 订单页在路由里通常叫 ordersList
        } else if (item.tableName == 'address') {
            path = 'addressList' // 地址页叫 addressList
        } else if (item.tableName == 'storeup') {
            path = 'storeupList' // 收藏页
        } else {
            // 其他普通的表（如 jiankangjiance），自动补全 List
            path = item.tableName.includes('List') ? item.tableName : `${item.tableName}List`
        }
        router.push(`/index/${path}?centerType=1`)
    }
}

	// 资料更新
	const touxiangUploadSuccess = (fileUrls) => { user.value.touxiang = fileUrls; }
	const userFormRef = ref(null)
	const onSubmit = () => {
		userFormRef.value.validate((valid) => {
			if(valid){
				context?.$http({ url: `${sessionTable.value}/update`, method: 'post', data: user.value }).then(res => {
					context?.$message.success('修改成功')
				})
			}
		})
	}
	
	// 密码修改逻辑
	const passwordForm = ref({ password: '', newpassword: '', repassword: '' })
	const passwordRules = ref({
		password: [{ required: true, message: '请输入', trigger: 'blur' }],
		newpassword: [{ required: true, message: '请输入', trigger: 'blur' }],
		repassword: [{ required: true, message: '请输入', trigger: 'blur' }],
	})
	const passwordFormRef = ref(null)
	const updatePassword = () => {
		passwordFormRef.value.validate((valid) => {
			if(valid){
				if(passwordForm.value.password != user.value.mima){
					context?.$message.error('原密码错误')
					return false
				}
				if(passwordForm.value.newpassword != passwordForm.value.repassword){
					context?.$message.error('两次密码输入不一致')
					return false
				}
				user.value.mima = passwordForm.value.newpassword
				context?.$http({ url: `${sessionTable.value}/update`, method: 'post', data: user.value }).then(res => {
					context?.$message.success('密码修改成功')
					passwordForm.value = { password: '', newpassword: '', repassword: '' }
				})
			}
		})
	}

    // ================= 新增：充值业务逻辑 =================
    const dialogFormVisibleMoney = ref(false)
    const chongzhiForm = ref({
        money: '',
        radio: '微信支付'
    })
    
    const chongzhiClick = () => {
        chongzhiForm.value.money = ''
        dialogFormVisibleMoney.value = true
    }
    
    const chongzhi = () => {
        if (!chongzhiForm.value.money) {
            context?.$message.error('请填写充值金额')
            return
        }
        if (Number(chongzhiForm.value.money) <= 0) {
            context?.$message.error('充值金额必须大于 0')
            return
        }
        
        // 加上金额（防止 NaN，做一次强转）
        let currentMoney = Number(user.value.money || 0);
        let addMoney = Number(chongzhiForm.value.money);
        user.value.money = (currentMoney + addMoney).toFixed(2);
        
        context?.$http({
            url: `${sessionTable.value}/update`,
            method: 'post',
            data: user.value
        }).then(res => {
            context?.$message.success('账户充值成功！正在返回...')
            dialogFormVisibleMoney.value = false
            // 刷新一遍 session 确保视图一致
            getMenu()
        })
    }
    // ========================================================
</script>

<style lang="scss" scoped>
.modern-center-page {
    width: 1200px;
    margin: 0 auto;
    padding: 30px 0 50px;
}

/* 顶部高级卡片背景 */
.profile-header {
    position: relative;
    border-radius: 16px;
    overflow: hidden;
    margin-bottom: 30px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.06);
    background: #fff;
}
.profile-bg {
    height: 180px;
    background: linear-gradient(120deg, #84fab0 0%, #8fd3f4 100%);
}
.profile-card {
    display: flex;
    align-items: center;
    padding: 0 50px 40px;
    margin-top: -50px;
    position: relative;
}
.user-avatar {
    border: 6px solid #fff;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}
.user-info {
    margin-left: 30px;
    margin-top: 45px;
}
.user-name {
    margin: 0 0 5px 0;
    font-size: 26px;
    color: #333;
}
.user-desc {
    margin: 0 0 12px 0;
    color: #666;
    font-size: 15px;
}

/* 主体容器左右分栏 */
.center-body {
    display: flex;
    gap: 30px;
    align-items: flex-start;
}

/* 左侧导航栏 */
.nav-sidebar {
    width: 260px;
    border-radius: 16px;
    border: none;
    box-shadow: 0 4px 20px rgba(0,0,0,0.04);
}
.nav-title {
    font-size: 18px;
    font-weight: bold;
    padding: 20px;
    border-bottom: 1px solid #f0f2f5;
    color: #333;
}
.usersTabView {
    padding: 10px;
}
.usersTab {
    padding: 15px 20px;
    font-size: 15px;
    color: #606266;
    border-radius: 10px;
    cursor: pointer;
    transition: all 0.3s;
    margin-bottom: 5px;
    display: flex;
    align-items: center;
    gap: 12px;
}
.usersTab:hover {
    background: #f4f9ff;
    color: #4A90E2;
}
.usersTabActive {
    background: #4A90E2 !important;
    color: #fff !important;
    font-weight: bold;
    box-shadow: 0 4px 12px rgba(74, 144, 226, 0.2);
}

/* 右侧内容面板 */
.content-panel {
    flex: 1;
    border-radius: 16px;
    border: none;
    box-shadow: 0 4px 20px rgba(0,0,0,0.04);
    min-height: 500px;
    :deep(.el-card__body) { padding: 0; }
}
.panel-header {
    padding: 25px 30px;
    border-bottom: 1px solid #f0f2f5;
    font-size: 20px;
    font-weight: bold;
    color: #333;
    background: #fafafa;
    border-radius: 16px 16px 0 0;
}
.panel-body {
    padding: 40px 60px 40px 40px;
}

/* 优美的表单样式（修复双层边框Bug） */
.center_form :deep(.el-input__wrapper) {
    border-radius: 8px;
    box-shadow: 0 0 0 1px #e4e7ed inset; /* 使用单层内发光代替 border */
    background: #fdfdfd;
    padding: 0 15px;
    transition: all 0.3s;
}
.center_form :deep(.el-input__wrapper.is-focus) {
    box-shadow: 0 0 0 2px #4A90E2 inset !important;
    background: #fff;
}
.center_form :deep(.el-input__inner) {
    height: 42px;
    border: none; /* 去除原本导致双重包裹的内部边框 */
    background: transparent;
}
.save-btn {
    padding: 12px 40px;
    font-size: 16px;
    margin-top: 10px;
    box-shadow: 0 4px 12px rgba(74, 144, 226, 0.3);
}

/* 充值弹窗的美化 */    
.recharge-header {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-bottom: 20px;
}
:deep(.recharge-dialog) {
    border-radius: 16px;
    overflow: hidden;
}
:deep(.recharge-dialog .el-dialog__header) {
    background: #fafafa;
    border-bottom: 1px solid #ebeef5;
    padding: 20px;
}
</style>