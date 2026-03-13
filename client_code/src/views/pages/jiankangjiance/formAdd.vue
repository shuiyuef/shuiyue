<template>
	<div class="edit_view" :style='{}'>
        <div class="breadcrumb-wrapper" style="width: 100%;">
            <div class="bread_view">
                <el-breadcrumb separator="—" class="breadcrumb">
                    <el-breadcrumb-item class="first_breadcrumb" :to="{ path: '/' }">首页</el-breadcrumb-item>
                    <el-breadcrumb-item class="second_breadcrumb" v-for="(item,index) in breadList" :key="index">{{item.name}}</el-breadcrumb-item>
                </el-breadcrumb>
            </div>
        </div>
		<el-form ref="formRef" :model="form" class="add_form" label-width="120px" :rules="rules">
			<el-row>
				<el-col :span="12">
					<el-form-item label="老人账号" prop="laorenzhanghao">
						<el-input class="list_inp"
                                  v-model="form.laorenzhanghao"
                                  placeholder="老人账号"
                                  type="text"
							      :readonly="!isAdd||disabledForm.laorenzhanghao?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="老人姓名" prop="laorenxingming">
						<el-input class="list_inp"
                                  v-model="form.laorenxingming"
                                  placeholder="老人姓名"
                                  type="text"
							      :readonly="!isAdd||disabledForm.laorenxingming?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="头像" prop="touxiang">
						<uploads
							:disabled="!isAdd||disabledForm.touxiang?true:false"
							action="file/upload" 
							tip="请上传头像"
							style="width: 100%;text-align: left;"
							:fileUrls="form.touxiang?form.touxiang:''" 
							@change="touxiangUploadSuccess">
						</uploads>
					</el-form-item>
				</el-col>
				<el-col :span="12">
					<el-form-item label="血压" prop="xueya">
						<el-input class="list_inp"
                                  v-model="form.xueya"
                                  placeholder="血压"
                                  type="text"
							      :readonly="!isAdd||disabledForm.xueya?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="血糖" prop="xuetang">
						<el-input class="list_inp"
                                  v-model="form.xuetang"
                                  placeholder="血糖"
                                  type="text"
							      :readonly="!isAdd||disabledForm.xuetang?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="心率" prop="xinlv">
						<el-input class="list_inp"
                                  v-model="form.xinlv"
                                  placeholder="心率"
                                  type="text"
							      :readonly="!isAdd||disabledForm.xinlv?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="皮肤状况" prop="pifuzhuangkuang">
						<el-input class="list_inp"
                                  v-model="form.pifuzhuangkuang"
                                  placeholder="皮肤状况"
                                  type="text"
							      :readonly="!isAdd||disabledForm.pifuzhuangkuang?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="精神状态" prop="jingshenzhuangtai">
						<el-input class="list_inp"
                                  v-model="form.jingshenzhuangtai"
                                  placeholder="精神状态"
                                  type="text"
							      :readonly="!isAdd||disabledForm.jingshenzhuangtai?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="基础疾病" prop="jichujibing">
						<el-input class="list_inp"
                                  v-model="form.jichujibing"
                                  placeholder="基础疾病"
                                  type="text"
							      :readonly="!isAdd||disabledForm.jichujibing?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="饮食限制" prop="yinshixianzhi">
						<el-input class="list_inp"
                                  v-model="form.yinshixianzhi"
                                  placeholder="饮食限制"
                                  type="text"
							      :readonly="!isAdd||disabledForm.yinshixianzhi?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="登记时间" prop="dengjishijian">
						<el-date-picker
							class="list_date"
							v-model="form.dengjishijian"
							format="YYYY-MM-DD HH:mm:ss"
							value-format="YYYY-MM-DD HH:mm:ss"
							type="datetime"
							style="width:100%;"
							:readonly="!isAdd||disabledForm.dengjishijian?true:false"
							placeholder="请选择登记时间" />
					</el-form-item>
				</el-col>
				<el-col :span="24">
					<el-form-item label="评估内容" prop="pingguneirong">
						<el-input v-model="form.pingguneirong" placeholder="评估内容" type="textarea"
						:readonly="!isAdd||disabledForm.pingguneirong?true:false"
						/>
					</el-form-item>
				</el-col>
				<el-col :span="24">
					<el-form-item label="健康报告" prop="jiankangbaogao">
						<el-input v-model="form.jiankangbaogao" placeholder="健康报告" type="textarea"
						:readonly="!isAdd||disabledForm.jiankangbaogao?true:false"
						/>
					</el-form-item>
				</el-col>
				<el-col :span="24">
					<el-form-item label="健康建议" prop="jiankangjianyi">
						<el-input v-model="form.jiankangjianyi" placeholder="健康建议" type="textarea"
						:readonly="!isAdd||disabledForm.jiankangjianyi?true:false"
						/>
					</el-form-item>
				</el-col>
			</el-row>
			<div class="formModel_btn_box">
				<el-button class="formModel_cancel" @click="backClick">取消</el-button>
				<el-button class="formModel_confirm"
                           @click="save"
                           type="success"
				>
					保存
				</el-button>
			</div>
		</el-form>
	</div>
