<%@ Page Title="My Bookings" Language="C#" MasterPageFile="~/MasterPage.Master" 
    AutoEventWireup="true" CodeBehind="MyBookings.aspx.cs" Inherits="Tripsync.MyBookings" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <style>
        .mybookings-container {
            max-width: 600px;
            margin: 32px auto 0 auto;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            padding: 24px 18px;
        }
        h2 {
            font-weight: 500;
            margin-bottom: 24px;
            color: #222;
        }
        .booking {
            border-bottom: 1px solid #eee;
            padding: 16px 0;
            display: flex;
            flex-direction: column;
            gap: 4px;
        }
        .booking:last-child {
            border-bottom: none;
        }
        .booking-label {
            color: #888;
            font-size: 13px;
            margin-right: 6px;
        }
        .booking-value {
            color: #222;
            font-size: 15px;
        }
        .status {
            font-size: 13px;
            color: #007b5e;
            margin-left: 8px;
        }
        .cancel-btn {
            align-self: flex-end;
            margin-top: 8px;
            background: #f5f5f5;
            border: 1px solid #ddd;
            color: #d32f2f;
            padding: 4px 14px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 13px;
            transition: background 0.2s;
        }
        .cancel-btn:hover {
            background: #ffeaea;
        }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mybookings-container">
        <h2>My Bookings</h2>
        <asp:Label ID="lblMessage" runat="server" CssClass="text-success" EnableViewState="false"></asp:Label>
        <asp:Repeater ID="rptBookings" runat="server">
            <ItemTemplate>
                <div class="booking">
                    <div>
                        <span class="booking-label">Ride ID:</span>
                        <span class="booking-value"><%# Eval("RideId") %></span>
                    </div>
                    <div>
                        <span class="booking-label">Pickup:</span>
                        <span class="booking-value"><%# Eval("PickupLocation") %></span>
                    </div>
                    <div>
                        <span class="booking-label">Destination:</span>
                        <span class="booking-value"><%# Eval("Destination") %></span>
                    </div>
                    <div>
                        <span class="booking-label">Date:</span>
                        <span class="booking-value"><%# Eval("DepartureDate", "{0:yyyy-MM-dd}") %></span>
                        <span class="booking-label" style="margin-left:16px;">Time:</span>
                        <span class="booking-value"><%# Eval("DepartureTime") %></span>
                    </div>
                    <div>
                        <span class="booking-label">Booked on:</span>
                        <span class="booking-value"><%# Eval("BookingDate", "{0:yyyy-MM-dd}") %></span>
                        <%# Eval("Status") != DBNull.Value ? "<span class='status'>Status: " + Eval("Status") + "</span>" : "" %>
                    </div>
                    <asp:Button ID="btnCancel" runat="server" CssClass="cancel-btn" Text="Cancel" CommandArgument='<%# Eval("BookingId") %>' OnClick="btnCancel_Click" />
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>