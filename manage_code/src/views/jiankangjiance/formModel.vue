<template>
	<div>
		<el-dialog modal-class="edit_form_modal" class="edit_form" v-model="formVisible" :title="formTitle" width="80%" destroy-on-close :fullscreen='false'>
			<el-form class="formModel_form" ref="formRef" :model="form" :rules="rules">
				<el-row >
					<el-col :span="12">
						<el-form-item label="老人账号" prop="laorenzhanghao">
							<el-input class="list_inp" v-model="form.laorenzhanghao" placeholder="老人账号"
                                type="text"
								:readonly="!isAdd||disabledForm.laorenzhanghao?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="老人姓名" prop="laorenxingming">
							<el-input class="list_inp" v-model="form.laorenxingming" placeholder="老人姓名"
                                type="text"
								:readonly="!isAdd||disabledForm.laorenxingming?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item prop="touxiang"
									  label="头像"
						>
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
							<el-input class="list_inp" v-model="form.xueya" placeholder="血压"
                                type="text"
								:readonly="!isAdd||disabledForm.xueya?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="血糖" prop="xuetang">
							<el-input class="list_inp" v-model="form.xuetang" placeholder="血糖"
                                type="text"
								:readonly="!isAdd||disabledForm.xuetang?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="心率" prop="xinlv">
							<el-input class="list_inp" v-model="form.xinlv" placeholder="心率"
                                type="text"
								:readonly="!isAdd||disabledForm.xinlv?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="皮肤状况" prop="pifuzhuangkuang">
							<el-input class="list_inp" v-model="form.pifuzhuangkuang" placeholder="皮肤状况"
                                type="text"
								:readonly="!isAdd||disabledForm.pifuzhuangkuang?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="精神状态" prop="jingshenzhuangtai">
							<el-input class="list_inp" v-model="form.jingshenzhuangtai" placeholder="精神状态"
                                type="text"
								:readonly="!isAdd||disabledForm.jingshenzhuangtai?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="基础疾病" prop="jichujibing">
							<el-input class="list_inp" v-model="form.jichujibing" placeholder="基础疾病"
                                type="text"
								:readonly="!isAdd||disabledForm.jichujibing?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="饮食限制" prop="yinshixianzhi">
							<el-input class="list_inp" v-model="form.yinshixianzhi" placeholder="饮食限制"
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
								:readonly="!isAdd||disabledForm.dengjishijian?true:false"
								placeholder="请选择登记时间" />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="评估内容" prop="pingguneirong">
							<el-input v-model="form.pingguneirong" placeholder="评估内容" type="textarea"
							:readonly="!isAdd||disabledForm.pingguneirong?true:false"
							/>
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="健康报告" prop="jiankangbaogao">
							<el-input v-model="form.jiankangbaogao" placeholder="健康报告" type="textarea"
							:readonly="!isAdd||disabledForm.jiankangbaogao?true:false"
							/>
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="健康建议" prop="jiankangjianyi">
							<el-input v-model="form.jiankangjianyi" placeholder="健康建议" type="textarea"
							:readonly="!isAdd||disabledForm.jiankangjianyi?true:false"
							/>
						</el-form-item>
					</el-col>
				</el-row>
			</el-form>
			<template #footer v-if="isAdd||type=='logistics'||type=='reply'">
				<span class="formModel_btn_box">
					<el-button class="cancel_btn" @click="closeClick">取消</el-button>
					<el-button class="confirm_btn" type="primary" @click="save"
						>
						提交
					</el-button>
				</span>
			</template>
		</el-dialog>
	</div>