</template>
<script setup>
	import {
		ref,
		getCurrentInstance,
		watch,
		onUnmounted,
		onMounted,
		nextTick,
		computed
	} from 'vue';
	import {
		useRoute,
		useRouter
	} from 'vue-router';
    import moment from "moment";
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const route = useRoute()
	const router = useRouter()
	//基础信息
	const tableName = 'jiankangjiance'
	const formName = '健康监测'
	//基础信息
	const breadList = ref([{
		name: formName
	}])
	//获取唯一标识
	const getUUID =()=> {
      return new Date().getTime();
    }
	//form表单
	const form = ref({
		laorenzhanghao: '',
		laorenxingming: '',
		touxiang: '',
		xueya: '',
		xuetang: '',
		xinlv: '',
		pifuzhuangkuang: '',
		jingshenzhuangtai: '',
		jichujibing: '',
		yinshixianzhi: '',
		dengjishijian: '',
		pingguneirong: '',
		jiankangbaogao: '',
		jiankangjianyi: '',
	})
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
	const disabledForm = ref({
		laorenzhanghao : false,
		laorenxingming : false,
		touxiang : false,
		xueya : false,
		xuetang : false,
		xinlv : false,
		pifuzhuangkuang : false,
		jingshenzhuangtai : false,
		jichujibing : false,
		yinshixianzhi : false,
		dengjishijian : false,
		pingguneirong : false,
		jiankangbaogao : false,
		jiankangjianyi : false,
	})
	const isAdd = ref(false)
	//表单验证
	const rules = ref({
		laorenzhanghao: [
		],
		laorenxingming: [
		],
		touxiang: [
		],
		xueya: [
		],
		xuetang: [
		],
		xinlv: [
		],
		pifuzhuangkuang: [
		],
		jingshenzhuangtai: [
		],
		jichujibing: [
		],
		yinshixianzhi: [
		],
		dengjishijian: [
		],
		pingguneirong: [
		],
		jiankangbaogao: [
		],
		jiankangjianyi: [
		],
	})
	//头像上传回调
	const touxiangUploadSuccess=(e)=>{
		form.value.touxiang = e
	}
	//methods

	//methods
	//获取info
	const getInfo = ()=>{
		context?.$http({
			url: `${tableName}/info/${id.value}`,
			method: 'get'
		}).then(res => {
			let reg=new RegExp('../../../file','g')
			form.value = res.data.data
		})
	}
	const crossRow = ref('')
	const crossTable = ref('')
	const crossTips = ref('')
	const crossColumnName = ref('')
	const crossColumnValue = ref('')
	//初始化
	const init = (formId=null,formType='add',formNames='',row=null,table=null,statusColumnName=null,tips=null,statusColumnValue=null) => {
			form.value.dengjishijian = context?.$toolUtil.getCurDateTime()
		if(formId){
			id.value = formId
			type.value = formType
		}
		if(formType == 'add'){
			isAdd.value = true
		}else if(formType == 'info'){
			isAdd.value = false
			getInfo()
		}else if(formType == 'edit'){
			isAdd.value = true
			getInfo()
		}
		else if(formType == 'cross'){
			isAdd.value = true
			// getInfo()
			for(let x in row){
				if(x=='laorenzhanghao'){
					form.value.laorenzhanghao = row[x];
					disabledForm.value.laorenzhanghao = true;
					continue;
				}
				if(x=='laorenxingming'){
					form.value.laorenxingming = row[x];
					disabledForm.value.laorenxingming = true;
					continue;
				}
				if(x=='touxiang'){
					form.value.touxiang = row[x];
					disabledForm.value.touxiang = true;
					continue;
				}
				if(x=='xueya'){
					form.value.xueya = row[x];
					disabledForm.value.xueya = true;
					continue;
				}
				if(x=='xuetang'){
					form.value.xuetang = row[x];
					disabledForm.value.xuetang = true;
					continue;
				}
				if(x=='xinlv'){
					form.value.xinlv = row[x];
					disabledForm.value.xinlv = true;
					continue;
				}
				if(x=='pifuzhuangkuang'){
					form.value.pifuzhuangkuang = row[x];
					disabledForm.value.pifuzhuangkuang = true;
					continue;
				}
				if(x=='jingshenzhuangtai'){
					form.value.jingshenzhuangtai = row[x];
					disabledForm.value.jingshenzhuangtai = true;
					continue;
				}
				if(x=='jichujibing'){
					form.value.jichujibing = row[x];
					disabledForm.value.jichujibing = true;
					continue;
				}
				if(x=='yinshixianzhi'){
					form.value.yinshixianzhi = row[x];
					disabledForm.value.yinshixianzhi = true;
					continue;
				}
				if(x=='dengjishijian'){
					form.value.dengjishijian = row[x];
					disabledForm.value.dengjishijian = true;
					continue;
				}
				if(x=='pingguneirong'){
					form.value.pingguneirong = row[x];
					disabledForm.value.pingguneirong = true;
					continue;
				}
				if(x=='jiankangbaogao'){
					form.value.jiankangbaogao = row[x];
					disabledForm.value.jiankangbaogao = true;
					continue;
				}
				if(x=='jiankangjianyi'){
					form.value.jiankangjianyi = row[x];
					disabledForm.value.jiankangjianyi = true;
					continue;
				}
			}
			if(row){
				crossRow.value = row
			}
			if(table){
				crossTable.value = table
			}
			if(tips){
				crossTips.value = tips
			}
			if(statusColumnName){
				crossColumnName.value = statusColumnName
			}
			if(statusColumnValue){
				crossColumnValue.value = statusColumnValue
			}
		}
		context?.$http({
			url: `${context?.$toolUtil.storageGet('frontSessionTable')}/session`,
			method: 'get'
		}).then(res => {
			var json = res.data.data
			if(json.hasOwnProperty('laorenzhanghao') && context?.$toolUtil.storageGet("frontRole")!="管理员"){
				form.value.laorenzhanghao = json.laorenzhanghao
				disabledForm.value.laorenzhanghao = true;
			}
			if(json.hasOwnProperty('laorenxingming') && context?.$toolUtil.storageGet("frontRole")!="管理员"){
				form.value.laorenxingming = json.laorenxingming
				disabledForm.value.laorenxingming = true;
			}
			if(json.hasOwnProperty('touxiang') && context?.$toolUtil.storageGet("frontRole")!="管理员"){
				form.value.touxiang = json.touxiang
				disabledForm.value.touxiang = true;
			}
            if (localStorage.getItem('autoSave')) {
                localStorage.removeItem('autoSave')
                save()
            }
		})
	}
	//初始化
	//取消
	const backClick = () => {
		history.back()
	}
	//提交
	const save=()=>{
		if(form.value.touxiang!=null) {
			form.value.touxiang = form.value.touxiang.replace(new RegExp(context?.$config.url,"g"),"");
		}
		var table = crossTable.value
		var objcross = JSON.parse(JSON.stringify(crossRow.value))
		let crossUserId = ''
		let crossRefId = ''
		let crossOptNum = ''
		if(type.value == 'cross'){
			if(crossColumnName.value!=''){
				if(!crossColumnName.value.startsWith('[')){
					for(let o in objcross){
						if(o == crossColumnName.value){
							objcross[o] = crossColumnValue.value
						}
					}
					//修改跨表数据
					changeCrossData(objcross)
				}else{
					crossUserId = context?.$toolUtil.storageGet('userid')
					crossRefId = objcross['id']
					crossOptNum = crossColumnName.value.replace(/\[/,"").replace(/\]/,"")
				}
			}
		}
		formRef.value.validate((valid)=>{
			if(valid){
				if(crossUserId&&crossRefId){
					form.value.crossuserid = crossUserId
					form.value.crossrefid = crossRefId
					let params = {
						page: 1,
						limit: 1000, 
						crossuserid:form.value.crossuserid,
						crossrefid:form.value.crossrefid,
					}
					context?.$http({
						url: `${tableName}/page`,
						method: 'get', 
						params: params 
					}).then(res=>{
						if(res.data.data.total>=crossOptNum){
							context?.$toolUtil.message(`${crossTips.value}`,'error')
							return false
						}else{
							context?.$http({
								url: `${tableName}/${!form.value.id ? "save" : "update"}`,
								method: 'post', 
								data: form.value 
							}).then(res=>{
                                context?.$toolUtil.message(`操作成功`,'success')
                                history.back()
							})
						}
					})
				}else{
					context?.$http({
						url: `${tableName}/${!form.value.id ? "save" : "update"}`,
						method: 'post', 
						data: form.value 
					}).then(res=>{
                        context?.$toolUtil.message(`操作成功`,'success')
                        history.back()
					})
				}
			}
		})
	}
	//修改跨表数据
	const changeCrossData=(row)=>{
        if(type.value == 'cross'){
            context?.$http({
                url: `${crossTable.value}/update`,
                method: 'post',
                data: row
            }).then(res=>{})
        }
	}
	onMounted(()=>{
		type.value = route.query.type?route.query.type:'add'
		let row = null
		let table = null
		let statusColumnName = null
		let tips = null
		let statusColumnValue = null
		if(type.value == 'cross'){
			row = context?.$toolUtil.storageGet('crossObj')?JSON.parse(context?.$toolUtil.storageGet('crossObj')):{}
			table = context?.$toolUtil.storageGet('crossTable')
			statusColumnName = context?.$toolUtil.storageGet('crossStatusColumnName')
			tips = context?.$toolUtil.storageGet('crossTips')
			statusColumnValue = context?.$toolUtil.storageGet('crossStatusColumnValue')
		}
		init(route.query.id?route.query.id:null, type.value,'', row, table, statusColumnName, tips, statusColumnValue)
	})
    onUnmounted(()=>{
        Object.keys(localStorage).map(item=>{
            if(item.startsWith('cross')){
                localStorage.removeItem(item)
            }
        })
    })
