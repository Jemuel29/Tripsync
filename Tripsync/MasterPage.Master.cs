using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tripsync
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UpdateLoginStatus();
            }

            if (Session["Role"] != null)
            {
                lblUserRole.Text = "Role: " + Session["Role"].ToString();
                lblUserRole.Visible = true;

                string role = Session["Role"].ToString().ToLower();
                liFindRides.Visible = (role != "driver");
                liOffer.Visible = (role == "driver");   
            }
            else
            {
                lblUserRole.Visible = false;
                liFindRides.Visible = true; 
                liOffer.Visible = false;   
            }
        }

        private void UpdateLoginStatus()
        {
            if (Session["Username"] != null)
            {
                lblUsername.Text = "Welcome " + Session["Username"].ToString();
                liLogout.Visible = true;
                liLogoutBtn.Visible = true;
                btnLogout.Visible = true;
                liLogin.Visible = false;
                hlDashboard.Visible = true; // Show Dashboard when logged in
            }
            else
            {
                lblUsername.Text = "";
                liLogout.Visible = false;
                liLogoutBtn.Visible = false;
                btnLogout.Visible = false;
                liLogin.Visible = true;
                hlDashboard.Visible = false; // Hide Dashboard when not logged in
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblLoginMessage.Text = "Username and password are required!";
                ScriptManager.RegisterStartupScript(this, GetType(), "OpenLoginModal",
                    "setTimeout(function() { new bootstrap.Modal(document.getElementById('loginModal')).show(); }, 100);", true);
                return;
            }

            string connString = "Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + Server.MapPath("~/App_Data/Tripsync.mdb");

            try
            {
                using (OleDbConnection connection = new OleDbConnection(connString))
                {
                    connection.Open();

                    string query = "SELECT UserId, password, role FROM Login_TBL WHERE username = ?";
                    using (OleDbCommand command = new OleDbCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("?", username);

                        using (OleDbDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string dbPassword = reader["password"].ToString();
                                string dbRole = reader["role"].ToString();
                                string dbUserId = reader["UserId"].ToString();

                                if (dbPassword == password)
                                {
                                    Session["Username"] = username;
                                    Session["Role"] = dbRole;
                                    Session["UserId"] = dbUserId; // <-- Set the user's role in session
                                    UpdateLoginStatus();
                                    Response.Redirect("Home.aspx");
                                }
                                else
                                {
                                    lblLoginMessage.Text = "Invalid username or password.";
                                    ScriptManager.RegisterStartupScript(this, GetType(), "OpenLoginModal",
                                        "setTimeout(function() { new bootstrap.Modal(document.getElementById('loginModal')).show(); }, 100);", true);
                                }
                            }
                            else
                            {
                                lblLoginMessage.Text = "Invalid username or password.";
                                ScriptManager.RegisterStartupScript(this, GetType(), "OpenLoginModal",
                                    "setTimeout(function() { new bootstrap.Modal(document.getElementById('loginModal')).show(); }, 100);", true);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblLoginMessage.Text = "Error: " + ex.Message;
                ScriptManager.RegisterStartupScript(this, GetType(), "OpenLoginModal",
                    "setTimeout(function() { new bootstrap.Modal(document.getElementById('loginModal')).show(); }, 100);", true);
            }
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            string email = txtResetEmail.Text.Trim();
            string newPassword = txtNewPasswordReset.Text.Trim();
            string confirmPassword = txtConfirmNewPassword.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(newPassword) || string.IsNullOrEmpty(confirmPassword))
            {
                lblResetMessage.Text = "All fields are required!";
                ShowResetModal();
                return;
            }

            if (newPassword != confirmPassword)
            {
                lblResetMessage.Text = "New password and confirmation do not match.";
                ShowResetModal();
                return;
            }

            if (!IsValidPassword(newPassword))
            {
                lblResetMessage.Text = "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character.";
                ShowResetModal();
                return;
            }

            string connString = "Provider=Microsoft.ACE.OLEDB.16.0;Data Source=" + Server.MapPath("~/App_Data/Tripsync.mdb");

            try
            {
                using (OleDbConnection connection = new OleDbConnection(connString))
                {
                    connection.Open();

                    string verifyQuery = "SELECT COUNT(*) FROM Login_TBL WHERE email = ?";
                    using (OleDbCommand verifyCommand = new OleDbCommand(verifyQuery, connection))
                    {
                        verifyCommand.Parameters.AddWithValue("?", email);

                        int count = Convert.ToInt32(verifyCommand.ExecuteScalar());
                        if (count == 0)
                        {
                            lblResetMessage.Text = "Email not found.";
                            ShowResetModal();
                            return;
                        }
                    }

                    string query = "UPDATE Login_TBL SET [password] = ? WHERE [email] = ?";
                    using (OleDbCommand command = new OleDbCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("?", newPassword);
                        command.Parameters.AddWithValue("?", email);
                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            txtResetEmail.Text = "";
                            txtNewPasswordReset.Text = "";
                            txtConfirmNewPassword.Text = "";

                            lblResetMessage.Text = "Password reset successfully!";

                            ScriptManager.RegisterStartupScript(this, GetType(), "ShowSuccessAndClose",
                                "setTimeout(function() { " +
                                "  alert('Password reset successfully! You can now login with your new password.'); " +
                                "  var modal = bootstrap.Modal.getInstance(document.getElementById('resetPasswordModal')); " +
                                "  if (modal) modal.hide(); " +
                                "}, 2000);", true);
                        }
                        else
                        {
                            lblResetMessage.Text = "Failed to reset password.";
                            ShowResetModal();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblResetMessage.Text = "Error: " + ex.Message;
                ShowResetModal();
            }
        }

        private void ShowResetModal()
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "OpenResetModal",
                "setTimeout(function() { new bootstrap.Modal(document.getElementById('resetPasswordModal')).show(); }, 100);", true);
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Home.aspx");
        }

        private bool IsValidPassword(string password)
        {
            string pattern = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,}$";
            return Regex.IsMatch(password, pattern);
        }
    }
}