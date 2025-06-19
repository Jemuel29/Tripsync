<%@ Page Title="Universities" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="universities.aspx.cs" Inherits="Tripsync.universities" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Only include custom styles that are unique to this page -->
    <style>
        .universities-container {
            max-width: 1200px;
            margin: 40px auto;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 32px;
        }
        .card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 2px 16px rgba(44, 62, 80, 0.08);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            transition: box-shadow 0.2s;
        }
        .card:hover {
            box-shadow: 0 4px 24px rgba(44, 62, 80, 0.16);
        }
        .card img {
            width: 100%;
            height: 160px;
            object-fit: cover;
        }
        .card-content {
            padding: 24px 20px 16px 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        .card-title {
            font-weight: 700;
            font-size: 1.1rem;
            margin: 0 0 6px 0;
        }
        .card-location {
            color: #e74c3c;
            font-size: 0.95rem;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 4px;
        }
        .card-desc {
            font-size: 0.97rem;
            color: #444;
            margin-bottom: 18px;
        }
        .stats {
            display: flex;
            gap: 24px;
            margin-bottom: 16px;
        }
        .stat {
            text-align: center;
        }
        .stat-value {
            font-weight: 600;
            font-size: 1.1rem;
            color: #5f4dee;
        }
        .stat-label {
            font-size: 0.85rem;
            color: #888;
        }
        .find-btn {
            background: #5f4dee;
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 12px 0;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
            width: 100%;
            margin-top: auto;
        }
        .find-btn:hover {
            background: #4736b5;
        }
        @media (max-width: 1000px) {
            .universities-container {
                grid-template-columns: 1fr 1fr;
            }
        }
        @media (max-width: 700px) {
            .universities-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="universities-container">
        <!-- Card 1 -->
        <div class="card">
            <img src="Picture/dlsu.png" alt="De La Salle University (DLSU)" />
            <div class="card-content">
                <div class="card-title">De La Salle University (DLSU)</div>
                <div class="card-location">&#x1F4CD; Manila</div>
                <div class="card-desc">
                    De La Salle University positions itself as a leader in molding human resources who serve the church and the nation. It is a Catholic coeducational institution founded by the Brothers of the Christian Schools.
                </div>
                <div class="stats">
                    <div class="stat">
                        <div class="stat-value">124</div>
                        <div class="stat-label">Rides</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value" style="color:#27ae60;">45</div>
                        <div class="stat-label">Drivers</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value">210</div>
                        <div class="stat-label">Riders</div>
                    </div>
                </div>
                <asp:Button runat="server" ID="btnFindRides1" CssClass="find-btn" Text="Find Rides →" OnClick="FindRides_Click" />
            </div>
        </div>
        <!-- Card 2 -->
        <div class="card">
            <img src="Picture/ust.png" alt="University of Santo Tomas (UST)" />
            <div class="card-content">
                <div class="card-title">University of Santo Tomas (UST)</div>
                <div class="card-location">&#x1F4CD; Manila</div>
                <div class="card-desc">
                    The University of Santo Tomas is the oldest existing university in Asia. In terms of student population, it is the largest Catholic university in the world in a single campus.
                </div>
                <div class="stats">
                    <div class="stat">
                        <div class="stat-value">187</div>
                        <div class="stat-label">Rides</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value" style="color:#27ae60;">63</div>
                        <div class="stat-label">Drivers</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value">345</div>
                        <div class="stat-label">Riders</div>
                    </div>
                </div>
                <asp:Button runat="server" ID="btnFindRides2" CssClass="find-btn" Text="Find Rides →" OnClick="FindRides_Click" />
            </div>
        </div>
        <!-- Card 3 -->
        <div class="card">
            <img src="Picture/mmcl.png" alt="Mapúa Malayan Colleges Laguna (MMCL)" />
            <div class="card-content">
                <div class="card-title">Mapúa Malayan Colleges Laguna (MMCL)</div>
                <div class="card-location">&#x1F4CD; Cabuyao, Laguna</div>
                <div class="card-desc">
                    Mapúa Malayan Colleges Laguna offers programs in engineering, architecture, business, arts and sciences, and serves as a center of excellence in education in Southern Luzon.
                </div>
                <div class="stats">
                    <div class="stat">
                        <div class="stat-value">98</div>
                        <div class="stat-label">Rides</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value" style="color:#27ae60;">32</div>
                        <div class="stat-label">Drivers</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value">145</div>
                        <div class="stat-label">Riders</div>
                    </div>
                </div>
                <asp:Button runat="server" ID="btnFindRides3" CssClass="find-btn" Text="Find Rides →" OnClick="FindRides_Click" />
            </div>
        </div>
        <!-- Card 4 -->
        <div class="card">
            <img src="Picture/nu.png" alt="National University Laguna (NU Laguna)" />
            <div class="card-content">
                <div class="card-title">National University Laguna (NU Laguna)</div>
                <div class="card-location">&#x1F4CD; Calamba, Laguna</div>
                <div class="card-desc">
                    National University Laguna is one of the newest university campuses in the region, offering quality education with a focus on technology and innovation.
                </div>
                <div class="stats">
                    <div class="stat">
                        <div class="stat-value">56</div>
                        <div class="stat-label">Rides</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value" style="color:#27ae60;">18</div>
                        <div class="stat-label">Drivers</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value">87</div>
                        <div class="stat-label">Riders</div>
                    </div>
                </div>
                <asp:Button runat="server" ID="btnFindRides4" CssClass="find-btn" Text="Find Rides →" OnClick="FindRides_Click" />
            </div>
        </div>
        <!-- Card 5 -->
        <div class="card">
            <img src="Picture/feu.png" alt="FEU Alabang" />
            <div class="card-content">
                <div class="card-title">FEU Alabang</div>
                <div class="card-location">&#x1F4CD; Muntinlupa</div>
                <div class="card-desc">
                    FEU Alabang is one of the newest branches of Far Eastern University, offering diverse programs and modern learning facilities.
                </div>
                <div class="stats">
                    <div class="stat">
                        <div class="stat-value">78</div>
                        <div class="stat-label">Rides</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value" style="color:#27ae60;">25</div>
                        <div class="stat-label">Drivers</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value">112</div>
                        <div class="stat-label">Riders</div>
                    </div>
                </div>
                <asp:Button runat="server" ID="btnFindRides5" CssClass="find-btn" Text="Find Rides →" OnClick="FindRides_Click" />
            </div>
        </div>
        <!-- Card 6 -->
        <div class="card">
            <img src="Picture/sbca.png" alt="San Beda College Alabang (SBCA)" />
            <div class="card-content">
                <div class="card-title">San Beda College Alabang (SBCA)</div>
                <div class="card-location">&#x1F4CD; Muntinlupa</div>
                <div class="card-desc">
                    San Beda College Alabang is an institution known for its progressive approach to education, creative programs, and commitment to community service.
                </div>
                <div class="stats">
                    <div class="stat">
                        <div class="stat-value">67</div>
                        <div class="stat-label">Rides</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value" style="color:#27ae60;">22</div>
                        <div class="stat-label">Drivers</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value">98</div>
                        <div class="stat-label">Riders</div>
                    </div>
                </div>
                <asp:Button runat="server" ID="btnFindRides6" CssClass="find-btn" Text="Find Rides →" OnClick="FindRides_Click" />
            </div>
        </div>
    </div>
</asp:Content>