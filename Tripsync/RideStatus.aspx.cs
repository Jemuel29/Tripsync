using System;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
using System.Web.UI;

namespace Tripsync
{
    public partial class RideStatus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("~/signup.aspx");
                    return;
                }

                LoadRideDetails();
            }
        }

        private void LoadRideDetails()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["TripsyncConnection"].ConnectionString;
                using (OleDbConnection conn = new OleDbConnection(connectionString))
                {
                    conn.Open();
                    string query = @"SELECT r.*, d.VehicleModel, d.VehicleNumber, d.Rating as DriverRating,
                                   u.FirstName + ' ' + u.LastName as DriverName
                                   FROM Rides r
                                   LEFT JOIN Drivers d ON r.DriverID = d.UserID
                                   LEFT JOIN Users u ON d.UserID = u.UserID
                                   WHERE r.PassengerID = ? AND r.Status != 'Cancelled'
                                   ORDER BY r.RequestTime DESC";

                    using (OleDbCommand cmd = new OleDbCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@PassengerID", Session["UserID"]);
                        using (OleDbDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Display ride details
                                lblPickupLocation.Text = reader["PickupLocation"].ToString();
                                lblDropoffLocation.Text = reader["DropoffLocation"].ToString();
                                lblRequestTime.Text = Convert.ToDateTime(reader["RequestTime"]).ToString("g");
                                lblEstimatedFare.Text = Convert.ToDecimal(reader["Fare"]).ToString("C");
                                lblEstimatedDuration.Text = reader["EstimatedDuration"].ToString() + " minutes";
                                lblStatus.Text = reader["Status"].ToString();

                                // Update status timeline
                                UpdateStatusTimeline(reader["Status"].ToString());

                                // Show/hide driver info
                                if (!string.IsNullOrEmpty(reader["DriverID"].ToString()))
                                {
                                    pnlDriverInfo.Visible = true;
                                    lblDriverName.Text = reader["DriverName"].ToString();
                                    lblVehicleModel.Text = reader["VehicleModel"].ToString();
                                    lblVehicleNumber.Text = reader["VehicleNumber"].ToString();
                                    lblDriverRating.Text = reader["DriverRating"].ToString();
                                }

                                // Show/hide action buttons
                                btnCancelRide.Visible = reader["Status"].ToString() == "Requested";
                                btnRateRide.Visible = reader["Status"].ToString() == "Completed";
                            }
                            else
                            {
                                lblMessage.Text = "No active ride found.";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading ride details: " + ex.Message;
            }
        }

        private void UpdateStatusTimeline(string currentStatus)
        {
            // Reset all steps
            stepRequested.Attributes["class"] = "status-step";
            stepAccepted.Attributes["class"] = "status-step";
            stepInProgress.Attributes["class"] = "status-step";
            stepCompleted.Attributes["class"] = "status-step";

            // Update active and completed steps
            switch (currentStatus)
            {
                case "Requested":
                    stepRequested.Attributes["class"] = "status-step active";
                    break;
                case "Accepted":
                    stepRequested.Attributes["class"] = "status-step completed";
                    stepAccepted.Attributes["class"] = "status-step active";
                    break;
                case "InProgress":
                    stepRequested.Attributes["class"] = "status-step completed";
                    stepAccepted.Attributes["class"] = "status-step completed";
                    stepInProgress.Attributes["class"] = "status-step active";
                    break;
                case "Completed":
                    stepRequested.Attributes["class"] = "status-step completed";
                    stepAccepted.Attributes["class"] = "status-step completed";
                    stepInProgress.Attributes["class"] = "status-step completed";
                    stepCompleted.Attributes["class"] = "status-step active";
                    break;
            }
        }

        protected void btnCancelRide_Click(object sender, EventArgs e)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["TripsyncConnection"].ConnectionString;
                using (OleDbConnection conn = new OleDbConnection(connectionString))
                {
                    conn.Open();
                    string query = "UPDATE Rides SET Status = 'Cancelled' WHERE PassengerID = ? AND Status = 'Requested'";
                    using (OleDbCommand cmd = new OleDbCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@PassengerID", Session["UserID"]);
                        cmd.ExecuteNonQuery();
                    }
                }

                Response.Redirect("~/Home.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error cancelling ride: " + ex.Message;
            }
        }

        protected void btnRateRide_Click(object sender, EventArgs e)
        {
            // Redirect to rating page
            Response.Redirect("~/RateRide.aspx");
        }
    }
} 