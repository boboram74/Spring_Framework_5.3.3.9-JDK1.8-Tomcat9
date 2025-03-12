# 📌 Spring legacy 게시판 기본기능 + 프로필사진 업로드 + 파일업로드 프로젝트

## 🔍 프로젝트 소개
Spring Framework 기반으로 제작한 웹 게시판 프로젝트입니다.  
사용자 회원가입 시 **프로필 이미지 업로드**,  
게시글 작성 시 **파일 업로드** 기능을 포함하며,  
**기본 CRUD 게시판 기능(글쓰기, 목록조회, 수정, 삭제, 상세보기)** 을 제공합니다.

모든 기능은 **MVC 아키텍처 구조**, **계층별 클래스 분리(Controller-Service-DAO)** 원칙에 따라 설계되었습니다.

---

## 💻 사용 기술 스택
| 구분 | 기술 |
|------|------|
| Language | Java 11 |
| Framework | Spring Legacy 5.5 (Spring MVC) |
| Build Tool | Maven |
| View | JSP, JSTL |
| DB | Oracle DB |
| ORM | MyBatis, Spring JDBC |
| File Upload | Apache Commons FileUpload, MultipartResolver |
| WAS | Apache Tomcat 9 |
| IDE | IntelliJ / Eclipse (STS3) |

---

## 📂 프로젝트 디렉토리 구조
```plaintext
Spring04  
└── src  
    └── main  
        ├── java  
        │   └── com  
        │       └── kedu  
        │           ├── controller  
        │           │   ├── BoardsController.java  
        │           │   ├── FileController.java  
        │           │   ├── HomeController.java  
        │           │   ├── MembersController.java  
        │           │   └── ReplyController.java  
        │           ├── dao  
        │           │   ├── BoardsDAO.java  
        │           │   ├── FileDAO.java  
        │           │   ├── MembersDAO.java  
        │           │   └── ReplyDAO.java  
        │           ├── dto  
        │           │   ├── BoardsDTO.java  
        │           │   ├── FileDTO.java  
        │           │   ├── MembersDTO.java  
        │           │   └── ReplyDTO.java  
        │           ├── service  
        │           │   ├── BoardsService.java  
        │           │   ├── MembersService.java  
        │           │   ├── FileService.java  
        │           │   └── ReplyService.java  
        │           └── utils  
        │               └── Statics.java  
        ├── resources  
        └── webapp  
            ├── resources  
            ├── WEB-INF  
            │   ├── classes  
            │   ├── spring  
            │   │   ├── appServlet  
            │   │   │   └── servlet-context.xml  
            │   │   └── root-context.xml  
            │   └── views  
            │       ├── board  
            │       │   ├── detail.jsp  
            │       │   ├── list.jsp  
            │       │   └── write.jsp  
            │       └── members  
            ├── web.xml  
            └── home.jsp
