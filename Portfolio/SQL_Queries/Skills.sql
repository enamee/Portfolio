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
    UpdatedAt DATETIME DEFAULT GETDATE()
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


INSERT INTO HomeContent (HeroSubtitle, HeroDescription, ProfileImage, ProfileImageBack)
VALUES ('Full Stack Web Developer', 'with knowledge in development, I offer quality work', 
'src/Portfolio_home.png', 'src/Portfolio_home.png');

INSERT INTO AboutContent (AboutText, AboutImage)
VALUES 
('Hello! I''m a passionate full stack web developer and 3rd-year Computer Science student at KUET. 
I enjoy building intuitive and efficient web applications using modern technologies, 
with a focus on clean code and strong user experience.

I love tackling real-world problems with thoughtful solutions, and I''m constantly learning and exploring new tools in web development. 
Whether it''s frontend design or backend logic, I aim to bring creativity, performance, and functionality together in every project.

Beyond coding, I believe that great development is about creating digital experiences that engage, inform, and make an impact.',
'src/Portfolio_about.png');

INSERT INTO Projects (ProjectTitle, ProjectDescription, ProjectImage, ProjectLink, GithubLink, IsFeatured, DisplayOrder)
VALUES
(
    'Web Development',
    'Creating modern, responsive websites and web applications using the latest technologies. From simple landing pages to complex full-stack applications, I deliver quality solutions tailored to your needs.',
    '/uploads/projects/webdev.png',   -- placeholder image
    'https://example.com/webdev',     -- demo/live link (replace later)
    'https://github.com/yourname/webdev', -- repo link (replace later)
    1,   -- featured
    1    -- display order
),
(
    'Web Design',
    'Designing beautiful, user-friendly interfaces that provide excellent user experience. I focus on clean, modern designs that are both aesthetically pleasing and functional across all devices.',
    '/uploads/projects/webdesign.png',
    'https://example.com/webdesign',
    'https://github.com/yourname/webdesign',
    1,   -- featured
    2    -- display order
),
(
    'Backend Development',
    'Building robust backend systems and APIs that power your applications. I work with various technologies including Node.js and ASP.NET to create scalable and secure server-side solutions.',
    '/uploads/projects/backend.png',
    'https://example.com/backend',
    'https://github.com/yourname/backend',
    0,   -- not featured
    3    -- display order (for "others")
),
(
    'Web Development',
    'Creating modern, responsive websites and web applications using the latest technologies. From simple landing pages to complex full-stack applications, I deliver quality solutions tailored to your needs.',
    'src/Portfolio_about.png',
    'https://example.com/webdev',
    'https://github.com/yourname/webdev',
    1,
    3
),
(
    'Portfolio Website',
    'A modern personal portfolio website with skills, projects, and blog integration, fully responsive across devices.',
    'src/Portfolio_about.png',
    'https://example.com/portfolio',
    'https://github.com/yourname/portfolio',
    0,
    2
),
(
    'Backend Development',
    'Building robust backend systems and APIs with Node.js and ASP.NET for scalable and secure server-side solutions.',
    'src/Portfolio_about.png',
    'https://example.com/backend',
    'https://github.com/yourname/backend',
    0,
    3
),
(
    'Web Design',
    'Designing beautiful, user-friendly interfaces that provide excellent user experience across all devices.',
    'src/Portfolio_about.png',
    'https://example.com/webdesign',
    'https://github.com/yourname/webdesign',
    0,
    4
),
(
    'Ride Sharing App',
    'Prototype ride-sharing platform with driver-passenger matching, route optimization, and in-app payments.',
    'src/Portfolio_about.png',
    'https://example.com/rideshare',
    'https://github.com/yourname/rideshare',
    0,
    5
),
(
    'Chat Application',
    'Real-time chat app using SignalR/WebSockets with rooms, notifications, and media sharing.',
    'src/Portfolio_about.png',
    'https://example.com/chatapp',
    'https://github.com/yourname/chatapp',
    0,
    6
),
(
    'Task Manager',
    'Project/task management tool with Kanban boards, team collaboration, and progress tracking.',
    'src/Portfolio_about.png',
    'https://example.com/taskmanager',
    'https://github.com/yourname/taskmanager',
    0,
    7
),
(
    'Inventory System',
    'System for managing product stock, suppliers, and purchase orders for small businesses.',
    'src/Portfolio_about.png',
    'https://example.com/inventory',
    'https://github.com/yourname/inventory',
    0,
    8
);

INSERT INTO Education (Degree, Institution, StartYear, EndYear, GPA, Description, DisplayOrder)
VALUES 
('B.Sc. in Computer Science', 'University of Example', 2018, 2022, 'CGPA: 3.85 / 4.00', 'Focused on software engineering, algorithms, and database systems.', 1),

('Higher Secondary', 'Example College', 2016, 2018, 'GPA: 5.00 / 5.00', 'Science background with majors in Physics, Chemistry, Mathematics.', 2),

('Secondary School', 'Example High School', 2014, 2016, 'GPA: 5.00 / 5.00', 'Major achievement: Science Fair 1st Place, 2015.', 3);

INSERT INTO ContactDetails (Email, Phone, Location, LinkedIn, GitHub, Twitter)
VALUES (
    'yourname@example.com',
    '+880 1234-567890',
    'Dhaka, Bangladesh',
    'https://www.linkedin.com/in/yourname',
    'https://github.com/yourname',
    'https://twitter.com/yourname'
);

CREATE TABLE ContactMessages (
    MessageID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(150) NOT NULL,
    Message NVARCHAR(MAX) NOT NULL,
    SubmittedAt DATETIME DEFAULT GETDATE()
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

-- Categories
INSERT INTO SkillCategories (CategoryName, DisplayOrder)
VALUES ('Frontend', 1), ('Backend', 2), ('Database', 3);

-- Skills
INSERT INTO Skills (SkillName, CategoryID, ProficiencyLevel, DisplayOrder)
VALUES
('HTML', 1, 95, 1),
('CSS', 1, 90, 2),
('JavaScript', 1, 85, 3),
('C#', 2, 80, 1),
('ASP.NET', 2, 75, 2),
('SQL', 3, 88, 1),
('MySQL', 3, 82, 2);


INSERT INTO ContactMessages (Name, Email, Message)
VALUES ('John Doe', 'john@example.com', 'Hello! I am interested in your projects.');
