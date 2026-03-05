# TODO List Application

A comprehensive Java web-based TODO list application built with Maven, Servlets, JSP, and MySQL database. This application provides a complete task management system with user authentication, allowing users to register, login, and manage their personal tasks efficiently.

## Description

The TODO List Application is a full-featured web application designed to help users organize and track their daily tasks. Built using Java EE technologies, it demonstrates best practices in web application development including proper separation of concerns, secure authentication, and efficient database management.

### Key Features:
- **User Management**: Complete registration and authentication system with password encryption
- **Task Operations**: Create, read, update, and delete tasks with intuitive interface
- **Profile Management**: Users can update their personal information and manage their accounts
- **Session Security**: Secure session-based authentication with configurable timeout
- **Password Recovery**: Forgot password functionality for account recovery
- **Responsive Design**: Clean and user-friendly interface built with JSP

### Architecture:
The application follows a Model-View-Controller (MVC) architecture pattern:
- **Model**: Database entities and data access logic
- **View**: JSP pages for user interface
- **Controller**: Java Servlets handling requests and business logic

### Database Design:
Uses MySQL database with proper normalization for storing user information, tasks, and application data. The connection is managed through a centralized DBConnection class with environment-based configuration.

## Features

- User registration and authentication
- Task management (add, edit, delete tasks)
- User profile management
- Session-based authentication
- Password encryption
- Forgot password functionality

## Technology Stack

- **Backend**: Java Servlets
- **Frontend**: JSP (JavaServer Pages)
- **Database**: MySQL
- **Build Tool**: Maven
- **Server**: Apache Tomcat (or any servlet container)
- **Java Version**: Java 8+

## Prerequisites

- JDK 8 or higher
- Apache Tomcat 9.0 or higher
- MySQL 8.0 or higher
- Maven 3.6 or higher

## Database Setup

1. Create a MySQL database:
```sql
CREATE DATABASE todo_db;
```

2. Create the necessary tables (you'll need to run the SQL scripts or let the application create them)

## Configuration

1. Copy the environment configuration file:
```bash
cp .env.example .env
```

2. Update the `.env` file with your database credentials:
```
DB_URL=jdbc:mysql://localhost:3306/todo_db
DB_USER=your_mysql_username
DB_PASSWORD=your_mysql_password
```

## Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd TODO_LIST
```

2. Build the project using Maven:
```bash
mvn clean install
```

3. Deploy the WAR file to your Tomcat server:
   - Copy `target/TODO_LIST.war` to Tomcat's `webapps` directory

4. Start Tomcat server

5. Access the application at: `http://localhost:8080/TODO_LIST`

## Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── com/todo/servlets/
│   │       ├── AddTaskServlet.java
│   │       ├── DBConnection.java
│   │       ├── DeleteProfileServlet.java
│   │       ├── DeleteTaskServlet.java
│   │       ├── EditTaskServlet.java
│   │       ├── ForgotPasswordServlet.java
│   │       ├── LoginServlet.java
│   │       ├── LogoutServlet.java
│   │       ├── PasswordEncryption.java
│   │       ├── ProfileServlet.java
│   │       ├── RegisterServlet.java
│   │       └── UpdateProfileServlet.java
│   └── webapp/
│       ├── WEB-INF/
│       │   └── web.xml
│       └── [JSP files]
└── test/
    └── [Test files]
```

## Environment Variables

The application uses the following environment variables:

- `DB_URL` - MySQL database URL
- `DB_USER` - Database username
- `DB_PASSWORD` - Database password
- `DB_DRIVER` - JDBC driver class
- `APP_NAME` - Application name
- `APP_VERSION` - Application version
- `SERVER_PORT` - Server port (default: 8080)
- `SESSION_TIMEOUT` - Session timeout in minutes (default: 30)
- `ENV` - Environment (development/production)

## Usage

1. Register a new user account
2. Login with your credentials
3. Add, edit, or delete tasks
4. Manage your profile
5. Logout when done

## Development

To run the application in development mode:

1. Configure your database in `.env`
2. Run: `mvn tomcat7:run` (if using Tomcat Maven plugin)
3. Access at: `http://localhost:8080/TODO_LIST`

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Troubleshooting

### Database Connection Issues
- Ensure MySQL is running
- Check database credentials in `.env`
- Verify the database exists

### Deployment Issues
- Ensure Tomcat is properly configured
- Check the WAR file is correctly placed in `webapps`
- Verify Java version compatibility

### Common Errors
- **ClassNotFoundException**: Check MySQL connector dependency
- **SQLException**: Verify database connection parameters
- **404 Errors**: Check servlet mappings in `web.xml`

## Support

For issues and questions, please create an issue in the repository or contact the development team.
