<%@ page import="org.course.coursewebapplication.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="header.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Profile</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4A90E2;
            --secondary-color: #5C6BC0;
            --accent-color: #FF5722;
            --text-color: #333;
            --bg-color: #F5F7FA;
            --card-bg: #FFFFFF;
            --error-color: #FF3B30;
            --success-color: #4CD964;
            --gradient-1: linear-gradient(135deg, #6e8efb, #a777e3);
            --gradient-2: linear-gradient(135deg, #84fab0, #8fd3f4);
            --gradient-3: linear-gradient(135deg, #f6d365, #fda085);
            --box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-color);
            line-height: 1.6;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Header Styles */
        header {
            background: var(--gradient-1);
            color: white;
            padding: 1rem 0;
            position: fixed;
            width: 100%;
            z-index: 1000;
            box-shadow: var(--box-shadow);
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: 700;
            color: white;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            gap: 1.5rem;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .nav-links a:hover {
            color: var(--accent-color);
        }

        /* Hero Section */
        .hero {
            background: var(--gradient-2);
            color: white;
            padding: 8rem 0 6rem;
            text-align: center;
        }

        .hero h1 {
            font-size: 3.5rem;
            margin-bottom: 1rem;
            animation: fadeInUp 1s ease-out;
        }

        .hero p {
            font-size: 1.2rem;
            max-width: 600px;
            margin: 0 auto 2rem;
            opacity: 0.9;
            animation: fadeInUp 1s ease-out 0.5s both;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .cta-button {
            display: inline-block;
            background-color: var(--accent-color);
            color: white;
            padding: 0.8rem 2rem;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 600;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            animation: fadeInUp 1s ease-out 1s both;
        }

        .cta-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 15px rgba(255, 87, 34, 0.4);
        }

        /* About Section */
        .about-section {
            padding: 6rem 0;
            text-align: center;
        }

        .about-section h2 {
            font-size: 2.5rem;
            margin-bottom: 1.5rem;
            color: var(--primary-color);
        }

        .about-content {
            display: flex;
            justify-content: space-around;
            align-items: center;
            flex-wrap: wrap;
            gap: 2rem;
        }

        .about-card {
            background-color: var(--card-bg);
            border-radius: 10px;
            padding: 2rem;
            width: 300px;
            text-align: center;
            box-shadow: var(--box-shadow);
            transition: transform 0.3s ease;
        }

        .about-card:hover {
            transform: translateY(-10px);
        }

        .about-card img {
            width: 80px;
            height: 80px;
            margin-bottom: 1rem;
        }

        .about-card h3 {
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
            color: var(--secondary-color);
        }

        /* Courses Section */
        .courses-section {
            padding: 6rem 0;
            background: var(--gradient-3);
        }

        .courses-section h2 {
            font-size: 2.5rem;
            text-align: center;
            margin-bottom: 3rem;
            color: white;
        }

        .courses-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            padding-right: 1rem;
        }

        .course-card {
            background-color: var(--card-bg);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: var(--box-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .course-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
        }

        .course-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .course-content {
            padding: 1.5rem;
        }

        .course-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--primary-color);
        }

        .course-description {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 1rem;
        }

        .course-instructor {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
        }

        .instructor-image {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 0.5rem;
        }

        .instructor-name {
            font-size: 0.9rem;
            font-weight: 500;
            color: var(--secondary-color);
        }

        .course-button {
            display: inline-block;
            background-color: var(--primary-color);
            color: white;
            padding: 0.6rem 1.2rem;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }

        .course-button:hover {
            background-color: var(--secondary-color);
        }

        /* Footer */
        footer {
            background: var(--gradient-1);
            color: white;
            padding: 3rem 0;
            text-align: center;
        }

        .footer-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 2rem;
        }

        .footer-links a {
            color: white;
            text-decoration: none;
            margin: 0 1rem;
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: var(--accent-color);
        }

        .social-icons a {
            color: white;
            font-size: 1.5rem;
            margin: 0 0.5rem;
            transition: color 0.3s ease;
        }

        .social-icons a:hover {
            color: var(--accent-color);
        }

        .copyright {
            margin-top: 2rem;
            font-size: 0.9rem;
            opacity: 0.8;
        }

        /* Login and Registration Forms */
        .auth-form-container {
            max-width: 400px;
            margin: 8rem auto;
            padding: 2rem;
            background-color: var(--card-bg);
            border-radius: 10px;
            box-shadow: var(--box-shadow);
        }

        .auth-form-container h2 {
            text-align: center;
            color: var(--primary-color);
            margin-bottom: 2rem;
        }

        .auth-form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            margin-bottom: 0.5rem;
            font-weight: 500;
        }

        .form-group input {
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
        }

        .auth-button {
            background-color: var(--primary-color);
            color: white;
            padding: 0.8rem;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .auth-button:hover {
            background-color: var(--secondary-color);
        }

        .auth-link {
            text-align: center;
            margin-top: 1rem;
        }

        .auth-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        .auth-link a:hover {
            text-decoration: underline;
        }

        /* Course Details Page */
        .course-details {
            padding-top: 6rem;
        }

        .course-details-header {
            background: var(--gradient-2);
            color: white;
            padding: 4rem 0;
            text-align: center;
        }

        .course-details-header h1 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        .course-details-content {
            padding: 4rem 0;
        }

        .course-details-image {
            width: 100%;
            max-width: 800px;
            margin: 0 auto 2rem;
            border-radius: 10px;
            box-shadow: var(--box-shadow);
        }

        .course-details-info {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 2rem;
        }

        .course-details-description {
            flex: 2;
        }

        .course-details-sidebar {
            flex: 1;
            background-color: var(--card-bg);
            padding: 2rem;
            border-radius: 10px;
            box-shadow: var(--box-shadow);
        }

        .course-details-price {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .enroll-button {
            display: block;
            width: 100%;
            padding: 1rem;
            background-color: var(--accent-color);
            color: white;
            text-align: center;
            text-decoration: none;
            font-weight: 600;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .enroll-button:hover {
            background-color: var(--secondary-color);
        }

        /* Admin Dashboard */
        .admin-dashboard {
            padding-top: 6rem;
        }

        .admin-header {
            background: var(--gradient-1);
            color: white;
            padding: 2rem 0;
        }

        .admin-header h1 {
            font-size: 2rem;
        }

        .admin-content {
            padding: 2rem 0;
        }

        .admin-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
        }

        .admin-card {
            background-color: var(--card-bg);
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: var(--box-shadow);
        }

        .admin-card h3 {
            font-size: 1.2rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .admin-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 2rem;
        }

        .admin-table th,
        .admin-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .admin-table th {
            background-color: var(--primary-color);
            color: white;
        }

        .admin-action-button {
            padding: 0.5rem 1rem;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .admin-action-button:hover {
            background-color: var(--secondary-color);
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .courses-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .course-details-info {
                flex-direction: column;
            }

            .course-details-sidebar {
                width: 100%;
            }
        }

        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.5rem;
            }

            .hero p {
                font-size: 1rem;
            }

            .courses-grid {
                grid-template-columns: 1fr;
            }

            .about-content {
                flex-direction: column;
            }

            .footer-content {
                flex-direction: column;
            }

            .admin-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 480px) {
            .nav-links {
                display: none;
            }

            .auth-form-container {
                padding: 1.5rem;
            }

            .course-details-header h1 {
                font-size: 2rem;
            }
        }

        /* Utility Classes */
        .text-center {
            text-align: center;
        }

        .mt-1 { margin-top: 0.25rem; }
        .mt-2 { margin-top: 0.5rem; }
        .mt-3 { margin-top: 1rem; }
        .mt-4 { margin-top: 1.5rem; }
        .mt-5 { margin-top: 2rem; }

        .mb-1 { margin-bottom: 0.25rem; }
        .mb-2 { margin-bottom: 0.5rem; }
        .mb-3 { margin-bottom: 1rem; }
        .mb-4 { margin-bottom: 1.5rem; }
        .mb-5 { margin-bottom: 2rem; }

        .mx-auto { margin-left: auto; margin-right: auto; }

        .text-primary { color: var(--primary-color); }
        .text-secondary { color: var(--secondary-color); }
        .text-accent { color: var(--accent-color); }

        .bg-primary { background-color: var(--primary-color); }
        .bg-secondary { background-color: var(--secondary-color); }
        .bg-accent { background-color: var(--accent-color); }

        .rounded { border-radius: 5px; }
        .rounded-lg { border-radius: 10px; }

        .shadow { box-shadow: var(--box-shadow); }

        .transition { transition: all 0.3s ease; }

        /* Error and Success Messages */
        .message {
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 1rem;
        }

        .error-message {
            background-color: var(--error-color);
            color: white;
        }

        .success-message {
            background-color: var(--success-color);
            color: white;
        }

        /* Loading Spinner */
        .spinner {
            border: 4px solid rgba(0, 0, 0, 0.1);
            width: 36px;
            height: 36px;
            border-radius: 50%;
            border-left-color: var(--primary-color);
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }
            100% {
                transform: rotate(360deg);
            }
        }

        /* Tooltip */
        .tooltip {
            position: relative;
            display: inline-block;
        }

        .tooltip .tooltiptext {
            visibility: hidden;
            width: 120px;
            background-color: #555;
            color: #fff;
            text-align: center;
            border-radius: 6px;
            padding: 5px 0;
            position: absolute;
            z-index: 1;
            bottom: 125%;
            left: 50%;
            margin-left: -60px;
            opacity: 0;
            transition: opacity 0.3s;
        }

        .tooltip:hover .tooltiptext {
            visibility: visible;
            opacity: 1;
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 2rem;
        }

        .pagination button {
            margin: 0 0.5rem;
            padding: 0.5rem 1rem;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .pagination button:hover {
            background-color: var(--secondary-color);
        }

        .pagination button:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

        /* Modal */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .modal-content {
            background-color: var(--card-bg);
            padding: 2rem;
            border-radius: 10px;
            box-shadow: var(--box-shadow);
            max-width: 500px;
            width: 90%;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .modal-close {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
        }

        /* Responsive Images */
        .responsive-image {
            max-width: 100%;
            height: auto;
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 10px;
        }

        ::-webkit-scrollbar-track {
            background: #f1f1f1;
        }

        ::-webkit-scrollbar-thumb {
            background: var(--primary-color);
            border-radius: 5px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--secondary-color);
        }

        /* Print Styles */
        @media print {
            header, footer, .no-print {
                display: none;
            }

            body {
                font-size: 12pt;
            }

            a[href]:after {
                content: " (" attr(href) ")";
            }
        }
        /* Student Profile Page Styling */

        /* Main Container */
        .container {
            padding: 10rem 2rem;
            background-color: var(--bg-color);
        }

        /* Profile Image Section */
        .profile-img-container {
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            margin-bottom: 1.5rem;
        }

        .profile-img {
            width: 200px;
            height: 200px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid var(--primary-color);
            box-shadow: var(--box-shadow);
            transition: transform 0.3s ease;
        }

        .profile-img:hover {
            transform: scale(1.05);
        }

        /* Positioning the text below the profile image */
        /* Positioning the text below the profile image */
        .profile-text {
            text-align: left;
            margin-top: 1rem; /* Adds spacing between the image and the text */
        }

        .profile-text p {
            margin: 0.5rem 0 0.5rem 70px; /* Adds 10px margin to the left */
            font-size: 1rem;
            color: var(--text-color);
        }

        /* Profile Card */
        .profile-card {
            background-color: var(--card-bg);
            border-radius: 10px;
            box-shadow: var(--box-shadow);
            padding: 1.5rem;
            min-height: 100%;
            text-align: center; /* Ensures content alignment */
        }

        .profile-card h3 {
            font-size: 1.8rem;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            text-transform: uppercase;
        }

        /* Profile Button */
        .profile-card .btn {
            display: inline-block;
            padding: 0.8rem 1.5rem;
            background-color: var(--accent-color);
            color: white;
            border: none;
            border-radius: 5px;
            font-weight: 600;
            text-align: center;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 1.5rem;
            width: 30%; /* Makes the button responsive */
        }

        .profile-card .btn:hover {
            background-color: var(--secondary-color);
        }

        /* Profile Details */
        .profile-card .section-title {
            font-size: 1rem;
            font-weight: 600;
            color: var(--secondary-color);
            margin-bottom: 0.5rem;
        }

        .profile-card p {
            font-size: 1rem;
            color: var(--text-color);
            margin-bottom: 1rem;
        }

        /* Link Styling */
        .profile-card a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        .profile-card a:hover {
            text-decoration: underline;
        }


        /* Alerts */
        .alert-danger {
            background-color: var(--error-color);
            color: white;
            padding: 1rem;
            border-radius: 5px;
            margin-top: 2rem;
            text-align: center;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .profile-img {
                width: 150px;
                height: 150px;
            }

            .profile-card {
                padding: 1rem;
            }

            .profile-card .section-title,
            .profile-card p {
                font-size: 0.9rem;
            }

            .profile-card .btn {
                width: 50%; /* Adjust button width for smaller screens */
            }
        }
    </style>
</head>
<body>
<div class="container">
    <%
        // Retrieve the user object set by the servlet
        User user = (User) request.getAttribute("user");
        if (user != null) {
    %>
    <div class="row g-4">
        <!-- Left Profile Picture Card -->
        <div class="col-md-4">

            <img class="profile-img img-fluid rounded-circle"
                 src="<%= user.getProfile_pic() %>"
                 alt="profile_pic">
            <div class="profile-text">
                <p>
                    student
                </p>
            </div>
        </div>


        <!-- Right Profile Details -->
        <div class="col-md-8">
            <div class="profile-card p-3 border rounded">
                <h3 class="text-primary text-center">Student Profile</h3>
                <div class="row mt-4">
                    <div class="col-md-6">
                        <p class="section-title font-weight-bold">Full Name</p>
                        <p><%= user.getName() != null ? user.getName() : "N/A" %></p>
                    </div>
                    <div class="col-md-6">
                        <p class="section-title font-weight-bold">Email</p>
                        <p><%= user.getEmail() != null ? user.getEmail() : "N/A" %></p>
                    </div>
                    <div class="col-md-6">
                        <p class="section-title font-weight-bold">SSC</p>
                        <p><%= user.getSsc() != null ? user.getSsc() : "N/A" %></p>
                    </div>
                    <div class="col-md-6">
                        <p class="section-title font-weight-bold">Phone</p>
                        <p><%= user.getPhone() != null ? user.getPhone() : "N/A" %></p>
                    </div>
                    <div class="col-md-6">
                        <p class="section-title font-weight-bold">Parent Mobile</p>
                        <p><%= user.getParentMobile() != null ? user.getParentMobile() : "N/A" %></p>
                    </div>
                    <div class="col-md-6">
                        <p class="section-title font-weight-bold">Institution</p>
                        <p><%= user.getInstitution() != null ? user.getInstitution() : "N/A" %></p>
                    </div>
                    <div class="col-md-6">
                        <p class="section-title font-weight-bold">Facebook</p>
                        <p><a href="<%= user.getFacebook() != null ? user.getFacebook() : "#" %>" target="_blank">
                            <%= user.getFacebook() != null ? user.getFacebook() : "N/A" %>
                        </a></p>
                    </div>
                    <div class="col-md-6">
                        <p class="section-title font-weight-bold">Address</p>
                        <p><%= user.getAddress() != null ? user.getAddress() : "N/A" %></p>
                    </div>

                    <div class="button-container">
                        <a href="editProfile" class="btn btn-edit">Edit Profile</a>
                        <a href="logout.jsp" class="btn btn-logout">Logout</a>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <%
    } else {
    %>
    <div class="alert alert-danger text-center">
        <p>User not found. Please try again.</p>
    </div>
    <%
        }
    %>
</div>
<%@include file="footer.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>