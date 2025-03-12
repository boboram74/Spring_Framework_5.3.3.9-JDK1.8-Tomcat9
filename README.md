## 게시판 기본기능,프로필사진업로드,파일업로드

## 프로젝트 구조
Spring04
src
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
└── WEB-INF
├── classes
└── spring
├── appServlet
│   └── servlet-context.xml
└── root-context.xml
├── views
│   ├── board
│   │   ├── detail.jsp
│   │   ├── list.jsp
│   │   └── write.jsp
│   └── members
└── web.xml
└── home.jsp
