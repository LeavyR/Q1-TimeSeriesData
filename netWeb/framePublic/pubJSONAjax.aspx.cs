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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadData();

            }
        }
        private void loadData()
        {
            try
            {
                ArrayList tsd = new ArrayList();
                DataTable dt = CSVFileHelper.csv.OpenCSV();
                foreach (DataRow dr in dt.Rows)
                {
                    try
                    {
                        TimeSeriesData td = new TimeSeriesData();
                        td.time =dr[0];
                        td.values = dr[1];
                        tsd.Add(td);
                    }
                    catch
                    {
                        continue;
                    }

                }
                WriteResult(this, tsd);
            }
            catch
            {

            }
        }
        private static void WriteResult(Page AObjPage, object objResult)
        {
            System.IO.StringWriter sw = new System.IO.StringWriter();
            JsonTextWriter jw = new JsonTextWriter(sw);
            JsonSerializer ss = new JsonSerializer();
            ss.Serialize(jw, objResult);

            AObjPage.Response.Write(sw.ToString());

        }
        public class TimeSeriesData
        {
            public object time;
            public object values;
        }
    }
}