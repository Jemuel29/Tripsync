<%@ Page Title="Book a Ride" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="BookRide.aspx.cs" Inherits="Tripsync.BookRide" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .booking-form {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-control {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="booking-form">
        <h2>Book a Ride</h2>
        
        <div class="form-group">
            <label for="txtPickupLocation">Pickup Location</label>
            <asp:TextBox ID="txtPickupLocation" runat="server" CssClass="form-control" placeholder="Enter pickup address"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPickup" runat="server" ControlToValidate="txtPickupLocation"
                ErrorMessage="Pickup location is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label for="txtDropoffLocation">Drop-off Location</label>
            <asp:TextBox ID="txtDropoffLocation" runat="server" CssClass="form-control" placeholder="Enter drop-off address"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvDropoff" runat="server" ControlToValidate="txtDropoffLocation"
                ErrorMessage="Drop-off location is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label for="txtNotes">Special Instructions (Optional)</label>
            <asp:TextBox ID="txtNotes" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"
                placeholder="Any special instructions for the driver"></asp:TextBox>
        </div>

        <div class="form-group">
            <asp:Button ID="btnBookRide" runat="server" Text="Book Ride" CssClass="btn-primary" OnClick="btnBookRide_Click" />
        </div>

        <asp:Panel ID="pnlRideDetails" runat="server" Visible="false">
            <h3>Ride Details</h3>
            <div class="form-group">
                <label>Estimated Fare:</label>
                <asp:Label ID="lblEstimatedFare" runat="server"></asp:Label>
            </div>
            <div class="form-group">
                <label>Estimated Duration:</label>
                <asp:Label ID="lblEstimatedDuration" runat="server"></asp:Label>
            </div>
            <div class="form-group">
                <asp:Button ID="btnConfirmRide" runat="server" Text="Confirm Ride" CssClass="btn-primary" OnClick="btnConfirmRide_Click" />
            </div>
        </asp:Panel>

        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
    </div>
</asp:Content> 