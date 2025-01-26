CREATE TABLE [dbo].[PosticipiScadenze]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[Giorno] [int] NOT NULL,
[Mese] [int] NOT NULL,
[GiorniPosticipo] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PosticipiScadenze] ADD CONSTRAINT [PK_PosticipiScadenze] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
