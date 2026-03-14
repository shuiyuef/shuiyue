<template>
    <div class="list-page">
        <div class="breadcrumb-wrapper">
            <div class="bread_view">
                <el-breadcrumb separator="/" class="breadcrumb">
                    <el-breadcrumb-item class="first_breadcrumb" :to="{ path: '/' }">首页</el-breadcrumb-item>
                    <el-breadcrumb-item class="second_breadcrumb" v-for="(item,index) in breadList" :key="index">{{item.name}}</el-breadcrumb-item>
                </el-breadcrumb>
            </div>
            <div class="back_view" v-if="centerType">
                <el-button class="back_btn" @click="backClick" icon="el-icon-back" round>返回个人中心</el-button>
            </div>
        </div>

        <el-card shadow="hover" class="list_search_card">
            <el-form :inline="true" :model="searchQuery" class="list_search">
                <div class="search_view">
                    <div class="search_label">
                        <i class="el-icon-user"></i> 老人姓名：
                    </div>
                    <div class="search_box">
                        <el-input class="search_inp" v-model="searchQuery.laorenxingming" placeholder="请输入老人姓名进行检索..."
                            clearable prefix-icon="el-icon-search">
                        </el-input>
                    </div>
                </div>
                <div class="search_btn_view">
                    <el-button class="search_btn" type="primary" @click="searchClick" round icon="el-icon-search">智能搜索</el-button>
                    <el-button class="add_btn" type="success" v-if="btnAuth('jiankangjiance','新增')" @click="addClick" round icon="el-icon-plus">新增打卡</el-button>
                </div>
            </el-form>
        </el-card>

        <el-card shadow="hover" class="page_list_card">
            <div class="data_box">
                <div class="table_view">
                    <el-table v-loading="listLoading" class="data_table" :data="list" :border="false" :row-style="{'cursor':'pointer'}"
                        @row-click="tableDetailClick" stripe highlight-current-row>
                        <el-table-column :resizable='true' align="center" header-align="center" type="selection" width="55" />
                        <el-table-column label="序号" width="70" :resizable='true' align="center" header-align="center">
                            <template #default="scope">
                                <span class="index_badge">{{ (listQuery.page-1)*listQuery.limit+scope.$index + 1}}</span>
                            </template>
                        </el-table-column>
                        
                        <el-table-column label="老人姓名" :resizable='true' align="center" header-align="center" min-width="100">
                            <template #default="scope">
                                <strong>{{scope.row.laorenxingming}}</strong>
                            </template>
                        </el-table-column>
                        <el-table-column label="头像" :resizable='true' align="center" header-align="center" width="100">
                            <template #default="scope">
                                <div v-if="scope.row.touxiang">
                                    <el-avatar v-if="scope.row.touxiang.substring(0,4)=='http'" :size="50"
                                        :src="scope.row.touxiang.split(',')[0]" @click.stop="preViewClick(scope.row.touxiang.split(',')[0])"></el-avatar>
                                    <el-avatar v-else :size="50"
                                        :src="$config.url+scope.row.touxiang.split(',')[0]" @click.stop="preViewClick($config.url+scope.row.touxiang.split(',')[0])"></el-avatar>
                                </div>
                                <div v-else><el-avatar icon="el-icon-user-solid" :size="50"></el-avatar></div>
                            </template>
                        </el-table-column>
                        <el-table-column label="血压 (mmHg)" :resizable='true' align="center" header-align="center" min-width="120">
                            <template #default="scope">
                                <el-tag :type="parseInt(scope.row.xueya) > 140 ? 'danger' : 'success'" effect="light" round>
                                    {{scope.row.xueya}} <i v-if="parseInt(scope.row.xueya) > 140" class="el-icon-top"></i>
                                </el-tag>
                            </template>
                        </el-table-column>
                        <el-table-column label="血糖 (mmol/L)" :resizable='true' align="center" header-align="center" min-width="120">
                            <template #default="scope">
                                <el-tag :type="parseFloat(scope.row.xuetang) > 6.1 ? 'warning' : 'success'" effect="light" round>
                                    {{scope.row.xuetang}} <i v-if="parseFloat(scope.row.xuetang) > 6.1" class="el-icon-top"></i>
                                </el-tag>
                            </template>
                        </el-table-column>
                        <el-table-column label="心率" :resizable='true' align="center" header-align="center">
                            <template #default="scope">
                                {{scope.row.xinlv}}
                            </template>
                        </el-table-column>
                        <el-table-column label="基础疾病" :resizable='true' align="center" header-align="center" min-width="150" show-overflow-tooltip>
                            <template #default="scope">
                                {{scope.row.jichujibing || '无'}}
                            </template>
                        </el-table-column>
                        <el-table-column label="饮食限制" :resizable='true' align="center" header-align="center" min-width="150" show-overflow-tooltip>
                            <template #default="scope">
                                <el-tag v-if="scope.row.yinshixianzhi" type="danger" effect="plain" size="small">{{scope.row.yinshixianzhi}}</el-tag>
                                <span v-else style="color:#999;">无特殊限制</span>
                            </template>
                        </el-table-column>
                        <el-table-column label="登记时间" :resizable='true' align="center" header-align="center" min-width="160">
                            <template #default="scope">
                                <span style="color:#666; font-size: 13px;">{{scope.row.dengjishijian}}</span>
                            </template>
                        </el-table-column>
                        
                        <el-table-column label="系统操作" width="280" :resizable='true' align="center" header-align="center" fixed="right">
                            <template #default="scope">
                                <div class="action-buttons" @click.stop>
                                    <el-button v-if="btnAuth('jiankangjiance','查看')" type="primary" link @click="detailClick(scope.row)">
                                        <i class="el-icon-view"></i> 详情
                                    </el-button>
                                    <el-button v-if="btnAuth('jiankangjiance','修改')" type="warning" link @click="editClick(scope.row.id)">
                                        <i class="el-icon-edit"></i> 修改
                                    </el-button>
                                    <el-button v-if="btnAuth('jiankangjiance','删除')" type="danger" link @click="delClick(scope.row.id)">
                                        <i class="el-icon-delete"></i> 删除
                                    </el-button>
                                    <el-button type="success" size="small" round @click="downloadReport(scope.row)" class="report-btn">
                                        <i class="el-icon-printer"></i> 报告评估
                                    </el-button>
                                </div>
                            </template>
                        </el-table-column>
                    </el-table>
                </div>
                
                <div class="pagination-wrapper">
                    <el-pagination
                        background 
                        :layout="layouts.join(',')"
                        :total="total" 
                        :page-size="listQuery.limit"
                        v-model:current-page="listQuery.page"
                        prev-text="上一页"
                        next-text="下一页"
                        :hide-on-single-page="false"
                        @size-change="sizeChange"
                        @current-change="currentChange"/>
                </div>
            </div>
        </el-card>

        <el-dialog v-model="preViewVisible" title="查看头像大图" width="40%" destroy-on-close center>
            <div style="text-align:center; padding: 20px;">
                <img :src="preViewUrl" style="max-width: 100%; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1);" alt="">
            </div>
        </el-dialog>
    </div>
