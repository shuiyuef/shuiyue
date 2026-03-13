import { createRouter, createWebHashHistory } from 'vue-router'
import index from '../views'
import home from '../views/pages/home.vue'
import login from '../views/pages/login.vue'
import newsList from '@/views/pages/news/list'
import aboutusList from '@/views/pages/aboutus/list'
import aboutusDetail from '@/views/pages/aboutus/formModel'
import aboutusAdd from '@/views/pages/aboutus/formAdd'
import systemintroList from '@/views/pages/systemintro/list'
import systemintroDetail from '@/views/pages/systemintro/formModel'
import systemintroAdd from '@/views/pages/systemintro/formAdd'
import laorenList from '@/views/pages/laoren/list'
import laorenDetail from '@/views/pages/laoren/formModel'
import laorenAdd from '@/views/pages/laoren/formAdd'
import laorenRegister from '@/views/pages/laoren/register'
import laorenCenter from '@/views/pages/laoren/center'
import caipinxinxiList from '@/views/pages/caipinxinxi/list'
import caipinxinxiDetail from '@/views/pages/caipinxinxi/formModel'
import caipinxinxiAdd from '@/views/pages/caipinxinxi/formAdd'
import cartList from '@/views/pages/shop_order/cart'
import storeupList from '@/views/pages/storeup/list'
import chushiList from '@/views/pages/chushi/list'
import chushiDetail from '@/views/pages/chushi/formModel'
import chushiAdd from '@/views/pages/chushi/formAdd'
import addressList from '@/views/pages/shop_address/list'
import fankuiyujianyiList from '@/views/pages/fankuiyujianyi/list'
import fankuiyujianyiDetail from '@/views/pages/fankuiyujianyi/formModel'
import fankuiyujianyiAdd from '@/views/pages/fankuiyujianyi/formAdd'
import jiankangjianceList from '@/views/pages/jiankangjiance/list'
import jiankangjianceDetail from '@/views/pages/jiankangjiance/formModel'
import jiankangjianceAdd from '@/views/pages/jiankangjiance/formAdd'
import order_confirm from '@/views/pages/shop_order/confirm'
import ordersList from '@/views/pages/shop_order/list'

const routes = [{
		path: '/',
		redirect: '/index/home'
	},
	{
		path: '/index',
		component: index,
		children: [{
			path: 'home',
			component: home
		}
		, {
			path: 'newsList',
			component: newsList
		}
		, {
			path: 'aboutusList',
			component: aboutusList
		}, {
			path: 'aboutusDetail',
			component: aboutusDetail
		}, {
			path: 'aboutusAdd',
			component: aboutusAdd
		}
		, {
			path: 'systemintroList',
			component: systemintroList
		}, {
			path: 'systemintroDetail',
			component: systemintroDetail
		}, {
			path: 'systemintroAdd',
			component: systemintroAdd
		}
		, {
			path: 'laorenList',
			component: laorenList
		}, {
			path: 'laorenDetail',
			component: laorenDetail
		}, {
			path: 'laorenAdd',
			component: laorenAdd
		}
		, {
			path: 'laorenCenter',
			component: laorenCenter
		}
		, {
			path: 'caipinxinxiList',
			component: caipinxinxiList
		}, {
			path: 'caipinxinxiDetail',
			component: caipinxinxiDetail
		}, {
			path: 'caipinxinxiAdd',
			component: caipinxinxiAdd
		}
		, {
			path: 'cartList',
			component: cartList
		}
        , {
            path: 'storeupList',
            component: storeupList
        }
		, {
			path: 'chushiList',
			component: chushiList
		}, {
			path: 'chushiDetail',
			component: chushiDetail
		}, {
			path: 'chushiAdd',
			component: chushiAdd
		}
		, {
			path: 'addressList',
			component: addressList
		}
		, {
			path: 'fankuiyujianyiList',
			component: fankuiyujianyiList
		}, {
			path: 'fankuiyujianyiDetail',
			component: fankuiyujianyiDetail
		}, {
			path: 'fankuiyujianyiAdd',
			component: fankuiyujianyiAdd
		}
		, {
			path: 'jiankangjianceList',
			component: jiankangjianceList
		}, {
			path: 'jiankangjianceDetail',
			component: jiankangjianceDetail
		}, {
			path: 'jiankangjianceAdd',
			component: jiankangjianceAdd
		}
		, {
			path: 'order_confirm',
			component: order_confirm
		}
		, {
			path: 'ordersList',
			component: ordersList
		}
		]
	},
	{
		path: '/login',
		component: login
	}
	,{
		path: '/laorenRegister',
		component: laorenRegister
	}
]

const router = createRouter({
  history: createWebHashHistory(process.env.BASE_URL),
  routes
})

export default router
