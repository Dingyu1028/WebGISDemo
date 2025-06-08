<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="WebGIS2025.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">
        p
        {
            margin: 5px;
        }
        .settings
        {
            background-image: url(./resources/icons/fam/folder_wrench.png);
        }
        .nav
        {
            background-image: url(./resources/icons/fam/folder_go.png);
        }
        .info
        {
            background-image: url(./resources/icons/fam/information.png);
        }
        .layerlist
        {
            background-image: url(./resources/icons/fam/layer.png);
        }
        .HomeButton
        {
            background-image: url(./resources/icons/fam/HomeButton.png);
        }
        .RegisterButton
        {
            background-image: url(./resources/icons/fam/RegisterButton.png);
        }
        #custom-slider 
        {
            width: 214px;
            padding-top: 6px;
            background-image: url(./resources/images/ticks.gif);
        }
        #custom-slider .x-slider-thumb 
        {
            background-image: url(./resources/images/slider-thumb.png);
        }
    </style>

    <%--引用extjs库--%>
    <link rel="stylesheet" type="text/css" href="./lib/ext-4.2.1.883/resources/css/ext-all-neptune.css" />
    <script type="text/javascript" src="./lib/ext-4.2.1.883/bootstrap.js"></script>
    <script type="text/javascript" src="./lib/ext-4.2.1.883/locale/ext-lang-zh_CN.js"></script>

    <%--引用openlayer库--%>
    <script type="text/javascript" src="./lib/OpenLayers-2.13.1/OpenLayers.js"></script>

    <%--引用geoext2库--%>
    <script type="text/javascript" src="./lib/geoext2-2.0.3/loader.js"></script>

    <script type="text/javascript">
        //声明一个queryString函数
        Request = {
            QueryString: function (item) {
                var svalue = location.search.match(new RegExp("[\?\&]" + item + "=([^\&]*)(\&?)", "i"));
                return svalue ? svalue[1] : svalue;
            }
        }

        //=========begin:引用=========//
        Ext.require(['*',
            'Ext.Window',
            'Ext.container.Viewport',
            'Ext.layout.container.Border',
            'Ext.tree.plugin.TreeViewDragDrop',
            'Ext.state.Manager',
            'Ext.state.CookieProvider',
            'Ext.window.MessageBox',
            'Ext.form.*',
            'Ext.data.*',
            'Ext.chart.*',
            'Ext.grid.Panel',
            'Ext.layout.container.Column',
            'Ext.grid.column.Action',
            'Ext.slider.*',
            'GeoExt.tree.Panel',
            'GeoExt.panel.Map',
            'GeoExt.window.Popup',
            'GeoExt.tree.OverlayLayerContainer',
            'GeoExt.tree.BaseLayerContainer',
            'GeoExt.data.LayerTreeModel',
            'GeoExt.tree.View',
            'GeoExt.tree.Column',
            'GeoExt.data.ScaleStore',
            'GeoExt.slider.LayerOpacity',
            'GeoExt.slider.Tip',
            'GeoExt.slider.Zoom',
            'GeoExt.data.MapfishPrintProvider',
            'GeoExt.panel.PrintMap',
            'GeoExt.plugins.PrintExtent',
            'GeoExt.form.field.GeocoderComboBox',
            'GeoExt.Action',
        ]);
        //=========end:引用=========//

        Ext.onReady(function () {
            Ext.QuickTips.init();
            Ext.state.Manager.setProvider(Ext.create('Ext.state.CookieProvider'));
            //提示当前登录用户
            Ext.Msg.alert("Welcome", Request.QueryString("username") + "：欢迎您登录！");

            //========begin:创建openlayer map对象，设置坐标系统、显示范围、显示级别=========//
            var map = new OpenLayers.Map({});
            var mapOptions = {
                resolutions: [0.703125, 0.3515625, 0.17578125, 0.087890625, 0.0439453125, 0.02197265625, 0.010986328125,
                    0.0054931640625, 0.00274658203125, 0.001373291015625, 6.866455078125E-4, 3.433227539062E-4, 1.716613769531E-4,
                    8.58306884766E-5, 4.29153442383E-5, 2.14576721191E-5, 1.07288360596E-5, 5.3644180298E-6, 2.6822090149E-6,
                    1.3411045074E-6, 6.705522537E-7, 3.352761269E-7],
                projection: new OpenLayers.Projection('EPSG:4326'),
                maxExtent: new OpenLayers.Bounds(-180.0, -90.0, 180.0, 90.0),
                numZoomLevels: 15, //控制要显示的级别
                units: "degrees"
            };
	        //map.setOptions(mapOptions);
            //========end:创建openlayer map对象，设置坐标系统、显示范围、显示级别=========//

            //===添加OpenStreetMap发布的wms服务
            var LayerOSM = new OpenLayers.Layer.WMS(
                "OpenStreetMap WMS",
                "http://ows.terrestris.de/osm/service?",
                {
                    layers: 'OSM-WMS'
                }
            );
	        //map.addLayers([LayerOSM]);
            //===添加OpenStreetMap发布的wms服务

            //调用天地图WMTS服务
            var tdt_vec = new OpenLayers.Layer.WMTS({
                name: "天地图-矢量底图",
                url: "http://t0.tianditu.gov.cn/vec_c/wmts?tk=9ff561768b703468bf36445c01ad9b1d",
                layer: "vec",
                style: "default",
                matrixSet: "c",
                format: "tiles",
                isBaseLayer: true,
            });
            var tdt_img = new OpenLayers.Layer.WMTS({
                name: "天地图-影像底图",
                url: "http://t0.tianditu.gov.cn/img_c/wmts?tk=9ff561768b703468bf36445c01ad9b1d",
                //url: "",               
                layer: "img",
                style: "default",
                matrixSet: "c",
                format: "tiles",
                isBaseLayer: true,
            });
            var tdt_ter = new OpenLayers.Layer.WMTS({
                name: "天地图-地形渲染图",
                url: "http://t0.tianditu.gov.cn/ter_c/wmts?tk=9ff561768b703468bf36445c01ad9b1d",
                //url: "",               
                layer: "ter",
                style: "default",
                matrixSet: "c",
                format: "tiles",
                isBaseLayer: true,
            });
            map.addLayers([tdt_vec, tdt_img, tdt_ter]);
            var tdt_cva = new OpenLayers.Layer.WMTS({
                name: "天地图-矢量底图注记",
                url: "http://t0.tianditu.gov.cn/cva_c/wmts?tk=9ff561768b703468bf36445c01ad9b1d",
                //url: "",               
                layer: "cva",
                style: "default",
                matrixSet: "c",
                format: "tiles",
                isBaseLayer: false,
            });
            var tdt_cia = new OpenLayers.Layer.WMTS({
                name: "天地图-影像底图注记",
                url: "http://t0.tianditu.gov.cn/cia_c/wmts?tk=9ff561768b703468bf36445c01ad9b1d",
                //url: "",               
                layer: "cia",
                style: "default",
                matrixSet: "c",
                format: "tiles",
                isBaseLayer: false,
            });
            var tdt_cta = new OpenLayers.Layer.WMTS({
                name: "天地图-地形渲染图注记",
                url: "http://t0.tianditu.gov.cn/cta_c/wmts?tk=9ff561768b703468bf36445c01ad9b1d",
                //url: "",               
                layer: "cta",
                style: "default",
                matrixSet: "c",
                format: "tiles",
                isBaseLayer: false,
            });
            var tdt_ibo = new OpenLayers.Layer.WMTS({
                name: "天地图-全球境界",
                url: "http://t0.tianditu.gov.cn/ibo_c/wmts?tk=9ff561768b703468bf36445c01ad9b1d",
                //url: "",               
                layer: "ibo",
                style: "default",
                matrixSet: "c",
                format: "tiles",
                isBaseLayer: false,
            });
            map.addLayers([tdt_cva, tdt_cia, tdt_cta, tdt_ibo]);
            //调用天地图WMTS服务

            //===添加Geoserver发布的wms服务
            var layerCityboundary = new OpenLayers.Layer.WMS(
                "cityboundary-wms", "http://localhost:8088/geoserver/xb/wms?",
                {
                    layers: 'cityboundarylayer',
                    styles: '',
                    srs: 'EPSG:4326',
                    format: 'image/png',
                    tiled: 'true',
                    tilesOrigin: map.maxExtent.left + ',' + map.maxExtent.bottom,
                    transparent: true
                },
                {
                    isBaseLayer: false,
                    buffer: 0,
                    displayOutsideMaxExtent: true
                }
            );
            var layer_etm2000 = new OpenLayers.Layer.WMS(
                "etm2000-853tif", "http://localhost:8088/geoserver/xb/wms?",
                {
                    layers: 'etm2000-853tif',
                    styles: '',
                    srs: 'EPSG:4326',
                    format: 'image/png',
                    tiled: 'true',
                    tilesOrigin: map.maxExtent.left + ',' + map.maxExtent.bottom,
                    transparent: true
                },
                {
                    isBaseLayer: false,
                    buffer: 0,
                    displayOutsideMaxExtent: true
                }
            );
            var layer_road1 = new OpenLayers.Layer.WMS(
                "road1_line", "http://localhost:8088/geoserver/xb/wms?",
                {
                    layers: 'road1_line',
                    styles: '',
                    srs: 'EPSG:4326',
                    format: 'image/png',
                    tiled: 'true',
                    tilesOrigin: map.maxExtent.left + ',' + map.maxExtent.bottom,
                    transparent: true
                },
                {
                    isBaseLayer: false,
                    buffer: 0,
                    displayOutsideMaxExtent: true
                }
            );
            var layer_road4 = new OpenLayers.Layer.WMS(
                "road4_line_layer", "http://localhost:8088/geoserver/xb/wms?",
                {
                    layers: 'road4_line_layer',
                    styles: '',
                    srs: 'EPSG:4326',
                    format: 'image/png',
                    tiled: 'true',
                    tilesOrigin: map.maxExtent.left + ',' + map.maxExtent.bottom,
                    transparent: true
                },
                {
                    isBaseLayer: false,
                    buffer: 0,
                    displayOutsideMaxExtent: true
                }
            );
            map.addLayers([layerCityboundary, layer_etm2000, layer_road1, layer_road4]);
            //===添加Geoserver发布的wms服务

            /************************begin:加载一般的基础控件********************************/
            map.addControl(new OpenLayers.Control.Navigation());  //双击放大,平移
            //map.setCenter(new OpenLayers.LonLat(100.254, 35.25), 1);  //添加平移缩放工具条
            map.addControl(new OpenLayers.Control.OverviewMap());  //添加鹰眼图
            map.addControl(new OpenLayers.Control.LayerSwitcher({ 'ascending': false }));  //图层切换工具			
            map.addControl(new OpenLayers.Control.NavToolbar(mapOptions));
            map.addControl(new OpenLayers.Control.ScaleLine());
            var zb = new OpenLayers.Control.ZoomBox({ out: true });
            var panel = new OpenLayers.Control.Panel({ defaultControl: zb });
            map.addControl(panel);
	        /************************end:加载一般的基础控件********************************/


            //========begin:查询地名并定位到地图========//
            var pointData;
            var pointsStore = new Ext.data.Store({
                fields: [{ name: 'poiName' },
                { name: 'lon' },
                { name: 'lat' },
                { name: 'description' }]
            });

            function findLocation() {
                var LocationText = Ext.getCmp
                    ("LocationText").getValue(); //地名

                if (Ext.util.Format.
                    trim(LocationText) == "") {
                    Ext.Msg.alert("提示",
                        "地名不能为空");
                    return;
                }

                Ext.Ajax.request({
                    url: "location.ashx?LocationText="
                        + LocationText,
                    method: "get",
                    success: function (response) {
                        var getData = response.responseText; //获取服务器数据   
                        console.log(response.responseText);
                        if (getData != "") {
                            pointData = eval(getData); //将json字符串转换为array
                            console.log(pointData);
                            pointsStore.removeAll();
                            pointsStore.loadData(pointData);
                            console.log(pointsStore);
                        } else {
                            Ext.Msg.alert("警告", "查询失败！");
                        }
                    },
                    failure: function (response, options) {
                        Ext.Msg.alert("失败");
                    }
                });
            }

            var marker_layer = new OpenLayers
                .Layer.Markers("markers");
            var marker_size = new OpenLayers.
                Size(32, 32);
            var marker_offset = new OpenLayers
                .Pixel(-(marker_size.w / 2),
                    -(marker_size.h));
            var marker_starticon = new OpenLayers
                .Icon("./resources/images/address.png",
                    marker_size, marker_offset);
            map.addLayers([marker_layer]);
	    //========end:查询地名并定位到地图========//

            //===============begin:图层列表的数据===============//
            var layertreestore = Ext.create('Ext.data.TreeStore', {
                model: 'GeoExt.data.LayerTreeModel',
                root: {
                    expanded: true,
                    children: [
                        {
                            plugins: ['gx_baselayercontainer'],
                            expanded: true,
                            text: "基础图层"
                        },
                        {
                            plugins: ['gx_overlaylayercontainer'],
                            expanded: true,
                            text: "叠加图层"
                        }
                    ]
                }
            });
	    //===============end:图层列表的数据===============//


            //===============start:折线图===============//
            //查询水体参数
            var pointsStoreWater = new Ext.data.Store({
                fields: [{ name: 'poiName' },
                { name: 'lon' },
                { name: 'lat' },
                { name: 'description' },
                { name: 'Cdom' },
                { name: 'Chl' },
                { name: 'Cyan' },
                ]
            });
            //==后台发送请求==//
            Ext.Ajax.request({
                url: "searchWater.ashx?queryWater=WA",
                method: "get",
                success: function (response) {
                    if (response.responseText != "") {
                        pointsStoreWater.removeAll();
                        pointsStoreWater.loadData(eval(response.responseText));
                        console.log(pointsStoreWater);
                    }
                    else {
                        Ext.Msg.alert("警告", "查询失败！");
                    }
                },
                failure: function (response, options) {
                    Ext.Msg.alert("请求失败");
                }
            });

            function searchChart() {
                var chart = Ext.create('Ext.chart.Chart', {//创建一个新的窗口
                    style: 'background:#fff',
                    animate: true,
                    store: pointsStoreWater,
                    shadow: true,
                    theme: 'Category1',
                    legend: {
                        position: 'right'
                    },//图例
                    axes: [
                        {//定义两个坐标轴
                            type: 'Numeric',
                            minimum: 0,
                            maximum: 150,
                            position: 'left',
                            fields: ['Cdom', 'Chl', 'Cyan'],
                            title: '浓度',
                            minorTickSteps: 1,
                            grid: {
                                odd: {
                                    opacity: 1,
                                    fill: '#ddd',
                                    stroke: '#bbb',
                                    'stroke-width': 0.5
                                }
                            }
                        }, {
                            type: 'Category',
                            position: 'bottom',
                            fields: ['poiName'],
                            title: '水质点位'
                        }],
                    series: [
                        {//定义三条折线的属性
                            type: 'line',
                            highlight: {
                                size: 7,
                                radius: 7
                            },
                            axis: 'left',
                            xField: 'poiName',
                            yField: 'Cyan',
                            markerConfig: {
                                type: 'cross',//将点显示成叉号
                                size: 4,
                                radius: 4,
                                'stroke-width': 0
                            }
                        },
                        {
                            type: 'line',
                            highlight: {
                                size: 7,
                                radius: 7
                            },
                            axis: 'left',
                            smooth: true,
                            xField: 'poiName',
                            yField: 'Chl',
                            markerConfig: {
                                type: 'circle',
                                size: 4,
                                radius: 4,
                                'stroke-width': 0
                            }
                        },
                        {
                            type: 'line',
                            highlight: {
                                size: 7,
                                radius: 7
                            },
                            axis: 'left',
                            smooth: true,
                            xField: 'poiName',
                            yField: 'Cdom',
                            markerConfig: {
                                type: 'circle',
                                size: 4,
                                radius: 4,
                                'stroke-width': 0
                            }
                        }
                    ]
                });
                var win = Ext.create('Ext.Window', {
                    width: 600,
                    height: 400,
                    minHeight: 400,
                    minWidth: 550,
                    hidden: false,
                    maximizable: true,
                    title: '水质参数折线图',
                    renderTo: Ext.getBody(),
                    layout: 'fit',
                    items: chart
                });
            }
        //===============end:折线图===============//

            //========begin:轨迹回放========//
            //将所有点坐标放入数组
            var allpoints = [120.1429508459857, 30.26970728785357, 120.1433203727838, 30.26987813036302,
                120.1435960763801, 30.27004810202611, 120.1440598871008, 30.27030170181578, 120.1444335085162, 30.270470517764,
                120.144810643117, 30.27055560506131, 120.1451765255314, 30.27073067247369, 120.1456327853926, 30.27099172208011,
                120.146004257442, 30.27116346602122, 120.1462800039004, 30.27133552745275, 120.1467445443051, 30.27151014804406,
                120.1471173252899, 30.27168188169949, 120.1473998801327, 30.27176758744826, 120.1477675134656, 30.27202590069018,
                120.1482317030441, 30.27228427614901, 120.1486055668594, 30.2724565330538, 120.1489743480442, 30.27271556471561,
                120.1492577998196, 30.27280160960896, 120.1497279906527, 30.27297467574628, 120.1501076140693, 30.2730609856902,
                120.15022542109, 30.27271277764034, 120.1503419628279, 30.27236616902568, 120.150370961101, 30.2719304613715,
                120.1503926298281, 30.2715024323573, 120.1505031297421, 30.27116282807489, 120.1505171704705, 30.27090563537451,
                120.1505403491641, 30.27047775120843, 120.150561916451, 30.27005198112197, 120.1506784270925, 30.26962727257277,
                120.1507930652985, 30.26928582475572, 120.1510103543296, 30.26885733698972, 120.1511227741985, 30.26851854995961,
                120.1513340941565, 30.26809595127256];

            var vectorLayer, car, lineFeature;
            var px, py;
            var x = 0;
            var car_size = new OpenLayers.Size(32, 32);
            //var zoom = map.getZoom();
            var zoom = 15;

            function startReplay() {
                //feature style
                var style_green = {
                    strokeColor: "#339933",
                    strokeOpacity: 0.5,
                    strokeWidth: 10,
                    pointRadius: 6,
                    pointerEvents: "visiblePainted"
                };

                x = 0;
                if (vectorLayer != null) {
                    map.removeLayer(vectorLayer);
                }
                if (car != null) {
                    map.removeLayer(car);
                }

                //	        px = Math.random() * (122 - 121 + 0.001) + 121;
                //	        py = Math.random() * (30 - 29 + 0.001) + 29;
                //	        var lonlat = new OpenLayers.LonLat(px, py);
                var lonlat = new OpenLayers.LonLat
                    (allpoints[0], allpoints[1]);
                map.setCenter(lonlat, zoom);

                vectorLayer = new OpenLayers.Layer.Vector("route");
                map.addLayer(vectorLayer);

                car = new OpenLayers.Layer.Markers("car");
                map.addLayer(car);

                var imgUrl = "./resources/images/car.png";
                var icon = new OpenLayers.Icon(imgUrl, car_size);
                var marker = new OpenLayers.Marker(lonlat, icon);
                car.addMarker(marker);

                lineFeature = new OpenLayers.Feature.Vector(
                    new OpenLayers.Geometry.LineString
                        (lonlat.lon, lonlat.lat),
                    null, style_green);
                vectorLayer.addFeatures([lineFeature]);

                fn();
            }

            function fn() {
                if (x < allpoints.length) {
                    //	            px = Math.random() * (122 - 121 + 0.001) + 121;
                    //	            py = Math.random() * (30 - 29 + 0.001) + 29;
                    var lonlat = new OpenLayers.LonLat(allpoints[x],
                        allpoints[x + 1]);
                    map.setCenter(lonlat, zoom);

                    var newPoint = new OpenLayers.Geometry.Point(lonlat.lon,
                        lonlat.lat);
                    lineFeature.geometry.addPoint(newPoint);
                    vectorLayer.drawFeature(lineFeature);

                    car.clearMarkers();
                    var imgUrl = "./resources/images/car.png";
                    var icon = new OpenLayers.Icon(imgUrl, car_size);
                    var marker = new OpenLayers.Marker(lonlat, icon);
                    car.addMarker(marker);
                    //x++;
                    x += 2;
                    setTimeout(fn, 200);

                    console.log(x);
                }
            }
	    //========end:轨迹回放========//

            //========begin:动画显示多张图片========//
            var img_extent = new OpenLayers.
                Bounds(-131.0888671875, 30.5419921875,
                    -78.3544921875, 53.7451171875);
            var img_size = new OpenLayers.Size(780, 480);
            var img_url = image = null;
            var imgArray = [];
            for (var i = 1; i <= 32; i++) {
                index = (i < 10) ? "0" + i : i;

                //img_url = "./App_Data/radar/nexrad" + index + ".png";//此种路径无法访问？
                img_url = "nexrad" + index + ".png";
                //img_url = "http://localhost/radar/nexrad" + index + ".png";
                image = new OpenLayers.Layer.
                    Image(img_url, img_url, img_extent,
                        img_size,
                        {
                            isBaseLayer: false,
                            alwaysInRange: true, // Necessary to always draw the image
                            visibility: false
                        });
                imgArray.push(image);
                map.addLayer(image);
            }
            imgArray[0].setVisibility(true);

            var currentIndex = 0;
            function animation(value) {
                imgArray[currentIndex].setVisibility(false);
                currentIndex = Math.floor(value * 31 / 100);
                imgArray[currentIndex].setVisibility(true);
            }

            var interval = null;
            function animateAction(checked) {
                if (checked) {
                    interval = setInterval(function () {
                        var v = Ext.getCmp("animSlider").getValue();
                        v = (v >= 100) ? 0 : (v + 1);
                        Ext.getCmp("animSlider").setValue(v);
                        animation(v);
                    },
                        100); //控制刷新间隔，单位毫秒
                }
                else {
                    clearInterval(interval);
                }
            }
	    //========end:动画显示多张图片========//

            //===============begin:popup窗体===============//	    
            var popup;
            // create a vector layer, add a feature into it
            var LayerPopup = new OpenLayers.Layer.Vector("LayerPopup");
            Ext.Ajax.request({
                url: "searchWater.ashx?method=queryAll",
                method: "get",
                success: function (response) {
                    if (response.responseText != "") {
                        var waterData = eval(response.responseText);
                        //添加pointFeatures
                        //LayerPopup.removeAllFeatures();
                        var pointFeatures = [];
                        for (var i = 0; i < waterData.length; i++) {
                            var attributes = {
                                'poiName': waterData[i].poiName,
                                'lon': waterData[i].lon,
                                'lat': waterData[i].lat,
                                'description': waterData[i].description,
                                'Cdom': waterData[i].Cdom,
                                'Chl': waterData[i].Chl,
                                'Cyan': waterData[i].Cyan
                            };
                            var pointGeometry = new OpenLayers.Geometry.Point(waterData[i].lon, waterData[i].lat);
                            var pointFeature = new OpenLayers.Feature.Vector(pointGeometry, attributes);
                            pointFeatures.push(pointFeature);
                        }
                        LayerPopup.addFeatures(pointFeatures);
                    } else {
                        Ext.Msg.alert("警告", "QueryWater失败！");
                    }
                },
                failure: function (response, options) {
                    Ext.Msg.alert("加载水质监测点失败");
                }
            });



            var attributes = {
                'poiName': '地名1',
                'lon': 120,
                'lat': 30,
                'description': '描述信息1：该点为地名1',
                'Cdom': 30,
                'Chl': 40,
                'Cyan': 50
            };
            LayerPopup.addFeatures(new OpenLayers.Feature.Vector
                (new OpenLayers.Geometry.Point(120, 30), attributes));
            attributes = {
                'poiName': '地名2',
                'lon': 120.1,
                'lat': 30.1,
                'description': '描述信息2：该点为地名2',
                'Cdom': 60,
                'Chl': 70,
                'Cyan': 80
            };
            LayerPopup.addFeatures(new OpenLayers.Feature.Vector
                (new OpenLayers.Geometry.Point(120.1, 30.1), attributes));

            // create select feature control
            var selectCtrl = new OpenLayers.Control.SelectFeature(LayerPopup);
            // define "createPopup" function
            var bogusMarkup = "弹出框测试^_^!";

            function createPopup(feature) {
                var constrainOpts = "constrain-full"; //no-constrain,constrain-header,constrain-full
                var popupOpts = Ext.apply({
                    title: 'My Popup',
                    location: feature,
                    width: 200,
                    height: 250,
                    //	            html: bogusMarkup,
                    maximizable: true,
                    collapsible: true,
                    anchorPosition: 'auto',
                    alwaysOnTop: true,
                    items: [
                        {
                            labelWidth: 30,
                            width: 150,
                            anchor: '100%',
                            //labelAlign: 'right',
                            xtype: 'textfield',
                            fieldLabel: '地名',
                            value: feature.attributes.poiName
                        },
                        {
                            labelWidth: 30,
                            width: 150,
                            anchor: '100%',
                            //labelAlign: 'right',
                            xtype: 'textfield',
                            fieldLabel: '经度',
                            value: feature.attributes.lon
                        },
                        {
                            labelWidth: 30,
                            width: 150,
                            anchor: '100%',
                            //labelAlign: 'right',
                            xtype: 'textfield',
                            fieldLabel: '纬度',
                            value: feature.attributes.lat
                        },
                        {
                            labelWidth: 30,
                            width: 150,
                            anchor: '100%',
                            //labelAlign: 'right',
                            xtype: 'textfield',
                            fieldLabel: '详情',
                            value: feature.attributes.description
                        },
                        {
                            labelWidth: 30,
                            width: 150,
                            anchor: '100%',
                            //labelAlign: 'right',
                            xtype: 'textfield',
                            fieldLabel: 'Cdom',
                            value: feature.attributes.Cdom
                        },
                        {
                            labelWidth: 30,
                            width: 150,
                            anchor: '100%',
                            //labelAlign: 'right',
                            xtype: 'textfield',
                            fieldLabel: 'Chl',
                            value: feature.attributes.Chl
                        },
                        {
                            labelWidth: 30,
                            width: 150,
                            anchor: '100%',
                            //labelAlign: 'right',
                            xtype: 'textfield',
                            fieldLabel: 'Cyan',
                            value: feature.attributes.Cyan
                        }
                    ]
                }, constrainOpts);

                popup = Ext.create('GeoExt.window.Popup', popupOpts);
                // unselect feature when the popup is closed
                popup.on({
                    close: function () {
                        if (OpenLayers.Util.indexOf(LayerPopup.selectedFeatures,
                            this.feature) > -1) {
                            selectCtrl.unselect(this.feature);
                        }
                    }
                });
                popup.show();
            }

            // create popup on "featureselected"
            LayerPopup.events.on({
                featureselected: function (e) {
                    createPopup(e.feature);
                }
            });
            map.addLayers([LayerPopup]);
            map.addControl(selectCtrl);
            selectCtrl.activate();
	    //===============end:popup窗体===============//



            //===============begin:界面布局===============//
            var viewport = Ext.create('Ext.Viewport', {
                id: 'border-example',
                layout: 'border', //border
                items: [
                    //北
                    {
                        region: 'north',
                        xtype: 'panel',
                        height: 70,
                        margins: '0 0 5 0',
                        dockedItems: [
                            {
                                height: 70,
                                xtype: 'toolbar',
                                style: { background: 'url(./resources/images/banner.jpg)  left' },
                                items: ['->',
                                    {
                                        xtype: 'button',
                                        text: 'BaiduAPI',
                                        scale: 'medium',
                                        iconAlign: 'top',
                                        iconCls: 'RegisterButton',
                                        handler: function () {
                                            window.location.href = "/indexBaidu.aspx";
                                        }
                                    }
                                ]
                            }
                        ]
                    },
                    //西
                    {
                        region: 'west',
                        stateId: 'navigation-panel',
                        id: 'west-panel', // see Ext.getCmp() below
                        title: '工具',
                        split: true,
                        width: 200,
                        minWidth: 175,
                        maxWidth: 400,
                        collapsible: true,
                        animCollapse: true,
                        margins: '0 0 0 5',
                        layout: 'accordion',
                        items: [
                            Ext.create('GeoExt.tree.Panel', {
                                border: true,
                                title: "图层列表",
                                iconCls: 'layerlist', // see the HEAD section for style used
                                width: 250,
                                split: true,
                                collapsible: true,
                                autoScroll: true,
                                store: layertreestore,
                                rootVisible: true,
                                lines: true
                            }),
                            {
                                contentEl: 'west',
                                title: 'Navigation',
                                iconCls: 'nav' // see the HEAD section for style used
                            },
                            {
                                title: 'Settings',
                                html: '<p>Some settings in here.<a href="http://www.baidu.com/">百度网站</a> </p>',
                                iconCls: 'settings'
                            },
                            {
                                title: 'Information',
                                html: '<p>Some info in here.</p>',
                                iconCls: 'info'
                            }
                        ]
                    },
                    //东
                    {
                        xtype: 'tabpanel',
                        region: 'east',
                        title: '查询',
                        animCollapse: true,
                        collapsible: true,
                        split: true,
                        width: 225, // give east and west regions a width
                        minSize: 175,
                        maxSize: 400,
                        margins: '0 5 0 0',
                        activeTab: 0,
                        tabPosition: 'bottom',
                        dockedItems: [{
                            dock: 'top',
                            xtype: 'toolbar',
                            items: [
                                {
                                    labelWidth: 30,
                                    width: 150,
                                    anchor: '100%',
                                    //labelAlign: 'right',
                                    xtype: 'textfield',
                                    fieldLabel: '地名',
                                    emptyText: '杭州大厦',
                                    id: 'LocationText'
                                }, "->",
                                {
                                    xtype: 'button',
                                    text: '查询',
                                    tooltip: '查询按钮',
                                    handler: function () {
                                        findLocation(); //查询结果更新pointsStore
                                    }
                                }]
                        }],
                        items: [
                            Ext.create('Ext.grid.Panel', {
                                title: '查询结果',
                                id: 'pointlist',
                                store: pointsStore,
                                columns: [
                                    {
                                        width: 40, resizable: false, hideable: false, sortable: false, menuDisabled: true,
                                        renderer: function (value, metaData, record, rowIndex, colIndex, store) {
                                            return '<image style="width:16px;height:16px;" src="./resources/images/address.png" />';
                                        }
                                    },
                                    {
                                        text: '地名', menuDisabled: true, dataIndex: 'poiName', flex: 1
                                    },
                                    {
                                        xtype: 'actioncolumn',
                                        menuDisabled: true,
                                        text: '定位',
                                        width: 50,
                                        items: [{
                                            icon: './resources/images/location.png',
                                            tooltip: '地图定位',
                                            handler: function (grid, rowIndex, colIndex) {
                                                marker_layer.clearMarkers();
                                                var x = grid.store.getAt(rowIndex).raw["lon"];
                                                var y = grid.store.getAt(rowIndex).raw["lat"];
                                                var lonlat = new OpenLayers.LonLat(x, y);
                                                var marker = new OpenLayers.Marker(lonlat,
                                                    marker_starticon);
                                                marker_layer.addMarker(marker);
                                                map.zoomTo(13);
                                                map.panTo(lonlat);
                                            }
                                        }]
                                    }
                                ]
                            }),
                            Ext.create('Ext.grid.PropertyGrid', {
                                title: 'Property Grid',
                                closable: true,
                                source: {
                                    "(name)": "Properties Grid",
                                    "grouping": false,
                                    "autoFitColumns": true,
                                    "productionQuality": false,
                                    "created": Ext.Date.parse('10/15/2006', 'm/d/Y'),
                                    "tested": false,
                                    "version": 0.01,
                                    "borderWidth": 1
                                }
                            })]
                    },
                    //中
                    mapPanel = Ext.create('GeoExt.panel.Map', {
                        region: 'center',
                        title: '地图',
                        map: map,
                        center: '120,30',
                        zoom: 5,
                        stateful: true,
                        stateId: 'mappanel',
                        dockedItems: [
                            {
                                xtype: 'toolbar',
                                dock: 'top',
                                items: [
                                    {
                                        text: '当前地图中心',
                                        handler: function () {
                                            var c = GeoExt.panel.Map.guess().map.getCenter();
                                            Ext.Msg.alert(this.getText(), c.toString());
                                        }
                                    },
                                    {
                                        text: '全图',
                                        handler: function () {
                                            map.zoomToMaxExtent();
                                        }
                                    },
                                    {
                                        text: '定位到杭州',
                                        handler: function () {
                                            var lonlat = new OpenLayers.LonLat(120.16, 30.29);
                                            map.zoomTo(10);
                                            map.panTo(lonlat);
                                        }
                                    },
                                    "-",
                                    {
                                        text: '折线图',
                                        handler: function () {
                                            searchChart();
                                        }
                                    },
                                    {
                                        text: '轨迹回放',
                                        handler: function () {
                                            startReplay();
                                        }
                                    },
                                    {
                                        xtype: 'label',
                                        text: '动画'
                                    },
                                    Ext.create('Ext.slider.Single', {
                                        //renderTo: 'custom-slider',  //注意：渲染到dockitem toolbar上，custom-slider样式设置无效
                                        hideLabel: true,
                                        width: 100,
                                        increment: 1, //此处必须为1，否则slider滑条不动？
                                        minValue: 0,
                                        maxValue: 100,
                                        id: 'animSlider'
                                    }),
                                    {
                                        text: '播放',
                                        enableToggle: true,
                                        listeners: {
                                            toggle: function (sender, checked) {
                                                if (checked == true) {
                                                    map.setCenter(new OpenLayers.LonLat(-80, 40), 2);
                                                    animateAction(true);
                                                }
                                                else {
                                                    animateAction(false);
                                                }
                                            }
                                        }
                                    },
                                ]
                            }
                        ]
                    }),
                ]
            });
            //===============end:界面布局===============//
        });
    </script>
</head>
<body>
    <!-- use class="x-hide-display" to prevent a brief flicker of the content -->
    <div id="west" class="x-hide-display">
        <p>Hi. I'm the west panel.</p>
    </div>
    <div id="center1" class="x-hide-display">
        <p>Hi. I'm the openlayer map panel.</p>
    </div>
    <div id="center2" class="x-hide-display">
        <p><b>Done reading me? Close me by clicking the X in the top right corner.</b></p>
    </div>
    <div id="props-panel" class="x-hide-display" style="width: 200px; height: 200px;
        overflow: hidden;">
    </div>
    <div id="south" class="x-hide-display">
        <p>south - generally for informational stuff, also could be for status bar</p>
    </div>
    <div id="custom-slider"></div>
</body>
</html>
