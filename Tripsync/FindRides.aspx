<%@ Page Title="Find a Ride" Language="C#" MasterPageFile="~/MasterPage.Master" 
    AutoEventWireup="true" CodeBehind="FindRides.aspx.cs" Inherits="Tripsync.FindRides" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style type="text/css">
    body { background: #fafbfc; margin: 0; }
    .ride-search-box, .rides-list-box {
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 2px 12px rgba(0,0,0,0.04);
        margin: 32px auto 0 auto;
        max-width: 1150px;
        width: 95vw;
        padding: 32px 32px 24px 32px;
        border: 1px solid #e5d1d1;
        box-sizing: border-box;
    }
    .ride-search-title, .rides-list-title {
        text-align: center;
        color: #7a2327;
        font-size: 2.2rem;
        font-weight: 700;
        margin-bottom: 24px;
    }
    .ride-search-form {
        display: flex;
        gap: 18px;
        justify-content: center;
        flex-wrap: wrap;
        margin-bottom: 0;
        width: 100%;
    }
    .ride-search-form .form-control {
        border-radius: 8px;
        border: 1px solid #e5d1d1;
        font-size: 1.1rem;
        padding: 12px 16px;
        min-width: 180px;
        flex: 1 1 180px;
        box-sizing: border-box;
    }
    .ride-search-form .btn {
        border-radius: 8px;
        font-size: 1.1rem;
        font-weight: 600;
        padding: 12px 28px;
        background: linear-gradient(90deg,#6a5af9,#7868e6 80%);
        color: #fff;
        border: none;
        transition: background 0.2s;
        min-width: 140px;
    }
    .ride-search-form .btn:hover {
        background: linear-gradient(90deg,#5a4ae6,#5a4ae6 80%);
    }
    .rides-list-title {
        margin-top: 0;
        margin-bottom: 24px;
    }
    .ride-card {
        background: #fff;
        border-radius: 10px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        border: 1px solid #e5d1d1;
        margin: 0 auto 24px auto;
        padding: 24px 32px 20px 32px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        max-width: 1000px;
        width: 100%;
        box-sizing: border-box;
    }
    .ride-card-main {
        flex: 1;
        min-width: 0;
    }
    .ride-title {
        font-size: 1.2rem;
        font-weight: 700;
        color: #2d2d2d;
        margin-bottom: 6px;
        word-break: break-word;
    }
    .ride-details {
        color: #444;
        font-size: 1rem;
        margin-bottom: 8px;
    }
    .ride-meta {
        display: flex;
        align-items: center;
        gap: 18px;
        margin-bottom: 0;
        flex-wrap: wrap;
    }
    .ride-status {
        background: #c6f6d5;
        color: #256029;
        font-size: 0.98rem;
        font-weight: 600;
        border-radius: 16px;
        padding: 4px 18px;
        display: inline-block;
    }
    .ride-seats, .ride-price {
        font-size: 1rem;
        color: #222;
    }
    .ride-price {
        font-weight: 700;
        margin-left: 8px;
    }
    .ride-card-action {
        margin-left: 32px;
        min-width: 140px;
        display: flex;
        justify-content: flex-end;
    }
    .btn-book-ride {
        background: #18804b;
        color: #fff;
        font-size: 1.1rem;
        font-weight: 600;
        border: none;
        border-radius: 8px;
        padding: 14px 32px;
        transition: background 0.2s;
        width: 100%;
        box-sizing: border-box;
    }
    .btn-book-ride:hover {
        background: #0e5c34;
    }
    @media (max-width: 1000px) {
        .ride-search-box, .rides-list-box {
            max-width: 98vw;
            padding: 20px 8px 16px 8px;
        }
        .ride-card {
            max-width: 98vw;
            padding: 18px 8px 14px 8px;
        }
    }
    @media (max-width: 700px) {
        .ride-card { 
            flex-direction: column; 
            align-items: flex-start; 
            padding: 14px 4vw; 
        }
        .ride-card-action { 
            margin-left: 0; 
            margin-top: 18px; 
            width: 100%; 
        }
        .ride-search-form {
            flex-direction: column;
            gap: 12px;
            align-items: stretch;
        }
        .ride-search-form .form-control,
        .ride-search-form .btn {
            width: 100%;
            min-width: 0;
        }
    }
    .find-rides-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 32px;
        width: 100vw;
        box-sizing: border-box;
    }
</style>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="find-rides-container">
        <!-- Search Box -->
        <div class="ride-search-box">
            <div class="ride-search-title">Find a Ride</div>
            <div>
                <asp:Panel runat="server" CssClass="ride-search-form">
                    <asp:TextBox ID="txtPickup" runat="server" CssClass="form-control" placeholder="Pickup Location" />
                    <asp:TextBox ID="txtDestination" runat="server" CssClass="form-control" placeholder="Destination" />
                    <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" placeholder="mm/dd/yyyy" TextMode="Date" />
                    <asp:Button ID="btnSearch" runat="server" Text="Search Rides" CssClass="btn" OnClick="btnSearch_Click" />
                </asp:Panel>
            </div>
        </div>

        <!-- Place the message label here -->
        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" EnableViewState="false"></asp:Label>

        <!-- Available Rides List -->
        <div class="rides-list-box">
            <div class="rides-list-title">Available Rides</div>
            <asp:Repeater ID="rptRides" runat="server">
                <ItemTemplate>
                    <div class="ride-card">
                        <div class="ride-card-main">
                            <div class="ride-title"><%# Eval("PickupLocation") %> to <%# Eval("Destination") %></div>
                            <div class="ride-details">
                                <%# Eval("DepartureDate", "{0:MMM dd, yyyy}") %> at <%# Eval("DepartureTime", "{0:HH:mm}") %>
                            </div>
                            <div class="ride-details">
                                Vehicle Type: <%# Eval("VehicleType") %>
                            </div>
                            <div class="ride-meta">
                                <span class="ride-status">Active</span>
                                <span class="ride-seats">Available Seats: <%# Eval("AvailableSeats") %></span>
                                <span class="ride-price">₱<%# Eval("PricePerSeat") %></span>
                            </div>
                        </div>
                        <div class="ride-card-action">
                            <asp:Button ID="btnBookRide" runat="server" Text="Book Ride" CssClass="btn-book-ride" CommandArgument='<%# Eval("RideId") %>' OnClick="btnBookRide_Click" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>