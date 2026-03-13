<template>
	<div>
		<div class="register_view">
			<el-form :model="registerForm" class="register_form">
				<div class="title_view">{{projectName}}注册</div>
				<div class="list_item">
					<div class="list_label">老人账号：</div>
					<input class="list_inp"
					 v-model="registerForm.laorenzhanghao" 
					 placeholder="请输入老人账号"
					 type="text"
					 />
				</div>
				<div class="list_item">
					<div class="list_label">密码：</div>
					<input class="list_inp"
					 v-model="registerForm.mima" 
					 placeholder="请输入密码"
					 type="password"
					 />
				</div>
				<div class="list_item">
					<div class="list_label">确认密码：</div>
					<input class="list_inp" v-model="registerForm.mima2" type="password" placeholder="请输入确认密码" />
				</div>
				<div class="list_item">
					<div class="list_label">老人姓名：</div>
					<input class="list_inp"
					 v-model="registerForm.laorenxingming" 
					 placeholder="请输入老人姓名"
					 type="text"
					 />
				</div>
				<div class="list_item">
					<div class="list_label">性别：</div>
					<el-select 
						class="list_sel" 
						v-model="registerForm.xingbie" 
						placeholder="请选择性别"
						>
						<el-option v-for="item in laorenxingbieLists" :label="item" :value="item"></el-option>
					</el-select>
				</div>
				<div class="list_item">
					<div class="list_label">头像：</div>
					<div class="list_file_list">
						<uploads
							action="file/upload" 
							tip="请上传头像"
							style="width: 100%;text-align: left;"
							:fileUrls="registerForm.touxiang?registerForm.touxiang:''" 
							@change="touxiangUploadSuccess">
						</uploads>
					</div>
				</div>
				<div class="list_item">
					<div class="list_label">年龄：</div>
					<input class="list_inp"
					 v-model="registerForm.nianling" 
					 placeholder="请输入年龄"
					 type="text"
					 />
				</div>
				<div class="list_item">
					<div class="list_label">饮食禁忌：</div>
					<input class="list_inp"
					 v-model="registerForm.yinshijinji" 
					 placeholder="请输入饮食禁忌"
					 type="text"
					 />
				</div>
				<div class="list_item">
					<div class="list_label">偏好口味：</div>
					<input class="list_inp"
					 v-model="registerForm.pianhaokouwei" 
					 placeholder="请输入偏好口味"
					 type="text"
					 />
				</div>
				<div class="list_btn">
					<el-button class="register" type="success" @click="handleRegister">注册</el-button>
					<div class="r-login" @click="close">已有账号，直接登录</div>
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
	} from 'vue';
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const projectName = context?.$project.projectName
	//获取注册类型
	import { useRoute } from 'vue-router';
	const route = useRoute()
	const tableName = ref('laoren')

	//公共方法
	const getUUID=()=> {
		return new Date().getTime();
	}
	
	const registerForm = ref({
        xingbie: '',
	})
	const laorenxingbieLists = ref([])
	const init=()=>{
		laorenxingbieLists.value = "男,女".split(',')
	}
    const touxiangUploadSuccess=(fileUrls)=> {
        registerForm.value.touxiang = fileUrls;
    }
	// 多级联动参数
	//注册按钮
	const handleRegister = () => {
		let url = tableName.value +"/register";
		if((!registerForm.value.laorenzhanghao)){
			context?.$toolUtil.message(`老人账号不能为空`,'error')
			return false
		}
		if((!registerForm.value.mima)){
			context?.$toolUtil.message(`密码不能为空`,'error')
			return false
		}
		if(registerForm.value.mima!=registerForm.value.mima2){
			context?.$toolUtil.message('两次密码输入不一致','error')
			return false
		}
		if((!registerForm.value.laorenxingming)){
			context?.$toolUtil.message(`老人姓名不能为空`,'error')
			return false
		}
		if(registerForm.value.touxiang!=null){
			registerForm.value.touxiang = registerForm.value.touxiang.replace(new RegExp(context?.$config.url,"g"),"");
		}
		if(registerForm.value.nianling&&(!context?.$toolUtil.isIntNumer(registerForm.value.nianling))){
			context?.$toolUtil.message(`年龄应输入整数`,'error')
			return false
		}
		if(registerForm.value.money&&(!context?.$toolUtil.isNumber(registerForm.value.money))){
			context?.$toolUtil.message(`余额应输入数字`,'error')
			return false
		}
		context?.$http({
			url:url,
			method:'post',
			data:registerForm.value
		}).then(res=>{
			context?.$toolUtil.message('注册成功','success', obj=>{
				context?.$router.push({
					path: "/login"
				});
			})
		})
	}
	//返回登录
	const close = () => {
		context?.$router.push({
			path: "/login"
		});
	}
	init()
	onMounted(()=>{

	})
