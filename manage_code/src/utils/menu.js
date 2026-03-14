import toolUtil from '@/utils/toolUtil'
const menu = {
    list() {
        if(toolUtil.storageGet("menus")) {
            // 1. 先把系统原本的菜单解析出来
            let menuData = eval('(' + toolUtil.storageGet("menus")+ ')');
            
            // 2. 毕设特供绝招：强行注入我们的“社区公告”菜单
            try {
                // 遍历所有角色，找到“管理员”
                for (let i = 0; i < menuData.length; i++) {
                    if (menuData[i].roleName === '管理员') {
                        // 在管理员的菜单末尾，加上我们的公告模块
                        menuData[i].backMenu.push({
                            menu: "公告管理中心",
                            fontClass: "iconfont icon-xitong",
                            child: [
                                {
                                    menu: "社区公告",
                                    tableName: "gonggao",
                                    menuJump: "列表",
                                    buttons: ["新增", "查看", "修改", "删除"]
                                }
                            ]
                        });
                        break; // 塞完就跑，真刺激
                    }
                }
            } catch (e) {
                console.error("强行注入菜单失败", e);
            }

            // 3. 把加了料的菜单返回给系统
            return menuData;
        } else {
            return null;
        }
    }
}
export default menu;