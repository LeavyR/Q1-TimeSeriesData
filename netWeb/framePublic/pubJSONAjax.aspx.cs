using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace netWeb.framePublic
{
    public partial class pubJSONAjax : System.Web.UI.Page
    {
        jsresult jr = new jsresult();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadData();

            }
        }
        /// <summary>
        /// 时间戳转为C#格式时间
        /// </summary>
        /// <param name="timeStamp">Unix时间戳格式</param>
        /// <returns>C#格式时间</returns>
        private  DateTime GetTime(string timeStamp)
        {
            DateTime dtStart = TimeZone.CurrentTimeZone.ToLocalTime(new DateTime(1970, 1, 1));

            long lTime = long.Parse(timeStamp + "0000000");
            TimeSpan toNow = new TimeSpan(lTime);
            return dtStart.Add(toNow);
        }
        private void loadData()
        {
            try
            {
                jr.myData.Clear();
                DataTable dt = CSVFileHelper.csv.OpenCSV();
                foreach (DataRow dr in dt.Rows)
                {
                    try
                    {
                        TimeSeriesData td = new TimeSeriesData();
                        td.time = GetTime(dr[0].ToString()).ToString("yyyy-MM-dd HH:mm:ss:ffff");
                        td.sourceTime = dr[0];
                        td.values = dr[1];
                        jr.myData.Add(td);
                    }
                    catch
                    {
                        continue;
                    }

                }
                jr.success = true;
                WriteResult(this, jr);
            }
            catch
            {

            }
        }
        /// <summary>
        /// json数据处理
        /// </summary>
        /// <param name="AObjPage"></param>
        /// <param name="objResult"></param>
        private static void WriteResult(Page AObjPage, object objResult)
        {
            System.IO.StringWriter sw = new System.IO.StringWriter();
            JsonTextWriter jw = new JsonTextWriter(sw);
            JsonSerializer ss = new JsonSerializer();
            ss.Serialize(jw, objResult);

            AObjPage.Response.Write(sw.ToString());

        }
        /// <summary>
        /// 数据传输实体类
        /// </summary>
        public class jsresult
        {
            public bool success = true;
            public ArrayList myData = new ArrayList();
        }
        /// <summary>
        /// 数据实体类
        /// </summary>
        public class TimeSeriesData
        {
            public object time;
            public object sourceTime;
            public object values;
        }
    }
}