</script>
<style lang="scss" scoped>
	.register_view {
        background-image: url("http://clfile.zggen.cn/20250103/4f6907bc0c8447dba71983748e6bf763.webp")!important;
		// 表单盒子
		.register_form {
		}
		// 标题样式
		.title_view {
		}
		// item盒子
		.list_item {
			// label
			.list_label {
			}
			// 输入框
			:deep(.list_inp) {

			}
		}
		//下拉框样式
		:deep(.list_sel) {
			//去掉默认样式
			.select-trigger{
				height: 100%;
				.el-input{
					height: 100%;
				}
			}
		}
		//图片上传样式
		.list_file_list  {
			//提示语
			:deep(.el-upload__tip){
			}
			//外部盒子
			:deep(.el-upload--picture-card){
				//图标
				.el-icon{
				}
			}
			:deep(.el-upload-list__item) {
			}
		}
		//按钮盒子
		.list_btn {
			//注册按钮
			.register {
			}
			//注册按钮悬浮样式
			.register:hover {
			}
			//已有账号
			.r-login {
			}
		}
	}
</style>
<style>

.register_view {
    min-height: 100vh;
    position: relative;
    display: flex;
    align-items: flex-start;
    justify-content: center;
    padding: 15vh 10%;
    background-attachment: fixed;
    background-size: 100% 100%;
}


.register_view .register_form{
    border-radius: 10px;
    background: rgba(0, 0, 0, 0.50);
    width: 500px;
    padding: 50px;
    display: flex;
    flex-wrap: wrap;
    background-size: 400px 700px;
    background-repeat: no-repeat;
    background-position: right;
    color: #fff;
    justify-content: center;
    box-shadow: 1px 1px 6px rgba(0, 0, 0, 0.30);
}


