USE [Obveze]
GO

/****** Object:  Table [dbo].[Razpored]    Script Date: 2. 05. 2021 16:03:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Razpored](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Leto] [int] NOT NULL,
	[EnotaID] [int] NOT NULL,
	[OddelekID] [int] NOT NULL,
	[PredmetID] [int] NOT NULL,
	[ZaposleniID] [int] NOT NULL,
	[VrstaObvezeID] [int] NOT NULL,
	[Ure] [float] NOT NULL,
	[Število dijakov] [int] NULL,
	[Procent obveze] [float] NULL,
	[Skupina] [nvarchar](50) NULL,
	[DolžinaBloka] [int] NULL,
	[Število blokov] [int] NULL,
	[Učilnice] [nvarchar](100) NULL,
	[Opombe] [nvarchar](50) NULL,
	[DatumVnosa] [datetime] NULL,
	[Vnesel] [nvarchar](50) NULL,
	[DatumPopravka] [datetime] NULL,
	[Popravil] [nvarchar](50) NULL,
 CONSTRAINT [PK_Razpored_2] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


ALTER TABLE [dbo].[Razpored]  WITH CHECK ADD  CONSTRAINT [FK_Razpored_Enote1] FOREIGN KEY([EnotaID])
REFERENCES [dbo].[Enote] ([EnotaID])
GO

ALTER TABLE [dbo].[Razpored] CHECK CONSTRAINT [FK_Razpored_Enote1]
GO

ALTER TABLE [dbo].[Razpored]  WITH CHECK ADD  CONSTRAINT [FK_Razpored_Oddelki1] FOREIGN KEY([OddelekID])
REFERENCES [dbo].[Oddelki] ([OddelekID])
GO

ALTER TABLE [dbo].[Razpored] CHECK CONSTRAINT [FK_Razpored_Oddelki1]
GO

ALTER TABLE [dbo].[Razpored]  WITH CHECK ADD  CONSTRAINT [FK_Razpored_Predmeti1] FOREIGN KEY([PredmetID])
REFERENCES [dbo].[Predmeti] ([PredmetID])
GO

ALTER TABLE [dbo].[Razpored] CHECK CONSTRAINT [FK_Razpored_Predmeti1]
GO


ALTER TABLE [dbo].[Razpored]  WITH CHECK ADD  CONSTRAINT [FK_Razpored_VrstaObveze1] FOREIGN KEY([VrstaObvezeID])
REFERENCES [dbo].[VrstaObveze] ([TipObvezeID])
GO

ALTER TABLE [dbo].[Razpored] CHECK CONSTRAINT [FK_Razpored_VrstaObveze1]
GO

ALTER TABLE [dbo].[Razpored]  WITH CHECK ADD  CONSTRAINT [FK_Razpored_Zaposleni1] FOREIGN KEY([ZaposleniID])
REFERENCES [dbo].[Zaposleni] ([ZapId])
GO

ALTER TABLE [dbo].[Razpored] CHECK CONSTRAINT [FK_Razpored_Zaposleni1]
GO

