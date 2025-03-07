USE [PRJ301_Assignment]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 2/24/2025 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[did] [int] NOT NULL,
	[dname] [varchar](150) NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[did] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 2/24/2025 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[eid] [int] NOT NULL,
	[ename] [varchar](150) NOT NULL,
	[did] [int] NOT NULL,
	[managerid] [int] NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[eid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Features]    Script Date: 2/24/2025 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Features](
	[fid] [int] NOT NULL,
	[url] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Features] PRIMARY KEY CLUSTERED 
(
	[fid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role_Feature]    Script Date: 2/24/2025 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role_Feature](
	[rid] [int] NOT NULL,
	[fid] [int] NOT NULL,
 CONSTRAINT [PK_Role_Feature] PRIMARY KEY CLUSTERED 
(
	[rid] ASC,
	[fid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 2/24/2025 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[rid] [int] NOT NULL,
	[rname] [varchar](150) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[rid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 2/24/2025 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[User_Role]    Script Date: 2/24/2025 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Role](
	[username] [varchar](150) NOT NULL,
	[rid] [int] NOT NULL,
 CONSTRAINT [PK_User_Role] PRIMARY KEY CLUSTERED 
(
	[username] ASC,
	[rid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2/24/2025 3:15:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[username] [varchar](150) NOT NULL,
	[password] [varchar](150) NOT NULL,
	[displayname] [nvarchar](150) NOT NULL,
	[eid] [int] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Departments] ([did], [dname]) VALUES (1, N'Director')
INSERT [dbo].[Departments] ([did], [dname]) VALUES (2, N'IT')
INSERT [dbo].[Departments] ([did], [dname]) VALUES (3, N'Accounting')
INSERT [dbo].[Departments] ([did], [dname]) VALUES (4, N'Sale')
GO
INSERT [dbo].[Employees] ([eid], [ename], [did], [managerid]) VALUES (1, N'Ngo Tung Son', 2, NULL)
INSERT [dbo].[Employees] ([eid], [ename], [did], [managerid]) VALUES (2, N'mr A', 2, 1)
INSERT [dbo].[Employees] ([eid], [ename], [did], [managerid]) VALUES (3, N'mr B', 2, 1)
INSERT [dbo].[Employees] ([eid], [ename], [did], [managerid]) VALUES (4, N'mr D', 2, 2)
GO
INSERT [dbo].[Features] ([fid], [url]) VALUES (1, N'/student/create')
INSERT [dbo].[Features] ([fid], [url]) VALUES (2, N'/student/update')
INSERT [dbo].[Features] ([fid], [url]) VALUES (3, N'/student/delete')
GO
INSERT [dbo].[Role_Feature] ([rid], [fid]) VALUES (1, 1)
INSERT [dbo].[Role_Feature] ([rid], [fid]) VALUES (1, 2)
INSERT [dbo].[Role_Feature] ([rid], [fid]) VALUES (1, 3)
INSERT [dbo].[Role_Feature] ([rid], [fid]) VALUES (2, 1)
INSERT [dbo].[Role_Feature] ([rid], [fid]) VALUES (2, 2)
INSERT [dbo].[Role_Feature] ([rid], [fid]) VALUES (3, 1)
GO
INSERT [dbo].[Roles] ([rid], [rname]) VALUES (1, N'boss')
INSERT [dbo].[Roles] ([rid], [rname]) VALUES (2, N'team leader')
INSERT [dbo].[Roles] ([rid], [rname]) VALUES (3, N'staff')
GO
INSERT [dbo].[User_Role] ([username], [rid]) VALUES (N'mra', 3)
INSERT [dbo].[User_Role] ([username], [rid]) VALUES (N'mrb', 2)
INSERT [dbo].[User_Role] ([username], [rid]) VALUES (N'sonnt', 1)
GO
INSERT [dbo].[Users] ([username], [password], [displayname], [eid]) VALUES (N'mra', N'123', N'Mr ABC', 2)
INSERT [dbo].[Users] ([username], [password], [displayname], [eid]) VALUES (N'mrb', N'123', N'Mr Fuc', 3)
INSERT [dbo].[Users] ([username], [password], [displayname], [eid]) VALUES (N'mrd', N'123', N'Mr D', 4)
INSERT [dbo].[Users] ([username], [password], [displayname], [eid]) VALUES (N'sonnt', N'123', N'Boy ?i dream chi?n, ch?a có ng??i yêu', 1)
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Departments] FOREIGN KEY([did])
REFERENCES [dbo].[Departments] ([did])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Departments]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Employees] FOREIGN KEY([managerid])
REFERENCES [dbo].[Employees] ([eid])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Employees]
GO
ALTER TABLE [dbo].[Role_Feature]  WITH CHECK ADD  CONSTRAINT [FK_Role_Feature_Features] FOREIGN KEY([fid])
REFERENCES [dbo].[Features] ([fid])
GO
ALTER TABLE [dbo].[Role_Feature] CHECK CONSTRAINT [FK_Role_Feature_Features]
GO
ALTER TABLE [dbo].[Role_Feature]  WITH CHECK ADD  CONSTRAINT [FK_Role_Feature_Roles] FOREIGN KEY([rid])
REFERENCES [dbo].[Roles] ([rid])
GO
ALTER TABLE [dbo].[Role_Feature] CHECK CONSTRAINT [FK_Role_Feature_Roles]
GO
ALTER TABLE [dbo].[User_Role]  WITH CHECK ADD  CONSTRAINT [FK_User_Role_Roles] FOREIGN KEY([rid])
REFERENCES [dbo].[Roles] ([rid])
GO
ALTER TABLE [dbo].[User_Role] CHECK CONSTRAINT [FK_User_Role_Roles]
GO
ALTER TABLE [dbo].[User_Role]  WITH CHECK ADD  CONSTRAINT [FK_User_Role_Users] FOREIGN KEY([username])
REFERENCES [dbo].[Users] ([username])
GO
ALTER TABLE [dbo].[User_Role] CHECK CONSTRAINT [FK_User_Role_Users]
GO
