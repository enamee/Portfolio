CREATE TABLE HomeContent (
    HomeId INT IDENTITY(1,1) PRIMARY KEY,
    HeroSubtitle NVARCHAR(200) NOT NULL,
    HeroDescription NVARCHAR(MAX) NOT NULL,
    ProfileImage NVARCHAR(300) NOT NULL,
    ProfileImageBack NVARCHAR(300) NOT NULL
);

CREATE TABLE AboutContent (
    AboutId INT IDENTITY(1,1) PRIMARY KEY,
    AboutText NVARCHAR(MAX) NOT NULL,
    AboutImage NVARCHAR(300) NOT NULL
);

CREATE TABLE SkillCategories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,      -- Unique ID
    CategoryName NVARCHAR(100) NOT NULL UNIQUE,    -- e.g., Frontend, Backend, Database
    DisplayOrder INT NOT NULL,                     -- Order in which categories are shown
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Skills (
    SkillID INT IDENTITY(1,1) PRIMARY KEY,          -- Unique ID
    SkillName NVARCHAR(100) NOT NULL,               -- e.g., JavaScript
    CategoryID INT NOT NULL,                        -- FK → SkillCategories
    ProficiencyLevel INT NOT NULL 
        CHECK (ProficiencyLevel BETWEEN 0 AND 100), -- % (0–100)
    DisplayOrder INT NOT NULL,                      -- Order inside category
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Skills_CategoryID FOREIGN KEY (CategoryID)
        REFERENCES SkillCategories(CategoryID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Projects (
    ProjectID INT IDENTITY(1,1) PRIMARY KEY,
    ProjectTitle NVARCHAR(200) NOT NULL,
    ProjectDescription NVARCHAR(MAX) NULL,
    ProjectImage NVARCHAR(255) NULL,       -- path or URL
    ProjectLink NVARCHAR(255) NULL,        -- demo/live link
    GithubLink NVARCHAR(255) NULL,         -- source code
    IsFeatured BIT DEFAULT 0,              -- featured project flag
    DisplayOrder INT NOT NULL,             -- ordering for featured
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    Languages NVARCHAR(max) NULL
);

CREATE TABLE Education (
    EducationID INT IDENTITY(1,1) PRIMARY KEY,
    Degree NVARCHAR(200) NOT NULL,
    Institution NVARCHAR(200) NOT NULL,
    StartYear INT NOT NULL,
    EndYear INT NULL, -- NULL if still ongoing
    GPA NVARCHAR(20) NULL,
    Description NVARCHAR(MAX) NULL,
    DisplayOrder INT NOT NULL DEFAULT 0, -- for custom ordering
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE ContactDetails (
    ContactID INT IDENTITY(1,1) PRIMARY KEY,
    Email NVARCHAR(150) NOT NULL,
    Phone NVARCHAR(50) NULL,
    Location NVARCHAR(150) NULL,
    LinkedIn NVARCHAR(200) NULL,
    GitHub NVARCHAR(200) NULL,
    Twitter NVARCHAR(200) NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE ContactMessages (
    MessageID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(150) NOT NULL,
    Message NVARCHAR(MAX) NOT NULL,
    SubmittedAt DATETIME DEFAULT GETDATE()
);
