<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="about us.aspx.cs" Inherits="Tripsync.about_us" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .about-container {
            max-width: 900px;
            margin: auto;
            padding: 32px 20px;
            background: linear-gradient(90deg, #1565c0 0%, #42a5f5 100%);
            border-radius: 18px;
            box-shadow: 0 4px 24px rgba(21,101,192,0.10);
            color: #fff;
        }
        .about-title {
            text-align: center;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 12px;
            letter-spacing: 1px;
        }
        .about-icon {
            display: block;
            text-align: center;
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        .about-text {
            font-size: 1.18rem;
            line-height: 1.7;
            text-align: center;
            margin-bottom: 18px;
            color: #e3f2fd;
        }
        .about-highlight {
            font-weight: 600;
            color: #fff176;
        }
        @media (max-width: 576px) {
            .about-container { padding: 18px 6px; }
            .about-title { font-size: 1.5rem; }
            .about-text { font-size: 1rem; }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container my-5">
        <div class="about-container">
            <span class="about-icon">
                <i class="fas fa-bus-alt"></i>
            </span>
            <h2 class="about-title">About Tripsync</h2>
            <p class="about-text">
                <span class="about-highlight">Tripsync</span> is a ride-booking app built to serve university students who need reliable transportation between campuses. Designed with the student lifestyle in mind, it offers a simple and efficient way to book rides for academic, social, or personal trips. By focusing on inter-university routes, TripSync fills a unique gap in traditional transportation services.
            </p>
            <p class="about-text">
                The app connects students traveling in the same direction, promoting ride-sharing that is both cost-effective and eco-friendly. With features like verified student profiles, real-time tracking, and secure payment options, TripSync ensures that every ride is safe and convenient. It also helps reduce the stress of navigating public transport or expensive private alternatives.            </p>
            <p class="about-text">
                TripSync builds a sense of community by encouraging connections among students from different universities. Whether you're attending a seminar, visiting friends, or going home for the weekend, the app makes planning and sharing rides simple. As it grows, TripSync aims to become the go-to platform for student mobility across campuses nationwide.            </p>
            <p class="about-text">
                <span class="about-highlight">Hop on. Sync up. Move smarter with Tripsync.</span>
            </p>
        </div>
    </div>
</asp:Content>