using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using System.Web.Configuration;

using System.Data;
using System.Data.OleDb;
namespace WebGIS2025
{
    /// <summary>
    /// checklogin 的摘要说明
    /// </summary>
    public class checklogin : IHttpHandler, IRequiresSessionState
    {
        //1、构造数据库连接字符串
        public static readonly string connStr =
            WebConfigurationManager.ConnectionStrings
            ["AccessConnectionString"].ConnectionString +
            HttpContext.Current.Server.MapPath(
                WebConfigurationManager.ConnectionStrings
            ["Access_Path"].ConnectionString);

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //解析前端发过来的请求字符串
            string l_username_back =
                context.Request.QueryString["l_username_front"];
            string l_password_back =
                context.Request.QueryString["l_password_front"];

            try
            {
                //操作数据库，执行插入操作
                //2、创建数据库连接对象
                OleDbConnection conn =
                    new OleDbConnection(connStr);
                //3、打开数据库
                conn.Open();
                //4、创建SQL命令字符串
                string strSQL = "select * from users";
                //5、执行SQL命令
                OleDbDataAdapter myadapter =
                    new OleDbDataAdapter(strSQL, conn);
                DataSet ds = new DataSet();
                myadapter.Fill(ds, "ds_users");
                //6、关闭数据库
                conn.Close();
                //7、校验登录用户名和密码是否存在
                foreach (DataRow dr in ds.Tables["ds_users"].Rows)
                {
                    if (l_username_back != dr["username"].ToString())
                    {
                        continue;
                    }
                    else
                    {
                        if (l_password_back != dr["password"].ToString())
                        {
                            continue;
                        }
                        else
                        {
                            context.Response.Write("ok"); //如果验证成功则返回ok

                            //记录用户登录信息
                            context.Session["IsLogin"] = "true";
                            context.Session["currentUser"] = l_username_back;
                            return;
                        }
                    }
                }
            }
            catch (Exception exce)
            {
                //将插入操作报错信息返回前端
                context.Response.Write(exce.Message);
            }
            context.Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}