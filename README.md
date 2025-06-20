## Complaint Management System (CMS)

This is a full-stack web-based Complaint Management System developed for the Municipal IT Division. The system allows internal employees to submit, edit, and delete complaints, while administrators can view, update, and resolve them.

## Setup Instructions

1. Clone the repository.
2. Import the project into IntelliJ or Eclipse.
3. Set up the MySQL database using the provided SQL script.
4. Configure the `context.xml` file for Apache Commons DBCP.
5. Deploy the project on Apache Tomcat (e.g., http://localhost:8080/CMS).
6. Open `SignIn.jsp` to begin.


## Project Structure

- `view/` – Contains JSP files (SignIn.jsp, SignUp.jsp, ComplainManage.jsp, sendComplain.jsp)
- `controller/` – Java Servlets (ComplainetServlet, EmployeeHomeServlet,LoginServletSignIn,UserServlet)
- `model/` – JavaBeans (UserModel.java, ComplainModel.java)
- `dto/` – Database interaction classes(UserDto.java, ComplainDto.java)
- `db/` – DBCP connection factory
