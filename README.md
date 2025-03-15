# 📌 Spring Legacy 게시판 기본기능 + 프로필사진 업로드 + 파일업로드 프로젝트

## 🔍 프로젝트 소개
Spring Framework 기반으로 제작한 웹 게시판 프로젝트입니다.  
사용자 회원가입 시 **프로필 이미지 업로드**,  
게시글 작성 시 **파일 업로드** 기능을 포함하며,  
**기본 CRUD 게시판 기능 (글쓰기, 목록조회, 수정, 삭제, 상세보기)** 를 제공합니다.  
또한, **웹소켓을 활용한 회원 실시간 채팅** 기능을 추가하여,  
회원 간의 즉각적인 소통 및 피드백이 가능하도록 설계되었습니다.

모든 기능은 **MVC 아키텍처 구조**, **계층별 클래스 분리(Controller - Service - DAO)** 원칙에 따라 설계되었으며,  
**jQuery ajax 기반 비동기 게시글 목록 조회** 또한 구현하였습니다.

---

## 💬 실시간 채팅 기능
본 프로젝트는 웹소켓(WebSocket) 기술을 활용하여 회원 간 실시간 채팅을 지원합니다.  
서버와 클라이언트 간의 지속적인 연결을 통해 지연 없는 메시지 전달이 가능하며,  
이 기능을 통해 회원들은 게시판 외에도 실시간으로 소통하며,  
즉각적인 피드백과 커뮤니케이션을 경험할 수 있습니다.

---

## 💻 사용 기술 스택

| 구분            | 기술                                              |
|----------------|---------------------------------------------------|
| Language        | Java 11                                           |
| Framework       | Spring Legacy 5.5 (Spring MVC)                   |
| Build Tool      | Maven                                             |
| Front-End       | JSP, jQuery, AJAX                                 |
| Database        | Oracle DB                                         |
| DB Access       | MyBatis                                           |
| File Upload     | Apache Commons FileUpload, MultipartResolver      |
| WAS             | Apache Tomcat 9                                   |
| IDE             | IntelliJ / Eclipse (Spring Tool Suite 3)          |
| Real-time Chat  | WebSocket                                         |

---

## 📂 프로젝트 디렉토리 구조
```plaintext
Spring04  
├── lib                           
└── src  
    └── main  
        ├── java  
        │   └── com  
        │       └── kedu  
        │           ├── config          
        │           │   ├── SpringProvider.java  
        │           │   └── WebSocketConfig.java  
        │           ├── controller  
        │           │   ├── BoardsController.java  
        │           │   ├── FileController.java  
        │           │   ├── HomeController.java  
        │           │   ├── MembersController.java  
        │           │   ├── ReplyController.java  
        │           │   └── ChatController.java  
        │           ├── dao  
        │           │   ├── BoardsDAO.java  
        │           │   ├── ChatDAO.java        
        │           │   ├── FileDAO.java  
        │           │   ├── MembersDAO.java  
        │           │   └── ReplyDAO.java  
        │           ├── dto  
        │           │   ├── BoardsDTO.java  
        │           │   ├── ChatDTO.java       
        │           │   ├── FileDTO.java  
        │           │   ├── MembersDTO.java  
        │           │   └── ReplyDTO.java  
        │           ├── service  
        │           │   ├── BoardsService.java  
        │           │   ├── ChatService.java   
        │           │   ├── MembersService.java  
        │           │   ├── FileService.java  
        │           │   └── ReplyService.java  
        │           └── utils  
        │               ├── ChatEndPoint.java
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
            │       ├── members  
            │       │   ├── mypage.jsp  
            │       │   └── signupForm.jsp  
            │       ├── chat  
            │       │   └── chat.jsp    
            │       └── home.jsp  
            ├── web.xml  
            └── upload  
