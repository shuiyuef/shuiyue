# 水月项目 (Shuiyue Project) 🚀

本项目是一个全栈前后端分离系统，旨在提供高效的数据管理与展示功能。后端基于 **Java 17 & Spring Boot 3**，前端基于 **Vue 3 & TypeScript**。

## 🏗 项目架构说明

项目采用前后端完全解耦的架构，通过 RESTful API 进行数据交互。

### 1. 技术栈

| 维度 | 技术选型 |
| --- | --- |
| **后端 (Backend)** | Spring Boot 3.x, MyBatis-Plus, MySQL 8.x, Maven |
| **前端 (Frontend)** | Vue 3, Vite, TypeScript, Element Plus, Axios |
| **工具/环境** | JDK 17, Node.js 20+, Git, IntelliJ IDEA / VS Code |

### 2. 目录结构

```text
XM/
├── bss-backend/          # 后端 Maven 项目
│   ├── src/main/java/    # Java 源代码 (Controller, Service, Entity, Mapper)
│   └── src/main/resources/# 配置文件 (application.yml, Mapper XML)
├── bss-frontend/         # 前端 Vue 项目
│   ├── src/api/          # Axios 接口封装
│   ├── src/views/        # 页面组件
│   └── vite.config.ts    # Vite 配置 (含跨域代理)
└── project_all_code.txt  # 项目全量代码导出

```

---

## 🔌 核心接口文档 (API)

后端 API 默认基础路径为 `/api`。以下是核心模块接口摘录：

### 用户/数据管理模块

| 功能 | 请求方法 | 路径 | 描述 |
| --- | --- | --- | --- |
| 获取列表 | `GET` | `/data/list` | 支持分页查询所有数据项 |
| 获取详情 | `GET` | `/data/{id}` | 根据唯一 ID 获取详细信息 |
| 新增数据 | `POST` | `/data/add` | 提交 JSON 格式的新数据 |
| 更新数据 | `PUT` | `/data/update` | 修改现有数据记录 |
| 删除数据 | `DELETE` | `/data/delete/{id}` | 物理删除指定记录 |

> **提示**：前端请求已通过 `vite.config.ts` 中的 `proxy` 配置，自动转发请求至后端 `8080` 端口，解决了开发环境下的跨域问题。

---

## 🛠 本地启动步骤

### 前置要求

* 已安装 **JDK 17** 及 **Maven 3.8+**
* 已安装 **Node.js 20+**
* 已安装 **MySQL 8.0** 并创建数据库（默认库名：`shuiyue`）

### 1. 后端启动 (IDEA)

1. 导入 `bss-backend` 文件夹作为 Maven 项目。
2. 修改 `src/main/resources/application.yml` 中的数据库账号密码。
3. 运行 `BssBackendApplication.java`。
4. **后端地址**：`http://localhost:8080`

### 2. 前端启动 (VS Code)

1. 进入 `bss-frontend` 目录。
2. 打开终端，安装依赖：
```bash
npm install

```


3. 启动开发服务器：
```bash
npm run dev

```


4. **浏览器访问**：`http://localhost:5173`

---

## 📝 开发者备注

* **跨域处理**：后端已配置 `WebMvcConfigurer` 或前端已配置 Vite 代理，确保生产与开发环境调用正常。
* **数据库规范**：请确保 SQL 脚本已执行，Mapper 映射字段与数据库列名保持一致（推荐开启驼峰转下划线配置）。

---

### 如何将此内容保存？

你可以直接将上述内容复制，然后在你的 GitHub 仓库根目录下新建（或覆盖）一个 `README.md` 文件。

**需要我为你补充具体的 SQL 数据库建表语句，或者是针对某个特定功能的详细逻辑说明吗？**
