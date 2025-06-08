using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using System.Web.Configuration;

using System.Data;
using System.Data.OleDb;

using System.Text;



namespace WebGIS2025
{
    /// <summary>
    /// location 的摘要说明
    /// </summary>
    public class location : IHttpHandler
    {
        public static readonly string connStr =
            WebConfigurationManager.ConnectionStrings["AccessConnectionString"].ConnectionString + HttpContext.Current.Server.MapPath(WebConfigurationManager.ConnectionStrings["Access_Path"].ConnectionString);

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Cache.SetNoStore();

            string LocationText = context.Request.
                QueryString["LocationText"];
            StringBuilder sb = new StringBuilder("[");
            string tpl = "\"poiName\":'{0}',\"lon\":{1},\"lat\":{2}";

            OleDbConnection conn = new OleDbConnection(connStr);
            try
            {
                //连接access数据库
                conn.Open();
                string sql =
                    "select * from POI where poiName like '%"
                    + LocationText + "%'";
                OleDbDataAdapter myadapter = new OleDbDataAdapter(sql, conn);
                DataSet ds = new DataSet();
                myadapter.Fill(ds, "points");
                conn.Close();

                //
                foreach (DataRow dr in ds.Tables["points"].Rows)
                {
                    //string poiName = dr["poiName"].ToString();
                    //string lon = dr["lon"].ToString();
                    //string lat = dr["lat"].ToString();

                    sb.Append("{" +
                        string.Format(tpl, dr["poiName"],
                        dr["lon"], dr["lat"]) + "},");
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