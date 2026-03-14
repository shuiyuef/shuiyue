<template>
	<div>
		<div class="login_view">
			<el-form :model="loginForm" class="login_form">
				<div class="title_view">社区养老助餐服务管理系统</div>
				
				<div class="list_item" v-if="loginType==1">
					<div class="list_label">老人账号：</div>
					<input class="list_inp" v-model="loginForm.username" name="username" placeholder="请输入您的账号" />
				</div>
				<div class="list_item" v-if="loginType==1">
					<div class="list_label">登录密码：</div>
					<input class="list_inp" v-model="loginForm.password" type="password" placeholder="请输入您的密码" @keydown.enter.native="handleLogin" />
				</div>
                
                <div class="login-wrapper">
                    <el-button class="login" v-if="loginType==1" @click="handleLogin">登 录 系 统</el-button>
                </div>

                <div class="action-wrapper">
                    <span class="no-account">还没有账号？</span>
                    <span class="register-link" @click="goToRegister">立即注册</span>
                </div>
                </el-form>
		</div>
	</div>
</template>

<script setup>
	import { ref, getCurrentInstance } from "vue";
	import { useStore } from 'vuex';
	import { useRouter } from 'vue-router';
	import menu from '@/utils/menu'
	
	const store = useStore()
	const router = useRouter()
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const loginType = ref(1)
	const loginForm = ref({ role: '', username: '', password: '' })
	const userList = ref([])
	
	const getMenu = () => {
		let menus = menu.list()
		userList.value = menus
	}
	getMenu()

	const handleLogin = () => {
		// 强制在底层把前台登录角色锁定为“老人”
		loginForm.value.role = '老人'; 

		if (!loginForm.value.username) {
			context?.$message.error('请输入用户名')
			return
		}
		if (!loginForm.value.password) {
			context?.$message.error('请输入密码')
			return
		}
		
		let url = '';
		for(let i=0; i<userList.value.length; i++) {
			if(userList.value[i].roleName == loginForm.value.role){
				url = userList.value[i].tableName+'/login'
				context?.$toolUtil.storageSet('frontSessionTable',userList.value[i].tableName)
				context?.$toolUtil.storageSet('frontRole',loginForm.value.role)
				context?.$toolUtil.storageSet('frontMenu',JSON.stringify(userList.value[i].frontMenu))
			}
		}
		
		if(!url) {
			url = 'laoren/login';
			context?.$toolUtil.storageSet('frontSessionTable', 'laoren')
			context?.$toolUtil.storageSet('frontRole', '老人')
		}
		
		context?.$http({
			url: url,
			method: 'get',
			params: { username: loginForm.value.username, password: loginForm.value.password }
		}).then(res => {
			context?.$toolUtil.storageSet('frontToken', res.data.token)
			store.dispatch('user/getSession').then(()=>{
				router.push('/index/home')
			})
		})
	}

// ================= 修复后的注册跳转逻辑 =================
    const goToRegister = () => {
        // 根据你原生系统的路由规则，精准跳转到老人的注册页面
        router.push('laorenRegister')
    }
    // ========================================================
</script>

<style lang="scss" scoped>

.action-wrapper {
    margin-top: 25px;
    text-align: center;
    font-size: 15px;
}
.no-account { color: #909399; }
.register-link {
    color: #4A90E2;
    font-weight: bold;
    cursor: pointer;
    margin-left: 8px;
    transition: all 0.3s;
}
.register-link:hover { color: #357ABD; text-decoration: underline; }

/* 整个登录页的背景容器 */
.login_view {
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.6)), url('https://images.unsplash.com/photo-1556910103-1c02745a872f?q=80&w=2000&auto=format&fit=crop') no-repeat center center;
    background-size: cover;
    position: relative;
}

/* 核心：纯白高质感登录卡片 */
.login_form {
    width: 440px;
    background: #ffffff;
    padding: 50px 40px 40px;
    border-radius: 16px;
    box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
    display: flex;
    flex-direction: column;
    position: relative;
    z-index: 2;
    box-sizing: border-box;
}

/* 标题优化 */
.title_view {
    font-size: 22px;
    font-weight: bold;
    color: #333;
    text-align: center;
    margin-bottom: 35px;
    letter-spacing: 1px;
}

/* 输入框组合排版 */
.list_item {
    display: flex;
    flex-direction: column;
    margin-bottom: 22px;
    width: 100%;
}

.list_label {
    font-size: 14px;
    color: #606266;
    margin-bottom: 8px;
    font-weight: bold;
}

/* 优美的圆角输入框 */
.list_inp {
    width: 100%;
    height: 48px;
    border: 1px solid #dcdfe6;
    border-radius: 8px;
    padding: 0 15px;
    font-size: 15px;
    color: #333;
    background: #f8f9fa;
    outline: none;
    transition: all 0.3s;
    box-sizing: border-box;
}

.list_inp:focus {
    border-color: #4A90E2;
    background: #ffffff;
    box-shadow: 0 0 0 2px rgba(74, 144, 226, 0.2);
}

/* 登录按钮包装器 */
.login-wrapper {
    margin-top: 15px;
    width: 100%;
}

/* 霸气的主按钮 */
.login {
    width: 100%;
    height: 50px;
    border-radius: 8px;
    background: #4A90E2;
    color: #fff;
    font-size: 18px;
    font-weight: bold;
    border: none;
    cursor: pointer;
    box-shadow: 0 6px 12px rgba(74, 144, 226, 0.3);
    transition: all 0.3s;
    display: flex;
    align-items: center;
    justify-content: center;
}
.login:hover {
    background: #357ABD;
    transform: translateY(-2px);
    box-shadow: 0 8px 16px rgba(74, 144, 226, 0.4);
}

/* 新增的注册引导区样式 */
.action-wrapper {
    margin-top: 25px;
    text-align: center;
    font-size: 14px;
}
.no-account {
    color: #909399;
}
.register-link {
    color: #4A90E2;
    font-weight: bold;
    cursor: pointer;
    margin-left: 5px;
    transition: color 0.3s;
}
.register-link:hover {
    color: #357ABD;
    text-decoration: underline;
}
</style>