</template>

<script setup>
    import { ref, getCurrentInstance, nextTick, computed, inject } from 'vue';
    import { useRoute, useRouter } from 'vue-router';
    import { useStore } from 'vuex';
    
    const store = useStore()
    const user = computed(()=>store.getters['user/session'])
    const context = getCurrentInstance()?.appContext.config.globalProperties;
    const router = useRouter()
    const route = useRoute()
    
    const tableName = 'jiankangjiance'
    const formName = '健康监测'
    const breadList = ref([{ name: formName }])
    const list = ref([])
    const listQuery = ref({ page: 1, limit: 10 }) // 建议每页10条看起来更宽敞
    const total = ref(0)
    const listLoading = ref(false)
    const searchQuery = ref({})
    const centerType = ref(false)
    const layouts = ref(["total","prev","pager","next","sizes","jumper"])
    
    //权限验证
    const btnAuth = (e,a)=>{
        if(centerType.value){
            return context?.$toolUtil.isBackAuth(e,a)
        }else{
            return context?.$toolUtil.isAuth(e,a)
        }
    }
    
    const addClick = () => {
        router.push('/index/jiankangjianceAdd')
    }
    
    const backClick = () => {
        router.push(`/index/${context?.$toolUtil.storageGet('frontSessionTable')}Center`)
    }
    
    const searchClick = () => {
        listQuery.value.page = 1
        getList()
    }
    
    const sizeChange = (size) => {
        listQuery.value.limit = size
        getList()
    }
    const currentChange = (page) => {
        listQuery.value.page = page
        getList()
    }

    // ================= 彻底修复的获取列表方法 (数据隔离) =================
    const getList = () => {
        listLoading.value = true
        let params = JSON.parse(JSON.stringify(listQuery.value))
        if(searchQuery.value.laorenxingming && searchQuery.value.laorenxingming != ''){
            params.laorenxingming = '%' + searchQuery.value.laorenxingming + '%'
        }
        
        context?.$http({
            url: `${tableName}/page`, // 绝对安全：强制走 page 接口验证 Token
            method: 'get',
            params: params
        }).then(res => {
            listLoading.value = false
            list.value = res.data.data.list
            total.value = Number(res.data.data.total)
        }).catch(err => {
            listLoading.value = false
            console.error("数据加载失败", err);
        })
    }
    // =====================================================================

    const tableDetailClick = (row) => {
        router.push(`${tableName}Detail?id=` + row.id + (centerType.value?'&&centerType=1':''))
    }
    const editClick = (id) => {
        router.push('jiankangjianceAdd?id=' + id + (centerType.value?'&centerType=1':''))
    }
    const delClick = (id) => {
        context?.$confirm('此操作将永久删除您的这条健康记录, 是否继续?', '系统安全提示', {
            confirmButtonText: '确认删除',
            cancelButtonText: '暂不删除',
            type: 'warning'
        }).then(()=>{
            context?.$http({
                url: `jiankangjiance/delete`,
                method: 'post',
                data: [id]
            }).then(res=>{
                context?.$message.success('记录已成功删除')
                getList()
            })
        })
    }

    // 查看大图
    const preViewUrl = ref('')
    const preViewVisible = ref(false)
    const preViewClick = (url) =>{
        preViewUrl.value = url
        preViewVisible.value = true
    }

    // ================= 核心亮点：生成健康报告与建议食谱 =================
    const downloadReport = async (row) => {
        let recommendHtml = '';
        try {
            const res = await context?.$http({
                url: `caipinxinxi/smartRecommend?laorenzhanghao=${row.laorenzhanghao}`,
                method: 'get'
            });
            if (res.data && res.data.code === 0 && res.data.data.length > 0) {
                let list = res.data.data;
                recommendHtml = `
                    <h3 style="color: #67C23A; border-bottom: 2px solid #67C23A; padding-bottom: 8px; margin-top: 35px; font-size: 20px;">🍽️ 专属系统膳食推荐方案</h3>
                    <div style="background: #f0f9eb; padding: 20px; border-radius: 10px; border: 1px solid #e1f3d8;">
                        <p style="color: #67C23A; margin-top: 0; font-weight: bold; font-size: 16px;">基于您的血压、血糖监测指标，营养系统为您精准匹配了以下膳食：</p>
                        <ul style="line-height: 2; font-size: 15px; color: #444; padding-left: 20px;">
                            ${list.map(item => `<li style="margin-bottom: 8px;"><strong>${item.caipinmingcheng}</strong> <span style="color:#888; font-size:13px;">[特色口味：${item.kouwei || '适中'}]</span><br/> <span style="color:#666;">✨ 营养摄入：${item.yingyangchengfen || '提供人体日常所需均衡营养素，易于消化。'}</span></li>`).join('')}
                        </ul>
                    </div>
                `;
            }
        } catch(e) { 
            console.log("获取建议食谱失败", e);
        }

        let printHtml = `
            <div style="font-family: 'Microsoft YaHei', 'PingFang SC', sans-serif; padding: 40px; color: #333; line-height: 1.8; max-width: 800px; margin: 0 auto; background: #fff;">
                <div style="text-align: center; margin-bottom: 30px;">
                    <h1 style="color: #2c3e50; letter-spacing: 3px; margin-bottom: 5px;">社区老年人健康评估报告</h1>
                    <span style="display: inline-block; width: 60px; height: 4px; background: #4A90E2; border-radius: 2px;"></span>
                </div>
                <div style="text-align: right; margin-bottom: 20px; color: #888; font-size: 14px;">档案生成时间：${new Date().toLocaleString()}</div>
                
                <table style="width: 100%; border-collapse: collapse; text-align: left; box-shadow: 0 0 10px rgba(0,0,0,0.05);" border="1" bordercolor="#e4e7ed">
                    <tr>
                        <th style="padding: 15px; background: #fafafa; width: 20%; color:#606266;">顾客姓名</th>
                        <td style="padding: 15px; width: 30%; font-weight: bold;">${row.laorenxingming || '-'}</td>
                        <th style="padding: 15px; background: #fafafa; width: 20%; color:#606266;">系统账号</th>
                        <td style="padding: 15px; width: 30%; color: #666;">${row.laorenzhanghao || '-'}</td>
                    </tr>
                    <tr>
                        <th style="padding: 15px; background: #fafafa; color:#606266;">血压指标 (mmHg)</th>
                        <td style="padding: 15px; color: ${parseInt(row.xueya)>140 ? '#F56C6C' : '#333'}; font-weight: ${parseInt(row.xueya)>140 ? 'bold' : 'normal'};">
                            ${row.xueya || '-'} ${parseInt(row.xueya)>140 ? ' <span style="font-size:12px;color:#F56C6C;">(↑偏高)</span>' : ''}
                        </td>
                        <th style="padding: 15px; background: #fafafa; color:#606266;">空腹血糖 (mmol/L)</th>
                        <td style="padding: 15px; color: ${parseFloat(row.xuetang)>6.1 ? '#E6A23C' : '#333'}; font-weight: ${parseFloat(row.xuetang)>6.1 ? 'bold' : 'normal'};">
                            ${row.xuetang || '-'} ${parseFloat(row.xuetang)>6.1 ? ' <span style="font-size:12px;color:#E6A23C;">(↑偏高)</span>' : ''}
                        </td>
                    </tr>
                    <tr>
                        <th style="padding: 15px; background: #fafafa; color:#606266;">心率特征 (次/分)</th>
                        <td style="padding: 15px;">${row.xinlv || '-'}</td>
                        <th style="padding: 15px; background: #fafafa; color:#606266;">记录时间</th>
                        <td style="padding: 15px; color:#666;">${row.dengjishijian || '-'}</td>
                    </tr>
                    <tr>
                        <th style="padding: 15px; background: #fafafa; color:#606266;">既往基础疾病</th>
                        <td style="padding: 15px;" colspan="3">${row.jichujibing || '经询问无特殊基础疾病。'}</td>
                    </tr>
                </table>

                <h3 style="color: #4A90E2; border-bottom: 2px solid #4A90E2; padding-bottom: 8px; margin-top: 35px; font-size: 20px;">📝 医疗系统综合建议</h3>
                <div style="background: #f4f9ff; padding: 20px; border-radius: 10px; border: 1px solid #d9ecff; font-size: 15px; color: #444;">
                    <p style="margin-top:0;"><strong>【体检状况摘要】</strong><br/>${row.jiankangbaogao || '整体指标相对平稳，暂无明显危急异常。请继续保持日常规律作息与定期监测。'}</p>
                    <p style="margin-bottom:0;"><strong>【日常起居建议】</strong><br/>${row.jiankangjianyi || '建议维持低盐、低脂、低糖饮食，配合适量温和的散步运动。保持心情愉悦，保证充足睡眠。'}</p>
                </div>

                ${recommendHtml}

                <div style="margin-top: 60px; text-align: right; border-top: 1px dashed #e4e7ed; padding-top: 20px;">
                    <p style="margin: 0; font-weight: bold; font-size: 16px; color: #333;">签发平台：智慧社区养老助餐与健康管理系统</p>
                    <p style="margin: 8px 0 0 0; color: #999; font-size: 13px;">* 本报告由系统自动生成，旨在提供膳食及康养参考，具体医疗诊断请遵医嘱。</p>
                </div>
            </div>
        `;

        let printWindow = window.open('', '_blank', 'width=900,height=800');
        printWindow.document.write('<html><head><title>个人健康评估报告</title></head><body style="background:#f0f2f5;">');
        printWindow.document.write(printHtml);
        printWindow.document.write('</body></html>');
        printWindow.document.close();
        
        setTimeout(() => {
            printWindow.print();
        }, 400);
    }
    // =================================================================

    const init = async() => {
        if(route.query.centerType){
            centerType.value = true
        }
        if(context.$toolUtil.storageGet('frontToken') && !user.value.id){
            await store.dispatch("user/getSession")
        }
        getList()
    }
    init()
