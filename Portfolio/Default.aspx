<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Portfolio.Default" UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Portfolio - Enam</title>
    <link href="Styles/style.css" rel="stylesheet" />
    <link href="Styles/home.css" rel="stylesheet" />
    <link href="Styles/about.css" rel="stylesheet" />
    <link href="Styles/skills.css" rel="stylesheet" />
    <link href="Styles/projects.css" rel="stylesheet" />
    <link href="Styles/education.css" rel="stylesheet" />
    <link href="Styles/contact.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <header class="header">
            <a href="#home" class="logo">
                <span class="logo-circle">E</span>
                <span class="logo-name">Enam</span>
            </a>
            <nav class="nav">
                <ul class="nav-list">
                    <li class="nav-item"><a href="#home" class="nav-link">Home</a></li>
                    <li class="nav-item"><a href="#about" class="nav-link">About</a></li>
                    <li class="nav-item"><a href="#skills" class="nav-link">Skills</a></li>
                    <li class="nav-item"><a href="#portfolio" class="nav-link">Portfolio</a></li>
                    <li class="nav-item"><a href="#education" class="nav-link">Education</a></li>
                    <li class="nav-item"><a href="#contact" class="nav-link">Contact</a></li>
                </ul>
            </nav>
            <button type="button" class="mobile-nav-toggle" aria-label="Menu">☰</button>
        </header>

        <main>
            <!-- Home Section -->
            <section class="section" id="home">
                <div class="home-content">
                    <h1 class="typewriter">
                        <span class="first-E">E</span>
                        <span class="base">NAM</span>
                        <span class="space"></span>
                        <span class="last-E">E</span>
                        <span class="rest">ELAHI</span>
                    </h1>
                    <p class="hero-description">
                        <span class="hero-subtitle">
                            <asp:Literal ID="litHeroSubtitle" runat="server"></asp:Literal></span>
                        <br />
                        <span class="hero-text">—
                            <asp:Literal ID="litHeroDescription" runat="server"></asp:Literal></span>
                    </p>
                    <div class="links">
                        <a href="#about" class="cta-button">Learn More</a>
                        <a href="assets/Resume.pdf" download class="resume-btn">Download Resume</a>
                    </div>
                    <div class="image-container">
                        <asp:Image ID="imgProfileBack" runat="server" CssClass="profile-image-back" />
                        <asp:Image ID="imgProfile" runat="server" CssClass="profile-image" />
                    </div>
                    
                </div>
            </section>

            <!-- About Section -->
            <section class="section" id="about">
                <div class="about-container">
                    <h2 class="section-title" data-text="ABOUT ME">ABOUT ME</h2>
                    <div class="about-content">
                        <div class="about-text">
                            <asp:Literal ID="litAbout" runat="server" Mode="PassThrough"></asp:Literal>
                        </div>
                        <div class="about-image-wrapper">
                            <asp:Image ID="imgAbout" runat="server" CssClass="about-image" />
                        </div>
                    </div>
                </div>
            </section>

            <!-- Skills Section -->
            <section class="section" id="skills">
                <div class="container">
                    <h2 class="section-title" data-text="SKILLS">SKILLS</h2>
                    <div class="skills-grid">
                        <asp:Repeater ID="rptCategories" runat="server">
                            <ItemTemplate>
                                <div class="skill-category">
                                    <h3></i><%# Eval("CategoryName") %></h3>
                                    <ul class="skill-list">
                                        <asp:Repeater ID="rptSkills" runat="server" DataSource='<%# Eval("Skills") %>'>
                                            <ItemTemplate>
                                                <li class="skill-item">
                                                    <span class="skill-name"><%# Eval("SkillName") %></span>
                                                    <div class="skill-bar">
                                                        <div class="skill-fill" data-level="<%# Eval("ProficiencyLevel") %>">
                                                            <span class="skill-percent"><%# Eval("ProficiencyLevel") %>%</span>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ul>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </section>

            <!-- Portfolio Section -->
            <section class="section" id="portfolio">
                <div class="container">
                    <h2 class="section-title" data-text="PROJECTS">PROJECTS</h2>

                    <!-- Featured Projects -->
                    <div class="featured-projects">
                        <asp:Repeater ID="rptFeatured" runat="server">
                            <ItemTemplate>
                                <div class="featured-card" onclick="window.open('<%# Eval("GithubLink") %>', '_blank')">
                                    <img src='<%# Eval("ProjectImage") %>' alt='<%# Eval("ProjectTitle") %>' />
                                    <h3><%# Eval("ProjectTitle") %></h3>
                                    <p><%# Eval("ProjectDescription") %></p>
                                    <div class="tags">
                                        <%# string.Join("", Eval("Languages").ToString().Split(',')
                                .Select(lang => $"<span class='tag'>{lang.Trim()}</span>")) %>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <!-- Other Projects -->
                    <div class="projects-slider">
                        <asp:Repeater ID="rptOthers" runat="server">
                            <ItemTemplate>
                                <div class="project-card" onclick="window.open('<%# Eval("GithubLink") %>', '_blank')">
                                    <img src='<%# Eval("ProjectImage") %>' alt='<%# Eval("ProjectTitle") %>' />
                                    <h4><%# Eval("ProjectTitle") %></h4>
                                    <div class="tags">
                                        <%# string.Join("", Eval("Languages").ToString().Split(',')
                                .Select(lang => $"<span class='tag'>{lang.Trim()}</span>")) %>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </section>


            <!-- Education -->
            <section class="section" id="education">
                <h2 class="section-title" data-text="EDUCATION">EDUCATION</h2>
                <div class="timeline-grid">
                    <asp:Repeater ID="rptEducation" runat="server">
                        <ItemTemplate>
                            <div class="timeline-item">
                                <div class="timeline-point"></div>
                                <div class="degree">
                                    <p><%# Eval("Degree") %></p>
                                </div>
                                <div class="details">
                                    <h4><%# Eval("Institution") %></h4>
                                    <p><%# Eval("Result") %></p>
                                    <p><%# Eval("Description") %></p>
                                    <p><%# Eval("StartYear") %> - <%# Eval("EndYear") %></p>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </section>

            <!-- Contact Section -->
            <section class="section" id="contact">
                <div class="container">
                    <h2 class="section-title" data-text="LET'S CONNECT">LET'S CONNECT</h2>

                    <div class="contact-grid">
                        <!-- Contact Info -->
                        <div class="contact-info">
                            <asp:Literal ID="litContactInfo" runat="server"></asp:Literal>
                        </div>

                        <!-- Contact Form -->
                        <asp:ScriptManager ID="ScriptManager1" runat="server" />

                        <asp:UpdatePanel ID="updContactForm" runat="server">
                            <ContentTemplate>
                                <div class="contact-form">
                                    <!-- Name Field -->
                                    <asp:Label AssociatedControlID="txtName" runat="server" Text="Name"></asp:Label>
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>

                                    <br />

                                    <!-- Email Field -->
                                    <asp:Label AssociatedControlID="txtEmail" runat="server" Text="Email"></asp:Label>
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>

                                    <br />

                                    <!-- Message Field -->
                                    <asp:Label AssociatedControlID="txtMessage" runat="server" Text="Message"></asp:Label>
                                    <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control"></asp:TextBox>

                                    <br />

                                    <!-- Submit Button -->
                                    <asp:Button ID="btnSend" runat="server" Text="Send Message" CssClass="btn" OnClick="btnSend_Click" />

                                    <!-- Status Label -->
                                    <asp:Label ID="lblStatus" runat="server" CssClass="status-message"></asp:Label>

                                    <!-- Optional: Summary of all errors -->
                                    <asp:ValidationSummary ID="valSummary" runat="server" ForeColor="Red" HeaderText="Please fix the following errors:" />
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </section>
        </main>
    </form>
    <script src="Scripts/script.js"></script>
</body>
</html>
