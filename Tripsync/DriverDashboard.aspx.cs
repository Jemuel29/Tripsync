using System;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tripsync
{
    public partial class DriverDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is logged in and is a driver
                if (Session["UserID"] == null || Session["UserRole"].ToString() != "Driver")
                {
                    Response.Redirect("~/signup.aspx");
                    return;
                }

                LoadDriverStatus();
                LoadRideRequests();
            }
        }

        private void LoadDriverStatus()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["TripsyncConnection"].ConnectionString;
                using (OleDbConnection conn = new OleDbConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT IsAvailable, CurrentLocation FROM Drivers WHERE UserID = ?";
                    using (OleDbCommand cmd = new OleDbCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                        using (OleDbDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                chkAvailable.Checked = Convert.ToBoolean(reader["IsAvailable"]);
                                txtCurrentLocation.Text = reader["CurrentLocation"].ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading driver status: " + ex.Message;
            }
        }

        private void LoadRideRequests()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["TripsyncConnection"].ConnectionString;
                using (OleDbConnection conn = new OleDbConnection(connectionString))
                {
                    conn.Open();
                    string query = @"SELECT r.*, u.FirstName + ' ' + u.LastName as PassengerName 
                                   FROM Rides r 
                                   INNER JOIN Users u ON r.PassengerID = u.UserID 
                                   WHERE r.Status IN ('Requested', 'InProgress') 
                                   ORDER BY r.RequestTime DESC";

                    using (OleDbCommand cmd = new OleDbCommand(query, conn))
                    {
                        using (OleDbDataAdapter adapter = new OleDbDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            gvRideRequests.DataSource = dt;
                            gvRideRequests.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading ride requests: " + ex.Message;
            }
        }

        protected void chkAvailable_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["TripsyncConnection"].ConnectionString;
                using (OleDbConnection conn = new OleDbConnection(connectionString))
                {
                    conn.Open();
                    string query = "UPDATE Drivers SET IsAvailable = ? WHERE UserID = ?";
                    using (OleDbCommand cmd = new OleDbCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@IsAvailable", chkAvailable.Checked);
                        cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error updating availability: " + ex.Message;
            }
        }

        protected void btnUpdateLocation_Click(object sender, EventArgs e)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["TripsyncConnection"].ConnectionString;
                using (OleDbConnection conn = new OleDbConnection(connectionString))
                {
                    conn.Open();
                    string query = "UPDATE Drivers SET CurrentLocation = ? WHERE UserID = ?";
                    using (OleDbCommand cmd = new OleDbCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@CurrentLocation", txtCurrentLocation.Text);
                        cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                        cmd.ExecuteNonQuery();
                    }
                }
                lblMessage.Text = "Location updated successfully.";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error updating location: " + ex.Message;
            }
        }

        protected void gvRideRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int rideId = Convert.ToInt32(e.CommandArgument);
                string newStatus = "";

                switch (e.CommandName)
                {
                    case "AcceptRide":
                        newStatus = "InProgress";
                        break;
                    case "RejectRide":
                        newStatus = "Cancelled";
                        break;
                    case "CompleteRide":
                        newStatus = "Completed";
                        break;
                }

                if (!string.IsNullOrEmpty(newStatus))
                {
                    string connectionString = ConfigurationManager.ConnectionStrings["TripsyncConnection"].ConnectionString;
                    using (OleDbConnection conn = new OleDbConnection(connectionString))
                    {
                        conn.Open();
                        string query = "UPDATE Rides SET Status = ?, DriverID = ? WHERE RideID = ?";
                        using (OleDbCommand cmd = new OleDbCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@Status", newStatus);
                            cmd.Parameters.AddWithValue("@DriverID", Session["UserID"]);
                            cmd.Parameters.AddWithValue("@RideID", rideId);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    LoadRideRequests();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error processing ride request: " + ex.Message;
            }
        }
    }
} 