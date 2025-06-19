using System;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tripsync
{
    public partial class FindRides : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadRides();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadRides();
        }

        private void LoadRides()
        {
            string connStr = ConfigurationManager.ConnectionStrings["TripsyncConnection"].ConnectionString;
            string query = "SELECT * FROM Rider WHERE 1=1";
            var cmd = new OleDbCommand();

            // Add filters if provided
            if (!string.IsNullOrWhiteSpace(txtPickup.Text))
            {
                query += " AND PickupLocation LIKE ?";
                cmd.Parameters.AddWithValue("PickupLocation", "%" + txtPickup.Text.Trim() + "%");
            }
            if (!string.IsNullOrWhiteSpace(txtDestination.Text))
            {
                query += " AND Destination LIKE ?";
                cmd.Parameters.AddWithValue("Destination", "%" + txtDestination.Text.Trim() + "%");
            }
            if (!string.IsNullOrWhiteSpace(txtDate.Text))
            {
                DateTime dt;
                if (DateTime.TryParse(txtDate.Text, out dt))
                {
                    query += " AND DepartureDate = ?";
                    cmd.Parameters.AddWithValue("DepartureDate", dt.Date);
                }
            }

            cmd.CommandText = query;

            using (OleDbConnection conn = new OleDbConnection(connStr))
            {
                cmd.Connection = conn;
                using (OleDbDataAdapter da = new OleDbDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptRides.DataSource = dt;
                    rptRides.DataBind();
                }
            }
        }

        protected void btnBookRide_Click(object sender, EventArgs e)
        {
            // 1. Get RideId from CommandArgument
            Button btn = (Button)sender;
            string rideId = btn.CommandArgument;

            // 2. Get current user ID
            string userId = Session["UserId"]?.ToString();
            if (string.IsNullOrEmpty(userId))
            {
                Response.Redirect("signup.aspx?returnUrl=FindRides.aspx");
                return;
            }

            // --- INSERT THIS BLOCK: Check for existing booking ---
            string connStr = ConfigurationManager.ConnectionStrings["TripsyncConnection"].ConnectionString;
            string checkQuery = "SELECT COUNT(*) FROM Bookings WHERE UserId = ?";
            using (OleDbConnection conn = new OleDbConnection(connStr))
            using (OleDbCommand cmd = new OleDbCommand(checkQuery, conn))
            {
                cmd.Parameters.AddWithValue("UserId", int.Parse(userId));
                conn.Open();
                int bookingCount = (int)cmd.ExecuteScalar();
                if (bookingCount > 0)
                {
                    lblMessage.Text = "You already have a booking. Cancel it before booking another ride.";
                    lblMessage.CssClass = "text-danger";
                    return;
                }
            }
            // --- END OF BLOCK ---

            // 3. Insert booking into Bookings table
            string insertQuery = "INSERT INTO Bookings (RideId, UserId, BookingDate) VALUES (?, ?, ?)";
            using (OleDbConnection conn = new OleDbConnection(connStr))
            using (OleDbCommand cmd = new OleDbCommand(insertQuery, conn))
            {
                cmd.Parameters.AddWithValue("RideId", int.Parse(rideId));
                cmd.Parameters.AddWithValue("UserId", int.Parse(userId));
                cmd.Parameters.AddWithValue("BookingDate", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            // 4. Redirect to MyBookings.aspx
            Response.Redirect("MyBookings.aspx");
        }
    }
}