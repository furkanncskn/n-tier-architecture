CREATE TABLE [Users] (
  [USER_ID] INT IDENTITY(1, 1),
  [USER_NAME] VARCHAR(150) UNIQUE NOT NULL,
  [USER_PASSWORD] VARCHAR(150) NOT NULL,
  [USER_EMAIL] VARCHAR(150) NOT NULL,
  [USER_REGISTER_DATE] datetime NOT NULL DEFAULT (GETDATE()),
  [USER_IS_ACTIVE] BIT NOT NULL DEFAULT (1)
)

GO

ALTER TABLE [users] ADD PRIMARY KEY(USER_ID)

GO