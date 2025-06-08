<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="WebGIS2025.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <!--引用extjs库 -->
    <script type="text/javascript" src="lib/ext-4.2.1.883/bootstrap.js"></script>
    <script type="text/javascript" src="lib/ext-4.2.1.883/locale/ext-lang-zh_CN.js"></script>
    <link rel="stylesheet" type="text/css" href="lib/ext-4.2.1.883/resources/css/ext-all-neptune.css"/>
    <style type="text/css">
        #div1 {
            position: absolute;
            width: 400px;
            height: 320px;
            left: 50%;
            top:50%;
            margin-left:-200px;
            margin-top:-200px;
        }
        #div2 {
            position: fixed;
            width: 1366px;
            height: 768px;
            background-image: url(./resources/images/background2.png);
        }
    </style>

    <script type="text/javascript">
        Ext.require(['*']);
        Ext.onReady(function () {
            Ext.QuickTips.init();

            function CheckLogin() {
                console.log("执行CheckLogin函数");
                //获取用户输入的信息
                var l_username_front =
                    Ext.getCmp("l_username_control").getValue();
                var l_password_front =
                    Ext.getCmp("l_password_control").getValue();

                //判断用户名密码是否为空
                if (l_username_front == "" || l_password_front == "") {
                    Ext.Msg.alert("提示", "用户名或密码不能为空");
                    return;
                }

                //发送请求到后台
                Ext.Ajax.request({
                    url: "checklogin.ashx?l_username_front=" + l_username_front
                        + "&l_password_front=" + l_password_front,
                    method: 'get',
                    success: function (response) {
                        console.log("请求成功！");
                        var getData = response.responseText;
                        if (getData == "ok") {
                            Ext.Msg.alert("提示", "登录成功！");
                            window.location.href =
                                "/index.aspx?username=" + l_username_front; //登录成功了
                        }
                        else {
                            Ext.Msg.alert("提示", "登录失败！" + getData);
                        }
                    },
                    failure: function (response, options) {
                        console.log("请求失败！");
                        Ext.Msg.alert("提示", "请求失败！");
                    }
                });
                console.log("已发送Ajax请求");
            }


            function Register() {
                console.log("执行Register函数");
                //获取用户输入的信息
                var r_username_front =
                    Ext.getCmp("r_username_control").getValue();
                var r_password_front =
                    Ext.getCmp("r_password_control").getValue();
                var r_password_front2 =
                    Ext.getCmp("r_password_control2").getValue();

                var r_name_front =
                    Ext.getCmp("r_name_control").getValue();
                var r_company_front =
                    Ext.getCmp("r_company_control").getValue();
                var r_email_front =
                    Ext.getCmp("r_email_control").getValue();
                var r_birthday_front =
                    Ext.getCmp("r_birthday_control").getValue();
                //判断用户名密码是否为空
                if (r_username_front == "" || r_password_front == "" ||
                    r_password_front2 == "") {
                    Ext.Msg.alert("提示", "用户名或密码不能为空");
                    return;
                }
                if (r_password_front != r_password_front2) {
                    Ext.Msg.alert("提示", "两次密码输入不匹配");
                    return;
                }

                //发送请求到后台
                Ext.Ajax.request({
                    url: "register.ashx?r_username_front=" + r_username_front
                        + "&r_password_front=" + r_password_front
                        + "&r_name_front=" + r_name_front
                        + "&r_company_front=" + r_company_front
                        + "&r_email_front=" + r_email_front
                        + "&r_birthday_front=" + r_birthday_front,
                    method: 'get',
                    success: function (response) {
                        console.log("请求成功！");
                        var getData = response.responseText;
                        if (getData == "ok") {
                            Ext.Msg.alert("提示", "注册成功！");
                        }
                        else {
                            Ext.Msg.alert("提示", "注册失败！" + getData);
                        }
                        registerForm.close();
                        registerForm = null;
                    },
                    failure: function (response, options) {
                        console.log("请求失败！");
                        Ext.Msg.alert("提示", "请求失败！");
                        registerForm.close();
                        registerForm = null;
                    }
                });
                console.log("已发送Ajax请求");
            }

            //UI界面
            var registerForm = null;
            var form = Ext.create("Ext.form.Panel", {
                id: 'loginForm',
                renderTo: Ext.get("div1"),
                width: 320,
                frame: true,
                bodyPadding: 10,
                title: "WebGIS Demo示例程序",
                autoScroll: true,
                defaultType: 'textfield',
                defaults: { anchor: '100%'},
                items: [
                    {
                        fieldLabel: '用户名',
                        allowBlank: false,
                        emptyText: "user id",
                        id: 'l_username_control'
                    },
                    {
                        fieldLabel: '密码',
                        allowBlank: false,
                        emptyText: "password",
                        id: 'l_password_control',
                        inputType: 'password'
                    },
                    {
                        xtype: 'checkbox',
                        fieldLabel: '记住我'
                    }
                ],
                buttons: [
                    {
                        text: '登录',
                        handler: CheckLogin
                    },
                    {
                        text: '注册',
                        handler: function () {
                            //创建注册弹框
                            if (registerForm == null) {
                                registerForm = Ext.create("Ext.window.Window", {
                                    title: '注册窗体',
                                    width: 355,
                                    defaultType: 'textfield',
                                    frame: true,
                                    bodyPadding: 10,
                                    //autoScroll: true,
                                    closable: false,
                                    items: [
                                        {
                                            xtype: 'fieldset',
                                            title: '用户信息',
                                            defaultType: 'textfield',
                                            defaults: { anchor: '100 %'},
                                            fieldDefaults: {
                                                labelAlign: 'right',
                                                labelWidth: 115,
                                                msgTarget: 'side'
                                            },
                                            items: [
                                                {
                                                    allowBlank: false,
                                                    fieldLabel: '用户名',
                                                    id:'r_username_control'
                                                },
                                                {
                                                    allowBlank: false,
                                                    fieldLabel: '密码',
                                                    id: 'r_password_control',
                                                    inputType: 'password'
                                                },
                                                {
                                                    allowBlank: false,
                                                    fieldLabel: '再次输入密码',
                                                    id: 'r_password_control2',
                                                    inputType: 'password'
                                                }
                                            ]
                                        },
                                        {
                                            xtype: 'fieldset',
                                            title: '联系信息',
                                            defaultType: 'textfield',
                                            defaults: { anchor: '100%' },
                                            fieldDefaults: {
                                                labelAlign: 'right',
                                                labelWidth: 115,
                                                msgTarget: 'side'
                                            },
                                            items: [
                                                {
                                                    fieldLabel: '姓名',
                                                    id:'r_name_control'
                                                },
                                                {
                                                    fieldLabel: '公司',
                                                    id: 'r_company_control'
                                                },
                                                {
                                                    fieldLabel: 'Email',
                                                    id: 'r_email_control',
                                                    vtype: 'email'
                                                },
                                                {
                                                    xtype: 'datefield',
                                                    fieldLabel: '生日',
                                                    id: 'r_birthday_control',
                                                    allowBlank: false,
                                                    maxValue: new Date()
                                                }
                                            ]
                                        }
                                    ],
                                    buttons: [
                                        {
                                            text: '确定',
                                            //handler:Register()//不能直接这样调用，会导致先执行Register函数，而界面尚未创建
                                            handler: function() {
                                                Register()
                                            }
                                        },
                                        {
                                            text: '取消',
                                            handler: function () {
                                                registerForm.close();
                                                registerForm = null;
                                            }
                                        }
                                    ]
                                }).show();
                            }
                        }
                    }
                ]
            });            
        });
    </script>
</head>
<body>
 <div id="div2">
     <div id="div1" align="center">

     </div>
 </div>
</body>
</html>
