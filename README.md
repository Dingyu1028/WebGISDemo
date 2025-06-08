# WebGISDemo
WebGIS Course Demo

## I. Project Overview
The `WebGISDemo` project serves as an illustrative example closely associated with the WebGIS (Web Geographic Information System) course. Its primary objective is to showcase the pivotal technologies and implementation logics inherent in WebGIS application development through tangible code examples.  

By leveraging libraries like GeoExt2 and OpenLayers, the project enables the realization of diverse functions of the geographic information system on web pages, offering practical references for those delving into WebGIS development.  


## II. Main Functions  

### 1. Layer Management  
The `GeoExt.data.LayerStore` is employed to manage map layers. It synchronizes the layer array of the OpenLayers map with the storage object, guaranteeing data consistency. This synchronization facilitates seamless operations such as adding, deleting, displaying, and hiding layers.  


### 2. Feature Processing  
The `GeoExt.data.FeatureStore` supports two-way synchronization between the feature array of the `OpenLayers.Layer.Vector` layer and the storage object. This bidirectional synchronization simplifies the manipulation and management of geographic features, encompassing operations like adding, deleting, modifying, and querying features.  


### 3. Legend Display  
A variety of legend components, including `GeoExt.container.LayerLegend`, `GeoExt.container.VectorLegend`, and `GeoExt.panel.Legend`, are integrated into the project. These components are capable of presenting the legends of different types of layers, enabling users to gain an intuitive understanding of the map layer information.  


### 4. Map Interaction  
With the assistance of classes such as `OpenLayers.Handler.Box`, the project supports interactive operations like dragging rectangular boxes on the map. These interactions can be utilized for zooming in on or selecting specific map areas.  


## III. Code Structure  WebGISDemo  
├── README.md  
└── WebGIS2025  
    ├── GeoExt2-related code (comprising various library files and functional classes, such as GeoExt.data.OwsStore, etc.)  
    └── OpenLayers-related code (comprising various library files and functional classes, such as OpenLayers.Handler.Box, etc.)  

## IV. Usage  

### 1. Clone the Repository  
In the local terminal, execute the command:  git clone https://github.com/Dingyu1028/WebGISDemo.git  to clone the project onto your local machine.  


### 2. Environment Configuration  
Ensure that the local environment has installed all the dependencies required to run the project. Given that the project utilizes libraries like GeoExt2 and OpenLayers, install the corresponding dependencies and configure the environment as per their official documentation.  


### 3. Run the Project  
Navigate to the project directory and start the project based on its actual operation method (e.g., via a local server). Once launched, you can observe the demonstration effects of the WebGIS.  


### V. Notes  
- Currently, this project is solely intended as a course example, and its functions may lack comprehensiveness. For practical applications, it necessitates further development and optimization according to specific requirements.  
- There may be compatibility issues with the versions of GeoExt2 and OpenLayers employed in the project. In the event of encountering problems during operation, refer to the official documentation of the respective libraries for troubleshooting and resolution.  


### VI. Future Prospects  
In the upcoming development, there are plans to expand and optimize the functions of this project. Specific improvements will include:  
- Adding support for a wider range of map data types.  
- Enhancing the map interaction experience.  
- Perfecting the layer and feature management functions.  

The ultimate goal is to transform it into a more practical WebGIS development example.  


---  

## 一、项目概述  
`WebGISDemo` 项目是一个与 WebGIS（网络地理信息系统）课程紧密相关的示例项目。其核心目标是通过实际代码示例，展示 WebGIS 应用开发中关键的技术与实现逻辑。  

借助 GeoExt2 和 OpenLayers 等库，该项目能够在网页上实现地理信息系统的多种功能，为学习 WebGIS 开发的人员提供实用参考。  


## 二、主要功能  

### 1. 图层管理  
使用 `GeoExt.data.LayerStore` 对地图图层进行管理。它能将 OpenLayers 地图的图层数组与存储对象进行同步，确保数据一致，从而轻松实现图层的添加、删除、显示和隐藏等操作。  


### 2. 要素处理  
`GeoExt.data.FeatureStore` 支持 `OpenLayers.Layer.Vector` 图层的要素数组与存储对象之间的双向同步。这种双向同步机制让地理要素的操作和管理更加便捷，涵盖要素的增删改查等操作。  


### 3. 图例显示  
项目集成了多种图例组件，如 `GeoExt.container.LayerLegend`、`GeoExt.container.VectorLegend` 和 `GeoExt.panel.Legend` 。这些组件能够展示不同类型图层的图例，帮助用户直观了解地图图层信息。  


### 4. 地图交互  
借助 `OpenLayers.Handler.Box` 等类，项目支持在地图上进行拖动矩形框等交互操作。这些交互可用于缩放地图区域或选择特定地图范围。  


## 三、代码结构  WebGISDemo  
├── README.md  
└── WebGIS2025  
    ├── GeoExt2 相关代码（包含各类库文件与功能类，如 GeoExt.data.OwsStore 等）  
    └── OpenLayers 相关代码（包含各类库文件与功能类，如 OpenLayers.Handler.Box 等）  

## 四、使用方法  

### 1. 克隆仓库  
在本地终端运行以下命令，将项目克隆到本地计算机：  git clone https://github.com/Dingyu1028/WebGISDemo.git  

### 2. 环境配置  
确保本地环境已安装运行项目所需的所有依赖项。由于项目使用了 GeoExt2 和 OpenLayers 等库，需根据其官方文档安装相应依赖并配置环境。  


### 3. 运行项目  
进入项目目录，根据项目实际运行方式（如通过本地服务器）启动项目，启动后即可查看 WebGIS 示例效果。  


## 五、注意事项  
- 目前，该项目仅作为课程示例，功能可能并不完善。在实际应用场景中，需要根据具体需求进一步开发和优化。  
- 项目中使用的 GeoExt2 和 OpenLayers 版本可能存在兼容性问题。若在运行过程中遇到问题，请参考对应库的官方文档进行排查和解决。  


## 六、未来展望  
在后续开发中，计划对该项目进行功能扩展与优化。具体改进方向包括：  
- 增加对更多类型地图数据的支持。  
- 优化地图交互体验。  
- 完善图层和要素管理功能。  

力求将其打造成一个更具实用性的 WebGIS 开发示例。  
