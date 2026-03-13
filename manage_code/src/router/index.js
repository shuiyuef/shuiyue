	import {
		createRouter,
		createWebHashHistory
	} from 'vue-router'
	import news from '@/views/news/list'
	import aboutus from '@/views/aboutus/list'
	import address from '@/views/address/list'
	import chushi from '@/views/chushi/list'
	import jiankangjiance from '@/views/jiankangjiance/list'
    import menu_manage from '@/views/menu_manage/list'
	import storeup from '@/views/storeup/list'
	import caipinxinxi from '@/views/caipinxinxi/list'
	import users from '@/views/users/list'
	import systemintro from '@/views/systemintro/list'
	import fankuiyujianyi from '@/views/fankuiyujianyi/list'
	import laoren from '@/views/laoren/list'
	import orders from '@/views/orders/list'
	import discusscaipinxinxi from '@/views/discusscaipinxinxi/list'
	import config from '@/views/config/list'
	import usersCenter from '@/views/users/center'
	import chushiRegister from '@/views/chushi/register'
	import chushiCenter from '@/views/chushi/center'

export const routes = [{
		path: '/login',
		name: 'login',
		component: () => import('../views/login.vue')
	},{
		path: '/',
		name: '首页',
		component: () => import('../views/index'),
		children: [{
			path: '/',
			name: '首页',
			component: () => import('../views/HomeView.vue'),
			meta: {
				affix: true
			}
		}, {
			path: '/updatepassword',
			name: '修改密码',
			component: () => import('../views/updatepassword.vue')
		}
		
		,{
			path: '/usersCenter',
			name: '管理员个人中心',
			component: usersCenter
		}
		,{
			path: '/chushiCenter',
			name: '厨师个人中心',
			component: chushiCenter
		}
		,{
			path: '/news',
			name: '健康资讯',
			component: news
		}
		,{
			path: '/aboutus',
			name: '发展历程',
			component: aboutus
		}
		,{
			path: '/address',
			name: '地址',
			component: address
		}
		,{
			path: '/chushi',
			name: '厨师',
			component: chushi
		}
		,{
			path: '/jiankangjiance',
			name: '健康监测',
			component: jiankangjiance
		}
        ,{
            path: '/menu',
            name: '菜单权限管理',
            component: menu_manage
        }
		,{
			path: '/storeup',
			name: '我的收藏',
			component: storeup
		}
		,{
			path: '/caipinxinxi',
			name: '菜品信息',
			component: caipinxinxi
		}
		,{
			path: '/users',
			name: '管理员',
			component: users
		}
		,{
			path: '/systemintro',
			name: '网站介绍',
			component: systemintro
		}
		,{
			path: '/fankuiyujianyi',
			name: '反馈与建议',
			component: fankuiyujianyi
		}
		,{
			path: '/laoren',
			name: '老人',
			component: laoren
		}
		,{
			path: '/orders',
			name: '订单管理',
			component: orders
		}
		,{
			path: '/discusscaipinxinxi',
			name: '菜品信息评论-评论',
			component: discusscaipinxinxi
		}
		,{
			path: '/config',
			name: '轮播图',
			component: config
		}
		]
	},
	{
		path: '/chushiRegister',
		name: '厨师注册',
		component: chushiRegister
	},
]

const router = createRouter({
	history: createWebHashHistory(process.env.BASE_URL),
	routes
})

export default router
