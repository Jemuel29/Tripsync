<%@ Page Title="Ride Status" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="RideStatus.aspx.cs" Inherits="Tripsync.RideStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .status-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
        }
        .ride-details {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .status-timeline {
            margin: 20px 0;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        .status-step {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        .status-step.active {
            color: #28a745;
            font-weight: bold;
        }
        .status-step.completed {
            color: #6c757d;
        }
        .driver-info {
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
        .btn-cancel {
            background-color: #dc3545;
            color: white;
        }
        .btn-rate {
            background-color: #17a2b8;
            color: white;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="status-container">
        <div class="ride-details">
            <h2>Ride Details</h2>
            <div class="row">
                <div class="col-md-6">
                    <p><strong>Pickup Location:</strong> <asp:Label ID="lblPickupLocation" runat="server"></asp:Label></p>
                    <p><strong>Drop-off Location:</strong> <asp:Label ID="lblDropoffLocation" runat="server"></asp:Label></p>
                    <p><strong>Request Time:</strong> <asp:Label ID="lblRequestTime" runat="server"></asp:Label></p>
                </div>
                <div class="col-md-6">
                    <p><strong>Estimated Fare:</strong> <asp:Label ID="lblEstimatedFare" runat="server"></asp:Label></p>
                    <p><strong>Estimated Duration:</strong> <asp:Label ID="lblEstimatedDuration" runat="server"></asp:Label></p>
                    <p><strong>Status:</strong> <asp:Label ID="lblStatus" runat="server"></asp:Label></p>
                </div>
            </div>
        </div>

        <div class="status-timeline">
            <h3>Ride Status</h3>
            <div class="status-step" id="stepRequested" runat="server">
                <span class="step-icon">1</span>
                <span class="step-text">Ride Requested</span>
            </div>
            <div class="status-step" id="stepAccepted" runat="server">
                <span class="step-icon">2</span>
                <span class="step-text">Driver Accepted</span>
            </div>
            <div class="status-step" id="stepInProgress" runat="server">
                <span class="step-icon">3</span>
                <span class="step-text">Ride in Progress</span>
            </div>
            <div class="status-step" id="stepCompleted" runat="server">
                <span class="step-icon">4</span>
                <span class="step-text">Ride Completed</span>
            </div>
        </div>

        <asp:Panel ID="pnlDriverInfo" runat="server" CssClass="driver-info" Visible="false">
            <h3>Driver Information</h3>
            <p><strong>Driver Name:</strong> <asp:Label ID="lblDriverName" runat="server"></asp:Label></p>
            <p><strong>Vehicle Model:</strong> <asp:Label ID="lblVehicleModel" runat="server"></asp:Label></p>
            <p><strong>Vehicle Number:</strong> <asp:Label ID="lblVehicleNumber" runat="server"></asp:Label></p>
            <p><strong>Driver Rating:</strong> <asp:Label ID="lblDriverRating" runat="server"></asp:Label></p>
        </asp:Panel>

        <div class="action-buttons">
            <asp:Button ID="btnCancelRide" runat="server" Text="Cancel Ride" CssClass="btn btn-cancel" 
                OnClick="btnCancelRide_Click" Visible="false" />
            <asp:Button ID="btnRateRide" runat="server" Text="Rate Ride" CssClass="btn btn-rate" 
                OnClick="btnRateRide_Click" Visible="false" />
        </div>

        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
    </div>
</asp:Content> 