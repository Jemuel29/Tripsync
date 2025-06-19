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
                <h4>My Booked Rides</h4>
                <asp:Repeater ID="rptMyBookings" runat="server">
                    <ItemTemplate>
                        <div class="booking-info">
                            <strong>Driver:</strong> <%# Eval("DriverName") %> <br />
                            <strong>Pickup:</strong> <%# Eval("PickupLocation") %> <br />
                            <strong>Destination:</strong> <%# Eval("Destination") %> <br />
                            <strong>Date:</strong> <%# Eval("DepartureDate") %> <br />
                            <strong>Status:</strong> <%# Eval("Status") %>
                        </div>
                        <hr />
                    </ItemTemplate>
                </asp:Repeater>
            </asp:Panel>
            <asp:Panel ID="pnlDriver" runat="server" Visible="false">
                <h3>Pending Ride Requests</h3>
                <asp:Repeater ID="rptPendingBookings" runat="server">
                    <ItemTemplate>
                        <div class="booking-request">
                            <strong>Passenger:</strong> <%# Eval("Username") %> <br />
                            <strong>Pickup:</strong> <%# Eval("PickupLocation") %> <br />
                            <strong>Destination:</strong> <%# Eval("Destination") %> <br />
                            <strong>Date:</strong> <%# Eval("DepartureDate") %> <br />
                            <asp:Button ID="btnAccept" runat="server" Text="Accept" CommandArgument='<%# Eval("BookingId") %>' OnClick="btnAccept_Click" CssClass="btn btn-success" />
                            <asp:Button ID="btnReject" runat="server" Text="Reject" CommandArgument='<%# Eval("BookingId") %>' OnClick="btnReject_Click" CssClass="btn btn-danger" />
                        </div>
                        <hr />
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Label ID="lblDriverMessage" runat="server" CssClass="text-info"></asp:Label>
            </asp:Panel>
    </div>
</asp:Content>