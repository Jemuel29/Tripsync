<%@ Page Title="Driver Dashboard" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="DriverDashboard.aspx.cs" Inherits="Tripsync.DriverDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .dashboard-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
        }
        .status-panel {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .ride-requests {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin: 5px;
        }
        .btn-accept {
            background-color: #28a745;
            color: white;
        }
        .btn-reject {
            background-color: #dc3545;
            color: white;
        }
        .btn-complete {
            background-color: #17a2b8;
            color: white;
        }
        .grid-view {
            width: 100%;
            border-collapse: collapse;
        }
        .grid-view th {
            background-color: #f8f9fa;
            padding: 12px;
            text-align: left;
        }
        .grid-view td {
            padding: 12px;
            border-bottom: 1px solid #dee2e6;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="dashboard-container">
        <div class="status-panel">
            <h2>Driver Status</h2>
            <asp:CheckBox ID="chkAvailable" runat="server" Text="Available for Rides" AutoPostBack="true" OnCheckedChanged="chkAvailable_CheckedChanged" />
            <div>
                <asp:Label ID="lblCurrentLocation" runat="server" Text="Current Location: "></asp:Label>
                <asp:TextBox ID="txtCurrentLocation" runat="server"></asp:TextBox>
                <asp:Button ID="btnUpdateLocation" runat="server" Text="Update Location" CssClass="btn" OnClick="btnUpdateLocation_Click" />
            </div>
        </div>

        <div class="ride-requests">
            <h2>Ride Requests</h2>
            <asp:GridView ID="gvRideRequests" runat="server" CssClass="grid-view" AutoGenerateColumns="False" 
                OnRowCommand="gvRideRequests_RowCommand">
                <Columns>
                    <asp:BoundField DataField="RideID" HeaderText="Ride ID" />
                    <asp:BoundField DataField="PickupLocation" HeaderText="Pickup Location" />
                    <asp:BoundField DataField="DropoffLocation" HeaderText="Drop-off Location" />
                    <asp:BoundField DataField="RequestTime" HeaderText="Request Time" DataFormatString="{0:g}" />
                    <asp:BoundField DataField="Fare" HeaderText="Fare" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnAccept" runat="server" Text="Accept" CssClass="btn btn-accept" 
                                CommandName="AcceptRide" CommandArgument='<%# Eval("RideID") %>' 
                                Visible='<%# Eval("Status").ToString() == "Requested" %>' />
                            <asp:Button ID="btnReject" runat="server" Text="Reject" CssClass="btn btn-reject" 
                                CommandName="RejectRide" CommandArgument='<%# Eval("RideID") %>' 
                                Visible='<%# Eval("Status").ToString() == "Requested" %>' />
                            <asp:Button ID="btnComplete" runat="server" Text="Complete" CssClass="btn btn-complete" 
                                CommandName="CompleteRide" CommandArgument='<%# Eval("RideID") %>' 
                                Visible='<%# Eval("Status").ToString() == "InProgress" %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
    </div>
</asp:Content> 