</template>
<script setup>
	import {
		reactive,
		ref,
		getCurrentInstance,
		nextTick,
		computed,
		defineEmits
	} from 'vue'
    import {
        useStore
    } from 'vuex';
    const store = useStore()
    const user = computed(()=>store.getters['user/session'])
	const context = getCurrentInstance()?.appContext.config.globalProperties;	
	const emit = defineEmits(['formModelChange'])
	//基础信息
	const tableName = 'jiankangjiance'
	const formName = '健康监测'
	//基础信息
	//form表单
	const form = ref({})
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
	const formVisible = ref(false)
	const isAdd = ref(false)
	const formTitle = ref('')
    
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
	//表单验证
	
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
	//头像上传回调
	const touxiangUploadSuccess=(e)=>{
		form.value.touxiang = e
	}

	//获取唯一标识
	const getUUID =()=> {
      return new Date().getTime();
    }
	//重置
	const resetForm = () => {
		form.value = {
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
		}
	}
	//获取info
	const getInfo = ()=>{
		context?.$http({
			url: `${tableName}/info/${id.value}`,
			method: 'get'
		}).then(res => {
			let reg=new RegExp('../../../file','g')
			form.value = res.data.data
			formVisible.value = true
		})
	}
	const crossRow = ref('')
	const crossTable = ref('')
	const crossTips = ref('')
	const crossColumnName = ref('')
	const crossColumnValue = ref('')
	//初始化
	const init=(formId=null,formType='add',formNames='',row=null,table=null,statusColumnName=null,tips=null,statusColumnValue=null)=>{
		resetForm()
			form.value.dengjishijian = context?.$toolUtil.getCurDateTime()
		if(formId){
			id.value = formId
			type.value = formType
		}
		if(formType == 'add'){
			isAdd.value = true
			formTitle.value = '新增' + formName
			formVisible.value = true
		}else if(formType == 'info'){
			isAdd.value = false
			formTitle.value = '查看' + formName
			getInfo()
		}else if(formType == 'edit'){
			isAdd.value = true
			formTitle.value = '修改' + formName
			getInfo()
		}
		else if(formType == 'cross'){
			isAdd.value = true
			formTitle.value = formNames
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
			formVisible.value = true
		}

		context?.$http({
			url: `${context?.$toolUtil.storageGet('sessionTable')}/session`,
			method: 'get'
		}).then(res => {
			var json = res.data.data
			if(json.hasOwnProperty('laorenzhanghao')&& context?.$toolUtil.storageGet("role")!="管理员"){
				form.value.laorenzhanghao = json.laorenzhanghao
				disabledForm.value.laorenzhanghao = true;
			}
			if(json.hasOwnProperty('laorenxingming')&& context?.$toolUtil.storageGet("role")!="管理员"){
				form.value.laorenxingming = json.laorenxingming
				disabledForm.value.laorenxingming = true;
			}
			if(json.hasOwnProperty('touxiang')&& context?.$toolUtil.storageGet("role")!="管理员"){
				form.value.touxiang = json.touxiang
				disabledForm.value.touxiang = true;
			}
		})
	}
	//初始化
	//声明父级调用
	defineExpose({
		init
	})
	//关闭
	const closeClick = () => {
		formVisible.value = false
	}
	//富文本
	const editorChange = (e,name) =>{
		form.value[name] = e
	}
	//提交
	const save= async ()=>{
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
					crossUserId = user.value.id
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
							}).then(async res=>{
								emit('formModelChange')
								context?.$toolUtil.message(`操作成功`,'success')
                                formVisible.value = false
							})
						}
					})
				}else{
					context?.$http({
						url: `${tableName}/${!form.value.id ? "save" : "update"}`,
						method: 'post', 
						data: form.value 
					}).then(async (res)=>{
						emit('formModelChange')
						context?.$toolUtil.message(`操作成功`,'success')
                        formVisible.value = false
					})
				}
			}else{
                context.$message.error('请完善信息')
            }
		})
	}
	//修改跨表数据
	const changeCrossData = async (row)=>{
        if(type.value == 'cross'){
            await context?.$http({
                url: `${crossTable.value}/update`,
                method: 'post',
                data: row
            }).then(res=>{})
        }
	}
</script>
<style lang="scss" scoped>
	// 表单
	.formModel_form{
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
		.cancel_btn {
		}
		.cancel_btn:hover {
		}
		
		.confirm_btn {
		}
		.confirm_btn:hover {
		}
	}
</style>
