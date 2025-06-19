<%@ Page Title="Offer a Ride" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Offer.aspx.cs" Inherits="Tripsync.Offer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .offer-header {
            background: #1565c0;
            color: #fff;
            padding: 2.5rem 2rem 1.5rem 2rem;
            border-radius: 0 0 0.5rem 0.5rem;
            margin-bottom: 2rem;
        }
        .offer-header h1 {
            font-weight: 700;
            font-size: 2.5rem;
        }
        .offer-header p {
            font-size: 1.1rem;
            margin-bottom: 0;
        }
        .offer-form-card {
            background: #fff;
            border-radius: 1rem;
            box-shadow: 0 2px 16px rgba(0,0,0,0.07);
            padding: 2.5rem 2rem 2rem 2rem;
            margin-bottom: 2rem;
        }
        .offer-form label {
            font-weight: 500;
            margin-bottom: 0.3rem;
        }
        .offer-form .form-control, .offer-form .input-group-text {
            border-radius: 0.5rem;
        }
        .offer-form .input-group-text {
            background: #f5f5f5;
        }
        .offer-form .form-text {
            color: #888;
            font-size: 0.95rem;
        }
        .offer-form .btn-offer {
            background: #1565c0; 
            color: #fff;
            font-weight: 600;
            font-size: 1.1rem;
            border-radius: 0.5rem;
            padding: 0.8rem 0;
            transition: background 0.2s;
        }
        .offer-form .btn-offer:hover {
            background: #0d47a1;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="offer-header">
            <h1>Offer a Ride</h1>
            <p>Share your journey and help others reach their destination</p>
        </div>
        <div class="offer-form-card mx-auto" style="max-width: 1100px;">
            <div class="offer-form">
                <div class="row g-4">
                    <div class="col-md-6">
                        <label for="txtPickup" class="form-label">Pickup Location</label>
                        <asp:TextBox ID="txtPickup" runat="server" CssClass="form-control" placeholder="Enter pickup location"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label for="txtDestination" class="form-label">Destination</label>
                        <asp:TextBox ID="txtDestination" runat="server" CssClass="form-control" placeholder="Enter destination"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label for="txtDate" class="form-label">Departure Date</label>
                        <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date" placeholder="mm/dd/yyyy"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label for="txtTime" class="form-label">Departure Time</label>
                        <div class="input-group">
                            <asp:TextBox ID="txtTime" runat="server" CssClass="form-control" TextMode="Time" placeholder="--:-- --"></asp:TextBox>
                            <span class="input-group-text"><i class="fa-regular fa-clock"></i></span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label for="rblVehicleType" class="form-label">Vehicle Type</label>
                        <asp:RadioButtonList ID="rblVehicleType" runat="server" CssClass="form-control" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Car" Value="Car" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Motorcycle" Value="Motorcycle"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                    <div class="col-md-6">
                        <label for="txtSeats" class="form-label">Available Seats</label>
                        <asp:TextBox ID="txtSeats" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label for="txtPrice" class="form-label">Price Per Seat</label>
                        <div class="input-group">
                            <span class="input-group-text">&#8369;</span>
                            <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" placeholder=""></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-12">
                        <label for="txtNotes" class="form-label">Additional Notes</label>
                        <asp:TextBox ID="txtNotes" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"
                            placeholder="Add any important information for passengers (e.g., luggage restrictions, payment methods accepted)"></asp:TextBox>
                        <div class="form-text mt-1">
                            Optional: Add any specific requirements or information for your passengers
                        </div>
                    </div>
                    <div class="col-12">
                        <asp:Button ID="btnPostRide" runat="server" CssClass="btn btn-offer w-100" Text="Post Your Ride" OnClick="btnPostRide_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>