.register_view .outTitle_view{
    display: flex;
    align-items: center;
    padding: 0px 0px 40px;
    margin:0 50% 0 0;
}
.register_view .outTitle_view .outTilte {
	font-size:32px;
	font-weight:600;
	text-align:center;
	background:-webkit-linear-gradient(left,#147B96,#7aa8c9 25%,#147B96 50%,#7aa8c9 75%,#147B96);
	color:transparent;
	-webkit-background-clip:text;
	background-size:200% 100%;
	animation:masked-animation 1s infinite linear;
}


.register_view .register_form .list_item{
    display: flex;
    align-items: center;
    width: 100%;
    margin: 0 0 20px;
    background: #fff;
    padding: 10px;
    
    border-radius: 6px;
    position: relative;
    z-index: 1;
    min-height: 50px;
}

.register_view .register_form .list_item .list_label{
    width: 120px;
    font-size: 16px;
    text-align: center;
    color: var(--theme);
}
.register_view .register_form .list_item .list_inp{
    line-height: 30px;
    border:none;
    border-bottom: 0;
    padding: 0px 10px;
    width: calc(100% - 120px);
    color:#999;
    font-size: 16px;
}
.register_view .register_form .list_item .list_date{
    width: calc(100% - 120px)!important;
    line-height: 30px;
    border:none;
    border-bottom: none;
    box-sizing: border-box;
    border-radius: 0px;
    color:#999;
    font-size: 16px;
}
.register_view .register_form .list_item .list_sel{
    line-height: 30px;
    border:none;
    border-bottom: none;
    box-sizing: border-box;
    width: calc(100% - 120px);
    padding: 0px 10px;
    border-radius: 0px;
    color:#999;
    font-size: 16px;
}


.register_view .register_form .list_item .list_file_list{
    width: calc(100% - 120px);
}

.register_view .register_form .list_item .el-upload--picture-card{
    background-color: rgb(255, 255, 255);
    width: 90px;
    height: 60px;
    line-height: 60px;
    text-align: center;
    border: 1px solid rgb(221, 221, 221);
    border-radius: 0px;
    cursor: pointer;
}

.register_view .register_form .list_item .el-upload--picture-card .el-icon{
    font-size: 22px;
    color: rgb(153, 153, 153);
}

.register_view .register_form .list_item .el-upload__tip{
    font-size: 16px;
    color: rgb(153, 153, 153);
    margin: 7px 0px 0px;
    display: flex;
    align-items: center;
    justify-content: flex-start;
}


.register_view .register_form .list_item .el-upload-dragger{
    background-color: rgb(255, 255, 255);
    border: 1px solid rgb(221, 221, 221);
    border-radius: 0px;
    box-sizing: border-box;
    width: 100%;
    height: auto;
    text-align: center;
    cursor: pointer;
    overflow: hidden;
    padding: 10px;
}

.register_view .register_form .list_item .el-upload-dragger .el-icon--upload{
    font-size: 60px;
    color: var(--theme);
    line-height: 50px;
    margin: 0px;
}

.register_view .register_form .list_item .el-upload-dragger .el-upload__text{
    font-size: 16px;
    color: rgb(153, 153, 153);
    margin: 5px 0px 0px;
}

.register_view .register_form .list_item .el-upload-dragger .el-upload__text em{
    color: var(--theme);
}


.register_view .register_form .list_item .list_radio{
    display: flex;
    width: calc(100% - 120px);
    align-items: center;
    flex-wrap: wrap;
}

.register_view .register_form .list_item .list_radio .el-radio{
    width: auto;
    margin: 0px 20px 0px 0px;
    display: flex;
    align-items: center;
}

.register_view .register_form .list_item .list_radio .el-radio .el-radio__inner{
    border-color: rgb(153, 153, 153);
    background: rgb(255, 255, 255);
}

.register_view .register_form .list_item .list_radio .el-radio.is-checked .el-radio__inner{
    border-color: var(--theme);
    background: var(--theme);
}

.register_view .register_form .list_item .list_radio .el-radio .el-radio__label{
    color: #999;
    font-size: 16px;
}

.register_view .register_form .list_item .list_radio .el-radio.is-checked .el-radio__label{
    color: var(--theme);
}


.register_view .register_form .list_item .list_checkbox{
    display: flex;
    width: calc(100% - 120px);
    flex-wrap: wrap;
    align-items: center;
}

.register_view .register_form .list_item .list_checkbox .el-checkbox{
    width: auto;
    margin: 0px 15px 0px 0px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.register_view .register_form .list_item .list_checkbox .el-checkbox .el-checkbox__inner{
    border-color: #999;
    background: rgb(255, 255, 255);
}

.register_view .register_form .list_item .list_checkbox .el-checkbox.is-checked .el-checkbox__inner{
    border-color: var(--theme);
    background: var(--theme);
}

.register_view .register_form .list_item .list_checkbox .el-checkbox .el-checkbox__label{
    color: #999;
    font-size: 16px;
}

.register_view .register_form .list_item .list_checkbox .el-checkbox.is-checked .el-checkbox__label{
    color: #999;
}


.register_view .register_form .list_code{
    display: flex;
    align-items: center;
    width: 100%;
    justify-content: center;
    margin: 0;
    padding: 10px;
    background: #fff;
    border-radius: 6px;
    
    position: relative;
    margin-bottom: 20px;
    z-index: 1;
}
.register_view .register_form .list_code .list_code_label{
    width: 120px;
    text-align: right;
    font-size: 16px;
    text-align: center;
    flex-shrink: 0;
    color: var(--theme);
}
.register_view .register_form .list_code .list_code_item{
    display: flex;
    align-items: center;
}
.register_view .register_form .list_code .list_code_item .list_code_inp{
    height: 30px;
    line-height: 36px;
    border:none;
    border-bottom: none;
    padding: 0px 10px;
    width: calc(100% - 110px);
    font-size: 16px;
    border-right: 0px;
    flex: 1;
}
.register_view .register_form .list_code .list_code_btn{
    padding:0px;
    width: 120px;
    height: 40px;
    line-height: 36px;
    text-align: center;
    border-radius: 0;
    border: none;
    background: var(--theme);
    color: rgb(255, 255, 255);
    font-size: 14px;
    margin-left:10px;
    border-radius: 0;
}


.register_view .register_form .list_btn{
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    justify-content: center;
    width: 100%;
    margin: 20px 0px 0px;
    padding: 0;
}

.register_view .register_form .list_btn .register{
    margin: 0;
    padding: 0px 10px;
    width: 100%;
    height: 44px;
    font-size: 16px;
    color: rgb(255, 255, 255);
    border: 0px;
    background: var(--theme);
    cursor: pointer;
    min-width:120px;
    border-radius: 0;
}

.register_view .register_form .list_btn .r-login{
    width: 100%;
    cursor: pointer;
    padding: 10px 0px 0px;
    color: #fff;
    font-size: 16px;
    text-align: center;
    margin-top: 30px;
}
.register_view .register_form .list_btn .r-login:hover{
    text-decoration:underline;
}


.register_view .title_view {
    
    font-size: 24px;
    margin-bottom: 20px;
}

.register_view i {
    line-height: 30px!important;
}
</style>