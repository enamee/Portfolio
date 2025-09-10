<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Portfolio.Admin" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin - Portfolio</title>
    <link rel="stylesheet" type="text/css" href="Styles/admin.css" />
    <style>
        .links {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
    </style>
</head>
<body>
    <header>
        <div class="links">
            <a class="portfolio-btn" href="/Default.aspx">Portfolio</a>
            <a class="logout-btn" href="/Logout.aspx">Logout</a>
        </div>
    </header>
    <form id="form1" runat="server">
        <div>
            <!-- Home Section -->
            <h2>Home Section</h2>
            <asp:GridView ID="gvHome" runat="server" AutoGenerateColumns="False" DataKeyNames="HomeId"
                OnRowEditing="gvHome_RowEditing"
                OnRowUpdating="gvHome_RowUpdating"
                OnRowCancelingEdit="gvHome_RowCancelingEdit"
                OnRowDeleting="gvHome_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="HomeId" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="HeroSubtitle" HeaderText="Subtitle" />
                    <asp:BoundField DataField="HeroDescription" HeaderText="Description" />
                    <asp:BoundField DataField="ProfileImage" HeaderText="Profile Image" />
                    <asp:BoundField DataField="ProfileImageBack" HeaderText="Profile Image Back" />
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>

            <!-- About Section -->
            <section class="admin-section" id="about-section">
                <h2>About Section</h2>

                <asp:GridView ID="gvAbout" runat="server" AutoGenerateColumns="False" CssClass="table"
                    DataKeyNames="AboutId"
                    OnRowEditing="gvAbout_RowEditing"
                    OnRowCancelingEdit="gvAbout_RowCancelingEdit"
                    OnRowUpdating="gvAbout_RowUpdating">
                    <Columns>
                        <asp:BoundField DataField="AboutId" HeaderText="ID" ReadOnly="true" />

                        <asp:TemplateField HeaderText="About Text">
                            <EditItemTemplate>
                                <asp:TextBox
                                    ID="txtEditAboutText"
                                    runat="server"
                                    Text='<%# Bind("AboutText") %>'
                                    TextMode="MultiLine"
                                    Rows="4"
                                    CssClass="form-control"
                                    ValidateRequestMode="Disabled">
                                </asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <%# Eval("AboutText") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="About Image">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditAboutImage" runat="server" Text='<%# Bind("AboutImage") %>'
                                    CssClass="form-control"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="imgAbout" runat="server" ImageUrl='<%# Eval("AboutImage") %>'
                                    Width="100px" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:CommandField ShowEditButton="true" />
                    </Columns>
                </asp:GridView>
            </section>

            <!-- Categories Section -->
            <h2>Skill Categories</h2>
            <asp:GridView ID="gvCategories" runat="server" AutoGenerateColumns="False" DataKeyNames="CategoryID"
                OnRowEditing="gvCategories_RowEditing"
                OnRowUpdating="gvCategories_RowUpdating"
                OnRowCancelingEdit="gvCategories_RowCancelingEdit"
                OnRowDeleting="gvCategories_RowDeleting"
                OnRowCommand="gvCategories_RowCommand">
                <Columns>
                    <asp:BoundField DataField="CategoryID" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="CategoryName" HeaderText="Category Name" />
                    <asp:BoundField DataField="DisplayOrder" HeaderText="Order" ReadOnly="True" />
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                    <asp:ButtonField ButtonType="Button" Text="Up" CommandName="MoveUp" />
                    <asp:ButtonField ButtonType="Button" Text="Down" CommandName="MoveDown" />
                </Columns>
            </asp:GridView>
            <asp:Button ID="btnAddCategory" runat="server" Text="Add Category" OnClick="btnAddCategory_Click" />

            <hr />

            <!-- Skills Section -->
            <h2>Skills</h2>
            <asp:GridView ID="gvSkills" runat="server" AutoGenerateColumns="False" OnRowDeleting="gvSkills_RowDeleting" OnRowEditing="gvSkills_RowEditing"
                OnRowUpdating="gvSkills_RowUpdating" OnRowCancelingEdit="gvSkills_RowCancelingEdit" DataKeyNames="SkillID">
                <Columns>
                    <asp:BoundField DataField="SkillID" HeaderText="ID" ReadOnly="true" />

                    <asp:TemplateField HeaderText="Skill Name">
                        <ItemTemplate>
                            <%# Eval("SkillName") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtSkillName" runat="server" Text='<%# Bind("SkillName") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Category">
                        <ItemTemplate>
                            <%# Eval("CategoryName") %>
                            <asp:HiddenField ID="hfCategoryId" runat="server" Value='<%# Eval("CategoryID") %>' />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlCategories" runat="server" />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Proficiency">
                        <ItemTemplate>
                            <%# Eval("ProficiencyLevel") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtProficiency" runat="server" Text='<%# Bind("ProficiencyLevel") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Display Order">
                        <ItemTemplate>
                            <%# Eval("DisplayOrder") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDisplayOrder" runat="server" Text='<%# Bind("DisplayOrder") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
            <asp:Button ID="btnAddSkill" runat="server" Text="Add Skill" OnClick="btnAddSkill_Click" />

            <!-- Projects Section -->
            <section class="admin-section" id="projects-section">
                <h2>Manage Projects</h2>

                <asp:Button ID="btnAddProject" runat="server" Text="Add Project"
                    CssClass="btn btn-primary" OnClick="btnAddProject_Click" />

                <asp:GridView ID="gvProjects" runat="server" AutoGenerateColumns="False" CssClass="table"
                    DataKeyNames="ProjectID"
                    OnRowEditing="gvProjects_RowEditing"
                    OnRowCancelingEdit="gvProjects_RowCancelingEdit"
                    OnRowUpdating="gvProjects_RowUpdating"
                    OnRowCommand="gvProjects_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="ProjectID" HeaderText="ID" ReadOnly="true" />

                        <asp:TemplateField HeaderText="Title">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditTitle" runat="server" Text='<%# Bind("ProjectTitle") %>'
                                    CssClass="form-control"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <%# Eval("ProjectTitle") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Description">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditDescription" runat="server" Text='<%# Bind("ProjectDescription") %>'
                                    TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <%# Eval("ProjectDescription") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Image">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditImage" runat="server" Text='<%# Bind("ProjectImage") %>'
                                    CssClass="form-control"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="imgProject" runat="server" ImageUrl='<%# Eval("ProjectImage") %>'
                                    Width="100px" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Live Link">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditLink" runat="server" Text='<%# Bind("ProjectLink") %>'
                                    CssClass="form-control"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <a href='<%# Eval("ProjectLink") %>' target="_blank">Demo</a>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Github">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEditGithub" runat="server" Text='<%# Bind("GithubLink") %>'
                                    CssClass="form-control"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <a href='<%# Eval("GithubLink") %>' target="_blank">Source</a>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:CheckBoxField DataField="IsFeatured" HeaderText="Featured" />

                        <asp:TemplateField HeaderText="Order">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnUp" runat="server" CommandName="MoveUp" CommandArgument='<%# Eval("ProjectID") %>'>
                        ⬆
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDown" runat="server" CommandName="MoveDown" CommandArgument='<%# Eval("ProjectID") %>'>
                        ⬇
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:CommandField ShowEditButton="true" />
                    </Columns>
                </asp:GridView>
            </section>

            <!-- Education Section -->
            

        </div>
    </form>
    <footer></footer>
</body>
</html>
