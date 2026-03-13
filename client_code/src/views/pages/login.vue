<template>
	<div>
		<div class="login_view">
			<el-form :model="loginForm" class="login_form">
				<div class="title_view">社区养老助餐服务管理系统登录</div>
				<div class="list_item" v-if="loginType==1">
					<div class="list_label">
						账号：
					</div>
					<input class="list_inp" v-model="loginForm.username" name="username" placeholder="请输入账号" />
				</div>
				<div class="list_item" v-if="loginType==1">
					<div class="list_label">
						密码：
					</div>
					<input class="list_inp" v-model="loginForm.password" type="password" placeholder="请输入密码" @keydown.enter.native="handleLogin" />
				</div>
				<div class="list_type" v-if="userList.length>1">
					<div class="list_label">
						用户类型：
					</div>
				  <el-select v-model="loginForm.role" placeholder="请选择用户类型">
				    <el-option v-for="(item,index) in userList" :label="item.roleName" :value="item.roleName"></el-option>
				  </el-select>
				</div>
                <div class="forget-wrapper">
                </div>
                <div class="login-wrapper">
                    <el-button class="login" v-if="loginType==1" @click="handleLogin">登录</el-button>
                </div>
                <div class="face-wrapper">
                </div>
                <div class="register-wrapper">
                    <el-button class="register" @click="handleRegister('laoren')">注册老人</el-button>
                </div>
			</el-form>
		</div>
	</div>
</template>
<script setup>
	import {
		ref,
		getCurrentInstance,
		nextTick,
		onMounted,
	} from "vue";
	import {
		useStore
	} from 'vuex';
	const store = useStore()
	import menu from '@/utils/menu'
	const userList = ref([])
	const menus = ref([])
	const loginForm = ref({
		role: '',
		username: '',
		password: ''
	})
	const tableName = ref('')
	const loginType = ref(1)
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	//注册
    const handleRegister = (tableName) => {
    	context?.$router.push(`/${tableName}Register`)
    	
    }
	const handleLogin = () => {
		if (!loginForm.value.username) {
			context?.$toolUtil.message('请输入用户名', 'error')
			return;
		}
		if (!loginForm.value.password) {
			context?.$toolUtil.message('请输入密码', 'error')
			return;
		}
		if (userList.value.length > 1) {
			if (!loginForm.value.role) {
				context?.$toolUtil.message('请选择角色', 'error')
				verifySlider.reset()
				return;
			}
			for (let i = 0; i < menus.value.length; i++) {
				if (menus.value[i].roleName == loginForm.value.role) {
					tableName.value = menus.value[i].pathName||menus.value[i].tableName;
				}
			}
		} else {
			tableName.value = userList.value[0].pathName||userList.value[0].tableName;
			loginForm.value.role = userList.value[0].roleName;
		}
		login()
	}
	const login = () => {
		context?.$http({
			url: `${tableName.value}/login?username=${loginForm.value.username}&password=${loginForm.value.password}`,
			method: 'post'
		}).then(res => {
			context?.$toolUtil.storageSet("frontToken", res.data.token);
			context?.$toolUtil.storageSet("frontRole", loginForm.value.role);
			context?.$toolUtil.storageSet("frontSessionTable", tableName.value);
			store.dispatch('user/getSession')
			let path = context?.$toolUtil.storageGet('toPath')
			if (path && path!='/login') {
				context?.$router.push(path)
				context?.$toolUtil.storageRemove('toPath')
				return
			}
			context?.$router.push(`/index/${tableName.value}Center`)
		},err=>{
		})
	}
	//获取菜单
	const getMenu= async ()=> {
		let arr = menu.list()
		if(!arr){
			let res = await context?.$http.get("menu/list")
			context?.$toolUtil.storageSet("menus", res.data.data.list[0].menujson);
			arr = JSON.parse(res.data.data.list[0].menujson)
		}
		menus.value = arr
		for (let i = 0; i < menus.value.length; i++) {
			if (menus.value[i].hasFrontLogin=='是') {
				userList.value.push(menus.value[i])
			}
		}
    }
	//初始化
	const init = async () => {
		await getMenu();
		loginForm.value.role = userList.value[0].roleName
	}
	onMounted(()=>{
		init()

	})
</script>

<style lang="scss" scoped>
	.login_view {
        background-image: url("http://clfile.zggen.cn/20250103/88f51b3c4e6c48e285aaaef6dc851f76.webp")!important;
		// 表单盒子
		.login_form {
		}
		.title_view {
		}
		// item盒子
		.list_item {
			// label
			.list_label {
			}
			// 输入框
			.list_inp {
			}
		}
		.list_type {
			.list_label {
			}
			// 下拉框样式
			:deep(.el-select) {
				//去掉默认样式
				.select-trigger{
					height: 100%;
					.el-input{
						height: 100%;

					}
				}
			}
		}
		// 按钮盒子
		.btn_view {
			// 登录
			.login {
			}
			// 注册
			.register {
			}
		}
	}

