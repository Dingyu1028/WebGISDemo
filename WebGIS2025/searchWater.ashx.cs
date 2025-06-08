using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Web.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Text;

namespace WebGIS2025
{
    /// <summary>
    /// searchWater 的摘要说明
    /// </summary>
    public class searchWater : IHttpHandler
    {
        public static readonly string connStr =
            WebConfigurationManager.ConnectionStrings["AccessConnectionString"].ConnectionString
            + HttpContext.Current.Server.MapPath(WebConfigurationManager.
                ConnectionStrings["Access_Path"].ConnectionString);


        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string method = context.Request.QueryString["method"];
            string queryWater = context.Request.QueryString["queryWater"];
            StringBuilder sb = new StringBuilder("[");
            string tpl = "\"poiName\":'{0}',\"lon\":{1},\"lat\":{2},\"description\":'{3}',\"Cdom\":{4},\"Chl\":{5},\"Cyan\":{6}";

            OleDbConnection conn = new OleDbConnection(connStr);
            try
            {
                //连接access数据库
                conn.Open();
                string sql = "select * from Water";
                if (method != "queryAll")
                {
                    sql = "select * from Water where poiName like '%" + queryWater + "%'";
                }
                OleDbDataAdapter myadapter = new OleDbDataAdapter(sql, conn);
                DataSet ds = new DataSet();
                myadapter.Fill(ds, "points");
                conn.Close();

                foreach (DataRow dr in ds.Tables["points"].Rows)
                {

                    sb.Append("{" +
                        string.Format(tpl, dr["poiName"], dr["lon"], dr["lat"],
                        dr["description"], dr["Cdom"], dr["Chl"], dr["Cyan"]) + "},");
                }

                context.Response.Write(sb.ToString().
                    Substring(0, sb.ToString().Length - 1) + "]");

                //context.Response.Write("ok");
            }
            catch (Exception exe)
            {
                context.Response.Write("fail");//如果验证失败则返回fail 
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