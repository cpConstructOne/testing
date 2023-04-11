USE [CWC_Data_2_0]
GO
/****** Object:  Schema [APP_DASHBOARD]    Script Date: 4/11/2023 3:00:05 PM ******/
CREATE SCHEMA [APP_DASHBOARD]
GO
/****** Object:  Schema [APP_IGMS]    Script Date: 4/11/2023 3:00:05 PM ******/
CREATE SCHEMA [APP_IGMS]
GO
/****** Object:  Schema [APP_SMARTLINKPLUS]    Script Date: 4/11/2023 3:00:05 PM ******/
CREATE SCHEMA [APP_SMARTLINKPLUS]
GO
/****** Object:  Schema [MAIN]    Script Date: 4/11/2023 3:00:05 PM ******/
CREATE SCHEMA [MAIN]
GO
/****** Object:  Schema [ML]    Script Date: 4/11/2023 3:00:05 PM ******/
CREATE SCHEMA [ML]
GO
/****** Object:  UserDefinedFunction [MAIN].[AlertLevel_Critical]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [MAIN].[AlertLevel_Critical]()
RETURNS [int]
AS 
BEGIN	   
    RETURN 10;
END

GO
/****** Object:  UserDefinedFunction [MAIN].[AlertLevel_High]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [MAIN].[AlertLevel_High]()
RETURNS [int]
AS 
BEGIN	   
    RETURN 7;
END

GO
/****** Object:  UserDefinedFunction [MAIN].[AlertLevel_Low]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [MAIN].[AlertLevel_Low]()
RETURNS [int]
AS 
BEGIN	   
    RETURN 3;
END

GO
/****** Object:  UserDefinedFunction [MAIN].[AlertLevel_Medium]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [MAIN].[AlertLevel_Medium]()
RETURNS [int]
AS 
BEGIN	   
    RETURN 5;
END

GO
/****** Object:  UserDefinedFunction [MAIN].[AlertLevel_Zero]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [MAIN].[AlertLevel_Zero]()
RETURNS [int]
AS 
BEGIN	   
    RETURN 0;
END

GO
/****** Object:  UserDefinedFunction [MAIN].[ToAlertLevel]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [MAIN].[ToAlertLevel] (@ALERT_LEVEL_CODE [int])
RETURNS [nvarchar](30)
AS 
BEGIN
    DECLARE @ALERT_LEVEL NVARCHAR(30)
    IF @ALERT_LEVEL_CODE IS NULL
	   SET @ALERT_LEVEL = NULL
    ELSE IF @ALERT_LEVEL_CODE = [MAIN].[AlertLevel_Zero]()
	   SET @ALERT_LEVEL = 'ZERO'
    ELSE IF @ALERT_LEVEL_CODE = [MAIN].[AlertLevel_Low]()
	   SET @ALERT_LEVEL = 'LOW'
    ELSE IF @ALERT_LEVEL_CODE = [MAIN].[AlertLevel_Medium]()
	   SET @ALERT_LEVEL = 'MEDIUM'
    ELSE IF @ALERT_LEVEL_CODE = [MAIN].[AlertLevel_High]()
	   SET @ALERT_LEVEL = 'HIGH'
    ELSE IF @ALERT_LEVEL_CODE = [MAIN].[AlertLevel_Critical]()
	   SET @ALERT_LEVEL = 'CRITICAL'
    ELSE 
	   SET @ALERT_LEVEL = '[UNDEFINED]'	   
    RETURN @ALERT_LEVEL
END

GO
/****** Object:  UserDefinedFunction [MAIN].[ToAlertLevelCode]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [MAIN].[ToAlertLevelCode] (@ALERT_LEVEL [nvarchar](30))
RETURNS [int]
AS 
BEGIN
    DECLARE @ALERT_LEVEL_CODE [int]
    IF @ALERT_LEVEL IS NULL
	   SET @ALERT_LEVEL_CODE = NULL
    ELSE IF @ALERT_LEVEL = 'ZERO'
	   SET @ALERT_LEVEL_CODE = [MAIN].[AlertLevel_Zero]()
    ELSE IF @ALERT_LEVEL = 'LOW'
	   SET @ALERT_LEVEL_CODE = [MAIN].[AlertLevel_Low]()
    ELSE IF @ALERT_LEVEL = 'MEDIUM'
	   SET @ALERT_LEVEL_CODE = [MAIN].[AlertLevel_Medium]()
    ELSE IF @ALERT_LEVEL = 'HIGH'
	   SET @ALERT_LEVEL_CODE = [MAIN].[AlertLevel_High]()
    ELSE IF @ALERT_LEVEL = 'CRITICAL'
	   SET @ALERT_LEVEL_CODE = [MAIN].[AlertLevel_Critical]()
    ELSE 
	   SET @ALERT_LEVEL_CODE = NULL
    RETURN @ALERT_LEVEL
END

GO
/****** Object:  Table [dbo].[Account]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[acc_pk] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[acc_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Alarm]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alarm](
	[alarm_pk] [int] IDENTITY(1,1) NOT NULL,
	[alarm_alarmtfk] [int] NOT NULL,
	[alarm_progfk_source] [int] NULL,
	[alarm_fctfk] [int] NULL,
	[alarm_global_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Alarm] PRIMARY KEY CLUSTERED 
(
	[alarm_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AlarmEvent]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlarmEvent](
	[alarme_alarmufk] [int] NOT NULL,
	[alarme_alarmetfk] [int] NOT NULL,
	[alarme_arg_string] [nvarchar](max) NULL,
	[alarme_arg_int] [int] NULL,
	[alarme_arg_bool] [bit] NULL,
	[alarme_arg_double] [float] NULL,
	[alarme_arg_guid] [uniqueidentifier] NULL,
	[alarme_arg_time] [datetime] NULL,
	[alarme_arg_dfk] [int] NULL,
	[alarme_arg_usrfk] [int] NULL,
	[alarme_arg_progfk] [int] NULL,
	[alarme_arg_tidfk] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AlarmEventType]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlarmEventType](
	[alarmet_pk] [int] IDENTITY(1,1) NOT NULL,
	[alarmet_code] [nvarchar](64) NOT NULL,
	[alarmet_description] [nvarchar](2048) NULL,
	[alarmet_description_args] [nvarchar](2048) NULL,
	[alarmet_exgrpfk] [int] NULL,
 CONSTRAINT [PK_AlarmEventType] PRIMARY KEY CLUSTERED 
(
	[alarmet_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AlarmType]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlarmType](
	[alarmt_pk] [int] IDENTITY(1,1) NOT NULL,
	[alarmt_code] [nvarchar](64) NOT NULL,
	[alarmt_description] [nvarchar](2048) NULL,
 CONSTRAINT [PK_AlarmType] PRIMARY KEY CLUSTERED 
(
	[alarmt_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_AlarmType_Code] UNIQUE NONCLUSTERED 
(
	[alarmt_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AlarmUpdate]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlarmUpdate](
	[alarmu_pk] [int] IDENTITY(1,1) NOT NULL,
	[alarmu_alarmfk] [int] NOT NULL,
	[alarmu_progfk_source] [int] NULL,
	[alarmu_time] [datetime] NOT NULL,
	[alarmu_is_keyframe] [bit] NULL,
 CONSTRAINT [PK_AlarmUpdate] PRIMARY KEY CLUSTERED 
(
	[alarmu_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Device]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Device](
	[d_pk] [int] IDENTITY(1,1) NOT NULL,
	[d_dtfk] [int] NOT NULL,
	[d_code] [nvarchar](128) NULL,
	[d_fctfk] [int] NULL,
	[d_parent_dfk] [int] NULL,
	[d_parent_index] [int] NULL,
	[d_global_id] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Device] PRIMARY KEY CLUSTERED 
(
	[d_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DeviceEvent]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceEvent](
	[de_dufk] [int] NOT NULL,
	[de_detfk] [int] NOT NULL,
	[de_arg_string] [nvarchar](max) NULL,
	[de_arg_int] [int] NULL,
	[de_arg_bool] [bit] NULL,
	[de_arg_double] [float] NULL,
	[de_arg_guid] [uniqueidentifier] NULL,
	[de_arg_time] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DeviceEventType]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceEventType](
	[det_pk] [int] IDENTITY(1,1) NOT NULL,
	[det_code] [nvarchar](64) NOT NULL,
	[det_description] [nvarchar](2048) NULL,
	[det_exgrpfk] [int] NULL,
	[det_description_args] [nvarchar](2048) NULL,
 CONSTRAINT [PK_DeviceEventType] PRIMARY KEY CLUSTERED 
(
	[det_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DeviceType]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceType](
	[dt_pk] [int] IDENTITY(1,1) NOT NULL,
	[dt_code] [nvarchar](64) NOT NULL,
	[dt_description] [nvarchar](2048) NULL,
 CONSTRAINT [PK_DeviceType] PRIMARY KEY CLUSTERED 
(
	[dt_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DeviceUpdate]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceUpdate](
	[du_pk] [int] IDENTITY(1,1) NOT NULL,
	[du_dfk] [int] NOT NULL,
	[du_progfk_source] [int] NULL,
	[du_time] [datetime] NOT NULL,
	[du_is_keyframe] [bit] NULL,
 CONSTRAINT [PK_DeviceUpdate] PRIMARY KEY CLUSTERED 
(
	[du_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EventExclusionGroup]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventExclusionGroup](
	[exgrp_pk] [int] IDENTITY(1,1) NOT NULL,
	[exgrp_code] [nvarchar](128) NOT NULL,
	[exgrp_description] [nvarchar](2048) NULL,
 CONSTRAINT [PK_EventExclusionGroup] PRIMARY KEY CLUSTERED 
(
	[exgrp_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Facility]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facility](
	[fct_pk] [int] IDENTITY(1,1) NOT NULL,
	[fct_code] [nvarchar](60) NOT NULL,
	[fct_name] [nvarchar](256) NULL,
	[fct_is_default] [bit] NULL,
 CONSTRAINT [PK_Facility] PRIMARY KEY CLUSTERED 
(
	[fct_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Grade]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grade](
	[grd_pk] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Grade] PRIMARY KEY CLUSTERED 
(
	[grd_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GradeFactor]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GradeFactor](
	[gf_pk] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_GradeFactor] PRIMARY KEY CLUSTERED 
(
	[gf_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[InventoryStorage]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryStorage](
	[inv_pk] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_InventoryStorage] PRIMARY KEY CLUSTERED 
(
	[inv_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[prd_pk] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[prd_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductBatch]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductBatch](
	[prdbatch_pk] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_ProductBatch] PRIMARY KEY CLUSTERED 
(
	[prdbatch_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Program]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Program](
	[prog_pk] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Program] PRIMARY KEY CLUSTERED 
(
	[prog_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[tid_pk] [int] IDENTITY(1,1) NOT NULL,
	[tid_tidtfk] [int] NOT NULL,
	[tid_progfk_source] [int] NOT NULL,
	[tid_fctfk] [int] NOT NULL,
	[tid_global_id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[tid_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TransactionEvent]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionEvent](
	[tide_tidufk] [int] NOT NULL,
	[tide_tidetfk] [int] NOT NULL,
	[tide_arg_string] [nvarchar](max) NULL,
	[tide_arg_int] [int] NULL,
	[tide_arg_bool] [bit] NULL,
	[tide_arg_double] [float] NULL,
	[tide_arg_guid] [uniqueidentifier] NULL,
	[tide_arg_time] [datetime] NULL,
	[tide_arg_dfk] [int] NULL,
	[tide_arg_usrfk] [int] NULL,
	[tide_arg_trkfk] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TransactionEventType]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionEventType](
	[tidet_pk] [int] IDENTITY(1,1) NOT NULL,
	[tidet_code] [nvarchar](64) NOT NULL,
	[tidet_description] [nvarchar](2048) NULL,
	[tidet_description_args] [nvarchar](2048) NULL,
	[tidet_exgrpfk] [int] NULL,
 CONSTRAINT [PK_TransactionEventType] PRIMARY KEY CLUSTERED 
(
	[tidet_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TransactionType]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionType](
	[tidt_pk] [int] IDENTITY(1,1) NOT NULL,
	[tidt_code] [nvarchar](64) NOT NULL,
	[tidt_description] [nvarchar](2048) NULL,
 CONSTRAINT [PK_TransactionType] PRIMARY KEY CLUSTERED 
(
	[tidt_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TransactionUpdate]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionUpdate](
	[tidu_pk] [int] IDENTITY(1,1) NOT NULL,
	[tidu_tidfk] [int] NOT NULL,
	[tidu_progfk_source] [int] NULL,
	[tidu_time] [datetime] NOT NULL,
	[tidu_is_keyframe] [bit] NULL,
 CONSTRAINT [PK_TransactionUpdate] PRIMARY KEY CLUSTERED 
(
	[tidu_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Truck]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Truck](
	[trk_pk] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Truck] PRIMARY KEY CLUSTERED 
(
	[trk_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TruckSpot]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TruckSpot](
	[spot_pk] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_TruckSpot] PRIMARY KEY CLUSTERED 
(
	[spot_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[usr_pk] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[usr_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WorkArea]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkArea](
	[wa_pk] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_WorkArea] PRIMARY KEY CLUSTERED 
(
	[wa_pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [MAIN].[Alarm_View]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [MAIN].[Alarm_View]
AS
SELECT  
    [alarm_pk] AS [PK],
    [alarm_alarmtfk] AS [TYPE FK],
    [alarm_progfk_source] AS [SOURCE PROGRAM FK],
    [alarm_fctfk] AS [FACILITY FK],
    [alarm_global_id] AS [GLOBAL ID]
FROM [dbo].[Alarm]

GO
/****** Object:  View [MAIN].[AlarmEvent_View]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [MAIN].[AlarmEvent_View]
AS
SELECT  
    [alarme_alarmufk] AS [UPDATE FK],
    [alarme_alarmetfk] AS [EVENT TYPE FK],
    [alarme_arg_string] AS [ARG STRING],
    [alarme_arg_int] AS [ARG INT],
    [alarme_arg_bool] AS [ARG BOOL],
    [alarme_arg_double] AS [ARG DOUBLE],
    [alarme_arg_guid] AS [ARG GUID],
    [alarme_arg_time] AS [ARG TIME],
    [alarme_arg_dfk] AS [ARG DEVICE FK],
    [alarme_arg_usrfk] AS [ARG USER FK],
    [alarme_arg_progfk] AS [ARG PROGRAM FK],
    [alarme_arg_tidfk] AS [ARG TRANSACTION FK]
FROM [dbo].[AlarmEvent]

GO
/****** Object:  View [MAIN].[AlarmEventType_View]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [MAIN].[AlarmEventType_View]
AS
SELECT  
    [alarmet_pk] AS [PK],
    [alarmet_code] AS [CODE],
    [alarmet_description] AS [DESCRIPTION],
    [alarmet_description_args] AS [DESCRIPTION (ARGS)],
    [alarmet_exgrpfk] AS [EXCLUSION GROUP FK],
    [exgrp_code] AS [EXCLUSION GROUP]
FROM [dbo].[AlarmEventType]
JOIN [dbo].[EventExclusionGroup] ON [alarmet_exgrpfk] = [exgrp_pk]

GO
/****** Object:  View [MAIN].[AlarmType_View]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [MAIN].[AlarmType_View]
AS
SELECT  
    [alarmt_pk] AS [PK],
    [alarmt_code] AS [CODE],
    [alarmt_description] AS [DESCRIPTION]
FROM [dbo].[AlarmType]

GO
/****** Object:  View [MAIN].[AlarmUpdate_View]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [MAIN].[AlarmUpdate_View]
AS
SELECT  
    [alarmu_pk] AS [PK],
    [alarmu_alarmfk] AS [ALARM FK],
    [alarmu_progfk_source] AS [SOURCE PROGRAM FK],
    [alarmu_time] AS [TIME], 
    ISNULL([alarmu_is_keyframe], 0) AS [IS KEYFRAME]
FROM [dbo].[AlarmUpdate]

GO
/****** Object:  View [MAIN].[Device_View]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [MAIN].[Device_View]
AS
SELECT  
    [d_pk] AS [PK],
    [d_dtfk] AS [TYPE FK],
    [d_code] AS [CODE],
    [d_fctfk] AS [FACILITY FK],
    [d_parent_dfk] AS [PARENT FK],
    [d_parent_index] AS [PARENT INDEX],
    [d_global_id] AS [GLOBAL ID]
FROM [dbo].[Device]

GO
/****** Object:  View [MAIN].[DeviceEvent_View]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [MAIN].[DeviceEvent_View]
AS
SELECT  
    [de_dufk] AS [UPDATE FK],
    [de_detfk] AS [EVENT TYPE FK],
    [de_arg_string] AS [ARG STRING],
    [de_arg_int] AS [ARG INT],
    [de_arg_bool] AS [ARG BOOL],
    [de_arg_double] AS [ARG DOUBLE],
    [de_arg_guid] AS [ARG GUID],
    [de_arg_time] AS [ARG TIME]
FROM [dbo].[DeviceEvent]

GO
/****** Object:  View [MAIN].[DeviceEventType_View]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [MAIN].[DeviceEventType_View]
AS
SELECT  
    [det_pk] AS [PK],
    [det_code] AS [CODE],
    [det_description] AS [DESCRIPTION],
    [det_description_args] AS [DESCRIPTION (ARGS)],
    [det_exgrpfk] AS [EXCLUSION GROUP FK],
    [exgrp_code] AS [EXCLUSION GROUP]
FROM [dbo].[DeviceEventType] 
JOIN [dbo].[EventExclusionGroup] ON [det_exgrpfk] = [exgrp_pk]

GO
/****** Object:  View [MAIN].[DeviceType_View]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [MAIN].[DeviceType_View]
AS
SELECT  
    [dt_pk] AS [PK],
    [dt_code] AS [CODE],
    [dt_description] AS [DESCRIPTION]
FROM [dbo].[DeviceType]

GO
/****** Object:  View [MAIN].[DeviceUpdate_View]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [MAIN].[DeviceUpdate_View]
AS
SELECT  
    [du_pk] AS [PK],
    [du_dfk] AS [DEVICE FK],
    [du_progfk_source] AS [SOURCE PROGRAM FK],
    [du_time] AS [TIME], 
    ISNULL([du_is_keyframe], 0) AS [IS KEYFRAME]
FROM [dbo].[DeviceUpdate]

GO
/****** Object:  View [MAIN].[EventExclusionGroup_View]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [MAIN].[EventExclusionGroup_View]
AS
SELECT  
    [exgrp_pk] AS [PK],
    [exgrp_code] AS [CODE],
    [exgrp_description] AS [DESCRIPTION]
FROM [dbo].[EventExclusionGroup]

GO
/****** Object:  View [MAIN].[Facility_View]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [MAIN].[Facility_View]
AS
SELECT  
    [fct_pk] AS [PK],
    [fct_code] AS [CODE],
    [fct_name] AS [NAME],
    ISNULL([fct_is_default], 0) AS [IS DEFAULT]
FROM [dbo].[Facility]

GO
/****** Object:  View [MAIN].[Transaction_View]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [MAIN].[Transaction_View]
AS
SELECT  
    [tid_pk] AS [PK],
    [tid_tidtfk] AS [TYPE FK],
    [tid_progfk_source] AS [SOURCE PROGRAM FK],
    [tid_fctfk] AS [FACILITY FK],
    [tid_global_id] AS [GLOBAL ID]
FROM [dbo].[Transaction]

GO
/****** Object:  View [MAIN].[TransactionEvent_View]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [MAIN].[TransactionEvent_View]
AS
SELECT  
    [tide_tidufk] AS [UPDATE FK],
    [tide_tidetfk] AS [EVENT TYPE FK],
    [tide_arg_string] AS [ARG STRING],
    [tide_arg_int] AS [ARG INT],
    [tide_arg_bool] AS [ARG BOOL],
    [tide_arg_double] AS [ARG DOUBLE],
    [tide_arg_guid] AS [ARG GUID],
    [tide_arg_time] AS [ARG TIME],
    [tide_arg_dfk] AS [ARG DEVICE FK],
    [tide_arg_usrfk] AS [ARG USER FK],
    [tide_arg_trkfk] AS [ARG TRUCK FK]
FROM [dbo].[TransactionEvent]

GO
/****** Object:  View [MAIN].[TransactionEventType_View]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [MAIN].[TransactionEventType_View]
AS
SELECT  
    [tidet_pk] AS [PK],
    [tidet_code] AS [CODE],
    [tidet_description] AS [DESCRIPTION],
    [tidet_description_args] AS [DESCRIPTION (ARGS)],
    [tidet_exgrpfk] AS [EXCLUSION GROUP FK],
    [exgrp_code] AS [EXCLUSION GROUP]
FROM [dbo].[TransactionEventType]
JOIN [dbo].[EventExclusionGroup] ON [tidet_exgrpfk] = [exgrp_pk]

GO
/****** Object:  View [MAIN].[TransactionType_View]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [MAIN].[TransactionType_View]
AS
SELECT  
    [tidt_pk] AS [PK],
    [tidt_code] AS [CODE],
    [tidt_description] AS [DESCRIPTION]
FROM [dbo].[TransactionType]

GO
/****** Object:  View [MAIN].[TransactionUpdate_View]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [MAIN].[TransactionUpdate_View]
AS
SELECT  
    [tidu_pk] AS [PK],
    [tidu_tidfk] AS [TRANSACTION FK],
    [tidu_progfk_source] AS [SOURCE PROGRAM FK],
    [tidu_time] AS [TIME], 
    ISNULL([tidu_is_keyframe], 0) AS [IS KEYFRAME]
FROM [dbo].[TransactionUpdate]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UIX_Device_d_code_d_fctfk]    Script Date: 4/11/2023 3:00:05 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Device_d_code_d_fctfk] ON [dbo].[Device]
(
	[d_code] ASC,
	[d_fctfk] ASC
)
WHERE ([d_code] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UIX_Device_d_parent_dfk_d_dtfk_d_parent_index]    Script Date: 4/11/2023 3:00:05 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UIX_Device_d_parent_dfk_d_dtfk_d_parent_index] ON [dbo].[Device]
(
	[d_parent_dfk] ASC,
	[d_dtfk] ASC,
	[d_parent_index] ASC
)
WHERE ([d_parent_dfk] IS NOT NULL AND [d_parent_index] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Alarm]  WITH CHECK ADD  CONSTRAINT [FK_Alarm_AlarmType] FOREIGN KEY([alarm_alarmtfk])
REFERENCES [dbo].[AlarmType] ([alarmt_pk])
GO
ALTER TABLE [dbo].[Alarm] CHECK CONSTRAINT [FK_Alarm_AlarmType]
GO
ALTER TABLE [dbo].[Alarm]  WITH CHECK ADD  CONSTRAINT [FK_Alarm_Facility] FOREIGN KEY([alarm_fctfk])
REFERENCES [dbo].[Facility] ([fct_pk])
GO
ALTER TABLE [dbo].[Alarm] CHECK CONSTRAINT [FK_Alarm_Facility]
GO
ALTER TABLE [dbo].[Alarm]  WITH CHECK ADD  CONSTRAINT [FK_Alarm_Program] FOREIGN KEY([alarm_progfk_source])
REFERENCES [dbo].[Program] ([prog_pk])
GO
ALTER TABLE [dbo].[Alarm] CHECK CONSTRAINT [FK_Alarm_Program]
GO
ALTER TABLE [dbo].[AlarmEvent]  WITH CHECK ADD  CONSTRAINT [FK_AlarmEvent_AlarmEventType] FOREIGN KEY([alarme_alarmetfk])
REFERENCES [dbo].[AlarmEventType] ([alarmet_pk])
GO
ALTER TABLE [dbo].[AlarmEvent] CHECK CONSTRAINT [FK_AlarmEvent_AlarmEventType]
GO
ALTER TABLE [dbo].[AlarmEvent]  WITH CHECK ADD  CONSTRAINT [FK_AlarmEvent_AlarmUpdate] FOREIGN KEY([alarme_alarmufk])
REFERENCES [dbo].[AlarmUpdate] ([alarmu_pk])
GO
ALTER TABLE [dbo].[AlarmEvent] CHECK CONSTRAINT [FK_AlarmEvent_AlarmUpdate]
GO
ALTER TABLE [dbo].[AlarmEvent]  WITH CHECK ADD  CONSTRAINT [FK_AlarmEvent_Device] FOREIGN KEY([alarme_arg_dfk])
REFERENCES [dbo].[Device] ([d_pk])
GO
ALTER TABLE [dbo].[AlarmEvent] CHECK CONSTRAINT [FK_AlarmEvent_Device]
GO
ALTER TABLE [dbo].[AlarmEvent]  WITH CHECK ADD  CONSTRAINT [FK_AlarmEvent_Program] FOREIGN KEY([alarme_arg_progfk])
REFERENCES [dbo].[Program] ([prog_pk])
GO
ALTER TABLE [dbo].[AlarmEvent] CHECK CONSTRAINT [FK_AlarmEvent_Program]
GO
ALTER TABLE [dbo].[AlarmEvent]  WITH CHECK ADD  CONSTRAINT [FK_AlarmEvent_Transaction] FOREIGN KEY([alarme_arg_tidfk])
REFERENCES [dbo].[Transaction] ([tid_pk])
GO
ALTER TABLE [dbo].[AlarmEvent] CHECK CONSTRAINT [FK_AlarmEvent_Transaction]
GO
ALTER TABLE [dbo].[AlarmEvent]  WITH CHECK ADD  CONSTRAINT [FK_AlarmEvent_User] FOREIGN KEY([alarme_arg_usrfk])
REFERENCES [dbo].[User] ([usr_pk])
GO
ALTER TABLE [dbo].[AlarmEvent] CHECK CONSTRAINT [FK_AlarmEvent_User]
GO
ALTER TABLE [dbo].[AlarmEventType]  WITH CHECK ADD  CONSTRAINT [FK_AlarmEventType_EventExclusionGroup] FOREIGN KEY([alarmet_exgrpfk])
REFERENCES [dbo].[EventExclusionGroup] ([exgrp_pk])
GO
ALTER TABLE [dbo].[AlarmEventType] CHECK CONSTRAINT [FK_AlarmEventType_EventExclusionGroup]
GO
ALTER TABLE [dbo].[AlarmUpdate]  WITH CHECK ADD  CONSTRAINT [FK_AlarmUpdate_Alarm] FOREIGN KEY([alarmu_alarmfk])
REFERENCES [dbo].[Alarm] ([alarm_pk])
GO
ALTER TABLE [dbo].[AlarmUpdate] CHECK CONSTRAINT [FK_AlarmUpdate_Alarm]
GO
ALTER TABLE [dbo].[AlarmUpdate]  WITH CHECK ADD  CONSTRAINT [FK_AlarmUpdate_Program] FOREIGN KEY([alarmu_progfk_source])
REFERENCES [dbo].[Program] ([prog_pk])
GO
ALTER TABLE [dbo].[AlarmUpdate] CHECK CONSTRAINT [FK_AlarmUpdate_Program]
GO
ALTER TABLE [dbo].[Device]  WITH CHECK ADD  CONSTRAINT [FK_Device_Device] FOREIGN KEY([d_parent_dfk])
REFERENCES [dbo].[Device] ([d_pk])
GO
ALTER TABLE [dbo].[Device] CHECK CONSTRAINT [FK_Device_Device]
GO
ALTER TABLE [dbo].[Device]  WITH CHECK ADD  CONSTRAINT [FK_Device_DeviceType] FOREIGN KEY([d_dtfk])
REFERENCES [dbo].[DeviceType] ([dt_pk])
GO
ALTER TABLE [dbo].[Device] CHECK CONSTRAINT [FK_Device_DeviceType]
GO
ALTER TABLE [dbo].[Device]  WITH CHECK ADD  CONSTRAINT [FK_Device_Facility] FOREIGN KEY([d_fctfk])
REFERENCES [dbo].[Facility] ([fct_pk])
GO
ALTER TABLE [dbo].[Device] CHECK CONSTRAINT [FK_Device_Facility]
GO
ALTER TABLE [dbo].[DeviceEvent]  WITH CHECK ADD  CONSTRAINT [FK_DeviceEvent_DeviceEventType] FOREIGN KEY([de_detfk])
REFERENCES [dbo].[DeviceEventType] ([det_pk])
GO
ALTER TABLE [dbo].[DeviceEvent] CHECK CONSTRAINT [FK_DeviceEvent_DeviceEventType]
GO
ALTER TABLE [dbo].[DeviceEvent]  WITH CHECK ADD  CONSTRAINT [FK_DeviceEvent_DeviceUpdate] FOREIGN KEY([de_dufk])
REFERENCES [dbo].[DeviceUpdate] ([du_pk])
GO
ALTER TABLE [dbo].[DeviceEvent] CHECK CONSTRAINT [FK_DeviceEvent_DeviceUpdate]
GO
ALTER TABLE [dbo].[DeviceEventType]  WITH CHECK ADD  CONSTRAINT [FK_DeviceEventType_EventExclusionGroup] FOREIGN KEY([det_exgrpfk])
REFERENCES [dbo].[EventExclusionGroup] ([exgrp_pk])
GO
ALTER TABLE [dbo].[DeviceEventType] CHECK CONSTRAINT [FK_DeviceEventType_EventExclusionGroup]
GO
ALTER TABLE [dbo].[DeviceUpdate]  WITH CHECK ADD  CONSTRAINT [FK_DeviceUpdate_Device] FOREIGN KEY([du_dfk])
REFERENCES [dbo].[Device] ([d_pk])
GO
ALTER TABLE [dbo].[DeviceUpdate] CHECK CONSTRAINT [FK_DeviceUpdate_Device]
GO
ALTER TABLE [dbo].[DeviceUpdate]  WITH CHECK ADD  CONSTRAINT [FK_DeviceUpdate_Program] FOREIGN KEY([du_progfk_source])
REFERENCES [dbo].[Program] ([prog_pk])
GO
ALTER TABLE [dbo].[DeviceUpdate] CHECK CONSTRAINT [FK_DeviceUpdate_Program]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_Facility] FOREIGN KEY([tid_fctfk])
REFERENCES [dbo].[Facility] ([fct_pk])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_Facility]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_Program] FOREIGN KEY([tid_progfk_source])
REFERENCES [dbo].[Program] ([prog_pk])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_Program]
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_TransactionType] FOREIGN KEY([tid_tidtfk])
REFERENCES [dbo].[TransactionType] ([tidt_pk])
GO
ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_TransactionType]
GO
ALTER TABLE [dbo].[TransactionEvent]  WITH CHECK ADD  CONSTRAINT [FK_TransactionEvent_Device] FOREIGN KEY([tide_arg_dfk])
REFERENCES [dbo].[Device] ([d_pk])
GO
ALTER TABLE [dbo].[TransactionEvent] CHECK CONSTRAINT [FK_TransactionEvent_Device]
GO
ALTER TABLE [dbo].[TransactionEvent]  WITH CHECK ADD  CONSTRAINT [FK_TransactionEvent_TransactionEventType] FOREIGN KEY([tide_tidetfk])
REFERENCES [dbo].[TransactionEventType] ([tidet_pk])
GO
ALTER TABLE [dbo].[TransactionEvent] CHECK CONSTRAINT [FK_TransactionEvent_TransactionEventType]
GO
ALTER TABLE [dbo].[TransactionEvent]  WITH CHECK ADD  CONSTRAINT [FK_TransactionEvent_TransactionUpdate] FOREIGN KEY([tide_tidufk])
REFERENCES [dbo].[TransactionUpdate] ([tidu_pk])
GO
ALTER TABLE [dbo].[TransactionEvent] CHECK CONSTRAINT [FK_TransactionEvent_TransactionUpdate]
GO
ALTER TABLE [dbo].[TransactionEvent]  WITH CHECK ADD  CONSTRAINT [FK_TransactionEvent_Truck] FOREIGN KEY([tide_arg_trkfk])
REFERENCES [dbo].[Truck] ([trk_pk])
GO
ALTER TABLE [dbo].[TransactionEvent] CHECK CONSTRAINT [FK_TransactionEvent_Truck]
GO
ALTER TABLE [dbo].[TransactionEvent]  WITH CHECK ADD  CONSTRAINT [FK_TransactionEvent_User] FOREIGN KEY([tide_arg_usrfk])
REFERENCES [dbo].[User] ([usr_pk])
GO
ALTER TABLE [dbo].[TransactionEvent] CHECK CONSTRAINT [FK_TransactionEvent_User]
GO
ALTER TABLE [dbo].[TransactionEventType]  WITH CHECK ADD  CONSTRAINT [FK_TransactionEventType_EventExclusionGroup] FOREIGN KEY([tidet_exgrpfk])
REFERENCES [dbo].[EventExclusionGroup] ([exgrp_pk])
GO
ALTER TABLE [dbo].[TransactionEventType] CHECK CONSTRAINT [FK_TransactionEventType_EventExclusionGroup]
GO
ALTER TABLE [dbo].[TransactionUpdate]  WITH CHECK ADD  CONSTRAINT [FK_TransactionUpdate_Program] FOREIGN KEY([tidu_progfk_source])
REFERENCES [dbo].[Program] ([prog_pk])
GO
ALTER TABLE [dbo].[TransactionUpdate] CHECK CONSTRAINT [FK_TransactionUpdate_Program]
GO
ALTER TABLE [dbo].[TransactionUpdate]  WITH CHECK ADD  CONSTRAINT [FK_TransactionUpdate_Transaction] FOREIGN KEY([tidu_tidfk])
REFERENCES [dbo].[Transaction] ([tid_pk])
GO
ALTER TABLE [dbo].[TransactionUpdate] CHECK CONSTRAINT [FK_TransactionUpdate_Transaction]
GO
ALTER TABLE [dbo].[Device]  WITH CHECK ADD  CONSTRAINT [CK_Device_d_code_null] CHECK  (([d_code] IS NOT NULL OR [d_parent_dfk] IS NOT NULL))
GO
ALTER TABLE [dbo].[Device] CHECK CONSTRAINT [CK_Device_d_code_null]
GO
ALTER TABLE [dbo].[Device]  WITH CHECK ADD  CONSTRAINT [CK_Device_d_dtfk_not_null] CHECK  (([d_dtfk] IS NOT NULL))
GO
ALTER TABLE [dbo].[Device] CHECK CONSTRAINT [CK_Device_d_dtfk_not_null]
GO
ALTER TABLE [dbo].[Device]  WITH CHECK ADD  CONSTRAINT [CK_Device_d_fctfk_null] CHECK  (([d_fctfk] IS NOT NULL OR [d_parent_dfk] IS NOT NULL))
GO
ALTER TABLE [dbo].[Device] CHECK CONSTRAINT [CK_Device_d_fctfk_null]
GO
ALTER TABLE [dbo].[Device]  WITH CHECK ADD  CONSTRAINT [CK_Device_d_parent_dfk_not_self] CHECK  (([d_parent_dfk] IS NULL OR [d_parent_dfk]<>[d_pk]))
GO
ALTER TABLE [dbo].[Device] CHECK CONSTRAINT [CK_Device_d_parent_dfk_not_self]
GO
ALTER TABLE [dbo].[Device]  WITH CHECK ADD  CONSTRAINT [CK_Device_d_parent_index] CHECK  (([d_parent_dfk] IS NULL OR [d_parent_index] IS NOT NULL AND [d_parent_dfk] IS NOT NULL))
GO
ALTER TABLE [dbo].[Device] CHECK CONSTRAINT [CK_Device_d_parent_index]
GO
/****** Object:  StoredProcedure [dbo].[UpdateEventExclusionGroup]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateEventExclusionGroup]
    @CODE [nvarchar](64),
    @DESCRIPTION [nvarchar](2048)
AS
    SET NOCOUNT ON;
    IF @CODE IS NOT NULL
    BEGIN
        MERGE INTO dbo.[EventExclusionGroup] AS [EXGRP]
        USING (SELECT TOP 1 @CODE AS [CODE], @DESCRIPTION AS [DESC]) AS [ARGS]
        ON [ARGS].[CODE] = [EXGRP].[exgrp_code]
        WHEN MATCHED THEN
        UPDATE SET [EXGRP].[exgrp_description] = ISNULL([ARGS].[DESC], [EXGRP].[exgrp_description])
        WHEN NOT MATCHED THEN
        INSERT ([exgrp_code], [exgrp_description]) VALUES ([ARGS].[CODE], [ARGS].[DESC]);
    END;

GO
/****** Object:  StoredProcedure [MAIN].[UpdateAlarmEventType]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [MAIN].[UpdateAlarmEventType]
    @CODE [nvarchar](64),
    @DESCRIPTION [nvarchar](2048),
    @DESCRIPTION_ARGS [nvarchar](2048),
    @EXCLUSION_GROUP [nvarchar](128) = NULL
AS
    SET NOCOUNT ON;
    IF @CODE IS NOT NULL
    BEGIN
	   declare @exgrp_pk int = (select top 1 [exgrp_pk] from dbo.[EventExclusionGroup] where exgrp_code = @EXCLUSION_GROUP)
	   if @EXCLUSION_GROUP is not null and @exgrp_pk is null
	   BEGIN
		  EXEC [dbo].[UpdateEventExclusionGroup] @EXCLUSION_GROUP, NULL;
		  SET @exgrp_pk = (select top 1 [exgrp_pk] from dbo.[EventExclusionGroup] where exgrp_code = @EXCLUSION_GROUP)
	   END        

	   MERGE INTO dbo.AlarmEventType AS [ET]
	   USING (SELECT TOP 1 @CODE AS [CODE], @DESCRIPTION AS [DESC], @DESCRIPTION_ARGS AS [DESC ARGS]) AS [ARGS]
	   ON [ARGS].[CODE] = [ET].[alarmet_code]
	   WHEN MATCHED THEN
	   UPDATE SET 
		  [ET].[alarmet_description] = ISNULL([ARGS].[DESC], [ET].[alarmet_description]), 
		  [ET].[alarmet_description_args] = ISNULL([ARGS].[DESC ARGS], [ET].[alarmet_description_args]),
		  [ET].[alarmet_exgrpfk] = @exgrp_pk
	   WHEN NOT MATCHED THEN
	   INSERT ([alarmet_code], [alarmet_description], [alarmet_description_args], [alarmet_exgrpfk]) 
	   VALUES ([ARGS].[CODE], [ARGS].[DESC], [ARGS].[DESC ARGS], @exgrp_pk);
    END

GO
/****** Object:  StoredProcedure [MAIN].[UpdateAlarmType]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [MAIN].[UpdateAlarmType]
    @CODE [nvarchar](64),
    @DESCRIPTION [nvarchar](2048)
AS
    SET NOCOUNT ON;
    IF @CODE IS NOT NULL
    BEGIN	  
	   MERGE INTO dbo.AlarmType AS [T]
	   USING (SELECT TOP 1 @CODE AS [CODE], @DESCRIPTION AS [DESC]) AS [ARGS]
	   ON [ARGS].[CODE] = [T].[alarmt_code]
	   WHEN MATCHED THEN
	   UPDATE SET 
		  [T].[alarmt_description] = ISNULL([ARGS].[DESC], [T].[alarmt_description])
	   WHEN NOT MATCHED THEN
	   INSERT ([alarmt_code], [alarmt_description]) 
	   VALUES ([ARGS].[CODE], [ARGS].[DESC]);
    END

GO
/****** Object:  StoredProcedure [MAIN].[UpdateTransactionEventType]    Script Date: 4/11/2023 3:00:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [MAIN].[UpdateTransactionEventType]
    @CODE [nvarchar](64),
    @DESCRIPTION [nvarchar](2048),
    @DESCRIPTION_ARGS [nvarchar](2048),
    @EXCLUSION_GROUP [nvarchar](128) = NULL
AS
    SET NOCOUNT ON;
    IF @CODE IS NOT NULL
    BEGIN
	   declare @exgrp_pk int = (select top 1 [exgrp_pk] from dbo.[EventExclusionGroup] where exgrp_code = @EXCLUSION_GROUP)
	   if @EXCLUSION_GROUP is not null and @exgrp_pk is null
	   BEGIN
		  EXEC [dbo].[UpdateEventExclusionGroup] @EXCLUSION_GROUP, NULL;
		  SET @exgrp_pk = (select top 1 [exgrp_pk] from dbo.[EventExclusionGroup] where exgrp_code = @EXCLUSION_GROUP)
	   END        

	   MERGE INTO dbo.TransactionEventType AS [TIDET]
	   USING (SELECT TOP 1 @CODE AS [CODE], @DESCRIPTION AS [DESC], @DESCRIPTION_ARGS AS [DESC ARGS]) AS [ARGS]
	   ON [ARGS].[CODE] = [TIDET].[tidet_code]
	   WHEN MATCHED THEN
	   UPDATE SET 
		  [TIDET].[tidet_description] = ISNULL([ARGS].[DESC], [TIDET].[tidet_description]), 
		  [TIDET].[tidet_description_args] = ISNULL([ARGS].[DESC ARGS], [TIDET].[tidet_description_args]),
		  [TIDET].[tidet_exgrpfk] = @exgrp_pk
	   WHEN NOT MATCHED THEN
	   INSERT ([tidet_code], [tidet_description], [tidet_description_args], [tidet_exgrpfk]) 
	   VALUES ([ARGS].[CODE], [ARGS].[DESC], [ARGS].[DESC ARGS], @exgrp_pk);
    END

GO
USE [master]
GO
ALTER DATABASE [CWC_Data_2_0] SET  READ_WRITE 
GO