</style>
<style>
.login_view {
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    background-size: 100% 100%;
}

.login_view form.el-form.login_form {
    background: rgba(0, 0, 0, 0.50);
    width: 500px;
    padding: 50px;
    row-gap: 20px;
    display: flex;
    flex-wrap: wrap;
    background-size: 400px 700px;
    background-repeat: no-repeat;
    background-position: right;
    color: #fff;
    justify-content: center;
    box-shadow: 1px 1px 6px rgba(0,0,0,0.3);
    border-radius: 0;
}

.login_view .title_view {width: 100%;order: 1;font-size: 24px;text-align: center;}

.login_view .tabView {
    order: 2;
    display: flex;
    width: 100%;
    height: 50px;
    border-radius: 6px;
    overflow: hidden;
}

.login_view .tab {line-height: 50px;height: 50px;background: #E2E2E2;color: #959595;text-align: center;font-weight: 600;}

.login_view .tab.tabActive {
    background: var(--theme);
    color: #fff;
}

.login_view .list_item {
    order: 3;
    width: 100%;
    display: flex;
    background: #fff;
    align-items: center;
    height: 50px;
    
    border-radius: 6px;
    position: relative;
}

.login_view .listCode_view {
    order: 4;
    display: flex;
    align-items: center;
    background: #fff;
    height: 50px;
    border-radius: 6px;
    position: relative;
    
    margin-right: 120px;
}

.login_view .face {
    order: 5;
    cursor: pointer;
    color: #fff;
    font-size: 18px;
    font-weight: 700;
    line-height: 46px;
    text-align: center;
    background: var(--theme);
}

.login_view .btn_view {
    order: 5;
    position: relative;
    margin-top: 40px;
    width: 100%;
    display: flex;
    flex-wrap: wrap;
    gap: 30px;
}

.login_view .list_label {
    color: var(--theme);
    width: 100px;
    text-align: center;
    position: relative;
    z-index: 1;
    padding-left: 10px;
}

.login_view input.list_inp {
    flex: 1;
    border: none;
    line-height: 46px;
    padding-left: 10px;
}

.login_view .listCode_label {
    width: 100px;
    text-align: center;
    color: var(--theme);
    flex-shrink: 0;
    position: relative;
    z-index: 0;
    padding-left: 10px;
}

.login_view input.listCode_inp {
    flex: 1;
    border: none;
    line-height: 46px;
    margin-right: 25px;
    width: 145px;
    padding-left: 10px;
}

.login_view .listCode_btn {
    height: 100%;
    padding: 0 10px;
    display: flex;
    align-items: center;
    width: 110px;
    border-radius: 0;
    background: var(--theme);
    justify-content: center;
    border-radius: 6px;
    position: absolute;
    right: -120px;
}

.login_view .el-button.login {
    border: none;
    width: 100%;
    border-radius: 0;
    height: 46px;
    background: var(--theme);
    color: #fff;
    font-size: 18px;
    font-weight: 700;
}

.login_view .el-button.forget {
    width: 100px;
    background: none;
    border: none;
    color: inherit;
}

.login_view button.el-button.register {
    height: 50px;
    flex: 1;
    border: 1px solid var(--theme);
    border-radius: 0;
    color: #fff;
    margin: 0;
    background: var(--theme);
}

.login_view .list_type {
    order: 1;
    display: flex;
    height: 50px;
    align-items: center;
    width: 100%;
    border-radius: 6px;
    border: 0px solid var(--theme);
    justify-content: center;
    column-gap: 30px;
    flex-wrap: wrap;
    background: #fff;
}

.login_view .el-select {
    flex: 1;
    line-height: 50px;
    border: none!important;
    color: #000;
    padding-right: 10px;
}

.login_view .forget-wrapper {order: 6;width: 100%;text-align: center;}

.login_view .login-wrapper {
    order: 7;
    width: 100%;
}

.login_view .face-wrapper {
    order: 8;
    background: rgba(243, 110, 66, 1);
    width: 100%;
}

.login_view .register-wrapper {
    order: 9;
    width: 100%;
    display: flex;
    flex-wrap: wrap;
    column-gap: 20px;
}



.login_view .el-radio__input.is-checked .el-radio__inner {
    background: var(--theme);
    border-color: var(--theme);
}

.login_view .el-radio__input.is-checked+.el-radio__label {
    color: var(--theme);
}

.login_view .el-radio__inner:hover {
    border-color: var(--theme);
}
</style>