</script>

<style lang="scss" scoped>
/* 全局变量覆盖，统一柔和的适老化主色调 */
:global(:root) {
  --el-color-primary: #4A90E2;
  --el-color-success: #67C23A;
  --el-border-radius-base: 8px;
}

.list-page {
    margin: 0 auto;
    padding: 20px 0;
    width: 1200px;
    font-family: 'Microsoft YaHei', sans-serif;
}

/* 面包屑卡片样式 */
.breadcrumb-wrapper {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #fff;
    padding: 15px 20px;
    border-radius: 12px;
    box-shadow: 0 2px 12px rgba(0,0,0,0.03);
    margin-bottom: 20px;
}
.bread_view {
    :deep(.el-breadcrumb__inner) {
        font-weight: bold !important;
        color: #606266;
    }
}

/* 现代化搜索区域：卡片化 */
.list_search_card {
    border-radius: 12px;
    border: none;
    margin-bottom: 20px;
    :deep(.el-card__body) {
        padding: 20px 25px 5px;
    }
}
.list_search {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    .search_view {
        margin-right: 25px;
        margin-bottom: 15px;
        display: flex;
        align-items: center;
        .search_label {
            color: #606266;
            font-weight: 600;
            margin-right: 12px;
            font-size: 15px;
        }
        /* 圆润输入框 */
        :deep(.el-input__inner) {
            border-radius: 20px !important;
            background-color: #f5f7fa !important;
            border: 1px solid #e4e7ed !important;
            transition: all 0.3s;
        }
        :deep(.el-input__inner):focus {
            background-color: #fff !important;
            border-color: #4A90E2 !important;
            box-shadow: 0 0 0 2px rgba(74, 144, 226, 0.2) !important;
        }
    }
    .search_btn_view {
        margin-bottom: 15px;
        .el-button {
            padding: 10px 24px;
            font-weight: bold;
            letter-spacing: 1px;
            transition: all 0.3s;
        }
        .el-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
    }
}

