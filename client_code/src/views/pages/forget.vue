<template>
	<div>
		<div class="forget_view">
			<el-form :model="forgetForm" class="forget_box">
				<div class="forget_title">社区养老助餐服务管理系统{{pageType==1?'输入账号':pageType==2?'输入密保':'重置密码'}}</div>
				<div class="tab_line">
					<div class="line"></div>
					<div class="num_line">
						<div class="line_number" :class="pageType==1?'line_number1':'',pageType>1?'line_number2':''"><div class="number" v-if="pageType<2">1</div><el-icon v-else><Check /></el-icon></div>
						<div class="line_number" :class="pageType==2?'line_number1':'',pageType>2?'line_number2':''"><div class="number" v-if="pageType<3">2</div><el-icon v-else><Check /></el-icon></div>
						<div class="line_number" :class="pageType==3?'line_number1':''"><div class="number">3</div></div>
					</div>
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
    import { useRoute } from 'vue-router'
    const route = useRoute()
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	onMounted(()=>{
	})
	const pageType = ref(1)
	const forgetForm = ref({})
	const userForm = ref({})
	//返回登录
	const close = () => {
		context?.$router.push({
			path: "/login"
		});
	}
</script>

<style lang="scss" scoped>
	.forget_view {
        background-image: url("http://clfile.zggen.cn/20250103/d60222e228cd4c8eb77ddc0ecb3b948b.webp")!important;
		// 表单盒子
		.forget_box {
			// 标题
			.forget_title {
			}
			// tab
			// 盒子
			.tab_line{
				// 中间线
				.line{
				}
				// item盒子
				.num_line{
					// 默认样式
					.line_number{
					}
					// 选中样式
					.line_number1{
					}
					// 完成样式
					.line_number2{
					}
				}
			}
			// item
			.list_item {
				// label
				.item_label {
				}
				// 输入框
				:deep(.list_inp) {
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
			}
			// 按钮盒子
			.list_btn {
				// 获取密保
				:deep(.el-button--success) {
				}
				// 获取密保悬浮
				:deep(.el-button--success:hover) {
				}
				// 确认密保
				:deep(.el-button--primary) {
				}
				// 确认密保悬浮
				:deep(.el-button--primary:hover) {
				}
				// 重置密码
				:deep(.el-button--warning) {
				}
				// 重置密码悬浮
				:deep(.el-button--warning:hover) {
				}
				.r-login {
				}
			}
		}
	}
</style>
<style>

.forget_view{
    min-height: 100vh;
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    background-size: 100% 100%;
    padding: 0 10%;
}


.forget_view .forget_box{
    width: 500px;
    padding: 30px;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    border-radius: 10px;
    background: rgba(0, 0, 0, 0.50);
    box-shadow: 0px 3px 7px 0px rgba(0,0,0,0.3);
}


.forget_view .outTitle_view{
    display: flex;
    align-items: center;
    padding: 0px 0px 40px;
    margin:0 50% 0 0;
}
.forget_view .outTitle_view .outTilte {
	font-size:32px;
	font-weight:600;
	text-align:center;
	background:-webkit-linear-gradient(left,#147B96,#7aa8c9 25%,#147B96 50%,#7aa8c9 75%,#147B96);
	color:transparent;
	-webkit-background-clip:text;
	background-size:200% 100%;
	animation:masked-animation 1s infinite linear;
}


.forget_view .forget_box .tab_view{
    width: 100%;
    display: flex;
    align-items: center;
    padding: 0px 0px 20px;
}

.forget_view .forget_box .tab_view .tab{
    width: calc(33.3333%);
    padding: 16px 0px;
    box-sizing: border-box;
    text-align: center;
    font-size: 16px;
    background: #ccc;
    clip-path: polygon(0% 0%, 92% 0%, 100% 50%, 92% 100%, 0px 100%, 8% 50%);
}
.forget_view .forget_box .tab_view .tab.tab_active{
    width: calc(33.3333%);
    padding: 16px 0px;
    box-sizing: border-box;
    text-align: center;
    font-size: 16px;
    clip-path: polygon(0% 0%, 92% 0%, 100% 50%, 92% 100%, 0px 100%, 8% 50%);
    background: var(--theme);
    color: rgb(255, 255, 255);
}


.forget_view .forget_box .list_item{display: flex;align-items: center;width: 80%;justify-content: flex-start;margin: 0px 0px 30px;background: #fff;border-radius: 8px;}
.forget_view .forget_box .list_item .item_label{
    width: 120px;
    text-align: right;
    box-sizing: border-box;
    font-size: 16px;
    color: #000;
    text-align: center;
}
.forget_view .forget_box .list_item .list_inp{
    height: 36px;
    line-height: 36px;
    border:none;
    border-bottom: 1px solid rgb(221, 221, 221);
    padding: 0px 10px;
    width: calc(100% - 120px);
    box-sizing: border-box;
    font-size: 15px;
    margin-right: 30px;
}
.forget_view .forget_box .list_item .list_sel{
    line-height: 36px;
    border:none;
    border-bottom: 1px solid rgb(221, 221, 221);
    box-sizing: border-box;
    width: calc(100% - 120px);
    padding: 0px 10px;
    border-radius: 0px;
    background: #fff;
    margin-right: 30px;
}
.forget_view .forget_box .list_item .list_sel .el-input__inner{
    font-size: 15px;
    color:#666;
}


.forget_view .forget_box .list_btn{
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    width: 100%;
    margin: 0px;
    padding: 0;
    text-align: center;
    justify-content: center;
}

.forget_view .forget_box .list_btn .get_btn, .forget_view .forget_box .list_btn .valid_btn, .forget_view .forget_box .list_btn .update_btn{
    margin: 0;
    padding: 0px 24px;
    width: auto;
    height: 44px;
    font-size: 16px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0px;
    background: var(--theme);
    cursor: pointer;
    width: 80%;
    border-radius: 25px;
}

.forget_view .forget_box .list_btn .r-login{
    width: 100%;
    text-align: right;
    cursor: pointer;
    padding: 10px 0px 0px;
    font-size: 15px;
    color: #fff;
}
.forget_view .forget_box .list_btn .r-login:hover{
    text-decoration:underline;
}


.forget_view .forget_title {
    font-size: 26px;
    text-align: center;
    color: #fff;
    margin-bottom: 20px;
}

.tab_line {
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 30px 0px;
}

.line {
    width: 80%;
    height: 2px;
    background: rgb(204, 204, 204);
}

.num_line {
    margin: -20px 0px 0px;
    width: 80%;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.line_number {
    background: rgb(255, 255, 255);
    width: 40px;
    height: 40px;
    font-size: 18px;
    border-radius: 50%;
    border: 4px solid rgb(221, 221, 221);
    display: flex;
    align-items: center;
    justify-content: center;
    color: rgb(170, 170, 170);
}

.line_number.line_number1 {
    background: rgb(255, 255, 255);
    width: 40px;
    height: 40px;
    font-size: 22px;
    border-radius: 50%;
    border-width: 4px;
    border-style: solid;
    border-color: var(--theme);
    border-image: initial;
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--theme);
}

</style>
