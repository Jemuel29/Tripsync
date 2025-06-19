<%@ Page Title="Home" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Tripsync.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .hero-banner {
            background-image: url('Picture/carpool.png');
            background-size: cover;
            background-position: center;
            height: 400px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: white;
            border-radius: 10px;
            margin-bottom: 30px;
            position: relative; /* Needed for overlay */
            overflow: hidden
        }
        .hero-banner::before {
            content: "";
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0,0,0,0.45); /* Dark overlay */
            border-radius: 10px;
            z-index: 1;
        }
        .hero-banner > div {
            position: relative;
            z-index: 2;
        }
        .hero-banner h1 {
            font-size: 3rem;
            font-weight: bold;
            text-shadow: 3px 3px 8px rgba(0,0,0,0.9);
        }
        .hero-banner p {
            font-size: 1.2rem;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.8);
        }
        .how-it-works {
            text-align: center;
            margin: 50px 0 40px 0;
        }
        .how-it-works .steps-container {
            display: flex;
            flex-direction: row;
            justify-content: center;
            gap: 40px;
            flex-wrap: wrap;
            margin-top: 40px;
           }
        .how-it-works .step-card {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 30px 20px;
            width: 320px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            text-align: center;
        }
        .how-it-works .step-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }
        .how-it-works h2 {
            font-weight: 700;
            font-size: 2.2rem;
        }
        .how-it-works .section-subtitle {
            font-size: 1.15rem;
            margin-bottom: 0;
        }
        .feature-section {
            margin-top: 40px;
        }
        .feature-card {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 30px 20px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            margin-bottom: 20px;
        }
        .feature-card i {
            font-size: 2.5rem;
            color: #1565c0;
            margin-bottom: 15px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="hero-banner">
            <div>
                <h1>Welcome to Tripsync</h1>
                <p>Ride Together, Save Together</p>
            </div>
        </div>

            <section class="how-it-works">
            <h2>How TripSync Works</h2>
            <p class="section-subtitle">Quick, easy, and safe carpooling for students</p>
            <div class="steps-container">
                <div class="step-card">
                    <div class="step-icon">👤</div>
                    <h3>1. Create Your Account</h3>
                    <p>Sign up with your university email, complete your profile, and verify your student ID.</p>
                </div>
                <div class="step-card">
                    <div class="step-icon">📍</div>
                    <h3>2. Find or Offer a Ride</h3>
                    <p>Browse available rides that match your schedule or offer your own ride to help fellow students.</p>
                </div>
                <div class="step-card">
                    <div class="step-icon">🤝</div>
                    <h3>3. Connect & Save</h3>
                    <p>Coordinate through our secure messaging system, share costs, and track your ride in real-time.</p>
                </div>
            </div>
        </section>

            <section class="partner-universities text-center" style="background:#fafafa; padding:50px 0; margin-top:40px;">
            <h2 style="font-weight:700; font-size:2.5rem;">Partner Universities</h2>
            <p style="font-size:1.15rem; margin-bottom:40px;">
            TripSync is officially partnered with these universities to provide safe transportation options for students.
            </p>
            <div style="display:flex; flex-wrap:wrap; justify-content:center; gap:40px;">
                <img src="Picture/Mapúa Malayan Colleges Laguna (MMCL) logo.png" alt="Mapúa Malayan Colleges Laguna (MMCL) logo.png" style="height:110px;" />
                <img src="Picture/De La Salle University (DLSU) logo.png" alt="DLSU" style="height:110px;" />
                <img src="Picture/University of Santo Tomas (UST) logo.png" alt="UST" style="height:110px;" />
                <img src="Picture/FEU Alabang logo.png" alt="FEU" style="height:110px;" />
                <img src="Picture/National University Laguna (NU Laguna) logo.png" alt="NU" style="height:110px" />
                <img src="Picture/San Beda College Alabang (SBCA) logo.png" alt="San Beda" style="height:110px;" />
            </div>
        </section>
    </div>
</asp:Content>