/* 现代化表格区域：去线化、轻质感 */
.page_list_card {
    border-radius: 12px;
    border: none;
    :deep(.el-card__body) {
        padding: 25px;
    }
}
.data_table {
    border-radius: 8px;
    overflow: hidden;
    /* 去掉边框带来的沉重感 */
    --el-table-border-color: #ebeef5;
    
    :deep(th.el-table__cell) {
        background-color: #f8f9fa !important;
        color: #303133;
        font-weight: bold;
        padding: 15px 0;
        font-size: 15px;
        border-bottom: 2px solid #ebeef5 !important;
    }
    :deep(td.el-table__cell) {
        padding: 16px 0;
        color: #606266;
        border-bottom: 1px solid #f0f2f5;
    }
    :deep(.el-table__row:hover > td.el-table__cell) {
        background-color: #f4f9ff !important;
    }
}

/* 序号徽标 */
.index_badge {
    display: inline-block;
    width: 26px;
    height: 26px;
    line-height: 26px;
    background: #ecf5ff;
    color: #4A90E2;
    border-radius: 50%;
    font-weight: bold;
    font-size: 13px;
}

/* 操作按钮悬浮对齐 */
.action-buttons {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-wrap: nowrap;
    :deep(.el-button--link) {
        padding: 0 8px;
        font-weight: bold;
    }
    .report-btn {
        margin-left: 10px;
        font-weight: bold;
        box-shadow: 0 2px 6px rgba(103, 194, 58, 0.2);
    }
}

/* 优雅的分页组件 */
.pagination-wrapper {
    margin-top: 30px;
    display: flex;
    justify-content: flex-end;
    :deep(.el-pagination.is-background .el-pager li:not(.disabled).is-active) {
        background-color: #4A90E2;
        color: #fff;
        border-radius: 6px;
    }
    :deep(.el-pagination.is-background .el-pager li) {
        border-radius: 6px;
        background-color: #f4f4f5;
    }
}
</style>