</script>
<style lang="scss" scoped>
	// 面包屑盒子
	.bread_view {
		:deep(.breadcrumb) {
			.el-breadcrumb__separator {
			}
			.first_breadcrumb {
				.el-breadcrumb__inner {
				}
			}
			.second_breadcrumb {
				.el-breadcrumb__inner {
				}
			}
		}
	}
	// 表单
	.add_form{
		// form item
		:deep(.el-form-item) {
			//label
			.el-form-item__label {
			}
			// 内容盒子
			.el-form-item__content {
				// 输入框
				.list_inp {

				}
				//日期选择器
				.list_date {
				}
				// 长文本
				.el-textarea__inner {
				}
				//图片上传样式
				.el-upload-list  {
					//提示语
					.el-upload__tip {
					}
					//外部盒子
					.el-upload--picture-card {
						//图标
						.el-icon{
						}
					}
					.el-upload-list__item {
					}
				}
			}
		}
	}
	// 按钮盒子
	.formModel_btn_box {
		.formModel_cancel {
		}
		.formModel_cancel:hover {
		}
		
		.formModel_confirm {
		}
		.formModel_confirm:hover {
		}
	}
</style>
<style>
.edit_view {
    margin: 20px auto;
    width: 1200px;
    position: relative;
    background: rgb(255, 255, 255);
    font-size:16px;
    color:#666;
}
.edit_view .add_form{
    width: 100%;
    padding: 30px;
    border:1px solid #eee;
}
.edit_view .add_form .el-form-item{
    margin: 0px 0px 20px;
    display: flex;
}
.edit_view .add_form .el-form-item .el-form-item__label{
    width: 150px;
    background: none;
    text-align: right;
    display: block;
    font-size: 16px;
    color: rgb(51, 51, 51);
    font-weight: 500;
}
.edit_view .add_form .el-form-item .el-form-item__content{
    display: flex;
    justify-content: flex-start;
    align-items: center;
    flex-wrap: wrap;
    width: calc(100% - 120px);
}
.edit_view .add_form .el-form-item .el-form-item__content .list_inp{
    height: 36px;
    line-height: 36px;
    border: 1px solid rgba(226, 227, 229, 1);
    padding: 0px 10px;
    width: 100%;
    box-sizing: border-box;
    background: rgb(255, 255, 255);
    font-size: 16px;
}


