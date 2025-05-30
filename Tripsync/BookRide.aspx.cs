using System;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
using System.Web.UI;

namespace Tripsync
{
    public partial class BookRide : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is logged in
                if (Session["UserID"] == null)
                {
                    Response.Redirect("~/signup.aspx");
                }
            }
        }

        protected void btnBookRide_Click(object sender, EventArgs e)
        {
            try
            {
                // Calculate estimated fare and duration (this would typically use a mapping API)
                double estimatedFare = CalculateEstimatedFare();
                int estimatedDuration = CalculateEstimatedDuration();

                // Display ride details
                lblEstimatedFare.Text = $"${estimatedFare:F2}";
                lblEstimatedDuration.Text = $"{estimatedDuration} minutes";
                pnlRideDetails.Visible = true;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error calculating ride details: " + ex.Message;
            }
        }

        protected void btnConfirmRide_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("~/signup.aspx");
                    return;
                }

                string connectionString = ConfigurationManager.ConnectionStrings["TripsyncConnection"].ConnectionString;
                using (OleDbConnection conn = new OleDbConnection(connectionString))
                {
                    conn.Open();

                    // Insert ride request
                    string insertQuery = @"INSERT INTO Rides (PassengerID, PickupLocation, DropoffLocation, 
                                         RequestTime, Status, Fare, Distance, EstimatedDuration) 
                                         VALUES (?, ?, ?, GETDATE(), 'Requested', ?, ?, ?)";

                    using (OleDbCommand cmd = new OleDbCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@PassengerID", Session["UserID"]);
                        cmd.Parameters.AddWithValue("@PickupLocation", txtPickupLocation.Text);
                        cmd.Parameters.AddWithValue("@DropoffLocation", txtDropoffLocation.Text);
                        cmd.Parameters.AddWithValue("@Fare", Convert.ToDouble(lblEstimatedFare.Text.Replace("$", "")));
                        cmd.Parameters.AddWithValue("@Distance", CalculateDistance()); // Implement this method
                        cmd.Parameters.AddWithValue("@EstimatedDuration", Convert.ToInt32(lblEstimatedDuration.Text.Replace(" minutes", "")));

                        cmd.ExecuteNonQuery();
                    }
                }

                // Redirect to ride status page
                Response.Redirect("~/RideStatus.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error booking ride: " + ex.Message;
            }
        }

        private double CalculateEstimatedFare()
        {
            // This is a simple calculation. In a real application, you would:
            // 1. Use a mapping API to get the actual distance
            // 2. Apply your fare calculation rules
            // 3. Consider time of day, surge pricing, etc.
            return 25.00; // Placeholder
        }

        private int CalculateEstimatedDuration()
        {
            // This is a placeholder. In a real application, you would:
            // 1. Use a mapping API to get the actual duration
            // 2. Consider traffic conditions
            return 30; // Placeholder
        }

        private double CalculateDistance()
        {
            // This is a placeholder. In a real application, you would:
            // 1. Use a mapping API to get the actual distance
            return 10.0; // Placeholder
        }
    }
} 