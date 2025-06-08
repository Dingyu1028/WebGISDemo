using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Web.Configuration;
using System.Data;
using System.Data.OleDb;

namespace WebGIS2025
{
    /// <summary>
    /// register 的摘要说明
    /// </summary>
    public class register : IHttpHandler
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
            string r_username_back = 
                context.Request.QueryString["r_username_front"];
            string r_password_back =
                context.Request.QueryString["r_password_front"];
            string r_name_back =
                context.Request.QueryString["r_name_front"];
            string r_company_back =
                context.Request.QueryString["r_company_front"];
            string r_email_back =
                context.Request.QueryString["r_email_front"];
            string r_birthday_back =
                context.Request.QueryString["r_birthday_front"];

            try 
            {
                //操作数据库，执行插入操作
                //2、创建数据库连接对象
                OleDbConnection conn =
                    new OleDbConnection(connStr);
                //3、打开数据库
                conn.Open();
                //4、创建SQL命令字符串
                string strSQL = "insert into users ([username],[password],[pname],[company],[email],[birthday]) values('"
                    + r_username_back + "','"
                    + r_password_back + "','"
                    + r_name_back + "','"
                    + r_company_back + "','"
                    + r_email_back + "','"
                    + r_birthday_back + "')";
                //5、执行SQL命令
                OleDbCommand cmd =
                    new OleDbCommand(strSQL, conn);
                cmd.ExecuteNonQuery();
                //6、关闭数据库
                conn.Close();

                //将插入操作结果返回前端
                context.Response.Write("ok");
                //context.Response.Write(r_username_back);
            }
            catch(Exception exce)
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