.edit_view .add_form .el-form-item .el-form-item__content .list_date{
    line-height: 36px;
    border: 1px solid rgba(226, 227, 229, 1);
    box-sizing: border-box;
    width: 100%;
    border-radius: 0px;
    background: rgb(255, 255, 255);
    font-size: 16px;
}




.edit_view .add_form .el-form-item .el-form-item__content .el-textarea{border: 1px solid rgba(226, 227, 229, 1);}
.edit_view .add_form .el-form-item .el-form-item__content .el-textarea .el-textarea__inner{
    width: 100%;
    min-height: 150px;
    padding: 12px;
    border: 1px solid rgba(255, 255, 255, 1);
    border-radius: 0px;
    color: #666;
    font-size: 16px;
}


.edit_view .add_form .el-form-item .el-form-item__content .el-upload--picture-card{
    background-color: rgb(255, 255, 255);
    width: 100px;
    height: 90px;
    line-height: 100px;
    text-align: center;
    
    border-radius: 0px;
    cursor: pointer;
}

.edit_view .add_form .el-form-item .el-form-item__content .el-upload--picture-card .el-icon{
    font-size: 32px;
    color: #999;
}

.edit_view .add_form .el-form-item .el-form-item__content .img-uploader .el-upload__tip{
    font-size: 15px;
    color: #666;
    margin: 0;
}



</style>