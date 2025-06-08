
```markdown
# 🌍 WebGISDemo  
**WebGIS Course Demo** 🚀  


## 🌟 I. Project Overview  
The `WebGISDemo` project is a 🎓 **teaching example** tightly integrated with the WebGIS (Web Geographic Information System) course. Its mission is to showcase 🔑 **core technologies** and implementation patterns in WebGIS development through **runnable code examples**.  

By leveraging 🛠️ **GeoExt2** and **OpenLayers**, this project brings GIS capabilities to web browsers, offering hands-on learning resources for developers exploring WebGIS.  


## 🛠️ II. Main Functions  

### 🗺️ 1. Layer Management  
Powered by `GeoExt.data.LayerStore`, this module enables seamless management of map layers with features like:  
- 🔄 **Two-way synchronization** between map layers and data store  
- 📌 Add/remove layers with a single click  
- 👁️ Toggle layer visibility in real-time  
- 🔼🔽 Rearrange layer order dynamically  


### 🌍 2. Feature Processing  
The `GeoExt.data.FeatureStore` supports bidirectional data flow for vector layers, including:  
- ✨ Create and edit geographic features interactively  
- 🔍 Query and filter features by attributes  
- 📊 Perform spatial analysis on selected features  
- 💾 Persist feature changes to storage  


### 📜 3. Legend Display  
Integrated legend components provide intuitive visualization of map symbology:  
- 🎨 Auto-generate legends for raster/vector layers  
- 🔍 Zoomable and interactive legend panels  
- 🌈 Color-coded classification for thematic maps  
- 📱 Responsive legend design for all devices  


### 🖱️ 4. Map Interaction  
Enhanced user experience with interactive map controls:  
- 📦 Drag rectangular boxes for area selection  
- 🔍 Zoom in/out with smooth animations  
- 👆 Click features for pop-up information  
- 🗺️ Custom interaction handlers for advanced use cases  


## 📁 III. Code Structure  
```tree  
WebGISDemo/  
├── README.md               📖 Project documentation  
└── WebGIS2025/             🚀 Core implementation  
    ├── GeoExt2-related/    🌐 GeoExt2 framework integration  
    │   ├── stores/         🗄️ Data stores  
    │   ├── layers/         📑 Layer management  
    │   └── components/     🧩 UI components  
    └── OpenLayers-related/ 🗺️ OpenLayers map engine  
        ├── map/            🗺️ Map configuration  
        ├── layers/         🌌 Layer definitions  
        └── interactions/   👋 User interactions  
```  


## 🚀 IV. Usage  

### 1. 📥 Clone the Repository  
```bash  
git clone https://github.com/Dingyu1028/WebGISDemo.git  
cd WebGISDemo  
```  

### 2. ⚙️ Environment Configuration  
Install dependencies using your preferred package manager:  
```bash  
npm install  # or yarn install  
```  

### 3. 🌐 Run the Project  
Start a local server and open in browser:  
```bash  
npx http-server WebGIS2025  
# Visit http://localhost:8080 in your browser  
```  


## ⚠️ V. Notes  
- 🚧 **Work in Progress**: This is a course demo, not production-ready  
- 🔄 **Version Compatibility**: Ensure GeoExt2/OpenLayers versions match  
- 📚 **Documentation**: Refer to official docs for advanced customization  


## 🌟 VI. Future Prospects  
We're actively developing the following enhancements:  
- 🗂️ Support for more data formats (GeoJSON, KML, etc.)  
- 🚀 Performance optimizations for large datasets  
- 📱 Mobile-responsive design improvements  
- 🎯 Advanced spatial analysis tools  

Your feedback and contributions are welcome! 💖  


---  

## 🌍 一、项目概述  
`WebGISDemo` 是与 **WebGIS 课程** 深度结合的教学示例项目。通过实际代码展示 WebGIS 开发中的核心技术与实现模式，帮助学习者快速掌握 WebGIS 应用开发。  


## 🛠️ 二、主要功能  

### 🗺️ 1. 图层管理  
- 图层数据与存储对象双向同步  
- 支持图层增删改查操作  
- 实时控制图层显示状态  
- 灵活调整图层叠加顺序  

### 🌍 2. 地理要素处理  
- 交互式创建与编辑地理要素  
- 基于属性的要素查询与筛选  
- 空间分析功能集成  
- 要素变更持久化存储  

### 📜 3. 图例显示  
- 自动生成栅格/矢量图层图例  
- 交互式可缩放图例面板  
- 专题地图分类图例  
- 响应式图例设计  

### 🖱️ 4. 地图交互  
- 矩形框选区域  
- 平滑缩放与平移  
- 要素点击信息弹窗  
- 自定义交互事件处理  


## 📁 三、代码结构  
```tree  
WebGISDemo/  
├── README.md               📖 项目说明文档  
└── WebGIS2025/             🚀 核心代码  
    ├── GeoExt2-related/    🌐 GeoExt2框架集成  
    │   ├── stores/         🗄️ 数据存储  
    │   ├── layers/         📑 图层管理  
    │   └── components/     🧩 UI组件  
    └── OpenLayers-related/ 🗺️ OpenLayers地图引擎  
        ├── map/            🗺️ 地图配置  
        ├── layers/         🌌 图层定义  
        └── interactions/   👋 用户交互  
```  


## 🚀 四、使用方法  

### 1. 📥 克隆仓库  
```bash  
git clone https://github.com/Dingyu1028/WebGISDemo.git  
cd WebGISDemo  
```  

### 2. ⚙️ 环境配置  
安装项目依赖：  
```bash  
npm install  # 或使用 yarn install  
```  

### 3. 🌐 运行项目  
启动本地服务器并访问：  
```bash  
npx http-server WebGIS2025  
# 在浏览器中打开 http://localhost:8080  
```  


## ⚠️ 五、注意事项  
- 🚧 **开发中**：本项目为教学示例，功能尚未完备  
- 🔄 **版本兼容**：请确保 GeoExt2/OpenLayers 版本匹配  
- 📚 **文档参考**：高级功能请参考官方文档  


## 🌟 六、未来展望  
计划添加的功能包括：  
- 🗂️ 更多数据格式支持（GeoJSON、KML 等）  
- 🚀 大规模数据性能优化  
- 📱 移动设备响应式设计  
- 🎯 高级空间分析工具  

欢迎贡献代码与反馈！ 💖  
```
