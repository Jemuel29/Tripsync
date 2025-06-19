using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tripsync
{
    public partial class universities : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void FindRides_Click(object sender, EventArgs e)
        {
            Response.Redirect("FindRides.aspx");
        }
    }
}