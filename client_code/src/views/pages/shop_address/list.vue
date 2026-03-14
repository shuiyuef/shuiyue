<template>
	<div class="list-page modern-address-page">
        <el-card shadow="hover" class="breadcrumb-card">
            <div class="breadcrumb-wrapper">
                <el-breadcrumb separator="/" class="breadcrumb">
                    <el-breadcrumb-item :to="{ path: `/index/${sessionTable}Center` }">个人中心</el-breadcrumb-item>
                    <el-breadcrumb-item>{{formName}}管理</el-breadcrumb-item>
                </el-breadcrumb>
                <div class="back_view" v-if="centerType">
                    <el-button class="back_btn" @click="backClick" icon="el-icon-back" round size="small">返回中心</el-button>
                </div>
            </div>
        </el-card>

        <div class="action-bar">
			<el-button type="primary" class="add_btn" @click="addClick" icon="el-icon-plus" round>
                新增{{formName}}
            </el-button>
            <span class="tip-text">您可以设置一个默认收货地址，结算时将自动为您选中</span>
		</div>

        <div class="address-grid" v-loading="listLoading">
            <el-row :gutter="24" v-if="list && list.length > 0">
                <el-col :xs="24" :sm="12" :md="12" :lg="8" v-for="(item, index) in list" :key="index" style="margin-bottom: 24px;">
                    <el-card class="address-card" :class="{'is-default': item.isdefault=='是'}" shadow="hover">
                        <div class="card-status">
                            <el-tag v-if="item.isdefault=='是'" size="small" effect="dark" type="success">
                                <i class="el-icon-check"></i> 默认地址
                            </el-tag>
                            <span v-else class="status-placeholder"></span>
                        </div>
                        
                        <div class="card-content" @click="listChange(item)">
                            <div class="user-info">
                                <span class="user-name">{{item.name}}</span>
                                <span class="user-phone">{{item.phone}}</span>
                            </div>
                            <div class="detail-address">
                                <i class="el-icon-location-outline" style="font-size: 16px; margin-right: 4px; color: #4A90E2;"></i> 
                                {{item.address}}
                            </div>
                        </div>

                        <div class="card-footer">
                            <div class="default-switch" @click.stop>
                                <span class="switch-label">设为默认：</span>
                                <el-switch 
                                    v-model="item.isdefault" 
                                    @change="(e)=>isdefaultChange(e,item)" 
                                    active-value="是" 
                                    inactive-value="否"
                                    active-color="#67C23A"
                                    size="default" />
                            </div>
                            <div class="btn-group" @click.stop>
                                <el-button type="primary" link icon="el-icon-edit" @click="editClick(item.id)">修改</el-button>
                                <el-button type="danger" link icon="el-icon-delete" @click="delClick(item.id)">删除</el-button>
                            </div>
                        </div>
                    </el-card>
                </el-col>
            </el-row>
			<el-empty v-else description="您还没有添加地址信息哦，快去添加吧" :image-size="120"></el-empty>
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

        <formModel ref="formModelRef" @formModelChange="formModelChange"></formModel>
	</div>
</template>

<script setup>
    import formModel from './formModel'
    import { ref, nextTick, getCurrentInstance } from 'vue';
    import { ElMessageBox } from 'element-plus'
    import { useRoute, useRouter } from 'vue-router'

    const context = getCurrentInstance()?.appContext.config.globalProperties;
    const router = useRouter()
    const route = useRoute()

    // 基础信息
    const tableName = 'address'
    const formName = '收货地址'
    const sessionTable = context?.$toolUtil.storageGet('frontSessionTable')

    const btnAuth = (e, a) => {
        return context?.$toolUtil.isAuth(e, a)
    }

    const list = ref([])
    const listLoading = ref(false)
    const listQuery = ref({
        page: 1,
        limit: 12, // 卡片布局建议改成 12 (3的倍数)，比原先的 20 更好看
        userid: context?.$toolUtil.storageGet('userid')
    })
    const selRows = ref([])
    const searchQuery = ref({})
    const table = ref(null)

    const searchClick = () => {
        listQuery.value.page = 1
        getList()
    }

    const getList = () => {
        listLoading.value = true
        let params = JSON.parse(JSON.stringify(listQuery.value))
        context?.$http({
            url: `address/list`,
            method: 'get',
            params: params
        }).then(res => {
            listLoading.value = false
            list.value = res.data.data.list
            total.value = res.data.data.total
        })
    }

    // 定义弹窗
    const formModelRef = ref(null)
    const formModelChange = () =>{
        listQuery.value.page = 1
        getList()
    }

    // 分页
    const layouts = ref(["total", "prev", "pager", "next"])
    const total = ref(0)
    const sizeChange = (size) => {
        listQuery.value.limit = size
        getList()
    }
    const currentChange = (page) => {
        listQuery.value.page = page
        getList()
    }

    // 新增
    const addClick = () => {
        formModelRef.value.init(null,'新增' + formName)
    }
    
    // 修改
    const editClick = (id = null) => {
        if (id) {
            formModelRef.value.init(id,'修改' + formName)
        }
    }

    // 删除
    const delClick = (id = null) => {
        if (id) {
            ElMessageBox.confirm(`确定要永久删除这个${formName}吗？`, '安全提示', {
                confirmButtonText: '确定删除',
                cancelButtonText: '暂不删除',
                type: 'warning',
            }).then(() => {
                context?.$http({
                    url: `address/delete`,
                    method: 'post',
                    data: [id]
                }).then(res => {
                    context?.$toolUtil.message('删除成功', 'success', () => {
                        getList()
                    })
                })
            }).catch(_ => {})
        }
    }

    // 切换默认地址
    const isdefaultChange = (e, row) =>{
        context?.$http({
            url: `address/update`,
            method: 'post',
            data: row
        }).then(res => {
            context?.$message.success(row.isdefault === '是' ? '已成功设为默认地址' : '已取消默认地址');
            getList()
        })
    }

    // 多选
    const handleSelectionChange = (e) => {
        selRows.value = e
    }

    const centerType = ref(false)
    const backClick = () => {
        router.push(`/index/${context?.$toolUtil.storageGet('frontSessionTable')}Center`)
    }
    
    const listChange = () => {
        // 如果需要点击卡片某处触发事件可写在此处
    }

    const init = () => {
        if (route.query.centerType) {
            centerType.value = true
        }
        getList()
    }
    init()
