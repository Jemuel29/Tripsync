using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
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

            if (role == "driver" && !IsPostBack)
            {
                LoadPendingBookings();
            }
            if (role == "passenger" && !IsPostBack)
            {
                LoadMyBookings();
            }
        }

        private void LoadPendingBookings()
        {
            string driverId = Session["UserId"]?.ToString();
            if (string.IsNullOrEmpty(driverId))
                return;

            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["TripsyncConnection"].ConnectionString;
            string query = @"SELECT b.BookingId, b.Status, b.UserId, l.username AS Username, 
                                   r.PickupLocation, r.Destination, r.DepartureDate
                            FROM ((Bookings b
                            INNER JOIN Rider r ON b.RideId = r.RideId)
                            INNER JOIN Login_TBL l ON b.UserId = l.UserId)
                            WHERE r.DriverId = ? AND b.Status = 'Pending'";

            using (OleDbConnection conn = new OleDbConnection(connStr))
            using (OleDbCommand cmd = new OleDbCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("DriverId", driverId);
                using (OleDbDataAdapter da = new OleDbDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptPendingBookings.DataSource = dt;
                    rptPendingBookings.DataBind();
                }
            }
        }

        private void LoadMyBookings()
        {
            string userId = Session["UserId"]?.ToString();
            if (string.IsNullOrEmpty(userId))
                return;

            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["TripsyncConnection"].ConnectionString;
            string query = @"SELECT b.BookingId, b.Status, r.PickupLocation, r.Destination, r.DepartureDate, l.username AS DriverName
                     FROM ((Bookings b
                     INNER JOIN Rider r ON b.RideId = r.RideId)
                     INNER JOIN Login_TBL l ON r.DriverId = l.UserId)
                     WHERE b.UserId = ?";

            using (OleDbConnection conn = new OleDbConnection(connStr))
            using (OleDbCommand cmd = new OleDbCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("UserId", userId);
                using (OleDbDataAdapter da = new OleDbDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptMyBookings.DataSource = dt;
                    rptMyBookings.DataBind();
                }
            }
        }

        protected void btnAccept_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string bookingId = btn.CommandArgument;
            UpdateBookingStatus(bookingId, "Accepted");
        }

        protected void btnReject_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string bookingId = btn.CommandArgument;
            UpdateBookingStatus(bookingId, "Rejected");
        }

        private void UpdateBookingStatus(string bookingId, string status)
        {
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["TripsyncConnection"].ConnectionString;
            string query = "UPDATE Bookings SET Status = ? WHERE BookingId = ?";
            using (OleDbConnection conn = new OleDbConnection(connStr))
            using (OleDbCommand cmd = new OleDbCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("Status", status);
                cmd.Parameters.AddWithValue("BookingId", bookingId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            lblDriverMessage.Text = $"Booking {status.ToLower()}!";
            LoadPendingBookings();
        }
    }
}