using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tripsync
{
    public partial class Offer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnPostRide_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["TripsyncConnection"].ConnectionString;

            using (OleDbConnection conn = new OleDbConnection(connStr))
            {
                string sql = @"INSERT INTO Rider 
                    (PickupLocation, Destination, DepartureDate, DepartureTime, VehicleType, AvailableSeats, PricePerSeat, Notes)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

                using (OleDbCommand cmd = new OleDbCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("PickupLocation", txtPickup.Text.Trim());
                    cmd.Parameters.AddWithValue("Destination", txtDestination.Text.Trim());
                    cmd.Parameters.AddWithValue("DepartureDate", txtDate.Text);
                    cmd.Parameters.AddWithValue("DepartureTime", txtTime.Text);
                    cmd.Parameters.AddWithValue("VehicleType", rblVehicleType.SelectedValue);
                    cmd.Parameters.AddWithValue("AvailableSeats", txtSeats.Text);
                    cmd.Parameters.AddWithValue("PricePerSeat", txtPrice.Text);
                    cmd.Parameters.AddWithValue("Notes", txtNotes.Text.Trim());
                    

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // Optionally, show a success message or redirect
            Session["SuccessMessage"] = "Ride posted successfully!";
            Response.Redirect("Home.aspx");
        }
    }
}