</script>

<style lang="scss" scoped>
.modern-address-page {
    width: 1200px;
    margin: 0 auto;
    padding: 30px 0 60px;
    font-family: "Microsoft YaHei", sans-serif;
}

/* 顶部面包屑卡片 */
.breadcrumb-card {
    border-radius: 12px;
    border: none;
    margin-bottom: 25px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.03);
    :deep(.el-card__body) { padding: 18px 25px; }
}
.breadcrumb-wrapper {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

/* 操作栏 */
.action-bar {
    display: flex;
    align-items: center;
    margin-bottom: 25px;
    .add_btn {
        padding: 12px 30px;
        font-weight: bold;
        font-size: 15px;
        box-shadow: 0 4px 12px rgba(74, 144, 226, 0.3);
        transition: all 0.3s;
    }
    .add_btn:hover { transform: translateY(-2px); }
    .tip-text {
        margin-left: 20px;
        color: #909399;
        font-size: 14px;
    }
}

/* 地址卡片网格 */
.address-card {
    border-radius: 16px;
    border: 2px solid transparent;
    transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
    position: relative;
    height: 210px;
    display: flex;
    flex-direction: column;
    background: #ffffff;
    box-shadow: 0 6px 16px rgba(0,0,0,0.04) !important;
    
    :deep(.el-card__body) {
        padding: 20px 25px;
        height: 100%;
        display: flex;
        flex-direction: column;
        box-sizing: border-box;
    }
}
.address-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 16px 30px rgba(0,0,0,0.08) !important;
    border-color: #d9ecff;
}
.address-card.is-default {
    border-color: #67C23A;
    background: #fdfefd;
    box-shadow: 0 8px 20px rgba(103, 194, 58, 0.1) !important;
}

.card-status {
    height: 28px;
    margin-bottom: 5px;
    .el-tag {
        font-weight: bold;
        letter-spacing: 1px;
    }
}

.card-content {
    flex: 1;
    .user-info {
        margin-bottom: 15px;
        display: flex;
        align-items: flex-end;
        .user-name {
            font-size: 22px;
            font-weight: bold;
            color: #303133;
            margin-right: 15px;
            letter-spacing: 1px;
        }
        .user-phone {
            font-size: 16px;
            color: #606266;
            font-weight: 500;
        }
    }
    .detail-address {
        font-size: 15px;
        color: #606266;
        line-height: 1.6;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }
}

.card-footer {
    border-top: 1px dashed #ebeef5;
    padding-top: 15px;
    margin-top: auto;
    display: flex;
    justify-content: space-between;
    align-items: center;
    
    .default-switch {
        display: flex;
        align-items: center;
        .switch-label { font-size: 14px; color: #909399; margin-right: 5px; }
    }
    
    .btn-group {
        :deep(.el-button--link) {
            padding: 0 10px;
            font-size: 15px;
            font-weight: bold;
        }
    }
}

/* 分页 */
.pagination-wrapper {
    margin-top: 40px;
    display: flex;
    justify-content: center;
}
:deep(.el-pagination.is-background .el-pager li:not(.disabled).is-active) {
    background-color: #4A90E2;
}
</style>