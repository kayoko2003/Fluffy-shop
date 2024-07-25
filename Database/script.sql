USE [master]
GO
/****** Object:  Database [Fluffy_Shop]    Script Date: 7/18/2024 12:41:24 PM ******/
CREATE DATABASE [Fluffy_Shop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Fluffy_Shop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Fluffy_Shop.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Fluffy_Shop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Fluffy_Shop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Fluffy_Shop] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Fluffy_Shop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Fluffy_Shop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Fluffy_Shop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Fluffy_Shop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Fluffy_Shop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Fluffy_Shop] SET ARITHABORT OFF 
GO
ALTER DATABASE [Fluffy_Shop] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Fluffy_Shop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Fluffy_Shop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Fluffy_Shop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Fluffy_Shop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Fluffy_Shop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Fluffy_Shop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Fluffy_Shop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Fluffy_Shop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Fluffy_Shop] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Fluffy_Shop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Fluffy_Shop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Fluffy_Shop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Fluffy_Shop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Fluffy_Shop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Fluffy_Shop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Fluffy_Shop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Fluffy_Shop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Fluffy_Shop] SET  MULTI_USER 
GO
ALTER DATABASE [Fluffy_Shop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Fluffy_Shop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Fluffy_Shop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Fluffy_Shop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Fluffy_Shop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Fluffy_Shop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Fluffy_Shop] SET QUERY_STORE = ON
GO
ALTER DATABASE [Fluffy_Shop] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Fluffy_Shop]
GO
/****** Object:  Table [dbo].[blog]    Script Date: 7/18/2024 12:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[blog](
	[post_id] [int] IDENTITY(1,1) NOT NULL,
	[thumbnail] [nvarchar](200) NOT NULL,
	[title] [nvarchar](100) NOT NULL,
	[blog_category_id] [int] NULL,
	[id_creater] [int] NULL,
	[blog_detail] [nvarchar](max) NULL,
	[isShow] [bit] NULL,
	[blog_detail_short] [nvarchar](max) NULL,
	[create_date] [date] NULL,
	[update_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[post_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[blog_category]    Script Date: 7/18/2024 12:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[blog_category](
	[blog_category_id] [int] IDENTITY(1,1) NOT NULL,
	[cname] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[blog_category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[brand]    Script Date: 7/18/2024 12:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[brand](
	[brand_id] [int] IDENTITY(1,1) NOT NULL,
	[name_brand] [nvarchar](30) NOT NULL,
	[detail] [nvarchar](max) NULL,
 CONSTRAINT [PK__brand__4D3CE128037BDA2D] PRIMARY KEY CLUSTERED 
(
	[brand_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cart]    Script Date: 7/18/2024 12:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart](
	[quantity] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[customer_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC,
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[category]    Script Date: 7/18/2024 12:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[cid] [int] IDENTITY(1,1) NOT NULL,
	[cname] [nvarchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customer]    Script Date: 7/18/2024 12:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](200) NOT NULL,
	[password] [nvarchar](200) NOT NULL,
	[fullname] [nvarchar](100) NOT NULL,
	[address] [nvarchar](100) NOT NULL,
	[gender] [bit] NULL,
	[phone_number] [nvarchar](15) NOT NULL,
	[dob] [date] NULL,
	[create_date] [date] NULL,
	[update_date] [date] NULL,
	[token] [nvarchar](200) NULL,
	[status] [nvarchar](50) NULL,
	[avatar] [nvarchar](100) NULL,
	[log] [nvarchar](max) NULL,
 CONSTRAINT [PK__customer__CD65CB85EC0919F2] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[feedback]    Script Date: 7/18/2024 12:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[feedback](
	[feedback_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NULL,
	[product_id] [int] NULL,
	[content] [nvarchar](750) NOT NULL,
	[create_date] [date] NULL,
	[delete_date] [date] NULL,
	[delete_by] [int] NULL,
	[is_delete] [bit] NULL,
	[rating] [int] NULL,
	[sale_id] [int] NULL,
	[imagePath] [nchar](255) NULL,
	[order_id] [int] NOT NULL,
 CONSTRAINT [PK__feedback__7A6B2B8C5FF80355] PRIMARY KEY CLUSTERED 
(
	[feedback_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order]    Script Date: 7/18/2024 12:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NULL,
	[full_name] [nvarchar](50) NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[address] [nvarchar](100) NOT NULL,
	[phone_number] [int] NOT NULL,
	[payment_id] [int] NULL,
	[note] [nvarchar](200) NULL,
	[status_id] [int] NULL,
	[create_date] [datetime] NULL,
	[update_date] [datetime] NULL,
	[total_price] [int] NOT NULL,
	[sale_id] [int] NULL,
	[sale_note] [nvarchar](max) NULL,
 CONSTRAINT [PK__order__46596229365710ED] PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orderdetail]    Script Date: 7/18/2024 12:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orderdetail](
	[product_id] [int] NULL,
	[order_id] [int] NULL,
	[price] [int] NOT NULL,
	[quantity] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payment_method]    Script Date: 7/18/2024 12:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payment_method](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[payment] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product]    Script Date: 7/18/2024 12:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[cid] [int] NULL,
	[brand_id] [int] NULL,
	[price] [int] NOT NULL,
	[image] [nvarchar](100) NOT NULL,
	[status] [nvarchar](50) NOT NULL,
	[description] [nvarchar](500) NULL,
	[stock_quantity] [int] NOT NULL,
	[number_sold] [int] NOT NULL,
	[create_date] [date] NULL,
	[update_date] [date] NULL,
	[create_by] [int] NULL,
	[update_by] [int] NULL,
	[delete_by] [int] NULL,
	[delete_date] [date] NULL,
	[is_delete] [bit] NULL,
	[product_name] [nvarchar](100) NOT NULL,
	[import_price] [int] NULL,
 CONSTRAINT [PK__product__47027DF582AC1347] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[role]    Script Date: 7/18/2024 12:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role](
	[role_id] [int] IDENTITY(1,1) NOT NULL,
	[role_name] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[shipping_info]    Script Date: 7/18/2024 12:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[shipping_info](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NULL,
	[full_name] [nvarchar](100) NOT NULL,
	[phone_number] [nvarchar](20) NOT NULL,
	[address] [nvarchar](200) NOT NULL,
	[default] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[slider]    Script Date: 7/18/2024 12:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[slider](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[image] [nvarchar](255) NOT NULL,
	[backlink] [nvarchar](255) NOT NULL,
	[status] [bit] NULL,
	[notes] [text] NULL,
	[staff_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[staff]    Script Date: 7/18/2024 12:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[staff](
	[staff_id] [int] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](200) NOT NULL,
	[password] [nvarchar](200) NOT NULL,
	[fullname] [nvarchar](100) NOT NULL,
	[address] [nvarchar](100) NOT NULL,
	[phone_number] [nvarchar](15) NOT NULL,
	[role_id] [int] NULL,
	[create_date] [date] NULL,
	[update_date] [date] NULL,
	[avatar] [nvarchar](100) NULL,
	[status] [bit] NULL,
	[gender] [bit] NULL,
 CONSTRAINT [PK__staff__1963DD9CAE515CAB] PRIMARY KEY CLUSTERED 
(
	[staff_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[status_order]    Script Date: 7/18/2024 12:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[status_order](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[status] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[blog] ON 

INSERT [dbo].[blog] ([post_id], [thumbnail], [title], [blog_category_id], [id_creater], [blog_detail], [isShow], [blog_detail_short], [create_date], [update_date]) VALUES (3, N'Static_access_manager\assets\img\Post\3.jpg', N'Top 6 Sức Mạnh Đỉnh Của Chóp Nhất Zoro Đã Thể Hiện Ở Wano', 1, 1, N'Roronoa Zoro, một trong những hải tặc mạnh nhất trong One Piece, đã đạt được rất nhiều sức mạnh mới ở Wano. Dưới đây là những ấn tượng nhất trong số đó.

Chiến binh ngôi sao và số hai của băng hải tặc Mũ Rơm, Roronoa Zoro là một nhân vật cực kỳ quan trọng trong One Piece . Anh đặt mục tiêu trở thành kiếm sĩ vĩ đại nhất thế giới bằng cách vượt qua Dracule Mihawk, người hiện đang giữ danh hiệu này. Và nếu kỹ năng của anh ấy trong anime là bất kỳ dấu hiệu nào, thì anh ấy đang trên con đường của mình.', 1, N'Roronoa Zoro, một trong những hải tặc mạnh nhất trong One Piece, đã đạt được rất nhiều sức mạnh mới ở Wano. ', CAST(N'2024-11-20' AS Date), CAST(N'2024-11-20' AS Date))
INSERT [dbo].[blog] ([post_id], [thumbnail], [title], [blog_category_id], [id_creater], [blog_detail], [isShow], [blog_detail_short], [create_date], [update_date]) VALUES (4, N'Static_access_manager\assets\img\Post\4.jpg', N'Vì sao mô hình Hatsune Miku luôn được đông đảo dân chơi hobby yêu thích?', 1, 2, N'Từ mô hình Nendoroid đáng yêu đến các mô hình Figma linh hoạt hay Scale Figure tinh xảo, sự đa dạng về phiên bản của Hatsune Miku khiến người sưu tập luôn muốn tìm kiếm phiên bản mới để bổ sung vào bộ sưu tập. Các phiên bản theo chủ đề như Miku Racing, Snow Miku hay Miku Symphony tạo thêm sự phấn khích cho người chơi với sự thay đổi về trang phục, phụ kiện. Đặc biệt nổi tiếng với số lượng đồ sộ về mẫu mã, phong cách không thể không nhắc đến các mô hình Hatsune Miku của nhà Taito. Với dòng sản phẩm coreful gameprize, Hatsune Miku luôn được hãng ưu ái phát hành với số lượng lớn hàng tháng. Các sản phẩm mô hình Hatsune Miku của Taito luôn là sự lựa chọn ưu tiên cho những người mới chơi cũng như các fan lâu năm của Hatsune Miku.', 1, N'Với sự kết hợp của thương hiệu nổi tiếng, sự đa dạng về phong cách, chất lượng sản phẩm cùng cộng đồng mạnh mẽ, không có gì ngạc nhiên khi mô hình Hatsune Miku luôn là best seller trên các sàn thương mại, thu hút đông đảo dân chơi hobby.', CAST(N'2024-11-15' AS Date), CAST(N'2024-11-15' AS Date))
INSERT [dbo].[blog] ([post_id], [thumbnail], [title], [blog_category_id], [id_creater], [blog_detail], [isShow], [blog_detail_short], [create_date], [update_date]) VALUES (5, N'Static_access_manager\assets\img\Post\5.jpg', N'Unboxing Mô Hình Hatsune Miku BiCute Bunnies Rurudo ver', 1, 3, N'😍 Nếu bạn là Hành con chính hiệu và đang tìm kiếm một mô hình Hành chúa để “tôn thờ một tình yêu” trong tháng 03 này thì đích thị đây là mô hình chỉ dành riêng cho bạn!

👯‍♀️ Hành chúa phiên bản rurudo mới nhất của nhà FuRyu có thể nói là hội tụ đủ các yếu tố mà bạn trông đợi ở một mô hình Bunny Girl đó là: gương mặt xinh đẹp, body bốc lửa và tất lưới chuẩn real. Với chiều cao lên tới 27 cm cùng trang phục ôm sát đường cong cơ thể, kết hợp với chiếc nơ sọc đen mix màu baby blue tạo cảm giác vừa cuti, dễ thương nhưng không kém phần bí ẩn. Đôi mắt xếch sắc lạnh trái ngược với kiểu tóc thắt bím ngây thơ 2 bên mang đến một mãnh lực khó cưỡng, khiến người xem khó mà rời mắt. Đặc biệt là phần tất được làm bằng lưới thật, ôm trọn đôi chân dài 1m12 🐧 cùng đôi guốc được trang trí từ cổ áo cách điệu, trở thành một điểm nhấn vô cùng sáng tạo và độc đáo cho mô hình này.', 1, N'Bạn đã sẵn sàng để đón nhận một tuyệt phẩm từ Furyu chưa? Nếu bạn là một fan cuồng nhiệt của Hatsune Miku và đang tìm kiếm một mô hình để thể hiện tình yêu với cô nàng, thì mô hình Hatsune Miku phiên bản rurudo mới nhất chính là thứ bạn không thể bỏ qua.', CAST(N'2024-11-25' AS Date), CAST(N'2024-11-25' AS Date))
INSERT [dbo].[blog] ([post_id], [thumbnail], [title], [blog_category_id], [id_creater], [blog_detail], [isShow], [blog_detail_short], [create_date], [update_date]) VALUES (6, N'Static_access_manager\assets\img\Post\6.jpg', N'F:NEX giới thiệu mô hình Tokisaki Kurumi bán thân 1:1 - Niềm ao ước của các fan', 1, 4, N'Chất liệu cao cấp: Sử dụng polyresin, PU, thép không gỉ và nam châm cho độ bền và sự chân thực tối đa.
Thiết kế tinh xảo: Từ mái tóc đặc trưng với tư thế đầy quyến rũ đến đôi mắt thời gian được tái hiện sống động.
Chiều cao ấn tượng: Với kích thước tổng thể lên đến 730mm, mô hình làm nổi bật mọi không gian trưng bày. Tóc đặc trưng phong cách Kurumi: Mái tóc đôi không đối xứng đặc trưng của Tokisaki Kurumi được thể hiện một cách sống động với tỉ lệ 1/1, làm tăng thêm vẻ đẹp và sự quyến rũ cho bức tượng. Ánh mắt hút hồn: Đôi mắt biểu tượng với hình ảnh chiếc đồng hồ cát được tái hiện không sót chi tiết nào, mang lại ánh nhìn sắc sảo và cuốn hút đặc trưng.

Bộ váy ấn tượng: Chiếc váy với sự kết hợp giữa màu đỏ và đen truyền thống được thiết kế táo bạo, tôn lên đường cong mềm mại của nhân vật và sự tự tin trong từng động tác.

Tinh tế từng chi tiết: Từ những chiếc nơ, bèo nhún, cho đến phụ kiện trên đầu, mỗi chi tiết đều được chăm chút tỉ mỉ, tái hiện chất liệu và dáng vẻ tự nhiên nhất.', 1, N'F:NEX giới thiệu mô hình Tokisaki Kurumi bán thân 1:1 - Niềm ao ước của các fan', CAST(N'2024-12-20' AS Date), CAST(N'2024-12-20' AS Date))
SET IDENTITY_INSERT [dbo].[blog] OFF
GO
SET IDENTITY_INSERT [dbo].[blog_category] ON 

INSERT [dbo].[blog_category] ([blog_category_id], [cname]) VALUES (1, N'Style')
INSERT [dbo].[blog_category] ([blog_category_id], [cname]) VALUES (2, N'Life')
INSERT [dbo].[blog_category] ([blog_category_id], [cname]) VALUES (3, N'Fluffy')
INSERT [dbo].[blog_category] ([blog_category_id], [cname]) VALUES (4, N'Event')
SET IDENTITY_INSERT [dbo].[blog_category] OFF
GO
SET IDENTITY_INSERT [dbo].[brand] ON 

INSERT [dbo].[brand] ([brand_id], [name_brand], [detail]) VALUES (1, N'Bandai Namco', N'Tập đoàn Bandai Namco là nhà sản xuất đồ chơi lớn thứ ba trên thế giới (sau Mattel và Hasbro của Mỹ) và tập đoàn này sở hữu và phân phối một số lượng đáng kể giấy phép cho đồ chơi và hàng loạt Figure của Nhật Bản')
INSERT [dbo].[brand] ([brand_id], [name_brand], [detail]) VALUES (2, N'MegaHouse', N'Được thành lập vào năm 1962, MegaHouse là viết tắt của “Make, Enjoy, Global, Ability” và hãng sản xuất Figure được biết đến nhiều nhất với nhiều loạt mô hình Look Up và GEM.')
INSERT [dbo].[brand] ([brand_id], [name_brand], [detail]) VALUES (3, N'The Good Smile', N'Hãng sản xuất Figure với tên gọi rất vui vẻ là Good Smile Company chủ yếu được biết đến với loạt Action Figure Nendoroid  (bao gồm Nendoroid More, Plus, Petite và Playset với tổng cộng vài trăm nhân vật), đặc biệt là có một số điểm cử động khớp cũng như vài phiên bản của mặt và phụ kiện, để cho phép người chơi thay đổi các biểu cảm và tạo các cảnh tượng khác nhau.')
INSERT [dbo].[brand] ([brand_id], [name_brand], [detail]) VALUES (4, N'Max Factory', N'Max Factory là hãng sản xuất Figma - một dạng mô hình có khớp nối, (được tạo ra vào năm 2008) cho phép các nhân vật có thể thay đổi nhiều tư thế. Mỗi Figma đều đi kèm với các phụ kiện khác nhau như mặt và tay có thể hoán đổi và các bộ phận tùy chọn khác để cho phép tạo ra các tư thế khác nhau.')
INSERT [dbo].[brand] ([brand_id], [name_brand], [detail]) VALUES (5, N'ArtSpirits', N'Hãng sản xuất Figure này chuyên tạo hình các quái vật (từ MonsterVerse), đặc biệt là những con quái vật từ vũ trụ Godzilla.')
INSERT [dbo].[brand] ([brand_id], [name_brand], [detail]) VALUES (6, N'Prime 1 Studio', N'Những  Figure của Prime 1 Studio  thường không vượt quá 60 cm (từ 1/6 đến 1/1 đối với hầu hết các phần) nhưng nặng vài kg. Với kích cỡ như vậy, Figure của hãng gây được ấn tượng lớn về độ tỉ mỉ và chân thực.')
SET IDENTITY_INSERT [dbo].[brand] OFF
GO
INSERT [dbo].[cart] ([quantity], [product_id], [customer_id]) VALUES (3, 1, 1)
INSERT [dbo].[cart] ([quantity], [product_id], [customer_id]) VALUES (2, 6, 1)
INSERT [dbo].[cart] ([quantity], [product_id], [customer_id]) VALUES (1, 7, 1)
INSERT [dbo].[cart] ([quantity], [product_id], [customer_id]) VALUES (4, 17, 1)
GO
SET IDENTITY_INSERT [dbo].[category] ON 

INSERT [dbo].[category] ([cid], [cname]) VALUES (1, N'One piece')
INSERT [dbo].[category] ([cid], [cname]) VALUES (2, N'Dragon ball')
INSERT [dbo].[category] ([cid], [cname]) VALUES (3, N'Nendoroid')
INSERT [dbo].[category] ([cid], [cname]) VALUES (4, N'Naruto')
INSERT [dbo].[category] ([cid], [cname]) VALUES (5, N'Kimetsu no Yaiba')
INSERT [dbo].[category] ([cid], [cname]) VALUES (6, N'Pokemon')
INSERT [dbo].[category] ([cid], [cname]) VALUES (7, N'Marvel')
SET IDENTITY_INSERT [dbo].[category] OFF
GO
SET IDENTITY_INSERT [dbo].[customer] ON 

INSERT [dbo].[customer] ([customer_id], [email], [password], [fullname], [address], [gender], [phone_number], [dob], [create_date], [update_date], [token], [status], [avatar], [log]) VALUES (1, N'ngocqd5@gmail.com', N'$2a$10$5CklzhXh16fNSD4NojGbgecURMB6x.sTlKxnabp80ygyeVJMO7RWm', N'Nguyen Quoc The', N'Thường Tín', 1, N'1233456654', CAST(N'2005-06-01' AS Date), CAST(N'2024-06-09' AS Date), CAST(N'2024-06-12' AS Date), N'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJuZ29jcWQ1QGdtYWlsLmNvbSIsImlhdCI6MTcxNzkxODk2OCwiZXhwIjoxNzE3OTIyNTY4fQ.5MXyS09VPUMc94IvkftCFmWCbEJusyFMk6ATm7RvavY', N'Active', N'https://ss-images.saostar.vn/wp700/pc/1613810558698/Facebook-Avatar_3.png', N'{"phoneNumber":"from 338435433 to 1233456654","updateTime":"2024-06-12"}')
INSERT [dbo].[customer] ([customer_id], [email], [password], [fullname], [address], [gender], [phone_number], [dob], [create_date], [update_date], [token], [status], [avatar], [log]) VALUES (2, N'ngocqd6@gmail.com', N'$2a$10$9bP.CqTSeyercKf4uu0Z8O5TOg71/DYk6nZ6EM4/jxjF9bogcPija', N'Trịnh Đình Ngọc', N'Thường Tín', 1, N'338750792', CAST(N'2003-01-03' AS Date), CAST(N'2024-06-09' AS Date), CAST(N'2024-07-15' AS Date), N'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJuZ29jcWQ2QGdtYWlsLmNvbSIsImlhdCI6MTcyMTE0NjA4MywiZXhwIjoxNzIxMTQ5NjgzfQ.w6cx7vfqQkXzFaSYXMJNjYOnBBCax7XQ7z09be6DwgU', N'ACTIVE', N'', NULL)
INSERT [dbo].[customer] ([customer_id], [email], [password], [fullname], [address], [gender], [phone_number], [dob], [create_date], [update_date], [token], [status], [avatar], [log]) VALUES (3, N'ngocqd7@gmail.com', N'$2a$10$dZhl28BFTvAHIXWL2w1D8Owtj0CPwmUKn78SkutueiqVfU5cxNGC2', N'Nguyen Ngoc Minh', N'Thường Tín', 0, N'326636993', CAST(N'2003-11-26' AS Date), CAST(N'2024-06-09' AS Date), CAST(N'2024-06-09' AS Date), N'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJuZ29jcWQ3QGdtYWlsLmNvbSIsImlhdCI6MTcxOTEyNDYyMCwiZXhwIjoxNzE5MTI4MjIwfQ.N2OCK2MxyRWY1xU9koM2IzjR05yF9sOCMbadRHwt10w', N'ACTIVE', N'https://ss-images.saostar.vn/wp700/pc/1613810558698/Facebook-Avatar_3.png', NULL)
INSERT [dbo].[customer] ([customer_id], [email], [password], [fullname], [address], [gender], [phone_number], [dob], [create_date], [update_date], [token], [status], [avatar], [log]) VALUES (4, N'ngocqd8@gmail.com', N'$2a$10$4fEqBDNisiQq6dg1RVZKv.Bg6HMUnNNdyb9gWuGnDD9PoLAAsGS9K', N'Nguyen Anh Tu', N'Thach Hoa', 1, N'338750792', CAST(N'2003-06-11' AS Date), CAST(N'2024-06-09' AS Date), CAST(N'2024-06-09' AS Date), N'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJuZ29jcWQ4QGdtYWlsLmNvbSIsImlhdCI6MTcxNzkxOTU1MywiZXhwIjoxNzE3OTIzMTUzfQ.m23kK1GLQk8L6Q3ND_PLLEBYtzqrPW04uEqlXr_75HU', N'ACTIVE', N'https://ss-images.saostar.vn/wp700/pc/1613810558698/Facebook-Avatar_3.png', NULL)
INSERT [dbo].[customer] ([customer_id], [email], [password], [fullname], [address], [gender], [phone_number], [dob], [create_date], [update_date], [token], [status], [avatar], [log]) VALUES (5, N'ngocqd11@gmail.com', N'$2a$10$YJzcd76H8gYZzpAouSxiJOTDT01QVE66uP6e3KbiD1UHlYaaTc86C', N'Trinh Dinh Ngoc', N'Quat Dong - Thuong Tin - Ha Noi', 1, N'0338750792', CAST(N'2003-04-01' AS Date), CAST(N'2024-06-24' AS Date), CAST(N'2024-06-24' AS Date), N'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJuZ29jcWQxMUBnbWFpbC5jb20iLCJpYXQiOjE3MTkxOTM1OTIsImV4cCI6MTcxOTE5NzE5Mn0.PQFKkOwNB8QQWaAo8BNupAIFznQRCV2lFkPrnWtwEbs', N'ACTIVE', N'https://ss-images.saostar.vn/wp700/pc/1613810558698/Facebook-Avatar_3.png', NULL)
SET IDENTITY_INSERT [dbo].[customer] OFF
GO
SET IDENTITY_INSERT [dbo].[feedback] ON 

INSERT [dbo].[feedback] ([feedback_id], [customer_id], [product_id], [content], [create_date], [delete_date], [delete_by], [is_delete], [rating], [sale_id], [imagePath], [order_id]) VALUES (1, 2, 9, N'Good', CAST(N'2024-06-26' AS Date), NULL, NULL, NULL, 4, 1, N'C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps\FluffyShop_war\\uploads\z2859577381994_6a7500a73b134f3e81d3df2e2e3713a5_20240626103943.jpg                                                                                                     ', 6)
INSERT [dbo].[feedback] ([feedback_id], [customer_id], [product_id], [content], [create_date], [delete_date], [delete_by], [is_delete], [rating], [sale_id], [imagePath], [order_id]) VALUES (2, 2, 21, N'Good', CAST(N'2024-06-26' AS Date), NULL, NULL, NULL, 4, 1, N'C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps\FluffyShop_war\\uploads\z2859577381994_6a7500a73b134f3e81d3df2e2e3713a5_20240626103943.jpg                                                                                                     ', 6)
INSERT [dbo].[feedback] ([feedback_id], [customer_id], [product_id], [content], [create_date], [delete_date], [delete_by], [is_delete], [rating], [sale_id], [imagePath], [order_id]) VALUES (3, 2, 1, N'Khong tot', CAST(N'2024-07-16' AS Date), NULL, NULL, NULL, 3, 2, N'C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps\FluffyShop_war\\uploads\_20240716123150                                                                                                                                                        ', 71)
INSERT [dbo].[feedback] ([feedback_id], [customer_id], [product_id], [content], [create_date], [delete_date], [delete_by], [is_delete], [rating], [sale_id], [imagePath], [order_id]) VALUES (4, 2, 1, N'', CAST(N'2024-07-16' AS Date), NULL, NULL, NULL, 4, 1, N'C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps\FluffyShop_war\\uploads\_20240716123435                                                                                                                                                        ', 114)
INSERT [dbo].[feedback] ([feedback_id], [customer_id], [product_id], [content], [create_date], [delete_date], [delete_by], [is_delete], [rating], [sale_id], [imagePath], [order_id]) VALUES (5, 2, 6, N'', CAST(N'2024-07-16' AS Date), NULL, NULL, NULL, 4, 2, N'C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps\FluffyShop_war\\uploads\_20240716124441                                                                                                                                                        ', 71)
INSERT [dbo].[feedback] ([feedback_id], [customer_id], [product_id], [content], [create_date], [delete_date], [delete_by], [is_delete], [rating], [sale_id], [imagePath], [order_id]) VALUES (6, 2, 7, N'', CAST(N'2024-07-16' AS Date), NULL, NULL, NULL, 4, 2, N'C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps\FluffyShop_war\\uploads\_20240716124441                                                                                                                                                        ', 71)
INSERT [dbo].[feedback] ([feedback_id], [customer_id], [product_id], [content], [create_date], [delete_date], [delete_by], [is_delete], [rating], [sale_id], [imagePath], [order_id]) VALUES (7, 2, 9, N'', CAST(N'2024-07-16' AS Date), NULL, NULL, NULL, 4, 2, N'C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps\FluffyShop_war\\uploads\_20240716124441                                                                                                                                                        ', 71)
INSERT [dbo].[feedback] ([feedback_id], [customer_id], [product_id], [content], [create_date], [delete_date], [delete_by], [is_delete], [rating], [sale_id], [imagePath], [order_id]) VALUES (8, 2, 15, N'', CAST(N'2024-07-16' AS Date), NULL, NULL, NULL, 4, 2, N'C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps\FluffyShop_war\\uploads\_20240716124441                                                                                                                                                        ', 71)
INSERT [dbo].[feedback] ([feedback_id], [customer_id], [product_id], [content], [create_date], [delete_date], [delete_by], [is_delete], [rating], [sale_id], [imagePath], [order_id]) VALUES (9, 2, 18, N'', CAST(N'2024-07-16' AS Date), NULL, NULL, NULL, 4, 2, N'C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps\FluffyShop_war\\uploads\_20240716124441                                                                                                                                                        ', 71)
INSERT [dbo].[feedback] ([feedback_id], [customer_id], [product_id], [content], [create_date], [delete_date], [delete_by], [is_delete], [rating], [sale_id], [imagePath], [order_id]) VALUES (10, 2, 19, N'', CAST(N'2024-07-16' AS Date), NULL, NULL, NULL, 4, 2, N'C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps\FluffyShop_war\\uploads\_20240716124441                                                                                                                                                        ', 71)
INSERT [dbo].[feedback] ([feedback_id], [customer_id], [product_id], [content], [create_date], [delete_date], [delete_by], [is_delete], [rating], [sale_id], [imagePath], [order_id]) VALUES (11, 2, 21, N'', CAST(N'2024-07-16' AS Date), NULL, NULL, NULL, 4, 2, N'C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps\FluffyShop_war\\uploads\_20240716124441                                                                                                                                                        ', 71)
INSERT [dbo].[feedback] ([feedback_id], [customer_id], [product_id], [content], [create_date], [delete_date], [delete_by], [is_delete], [rating], [sale_id], [imagePath], [order_id]) VALUES (12, 2, 22, N'', CAST(N'2024-07-16' AS Date), NULL, NULL, NULL, 4, 2, N'C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps\FluffyShop_war\\uploads\_20240716124441                                                                                                                                                        ', 71)
INSERT [dbo].[feedback] ([feedback_id], [customer_id], [product_id], [content], [create_date], [delete_date], [delete_by], [is_delete], [rating], [sale_id], [imagePath], [order_id]) VALUES (13, 2, 6, N'', CAST(N'2024-07-16' AS Date), NULL, NULL, NULL, 5, 2, N'C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps\FluffyShop_war\\uploads\_20240716124800                                                                                                                                                        ', 37)
INSERT [dbo].[feedback] ([feedback_id], [customer_id], [product_id], [content], [create_date], [delete_date], [delete_by], [is_delete], [rating], [sale_id], [imagePath], [order_id]) VALUES (14, 2, 6, N'', CAST(N'2024-07-16' AS Date), NULL, NULL, NULL, 5, 2, N'C:\Program Files\Apache Software Foundation\Tomcat 10.1\webapps\FluffyShop_war\\uploads\_20240716124824                                                                                                                                                        ', 37)
SET IDENTITY_INSERT [dbo].[feedback] OFF
GO
SET IDENTITY_INSERT [dbo].[order] ON 

INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (2, 1, N'Nguyen Quoc The', N'ngocqd5@gmail.com', N'Thuong Tin', 1232432423, 1, N'Hello', 5, CAST(N'2024-05-20T00:00:00.000' AS DateTime), CAST(N'2024-05-20T00:00:00.000' AS DateTime), 827000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (3, 2, N'Trinh Dinh Ngoc', N'ngocqd6@gmail.com', N'Thuong Tin 0338750792', 338750792, 1, N'Xin chao', 5, CAST(N'2024-01-01T00:00:00.000' AS DateTime), CAST(N'2024-07-16T14:25:00.833' AS DateTime), 100000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (4, 3, N'Nguyen Ngoc Minh', N'ngocqd7@gmail.com', N'Quat Dong', 124231432, 1, N'Hello', 5, CAST(N'2024-06-01T00:00:00.000' AS DateTime), CAST(N'2024-06-01T00:00:00.000' AS DateTime), 500000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (5, 4, N'Nguyen Anh Tu', N'ngocqd8@gmail.com', N'Thach That', 1231243543, 2, N'Chao ban', 5, CAST(N'2024-04-04T00:00:00.000' AS DateTime), CAST(N'2024-07-16T14:25:00.810' AS DateTime), 123122, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (6, 2, N'Trinh Dinh Ngoc', N'ngocqd6@gmail.com', N'Ha Noi', 1234123213, 2, N'Hello', 6, CAST(N'2024-07-06T00:00:00.000' AS DateTime), CAST(N'2024-07-16T14:25:29.057' AS DateTime), 123132, 1, N'abcáđasadsadsa')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (9, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thường Tín', 338750792, 1, NULL, 2, CAST(N'2024-06-12T00:00:00.000' AS DateTime), CAST(N'2024-06-12T00:00:00.000' AS DateTime), 1400000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (10, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thường Tín', 338750792, 1, NULL, 2, CAST(N'2024-06-12T00:00:00.000' AS DateTime), CAST(N'2024-06-12T00:00:00.000' AS DateTime), 1800000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (11, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thường Tín', 338750792, 1, NULL, 2, CAST(N'2024-06-12T00:00:00.000' AS DateTime), CAST(N'2024-06-12T00:00:00.000' AS DateTime), 1400000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (12, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thường Tín', 338750792, 3, NULL, 2, CAST(N'2024-06-12T00:00:00.000' AS DateTime), CAST(N'2024-06-12T00:00:00.000' AS DateTime), 1200000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (13, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thường Tín', 338750792, 1, NULL, 2, CAST(N'2024-06-12T00:00:00.000' AS DateTime), CAST(N'2024-06-12T00:00:00.000' AS DateTime), 1240000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (14, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thường Tín', 338750792, 2, NULL, 2, CAST(N'2024-06-12T00:00:00.000' AS DateTime), CAST(N'2024-07-16T23:36:28.250' AS DateTime), 1551000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (15, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thường Tín', 338750792, 1, NULL, 2, CAST(N'2024-06-12T00:00:00.000' AS DateTime), CAST(N'2024-06-12T00:00:00.000' AS DateTime), 2200000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (16, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thường Tín', 338750792, 3, NULL, 2, CAST(N'2024-06-12T00:00:00.000' AS DateTime), CAST(N'2024-06-12T00:00:00.000' AS DateTime), 3595000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (34, 2, N'Nguyễn Thể', N'ngocqd6@gmail.com', N'Thạch Hòa Thạc Thất', 338750792, 3, N'', 2, CAST(N'2024-06-15T00:00:00.000' AS DateTime), CAST(N'2024-06-15T00:00:00.000' AS DateTime), 2540000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (35, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 3, N'', 2, CAST(N'2024-06-15T00:00:00.000' AS DateTime), CAST(N'2024-06-15T00:00:00.000' AS DateTime), 517000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (36, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 1, N'Be careful', 2, CAST(N'2024-06-15T00:00:00.000' AS DateTime), CAST(N'2024-06-15T00:00:00.000' AS DateTime), 514000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (37, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 3, N'', 6, CAST(N'2024-06-15T00:00:00.000' AS DateTime), CAST(N'2024-07-16T14:25:29.060' AS DateTime), 400000, 2, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (38, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 3, N'', 2, CAST(N'2024-06-15T00:00:00.000' AS DateTime), CAST(N'2024-06-15T00:00:00.000' AS DateTime), 635000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (39, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 1, N'', 2, CAST(N'2024-06-15T00:00:00.000' AS DateTime), CAST(N'2024-06-15T00:00:00.000' AS DateTime), 914000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (40, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 2, N'', 2, CAST(N'2024-06-15T00:00:00.000' AS DateTime), CAST(N'2024-07-16T23:36:04.680' AS DateTime), 2066000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (41, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 1, N'', 2, CAST(N'2024-06-15T00:00:00.000' AS DateTime), CAST(N'2024-06-15T00:00:00.000' AS DateTime), 769000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (42, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 3, N'', 2, CAST(N'2024-06-15T00:00:00.000' AS DateTime), CAST(N'2024-06-15T00:00:00.000' AS DateTime), 914000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (43, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 1, N'', 2, CAST(N'2024-06-15T00:00:00.000' AS DateTime), CAST(N'2024-06-15T00:00:00.000' AS DateTime), 2056000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (44, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 2, N'', 2, CAST(N'2024-06-15T00:00:00.000' AS DateTime), CAST(N'2024-07-16T23:36:04.703' AS DateTime), 5213000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (45, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 1, N'', 7, CAST(N'2024-06-16T00:00:00.000' AS DateTime), CAST(N'2024-06-16T00:00:00.000' AS DateTime), 635000, 2, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (57, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 1, N'', 2, CAST(N'2024-06-16T00:00:00.000' AS DateTime), CAST(N'2024-06-16T00:00:00.000' AS DateTime), 914000, 2, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (58, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 1, N'', 2, CAST(N'2024-06-16T00:00:00.000' AS DateTime), CAST(N'2024-06-16T00:00:00.000' AS DateTime), 517000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (59, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 2, N'', 5, CAST(N'2024-06-16T00:00:00.000' AS DateTime), CAST(N'2024-07-16T14:25:00.783' AS DateTime), 635000, 2, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (60, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 2, N'', 4, CAST(N'2024-06-16T00:00:00.000' AS DateTime), CAST(N'2024-06-16T00:00:00.000' AS DateTime), 2551000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (61, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 2, N'', 2, CAST(N'2024-06-16T00:00:00.000' AS DateTime), CAST(N'2024-07-16T23:39:31.873' AS DateTime), 2734000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (62, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 2, N'', 6, CAST(N'2024-06-16T00:00:00.000' AS DateTime), CAST(N'2024-07-16T14:25:29.060' AS DateTime), 1531000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (63, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 2, N'', 4, CAST(N'2024-06-16T00:00:00.000' AS DateTime), CAST(N'2024-07-16T23:42:29.017' AS DateTime), 1531000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (64, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 2, N'', 4, CAST(N'2024-06-16T00:00:00.000' AS DateTime), CAST(N'2024-06-16T00:00:00.000' AS DateTime), 648000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (65, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 2, N'', 4, CAST(N'2024-06-16T00:00:00.000' AS DateTime), CAST(N'2024-07-16T23:43:49.370' AS DateTime), 999000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (66, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 2, N'', 2, CAST(N'2024-06-16T00:00:00.000' AS DateTime), CAST(N'2024-07-16T23:36:04.630' AS DateTime), 999000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (67, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 2, N'', 4, CAST(N'2024-06-16T00:00:00.000' AS DateTime), CAST(N'2024-07-16T23:43:49.343' AS DateTime), 999000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (68, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 2, N'', 7, CAST(N'2024-06-17T00:00:00.000' AS DateTime), CAST(N'2024-06-17T00:00:00.000' AS DateTime), 51700000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (69, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 1, N'', 2, CAST(N'2024-06-17T00:00:00.000' AS DateTime), CAST(N'2024-06-17T00:00:00.000' AS DateTime), 514000, 2, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (70, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 3, N'', 2, CAST(N'2024-06-17T00:00:00.000' AS DateTime), CAST(N'2024-06-17T00:00:00.000' AS DateTime), 635000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (71, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 2, N'', 6, CAST(N'2024-06-17T00:00:00.000' AS DateTime), CAST(N'2024-07-16T14:25:29.060' AS DateTime), 5313000, 2, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (72, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 1, N'', 2, CAST(N'2024-06-17T00:00:00.000' AS DateTime), CAST(N'2024-06-17T00:00:00.000' AS DateTime), 514000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (73, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 2, N'Hellooooo', 7, CAST(N'2024-06-17T00:00:00.000' AS DateTime), CAST(N'2024-06-17T00:00:00.000' AS DateTime), 349000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (74, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 2, N'', 7, CAST(N'2024-06-17T00:00:00.000' AS DateTime), CAST(N'2024-06-17T00:00:00.000' AS DateTime), 400000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (75, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động - Hà Nội', 338750792, 2, N'', 7, CAST(N'2024-06-17T00:00:00.000' AS DateTime), CAST(N'2024-06-17T00:00:00.000' AS DateTime), 1100000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (76, 2, N'FPt', N'ngocqd6@gmail.com', N'Quất Động', 333333, 2, N'', 7, CAST(N'2024-06-17T00:00:00.000' AS DateTime), CAST(N'2024-06-17T00:00:00.000' AS DateTime), 1152000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (77, 2, N'FPt', N'ngocqd6@gmail.com', N'Quất Động', 333333, 2, N'', 2, CAST(N'2024-06-17T00:00:00.000' AS DateTime), CAST(N'2024-07-16T23:37:26.180' AS DateTime), 1100000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (78, 2, N'FPt', N'ngocqd6@gmail.com', N'Quất Động', 333333, 2, N'', 7, CAST(N'2024-06-17T00:00:00.000' AS DateTime), CAST(N'2024-06-17T00:00:00.000' AS DateTime), 999000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (81, 3, N'Ngọc Minh', N'ngocqd7@gmail.com', N'Thường Tín', 326636993, 1, N'', 5, CAST(N'2024-06-23T00:00:00.000' AS DateTime), CAST(N'2024-06-23T00:00:00.000' AS DateTime), 4560000, 2, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (82, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 2, CAST(N'2024-06-24T00:00:00.000' AS DateTime), CAST(N'2024-06-24T00:00:00.000' AS DateTime), 400000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (83, 5, N'Nguyễn Quốc Thể', N'ngocqd11@gmail.com', N'Quat Dong - Thuong Tin - Ha Noi', 338750792, 1, N'', 7, CAST(N'2024-06-24T00:00:00.000' AS DateTime), CAST(N'2024-06-24T00:00:00.000' AS DateTime), 6508000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (84, 5, N'Nguyễn Quốc Thể', N'ngocqd11@gmail.com', N'Quat Dong - Thuong Tin - Ha Noi', 338750792, 2, N'', 5, CAST(N'2024-06-24T00:00:00.000' AS DateTime), CAST(N'2024-06-24T00:00:00.000' AS DateTime), 1149000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (85, 5, N'Nguyễn Quốc Thể', N'ngocqd11@gmail.com', N'Quat Dong - Thuong Tin - Ha Noi', 338750792, 3, N'', 2, CAST(N'2024-06-24T00:00:00.000' AS DateTime), CAST(N'2024-06-24T00:00:00.000' AS DateTime), 500000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (86, 5, N'Nguyễn Quốc Thể', N'ngocqd11@gmail.com', N'Quat Dong - Thuong Tin - Ha Noi', 338750792, 2, N'', 7, CAST(N'2024-06-24T00:00:00.000' AS DateTime), CAST(N'2024-07-16T23:10:07.050' AS DateTime), 1000000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (87, 5, N'Nguyễn Quốc Thể', N'ngocqd11@gmail.com', N'Quat Dong - Thuong Tin - Ha Noi', 338750792, 1, N'', 2, CAST(N'2024-06-24T00:00:00.000' AS DateTime), CAST(N'2024-06-24T00:00:00.000' AS DateTime), 1000000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (88, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 2, CAST(N'2024-06-24T00:00:00.000' AS DateTime), CAST(N'2024-06-24T00:00:00.000' AS DateTime), 400000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (89, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 2, CAST(N'2024-06-24T00:00:00.000' AS DateTime), CAST(N'2024-06-24T00:00:00.000' AS DateTime), 1100000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (90, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 3, N'', 7, CAST(N'2024-06-25T00:00:00.000' AS DateTime), CAST(N'2024-06-25T00:00:00.000' AS DateTime), 1100000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (91, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 3, N'', 2, CAST(N'2024-06-25T00:00:00.000' AS DateTime), CAST(N'2024-06-25T00:00:00.000' AS DateTime), 1100000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (92, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 3, N'', 7, CAST(N'2024-06-25T00:00:00.000' AS DateTime), CAST(N'2024-06-25T00:00:00.000' AS DateTime), 1100000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (93, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 3, N'', 2, CAST(N'2024-06-25T00:00:00.000' AS DateTime), CAST(N'2024-06-25T00:00:00.000' AS DateTime), 1100000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (94, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 3, N'', 7, CAST(N'2024-06-25T00:00:00.000' AS DateTime), CAST(N'2024-06-25T00:00:00.000' AS DateTime), 1100000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (95, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 3, N'', 2, CAST(N'2024-06-25T00:00:00.000' AS DateTime), CAST(N'2024-06-25T00:00:00.000' AS DateTime), 1100000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (96, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 3, N'', 7, CAST(N'2024-06-25T00:00:00.000' AS DateTime), CAST(N'2024-06-25T00:00:00.000' AS DateTime), 1100000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (97, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 3, N'', 5, CAST(N'2024-06-25T00:00:00.000' AS DateTime), CAST(N'2024-07-16T14:25:00.743' AS DateTime), 1500000, 2, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (98, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 3, N'', 2, CAST(N'2024-06-25T00:00:00.000' AS DateTime), CAST(N'2024-06-25T00:00:00.000' AS DateTime), 1100000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (99, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 3, N'', 2, CAST(N'2024-06-25T00:00:00.000' AS DateTime), CAST(N'2024-06-25T00:00:00.000' AS DateTime), 1100000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (100, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 2, CAST(N'2024-06-25T00:00:00.000' AS DateTime), CAST(N'2024-06-25T00:00:00.000' AS DateTime), 299000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (101, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 2, CAST(N'2024-06-25T00:00:00.000' AS DateTime), CAST(N'2024-06-25T00:00:00.000' AS DateTime), 1100000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (102, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 2, CAST(N'2024-06-25T00:00:00.000' AS DateTime), CAST(N'2024-06-25T00:00:00.000' AS DateTime), 1100000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (103, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 2, CAST(N'2024-06-25T00:00:00.000' AS DateTime), CAST(N'2024-06-25T00:00:00.000' AS DateTime), 400000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (107, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 2, CAST(N'2024-07-02T00:00:00.000' AS DateTime), CAST(N'2024-07-02T00:00:00.000' AS DateTime), 400000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (108, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 2, N'', 2, CAST(N'2024-07-02T16:39:47.110' AS DateTime), CAST(N'2024-07-02T16:39:47.110' AS DateTime), 1542000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (109, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 2, CAST(N'2024-07-02T17:23:34.483' AS DateTime), CAST(N'2024-07-02T17:23:34.483' AS DateTime), 400000, 2, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (110, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 2, N'', 7, CAST(N'2024-07-02T18:24:00.530' AS DateTime), CAST(N'2024-07-02T18:24:00.530' AS DateTime), 1100000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (111, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 7, CAST(N'2024-07-02T20:35:02.160' AS DateTime), CAST(N'2024-07-02T20:35:02.160' AS DateTime), 10794000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (112, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 7, CAST(N'2024-07-14T14:41:21.747' AS DateTime), CAST(N'2024-07-14T14:41:21.747' AS DateTime), 5500000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (113, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 7, CAST(N'2024-07-14T14:42:31.067' AS DateTime), CAST(N'2024-07-14T14:42:31.067' AS DateTime), 1100000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (114, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 6, CAST(N'2024-07-14T14:43:40.143' AS DateTime), CAST(N'2024-07-14T14:43:40.143' AS DateTime), 1100000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (115, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 4, CAST(N'2024-07-14T14:44:08.950' AS DateTime), CAST(N'2024-07-16T23:18:20.097' AS DateTime), 1100000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (116, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 2, CAST(N'2024-07-15T06:42:40.157' AS DateTime), CAST(N'2024-07-15T06:42:40.157' AS DateTime), 635000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (117, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 3, N'', 2, CAST(N'2024-07-15T06:43:21.967' AS DateTime), CAST(N'2024-07-15T06:43:21.967' AS DateTime), 517000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (118, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 2, N'', 7, CAST(N'2024-07-15T09:02:49.537' AS DateTime), CAST(N'2024-07-15T09:02:49.537' AS DateTime), 1100000, 1, NULL)
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (119, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 7, CAST(N'2024-07-16T14:42:10.590' AS DateTime), CAST(N'2024-07-16T14:42:10.590' AS DateTime), 1100000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (120, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 5, CAST(N'2024-07-16T14:44:06.713' AS DateTime), CAST(N'2024-07-16T14:45:36.990' AS DateTime), 1100000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (121, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 7, CAST(N'2024-07-16T14:46:24.053' AS DateTime), CAST(N'2024-07-16T14:47:16.167' AS DateTime), 1100000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (122, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 7, CAST(N'2024-07-16T14:47:45.800' AS DateTime), CAST(N'2024-07-16T14:48:42.757' AS DateTime), 1100000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (123, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 7, CAST(N'2024-07-16T14:55:59.743' AS DateTime), CAST(N'2024-07-16T14:55:59.743' AS DateTime), 330000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (124, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 7, CAST(N'2024-07-16T14:58:30.020' AS DateTime), CAST(N'2024-07-16T14:58:30.020' AS DateTime), 110000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (125, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 7, CAST(N'2024-07-16T15:03:21.823' AS DateTime), CAST(N'2024-07-16T15:03:21.823' AS DateTime), 758000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (126, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 7, CAST(N'2024-07-16T22:41:56.917' AS DateTime), CAST(N'2024-07-16T22:41:56.917' AS DateTime), 2200000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (127, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 7, CAST(N'2024-07-16T22:42:21.033' AS DateTime), CAST(N'2024-07-16T22:42:21.033' AS DateTime), 1100000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (128, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 7, CAST(N'2024-07-16T22:43:35.307' AS DateTime), CAST(N'2024-07-16T22:43:35.307' AS DateTime), 1100000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (129, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 7, CAST(N'2024-07-16T23:12:24.597' AS DateTime), CAST(N'2024-07-16T23:13:38.097' AS DateTime), 4400000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (130, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 7, CAST(N'2024-07-16T23:14:30.510' AS DateTime), CAST(N'2024-07-16T23:14:30.510' AS DateTime), 3300000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (131, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 7, CAST(N'2024-07-16T23:47:20.870' AS DateTime), CAST(N'2024-07-16T23:47:20.870' AS DateTime), 2200000, 1, N'')
INSERT [dbo].[order] ([order_id], [customer_id], [full_name], [email], [address], [phone_number], [payment_id], [note], [status_id], [create_date], [update_date], [total_price], [sale_id], [sale_note]) VALUES (132, 2, N'Trịnh Đình Ngọc', N'ngocqd6@gmail.com', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 338750792, 1, N'', 7, CAST(N'2024-07-16T23:48:22.590' AS DateTime), CAST(N'2024-07-16T23:49:11.143' AS DateTime), 2200000, 1, N'')
SET IDENTITY_INSERT [dbo].[order] OFF
GO
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 2, 827000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (6, 3, 400000, 3)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (9, 3, 999000, 2)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (7, 3, 635000, 3)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (20, 4, 269000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (23, 4, 1100000, 2)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (19, 5, 514000, 3)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (22, 5, 349000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (15, 5, 299000, 2)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (9, 6, 999000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (21, 6, 500000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (11, 9, 160000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (17, 9, 310000, 4)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (6, 10, 400000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (11, 10, 160000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (17, 10, 310000, 4)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (11, 11, 160000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (17, 11, 310000, 4)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (6, 12, 400000, 3)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (6, 16, 400000, 5)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (7, 16, 635000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (11, 16, 160000, 6)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (23, 110, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (19, 111, 514000, 21)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 112, 1100000, 5)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (6, 107, 400000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (19, 108, 514000, 3)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 113, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 114, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (7, 116, 635000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 118, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 119, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 120, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (20, 125, 269000, 2)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (25, 125, 110000, 2)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 126, 1100000, 2)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 127, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 128, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (7, 34, 635000, 4)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (18, 35, 517000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (19, 36, 514000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (6, 37, 400000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (7, 38, 635000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (6, 42, 400000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (19, 42, 514000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 44, 1100000, 2)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (6, 44, 400000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (7, 44, 635000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (15, 44, 299000, 2)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (18, 44, 517000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (19, 44, 514000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (22, 44, 349000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (7, 45, 635000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 129, 1100000, 4)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 130, 1100000, 3)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 131, 1100000, 2)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 132, 1100000, 2)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (18, 58, 517000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 60, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (7, 60, 635000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (15, 60, 299000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (18, 60, 517000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 61, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (7, 61, 635000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (9, 61, 999000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (15, 64, 299000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (22, 64, 349000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (9, 65, 999000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (9, 66, 999000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (9, 67, 999000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (7, 70, 635000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (6, 74, 400000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 75, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (7, 76, 635000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (18, 76, 517000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 77, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (11, 81, 160000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (23, 81, 1100000, 4)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (6, 82, 400000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (9, 83, 999000, 6)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (19, 83, 514000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (21, 86, 500000, 2)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (6, 88, 400000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 89, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 90, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 91, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 92, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 93, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 95, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 96, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (21, 97, 500000, 3)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (23, 98, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (15, 100, 299000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (6, 103, 400000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (17, 13, 310000, 4)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 122, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (6, 57, 400000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (19, 57, 514000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (7, 59, 635000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (22, 73, 349000, 1)
GO
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 94, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (23, 102, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (18, 14, 517000, 3)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (23, 15, 1100000, 2)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (6, 109, 400000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 115, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (20, 41, 269000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (21, 41, 500000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (18, 62, 517000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (19, 62, 514000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (21, 62, 500000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (18, 63, 517000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (19, 63, 514000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (21, 63, 500000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (9, 78, 999000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (21, 85, 500000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (6, 39, 400000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (19, 39, 514000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (19, 69, 514000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (7, 84, 635000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (19, 84, 514000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (23, 99, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (23, 101, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 121, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (6, 40, 400000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (7, 40, 635000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (18, 40, 517000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (19, 40, 514000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (19, 43, 514000, 4)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (18, 68, 517000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (1, 71, 1100000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (6, 71, 400000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (7, 71, 635000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (9, 71, 999000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (15, 71, 299000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (18, 71, 517000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (19, 71, 514000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (21, 71, 500000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (22, 71, 349000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (21, 87, 500000, 2)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (25, 124, 110000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (18, 117, 517000, 1)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (25, 123, 110000, 3)
INSERT [dbo].[orderdetail] ([product_id], [order_id], [price], [quantity]) VALUES (19, 72, 514000, 1)
GO
SET IDENTITY_INSERT [dbo].[payment_method] ON 

INSERT [dbo].[payment_method] ([id], [payment]) VALUES (1, N'Cash on Delivery')
INSERT [dbo].[payment_method] ([id], [payment]) VALUES (2, N'Pay via payment')
INSERT [dbo].[payment_method] ([id], [payment]) VALUES (3, N'Pay via transfer bank')
SET IDENTITY_INSERT [dbo].[payment_method] OFF
GO
SET IDENTITY_INSERT [dbo].[product] ON 

INSERT [dbo].[product] ([product_id], [cid], [brand_id], [price], [image], [status], [description], [stock_quantity], [number_sold], [create_date], [update_date], [create_by], [update_by], [delete_by], [delete_date], [is_delete], [product_name], [import_price]) VALUES (1, 1, 6, 1100000, N'Static_access_manager\assets\img\products\One_piece\Luffy_gear_4.jpg', N'Available', N'Chất liệu cao cấp, chắc chắn, Màu sắc đẹp mắt, Các chi tiết được làm vô cùng tỉ mỉ', 26, 27, CAST(N'2024-06-05' AS Date), CAST(N'2024-07-17' AS Date), NULL, 5, 3, CAST(N'2024-07-14' AS Date), 0, N'Mô Hình Luffy', 900000)
INSERT [dbo].[product] ([product_id], [cid], [brand_id], [price], [image], [status], [description], [stock_quantity], [number_sold], [create_date], [update_date], [create_by], [update_by], [delete_by], [delete_date], [is_delete], [product_name], [import_price]) VALUES (6, 1, 4, 400000, N'Static_access_manager\assets\img\products\One_piece\Sanji_fight.jpg', N'Available', N'Chất liệu cao cấp, chắc chắn, Màu sắc đẹp mắt, Các chi tiết được làm vô cùng tỉ mỉ', 26, 41, CAST(N'2024-05-20' AS Date), CAST(N'2024-07-17' AS Date), NULL, 5, NULL, NULL, 0, N'Mô hình Sanji ', 250000)
INSERT [dbo].[product] ([product_id], [cid], [brand_id], [price], [image], [status], [description], [stock_quantity], [number_sold], [create_date], [update_date], [create_by], [update_by], [delete_by], [delete_date], [is_delete], [product_name], [import_price]) VALUES (7, 2, 2, 635000, N'Static_access_manager\assets\img\products\Dragon_Ball\Songoku_1.jpg', N'Available', N'Chất liệu cao cấp, chắc chắn, Màu sắc đẹp mắt, Các chi tiết được làm vô cùng tỉ mỉ', 20, 32, CAST(N'2024-06-10' AS Date), CAST(N'2024-07-17' AS Date), NULL, 5, NULL, NULL, 0, N'Mô Hình Songoku vô cực ', 350000)
INSERT [dbo].[product] ([product_id], [cid], [brand_id], [price], [image], [status], [description], [stock_quantity], [number_sold], [create_date], [update_date], [create_by], [update_by], [delete_by], [delete_date], [is_delete], [product_name], [import_price]) VALUES (9, 2, 1, 999000, N'Static_access_manager\assets\img\products\Dragon_Ball\Songoku_2.jpg', N'Available', N'Chất liệu cao cấp, chắc chắn, Màu sắc đẹp mắt, Các chi tiết được làm vô cùng tỉ mỉ', 18, 13, CAST(N'2024-04-05' AS Date), CAST(N'2024-07-17' AS Date), NULL, 5, NULL, NULL, 0, N'Mô Hình Songoku vô cực 3 đầu thay thế', 700500)
INSERT [dbo].[product] ([product_id], [cid], [brand_id], [price], [image], [status], [description], [stock_quantity], [number_sold], [create_date], [update_date], [create_by], [update_by], [delete_by], [delete_date], [is_delete], [product_name], [import_price]) VALUES (11, 3, 3, 160000, N'Static_access_manager\assets\img\products\Nenderoid\OnePicec_6nv.jpg', N'Available', N'Các nhân vật trong One Piece     ', 11, 8, CAST(N'2024-02-05' AS Date), CAST(N'2024-07-17' AS Date), NULL, 5, NULL, NULL, 0, N'Mô hình OnePiece Bộ 6 nhân vật', 100000)
INSERT [dbo].[product] ([product_id], [cid], [brand_id], [price], [image], [status], [description], [stock_quantity], [number_sold], [create_date], [update_date], [create_by], [update_by], [delete_by], [delete_date], [is_delete], [product_name], [import_price]) VALUES (15, 3, 5, 299000, N'Static_access_manager\assets\img\products\Nenderoid\HVSAH_9NV.png', N'Available', N'Các nhân vật trong Học viện siêu anh hùng', 32, 12, CAST(N'2024-02-08' AS Date), CAST(N'2024-07-17' AS Date), NULL, 5, NULL, NULL, 0, N'Mô Hình Chibi Học Viện Siêu Anh Hùng', 180000)
INSERT [dbo].[product] ([product_id], [cid], [brand_id], [price], [image], [status], [description], [stock_quantity], [number_sold], [create_date], [update_date], [create_by], [update_by], [delete_by], [delete_date], [is_delete], [product_name], [import_price]) VALUES (17, 4, 3, 310000, N'Static_access_manager\assets\img\products\Naruto\Naruto_Cuu_vi.jpg', N'Available', N'Chất liệu cao cấp, chắc chắn, Màu sắc đẹp mắt, Các chi tiết được làm vô cùng tỉ mỉ', 10, 29, CAST(N'2024-01-15' AS Date), CAST(N'2024-07-14' AS Date), NULL, 3, NULL, NULL, 0, N'Mô Hình Naruto Cửu Vĩ', 200000)
INSERT [dbo].[product] ([product_id], [cid], [brand_id], [price], [image], [status], [description], [stock_quantity], [number_sold], [create_date], [update_date], [create_by], [update_by], [delete_by], [delete_date], [is_delete], [product_name], [import_price]) VALUES (18, 4, 1, 517000, N'Static_access_manager\assets\img\products\Naruto\Kakashi.jpg', N'Available', N'Chất liệu cao cấp, chắc chắn, Màu sắc đẹp mắt, Các chi tiết được làm vô cùng tỉ mỉ', 16, 36, CAST(N'2024-01-20' AS Date), CAST(N'2024-07-14' AS Date), NULL, 3, 1, CAST(N'2024-06-13' AS Date), 0, N'Mô Hình Hokaghe Kakashi', 400000)
INSERT [dbo].[product] ([product_id], [cid], [brand_id], [price], [image], [status], [description], [stock_quantity], [number_sold], [create_date], [update_date], [create_by], [update_by], [delete_by], [delete_date], [is_delete], [product_name], [import_price]) VALUES (19, 5, 4, 514000, N'Static_access_manager\assets\img\products\Kimetsu_no_yaiba\Nezuko.jpg', N'Available', N'Manga – Anime​: Kimetsu No Yaiba Chiều cao: 31 cm  Mục đích: Trang trí văn phòng, bàn làm việc, sưu tầm, trưng bày, quà tặng,…', 17, 65, CAST(N'2024-05-12' AS Date), CAST(N'2024-07-14' AS Date), NULL, 3, NULL, NULL, 0, N'Mô Hình Kamado Nezuko', 400000)
INSERT [dbo].[product] ([product_id], [cid], [brand_id], [price], [image], [status], [description], [stock_quantity], [number_sold], [create_date], [update_date], [create_by], [update_by], [delete_by], [delete_date], [is_delete], [product_name], [import_price]) VALUES (20, 5, 5, 269000, N'Static_access_manager\assets\img\products\Kimetsu_no_yaiba\Kokushibou.jpg', N'Available', N'Chất liệu cao cấp, chắc chắn, Màu sắc đẹp mắt, Các chi tiết được làm vô cùng tỉ mỉ', 17, 11, CAST(N'2024-12-12' AS Date), CAST(N'2024-07-16' AS Date), NULL, 5, NULL, NULL, 0, N'Mô Hình Kokushibou', 190000)
INSERT [dbo].[product] ([product_id], [cid], [brand_id], [price], [image], [status], [description], [stock_quantity], [number_sold], [create_date], [update_date], [create_by], [update_by], [delete_by], [delete_date], [is_delete], [product_name], [import_price]) VALUES (21, 6, 5, 500000, N'Static_access_manager\assets\img\products\Pokemon\Pokemon_1.jpg', N'Available', N'Dusk Mane Necrozma do Necrozma hấp thụ năng lượng từ Pokémon Mặt Trời – Solgaleo. Dusk Mane Necrozma ngoài màu vàng sáng rực của mặt trời còn được bao bọc bởi màu đen của Necrozma. Sở hữu cặp mắt màu xanh biếc nổi bật, ra mắt trong Pokemon Gen VIII – Pokemon Ultra Sun.', 19, 23, CAST(N'2024-02-27' AS Date), CAST(N'2024-07-14' AS Date), NULL, 3, NULL, NULL, 0, N'Mô hình Dusk Mane Necrozma', 380000)
INSERT [dbo].[product] ([product_id], [cid], [brand_id], [price], [image], [status], [description], [stock_quantity], [number_sold], [create_date], [update_date], [create_by], [update_by], [delete_by], [delete_date], [is_delete], [product_name], [import_price]) VALUES (22, 6, 6, 349000, N'Static_access_manager\assets\img\products\Pokemon\Pokemon_2.jpg', N'Available', N'Charizard là Pokémon Lửa và Bay. Charizard cùng với Venusaur, Blastoise là Bộ Ba đầu tiên của thế giới Pokémon.', 6, 10, CAST(N'2024-03-20' AS Date), CAST(N'2024-07-14' AS Date), NULL, 3, 1, CAST(N'2024-06-13' AS Date), 0, N'Mô hình Charizard', 250000)
INSERT [dbo].[product] ([product_id], [cid], [brand_id], [price], [image], [status], [description], [stock_quantity], [number_sold], [create_date], [update_date], [create_by], [update_by], [delete_by], [delete_date], [is_delete], [product_name], [import_price]) VALUES (23, 7, 5, 1100000, N'Static_access_manager\assets\img\products\Marvel\HulkBuster.jpg', N'Available', N'Một mô hình Hulkbuster có chiều cao khoảng 55cm nặng khoảng 10kg
', 12, 19, CAST(N'2024-03-15' AS Date), CAST(N'2024-07-17' AS Date), NULL, 5, 1, CAST(N'2024-06-13' AS Date), 0, N'HulkBuster', 950000)
INSERT [dbo].[product] ([product_id], [cid], [brand_id], [price], [image], [status], [description], [stock_quantity], [number_sold], [create_date], [update_date], [create_by], [update_by], [delete_by], [delete_date], [is_delete], [product_name], [import_price]) VALUES (24, 4, 1, 100000, N'Static_access_manager/assets/img/products/Naruto/z5501516839512_25951f5235076ec120fd6958f64ce645.jpg', N'Available', N'This is naruto', 15, 0, CAST(N'2024-06-24' AS Date), CAST(N'2024-07-17' AS Date), 2, 5, NULL, NULL, 0, N'Naruto', 500000)
INSERT [dbo].[product] ([product_id], [cid], [brand_id], [price], [image], [status], [description], [stock_quantity], [number_sold], [create_date], [update_date], [create_by], [update_by], [delete_by], [delete_date], [is_delete], [product_name], [import_price]) VALUES (25, 2, 3, 110000, N'Static_access_manager/assets/img/products//480ce503-068a-4e45-a33f-cfb0200ee6ce.jfif', N'Available', N'This is product', 13, 0, CAST(N'2024-07-16' AS Date), CAST(N'2024-07-17' AS Date), 3, 5, NULL, NULL, 0, N'abc', 100000)
SET IDENTITY_INSERT [dbo].[product] OFF
GO
SET IDENTITY_INSERT [dbo].[role] ON 

INSERT [dbo].[role] ([role_id], [role_name]) VALUES (1, N'Admin')
INSERT [dbo].[role] ([role_id], [role_name]) VALUES (2, N'Marketer')
INSERT [dbo].[role] ([role_id], [role_name]) VALUES (3, N'Sale')
INSERT [dbo].[role] ([role_id], [role_name]) VALUES (4, N'Manager Sale')
INSERT [dbo].[role] ([role_id], [role_name]) VALUES (5, N'Warehouse Staff')
SET IDENTITY_INSERT [dbo].[role] OFF
GO
SET IDENTITY_INSERT [dbo].[shipping_info] ON 

INSERT [dbo].[shipping_info] ([id], [customer_id], [full_name], [phone_number], [address], [default]) VALUES (1, 2, N'Nguyễn Thể', N'0338750792', N'Thạch Hòa Thạc Thất', 0)
INSERT [dbo].[shipping_info] ([id], [customer_id], [full_name], [phone_number], [address], [default]) VALUES (2, 2, N'Nguyễn Ngọc Minh ', N'0326636993', N'Thư Phú, Thường Tín', 0)
INSERT [dbo].[shipping_info] ([id], [customer_id], [full_name], [phone_number], [address], [default]) VALUES (3, 2, N'Trịnh Đình Ngọc', N'0338750792', N'Thôn Quất Động, xã Quất Động, Thường Tín, Hà Nội', 1)
INSERT [dbo].[shipping_info] ([id], [customer_id], [full_name], [phone_number], [address], [default]) VALUES (4, 2, N'Trịnh Đình Ngọc', N'338750792', N'Quất Động, Thường Tín', 0)
INSERT [dbo].[shipping_info] ([id], [customer_id], [full_name], [phone_number], [address], [default]) VALUES (5, 2, N'Ngọc', N'0326636993', N'THPT Thường Tín', 0)
INSERT [dbo].[shipping_info] ([id], [customer_id], [full_name], [phone_number], [address], [default]) VALUES (6, 2, N'Trịnh Đình Ngọc', N'0338750792', N'Thôn Quất Động - Hà Nội', 0)
INSERT [dbo].[shipping_info] ([id], [customer_id], [full_name], [phone_number], [address], [default]) VALUES (7, 2, N'FPt', N'0333333', N'Quất Động', 0)
INSERT [dbo].[shipping_info] ([id], [customer_id], [full_name], [phone_number], [address], [default]) VALUES (8, 3, N'Ngọc Minh', N'0326636993', N'Thường Tín', 1)
INSERT [dbo].[shipping_info] ([id], [customer_id], [full_name], [phone_number], [address], [default]) VALUES (9, 5, N'Nguyễn Quốc Thể', N'0338750792', N'Quat Dong - Thuong Tin - Ha Noi', 1)
SET IDENTITY_INSERT [dbo].[shipping_info] OFF
GO
SET IDENTITY_INSERT [dbo].[slider] ON 

INSERT [dbo].[slider] ([id], [title], [image], [backlink], [status], [notes], [staff_id]) VALUES (1, N'hihi', N'Static_access_manager/assets/img/sliders/z2859577397035_da6c889e16daf74686e3f0c9dfc91cab.jpg', N'hihi', 0, N'This is slider', NULL)
INSERT [dbo].[slider] ([id], [title], [image], [backlink], [status], [notes], [staff_id]) VALUES (5, N'hihi', N'Static_acess_shop/img/hero/banner.png', N'home', 1, N'Ahihi', NULL)
INSERT [dbo].[slider] ([id], [title], [image], [backlink], [status], [notes], [staff_id]) VALUES (7, N'hihi', N'Static_acess_shop/img/hero/banner.png', N'hihi', 0, N'hihi', NULL)
INSERT [dbo].[slider] ([id], [title], [image], [backlink], [status], [notes], [staff_id]) VALUES (10, N'hihi', N'Static_access_manager/assets/img/sliders/z2859577404791_5fa96824d084eedaafb69388bbc65848 (1).jpg', N'con', 0, N'hihi', NULL)
SET IDENTITY_INSERT [dbo].[slider] OFF
GO
SET IDENTITY_INSERT [dbo].[staff] ON 

INSERT [dbo].[staff] ([staff_id], [email], [password], [fullname], [address], [phone_number], [role_id], [create_date], [update_date], [avatar], [status], [gender]) VALUES (1, N'ngocqd2@gmail.com', N'$2a$10$N9JufeHF9dnEYpm52HkbtORNTuQXT85O0XRl0MkIKM51izJrCgmGG', N'Trịnh Đình Ngọc', N'Thường Tín', N'0338750792', 3, CAST(N'2024-06-09' AS Date), CAST(N'2024-06-09' AS Date), N'Static_access_manager\assets\img\Avatar\None_avatar.jpg', 1, 1)
INSERT [dbo].[staff] ([staff_id], [email], [password], [fullname], [address], [phone_number], [role_id], [create_date], [update_date], [avatar], [status], [gender]) VALUES (2, N'ngocqd1@gmail.com', N'$2a$10$5STEhNLsFD9dxbs92Rxnn.qyRe2Tud6Eue.VDKghHRUmQ5sctlA3G', N'Nguyen Ngoc Minh', N'Thường Tín', N'123456789', 3, CAST(N'2024-06-09' AS Date), CAST(N'2024-06-09' AS Date), N'Static_access_manager\assets\img\Avatar\None_avatar.jpg', 1, 0)
INSERT [dbo].[staff] ([staff_id], [email], [password], [fullname], [address], [phone_number], [role_id], [create_date], [update_date], [avatar], [status], [gender]) VALUES (3, N'ngocqd3@gmail.com', N'$2a$10$.2KGWDmQBufeswwLNJW/euA8vOrKGLrpzj8G6bHZusJOPR/O7e0T2', N'Nguyen Quoc The', N'Thường Tín', N'0348006551', 2, CAST(N'2024-06-09' AS Date), CAST(N'2024-06-09' AS Date), N'Static_access_manager\assets\img\Avatar\None_avatar.jpg', 1, 1)
INSERT [dbo].[staff] ([staff_id], [email], [password], [fullname], [address], [phone_number], [role_id], [create_date], [update_date], [avatar], [status], [gender]) VALUES (4, N'ngocqd4@gmail.com', N'$2a$10$.arRppbYqxiFWaQWjqKojeoaFLAHSM8THRbfjRqbd2S2r6TL1CbUK', N'Pham Huy Tan', N'Thach That', N'324532432', 4, CAST(N'2024-06-09' AS Date), CAST(N'2024-06-09' AS Date), N'Static_access_manager\assets\img\Avatar\None_avatar.jpg', 1, 1)
INSERT [dbo].[staff] ([staff_id], [email], [password], [fullname], [address], [phone_number], [role_id], [create_date], [update_date], [avatar], [status], [gender]) VALUES (5, N'ngocqd9@gmail.com', N'$2a$10$hVhXrruT8ThNNfKqsIbFg.KmdE6H8lv894xpCBNSjzpd1h8ja0gWq', N'Nguyen Trung Anh', N'Viet Nam', N'0123212545', 5, CAST(N'2024-06-10' AS Date), CAST(N'2024-06-10' AS Date), N'Static_access_manager\assets\img\Avatar\None_avatar.jpg', 1, 1)
INSERT [dbo].[staff] ([staff_id], [email], [password], [fullname], [address], [phone_number], [role_id], [create_date], [update_date], [avatar], [status], [gender]) VALUES (6, N'ngocqd10@gmail.com', N'$2a$10$sj317QVxFMu/HpjV5wxwqOSQ4VedcmxchT7AOld4D5dh4qldcUxcy', N'Nguyễn Anh Tú', N'Hà Nội - Việt Nam', N'0326636993', 1, CAST(N'2024-06-23' AS Date), CAST(N'2024-06-23' AS Date), N'Static_access_manager\assets\img\Avatar\None_avatar.jpg', 1, 1)
INSERT [dbo].[staff] ([staff_id], [email], [password], [fullname], [address], [phone_number], [role_id], [create_date], [update_date], [avatar], [status], [gender]) VALUES (18, N'ngocqd17@gmail.com', N'$2a$10$H9sAUcKihJbRdGbjUDrrEuXntR.DcPbpkm7VixL0Ph2Aq90.Y84XC', N'John Doe', N'123 Street', N'1234567890', 4, CAST(N'2024-07-15' AS Date), CAST(N'2024-07-15' AS Date), N'Static_access_manager\assets\img\Avatar\None_avatar.jpg', 1, 1)
SET IDENTITY_INSERT [dbo].[staff] OFF
GO
SET IDENTITY_INSERT [dbo].[status_order] ON 

INSERT [dbo].[status_order] ([id], [status]) VALUES (1, N'Paid')
INSERT [dbo].[status_order] ([id], [status]) VALUES (2, N'Pending')
INSERT [dbo].[status_order] ([id], [status]) VALUES (3, N'Confirmed')
INSERT [dbo].[status_order] ([id], [status]) VALUES (4, N'Shipping')
INSERT [dbo].[status_order] ([id], [status]) VALUES (5, N'Delivered')
INSERT [dbo].[status_order] ([id], [status]) VALUES (6, N'Completed')
INSERT [dbo].[status_order] ([id], [status]) VALUES (7, N'Cancel')
INSERT [dbo].[status_order] ([id], [status]) VALUES (8, N'Payment failed')
SET IDENTITY_INSERT [dbo].[status_order] OFF
GO
ALTER TABLE [dbo].[blog]  WITH CHECK ADD FOREIGN KEY([blog_category_id])
REFERENCES [dbo].[blog_category] ([blog_category_id])
GO
ALTER TABLE [dbo].[blog]  WITH CHECK ADD  CONSTRAINT [FK__blog__id_creater__0E6E26BF] FOREIGN KEY([id_creater])
REFERENCES [dbo].[staff] ([staff_id])
GO
ALTER TABLE [dbo].[blog] CHECK CONSTRAINT [FK__blog__id_creater__0E6E26BF]
GO
ALTER TABLE [dbo].[cart]  WITH CHECK ADD  CONSTRAINT [FK__cart__customer_i__0F624AF8] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([customer_id])
GO
ALTER TABLE [dbo].[cart] CHECK CONSTRAINT [FK__cart__customer_i__0F624AF8]
GO
ALTER TABLE [dbo].[cart]  WITH CHECK ADD  CONSTRAINT [FK__cart__product_id__10566F31] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[cart] CHECK CONSTRAINT [FK__cart__product_id__10566F31]
GO
ALTER TABLE [dbo].[feedback]  WITH CHECK ADD  CONSTRAINT [FK__feedback__custom__14270015] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([customer_id])
GO
ALTER TABLE [dbo].[feedback] CHECK CONSTRAINT [FK__feedback__custom__14270015]
GO
ALTER TABLE [dbo].[feedback]  WITH CHECK ADD  CONSTRAINT [FK__feedback__delete__151B244E] FOREIGN KEY([delete_by])
REFERENCES [dbo].[staff] ([staff_id])
GO
ALTER TABLE [dbo].[feedback] CHECK CONSTRAINT [FK__feedback__delete__151B244E]
GO
ALTER TABLE [dbo].[feedback]  WITH CHECK ADD  CONSTRAINT [FK__feedback__produc__68487DD7] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[feedback] CHECK CONSTRAINT [FK__feedback__produc__68487DD7]
GO
ALTER TABLE [dbo].[order]  WITH CHECK ADD  CONSTRAINT [FK__order__customer___17036CC0] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([customer_id])
GO
ALTER TABLE [dbo].[order] CHECK CONSTRAINT [FK__order__customer___17036CC0]
GO
ALTER TABLE [dbo].[order]  WITH CHECK ADD  CONSTRAINT [FK_order_payment_method] FOREIGN KEY([payment_id])
REFERENCES [dbo].[payment_method] ([id])
GO
ALTER TABLE [dbo].[order] CHECK CONSTRAINT [FK_order_payment_method]
GO
ALTER TABLE [dbo].[order]  WITH CHECK ADD  CONSTRAINT [FK_order_staff] FOREIGN KEY([sale_id])
REFERENCES [dbo].[staff] ([staff_id])
GO
ALTER TABLE [dbo].[order] CHECK CONSTRAINT [FK_order_staff]
GO
ALTER TABLE [dbo].[order]  WITH CHECK ADD  CONSTRAINT [FK_order_status_order] FOREIGN KEY([status_id])
REFERENCES [dbo].[status_order] ([id])
GO
ALTER TABLE [dbo].[order] CHECK CONSTRAINT [FK_order_status_order]
GO
ALTER TABLE [dbo].[orderdetail]  WITH CHECK ADD  CONSTRAINT [FK__orderdeta__order__6A30C649] FOREIGN KEY([order_id])
REFERENCES [dbo].[order] ([order_id])
GO
ALTER TABLE [dbo].[orderdetail] CHECK CONSTRAINT [FK__orderdeta__order__6A30C649]
GO
ALTER TABLE [dbo].[orderdetail]  WITH CHECK ADD  CONSTRAINT [FK__orderdeta__produ__6B24EA82] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[orderdetail] CHECK CONSTRAINT [FK__orderdeta__produ__6B24EA82]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [FK__product__brand_i__19DFD96B] FOREIGN KEY([brand_id])
REFERENCES [dbo].[brand] ([brand_id])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK__product__brand_i__19DFD96B]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [FK__product__cid__1AD3FDA4] FOREIGN KEY([cid])
REFERENCES [dbo].[category] ([cid])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK__product__cid__1AD3FDA4]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [FK__product__create___1BC821DD] FOREIGN KEY([create_by])
REFERENCES [dbo].[staff] ([staff_id])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK__product__create___1BC821DD]
GO
ALTER TABLE [dbo].[shipping_info]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([customer_id])
GO
ALTER TABLE [dbo].[slider]  WITH CHECK ADD  CONSTRAINT [FK_slider_staff] FOREIGN KEY([staff_id])
REFERENCES [dbo].[staff] ([staff_id])
GO
ALTER TABLE [dbo].[slider] CHECK CONSTRAINT [FK_slider_staff]
GO
ALTER TABLE [dbo].[staff]  WITH CHECK ADD  CONSTRAINT [FK__staff__role_id__1EA48E88] FOREIGN KEY([role_id])
REFERENCES [dbo].[role] ([role_id])
GO
ALTER TABLE [dbo].[staff] CHECK CONSTRAINT [FK__staff__role_id__1EA48E88]
GO
USE [master]
GO
ALTER DATABASE [Fluffy_Shop] SET  READ_WRITE 
GO
