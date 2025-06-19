using System;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Web.UI.WebControls;

namespace Tripsync
{
    public partial class MyBookings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadBookings();
        }

        private void LoadBookings()
        {
            string userId = Session["UserId"]?.ToString();
            if (string.IsNullOrEmpty(userId))
                return;

            string connStr = ConfigurationManager.ConnectionStrings["TripsyncConnection"].ConnectionString;
            string query = @"SELECT b.BookingId, b.BookingDate, b.Status, b.RideId,
                            r.PickupLocation, r.Destination, r.DepartureDate, r.DepartureTime
                     FROM Bookings b
                     INNER JOIN Rider r ON b.RideId = r.RideId
                     WHERE b.UserId = ?";
            using (OleDbConnection conn = new OleDbConnection(connStr))
            using (OleDbCommand cmd = new OleDbCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("UserId", userId);
                using (OleDbDataAdapter da = new OleDbDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptBookings.DataSource = dt;
                    rptBookings.DataBind();
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            try
            {
                Button btn = (Button)sender;
                string bookingId = btn.CommandArgument;

                string connStr = ConfigurationManager.ConnectionStrings["TripsyncConnection"].ConnectionString;
                string deleteQuery = "DELETE FROM Bookings WHERE BookingId = ?";
                using (OleDbConnection conn = new OleDbConnection(connStr))
                using (OleDbCommand cmd = new OleDbCommand(deleteQuery, conn))
                {
                    cmd.Parameters.AddWithValue("BookingId", bookingId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMessage.Text = "Booking cancelled successfully.";
                lblMessage.CssClass = "text-success";
            }
            catch
            {
                lblMessage.Text = "An error occurred. Please try again.";
                lblMessage.CssClass = "text-danger";
            }

            LoadBookings();
        }
    }
}