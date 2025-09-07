<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Portfolio.Admin" MaintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <header>
        <section class="project">
        </section>
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

            <h3>Add New Home Content</h3>
            <asp:TextBox ID="txtSubtitle" runat="server" Placeholder="Subtitle"></asp:TextBox><br />
            <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4" Placeholder="Description"></asp:TextBox><br />
            <asp:TextBox ID="txtProfileImage" runat="server" Placeholder="Profile Image URL"></asp:TextBox><br />
            <asp:TextBox ID="txtProfileImageBack" runat="server" Placeholder="Profile Image Back URL"></asp:TextBox><br />
            <asp:Button ID="btnAddHome" runat="server" Text="Add Home Content" OnClick="btnAddHome_Click" />

            <!-- About Section -->
            <section class="admin-section" id="about-section">
                <h2>Manage About Section</h2>

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
            <asp:GridView ID="gvSkills" runat="server" AutoGenerateColumns="False" OnRowEditing="gvSkills_RowEditing"
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

        </div>
    </form>
    <footer></footer>
</body>
</html>
