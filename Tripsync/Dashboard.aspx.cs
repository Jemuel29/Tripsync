using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tripsync
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null || Session["Role"] == null)
            {
                Response.Redirect("signup.aspx");
                return;
            }

            lblDashboardUsername.Text = Session["Username"].ToString();
            lblDashboardRole.Text = Session["Role"].ToString();

            string role = Session["Role"].ToString().ToLower();
            pnlPassenger.Visible = (role == "passenger");
            pnlDriver.Visible = (role == "driver");
            pnlAdmin.Visible = (role == "admin");
        }
    }
}