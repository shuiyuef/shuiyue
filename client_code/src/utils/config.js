const config = {
    get() {
        return {
            url : process.env.VUE_APP_BASE_API_URL + process.env.VUE_APP_BASE_API + '/',
            name: process.env.VUE_APP_BASE_API,
			menuList:[
				{
					name: '菜品信息管理',
					icon: 'icon-common3',
					child:[

						{
							name:'菜品信息',
                            url:'/index/caipinxinxiList'

						},
					]
				},
				{
					name: '新闻资讯管理',
					icon: 'icon-common15',
					child:[

						{
							name:'健康资讯',
                            url:'/index/newsList'

						},
					]
				},
			]
        }
    },
    getProjectName(){
        return {
            projectName: `社区养老助餐服务管理系统`
        } 
    }
}
export default config
