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