<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Tripsync.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <h2>Welcome, <asp:Label ID="lblDashboardUsername" runat="server" />!</h2>
        <p>Your role: <asp:Label ID="lblDashboardRole" runat="server" /></p>
        <hr />
        <asp:Panel ID="pnlPassenger" runat="server" Visible="false">
            <h4>Passenger Options</h4>
            <ul>
                <li><a href="BookRide.aspx">Book a Ride</a></li>
                <li><a href="MyBookings.aspx">View My Bookings</a></li>
            </ul>
        </asp:Panel>
        <asp:Panel ID="pnlDriver" runat="server" Visible="false">
            <h4>Driver Options</h4>
            <ul>
                <li><a href="DriverRides.aspx">View Ride Requests</a></li>
                <li><a href="MyBookings.aspx">View My Accepted Rides</a></li>
            </ul>
        </asp:Panel>
        <asp:Panel ID="pnlAdmin" runat="server" Visible="false">
            <h4>Admin Options</h4>
            <ul>
                <li><a href="AdminPanel.aspx">Admin Dashboard</a></li>
            </ul>
        </asp:Panel>
    </div>
</asp:Content>