CREATE TABLE [dbo].[Banche]
(
[ID] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[ABI] [nchar] (5) COLLATE Latin1_General_CI_AS NULL,
[CAB] [nchar] (5) COLLATE Latin1_General_CI_AS NULL,
[CC] [nchar] (12) COLLATE Latin1_General_CI_AS NULL,
[CIN] [nchar] (1) COLLATE Latin1_General_CI_AS NULL,
[IBAN] [nchar] (27) COLLATE Latin1_General_CI_AS NULL,
[SWIFT] [nvarchar] (11) COLLATE Latin1_General_CI_AS NULL,
[ExpRb] [bit] NULL,
[ExpRb_Default] [bit] NULL,
[ExpRb_FileMagnetica] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[ExpRb_FileCartacea] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL,
[SIA] [nchar] (5) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Banche] ADD CONSTRAINT [PK_Banche] PRIMARY KEY CLUSTERED  ([ID]) ON [PRIMARY]
GO
