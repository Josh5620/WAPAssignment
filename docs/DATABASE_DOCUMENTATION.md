# CodeSage Database Architecture Documentation

## Overview
The CodeSage application uses Entity Framework Core 9.0.9 with SQL Server LocalDB as the primary database solution. The database follows a relational model designed to support an educational platform with user management, course content, assessments, and progress tracking.

## Database Connection
- **Provider**: SQL Server LocalDB
- **Connection String**: `Server=(localdb)\MSSQLLocalDB;Database=ProjectAPIDb;Trusted_Connection=true;MultipleActiveResultSets=true`
- **ORM**: Entity Framework Core 9.0.9
- **Database Name**: `ProjectAPIDb`

## Entity Models & Relationships

### 1. Profile (User Management)
**Table**: `Profiles`
**Purpose**: Stores user account information for students, teachers, and administrators

```csharp
public class Profile
{
    public Guid Id { get; set; }                    // Primary Key
    public string FullName { get; set; }            // Required, User's display name
    public string Email { get; set; }               // Required, Unique identifier for login
    public string PasswordHash { get; set; }        // Required, BCrypt hashed password
    public string Role { get; set; } = "student";   // Default role: student, teacher, admin
    public DateTime CreatedAt { get; set; }         // Account creation timestamp
}
```

**Relationships**:
- One-to-Many with `Enrolments` (via `UserId`)
- One-to-Many with `ForumPosts` (via `ProfileId`)
- One-to-Many with `ChapterProgress` (via `ProfileId`)
- One-to-Many with `Leaderboards` (via `ProfileId`)

**Key Features**:
- Uses BCrypt for secure password hashing
- Supports role-based access control (student/teacher/admin)
- Email used as unique login identifier

---

### 2. Course (Course Management)
**Table**: `Courses`
**Purpose**: Stores course information and metadata

```csharp
public class Course
{
    public Guid Id { get; set; }                    // Primary Key
    public string Title { get; set; }               // Course name
    public string? Description { get; set; }        // Course description (optional)
    public string? PreviewContent { get; set; }     // Course preview text (optional)
    public bool Published { get; set; } = true;     // Visibility flag
}
```

**Relationships**:
- One-to-Many with `Chapters`
- One-to-Many with `Enrolments`
- One-to-Many with `ForumPosts`

**Key Features**:
- Published flag controls course visibility
- Supports rich text descriptions and previews

---

### 3. Chapter (Course Content Structure)
**Table**: `Chapters`
**Purpose**: Organizes course content into sequential chapters

```csharp
public class Chapter
{
    public Guid Id { get; set; }                    // Primary Key
    public Guid CourseId { get; set; }              // Foreign Key to Course
    public int Number { get; set; }                 // Chapter sequence number
    public string Title { get; set; }               // Chapter name
    public string? Summary { get; set; }            // Chapter description (optional)
}
```

**Relationships**:
- Many-to-One with `Course` (via `CourseId`)
- One-to-Many with `Resources`
- One-to-Many with `ChapterProgress`

**Key Features**:
- Sequential numbering for ordered content
- Hierarchical content organization

---

### 4. Resource (Learning Materials)
**Table**: `Resources`
**Purpose**: Contains different types of learning materials within chapters

```csharp
public class Resource
{
    public Guid Id { get; set; }                    // Primary Key
    public Guid ChapterId { get; set; }             // Foreign Key to Chapter
    public string Type { get; set; }                // Resource type: "note", "flashcard", "mcq"
    public string? Content { get; set; }            // Resource content (optional)
}
```

**Relationships**:
- Many-to-One with `Chapter` (via `ChapterId`)
- One-to-Many with `Flashcards`
- One-to-Many with `Questions`

**Key Features**:
- Polymorphic design supporting multiple content types
- Flexible content storage system

---

### 5. Question (Assessment System)
**Table**: `Questions`
**Purpose**: Stores quiz questions and assessment items

```csharp
public class Question
{
    public Guid Id { get; set; }                    // Primary Key
    public Guid ResourceId { get; set; }            // Foreign Key to Resource
    public string Stem { get; set; }                // Required, Question text
    public string Difficulty { get; set; }          // Required, "easy", "medium", "hard"
    public string? Explanation { get; set; }        // Answer explanation (optional)
}
```

**Relationships**:
- Many-to-One with `Resource` (via `ResourceId`)
- One-to-Many with `QuestionOptions`

**Key Features**:
- Difficulty-based question categorization
- Support for detailed answer explanations

---

### 6. QuestionOption (Multiple Choice Options)
**Table**: `QuestionOptions`
**Purpose**: Stores multiple choice options for questions

```csharp
public class QuestionOption
{
    public Guid Id { get; set; }                    // Primary Key
    public Guid QuestionId { get; set; }            // Foreign Key to Question
    public string OptionText { get; set; }          // Option display text
    public bool IsCorrect { get; set; }             // Correct answer flag
}
```

**Relationships**:
- Many-to-One with `Question` (via `QuestionId`)

**Key Features**:
- Supports multiple correct answers per question
- Flexible option text formatting

---

### 7. Flashcard (Study Materials)
**Table**: `Flashcards`
**Purpose**: Stores flashcard study materials

```csharp
public class Flashcard
{
    public Guid Id { get; set; }                    // Primary Key
    public Guid ResourceId { get; set; }            // Foreign Key to Resource
    public string? FrontText { get; set; }          // Front side content (optional)
    public string? BackText { get; set; }           // Back side content (optional)
    public int OrderIndex { get; set; }             // Display order
}
```

**Relationships**:
- Many-to-One with `Resource` (via `ResourceId`)

**Key Features**:
- Traditional flashcard front/back design
- Ordered presentation support

---

### 8. Enrolment (Course Registration)
**Table**: `Enrolments`
**Purpose**: Tracks user enrollment in courses

```csharp
public class Enrolment
{
    public Guid UserId { get; set; }                // Foreign Key to Profile (Composite Key)
    public Guid CourseId { get; set; }              // Foreign Key to Course (Composite Key)
    public string Status { get; set; } = "active";  // "active", "completed", "withdrawn"
}
```

**Relationships**:
- Many-to-One with `Profile` (via `UserId`)
- Many-to-One with `Course` (via `CourseId`)

**Key Features**:
- Composite primary key (UserId + CourseId)
- Status tracking for enrollment lifecycle
- Prevents duplicate enrollments

---

### 9. ChapterProgress (Progress Tracking)
**Table**: `ChapterProgress`
**Purpose**: Tracks user progress through course chapters

```csharp
public class ChapterProgress
{
    public Guid Id { get; set; }                    // Primary Key
    public Guid ProfileId { get; set; }             // Foreign Key to Profile
    public Guid ChapterId { get; set; }             // Foreign Key to Chapter
    public bool IsCompleted { get; set; }           // Completion status
    public DateTime? CompletedAt { get; set; }       // Completion timestamp (optional)
    public int? Score { get; set; }                 // Chapter score (optional)
}
```

**Relationships**:
- Many-to-One with `Profile` (via `ProfileId`)
- Many-to-One with `Chapter` (via `ChapterId`)

**Key Features**:
- Individual chapter completion tracking
- Score recording for assessments
- Timestamp tracking for analytics

---

### 10. ForumPost (Discussion System)
**Table**: `ForumPosts`
**Purpose**: Stores forum discussions and posts

```csharp
public class ForumPost
{
    public Guid Id { get; set; }                    // Primary Key
    public Guid ProfileId { get; set; }             // Foreign Key to Profile
    public Guid CourseId { get; set; }              // Foreign Key to Course
    public string Title { get; set; }               // Post title
    public string Content { get; set; }             // Post content
    public DateTime CreatedAt { get; set; }         // Creation timestamp
}
```

**Relationships**:
- Many-to-One with `Profile` (via `ProfileId`)
- Many-to-One with `Course` (via `CourseId`)

**Key Features**:
- Course-specific discussion threads
- User attribution and timestamps

---

### 11. Leaderboard (Gamification)
**Table**: `Leaderboards`
**Purpose**: Tracks user performance and rankings

```csharp
public class Leaderboard
{
    public Guid Id { get; set; }                    // Primary Key
    public Guid ProfileId { get; set; }             // Foreign Key to Profile
    public int TotalScore { get; set; }             // User's total score
    public int Rank { get; set; }                   // User's current rank
    public DateTime LastUpdated { get; set; }       // Last update timestamp
}
```

**Relationships**:
- Many-to-One with `Profile` (via `ProfileId`)

**Key Features**:
- Real-time ranking system
- Score accumulation across courses
- Performance tracking over time

---

## Database Context Configuration

### ApplicationDbContext
The main Entity Framework context that manages all database operations:

```csharp
public class ApplicationDbContext : DbContext
{
    // DbSet properties for each entity
    public DbSet<Profile> Profiles { get; set; }
    public DbSet<Course> Courses { get; set; }
    public DbSet<Chapter> Chapters { get; set; }
    public DbSet<Resource> Resources { get; set; }
    public DbSet<Question> Questions { get; set; }
    public DbSet<QuestionOption> QuestionOptions { get; set; }
    public DbSet<Flashcard> Flashcards { get; set; }
    public DbSet<Enrolment> Enrolments { get; set; }
    public DbSet<ChapterProgress> ChapterProgress { get; set; }
    public DbSet<ForumPost> ForumPosts { get; set; }
    public DbSet<Leaderboard> Leaderboards { get; set; }
}
```

---

## API Endpoints

### Authentication Endpoints
- `POST /api/Profiles/login` - User authentication
- `POST /api/Profiles/simple-login` - Testing endpoint (plain text passwords)

### User Management
- `GET /api/Profiles` - List all users
- `GET /api/Profiles/{id}` - Get user by ID
- `GET /api/Profiles/role/{role}` - Get users by role
- `POST /api/Profiles` - Create new user
- `PATCH /api/Profiles/{id}` - Update user
- `DELETE /api/Profiles/{id}` - Delete user

### Course Management
- `GET /api/Courses` - List all courses
- `GET /api/Courses/{id}` - Get course by ID
- `POST /api/Courses` - Create new course
- `PUT /api/Courses/{id}` - Update course
- `DELETE /api/Courses/{id}` - Delete course

### Testing & Development
- `POST /api/TestData/seed` - Seed database with sample data
- `POST /api/TestData/create-test-users` - Create test users (BCrypt passwords)
- `POST /api/TestData/create-simple-users` - Create test users (plain passwords)
- `GET /api/TestData/status` - Check database statistics
- `DELETE /api/TestData/clear` - Clear all test data

### Debug Endpoints
- `GET /api/Debug/profiles` - Debug user information
- `POST /api/Debug/test-login` - Debug login functionality

---

## Security Features

### Password Security
- **BCrypt Hashing**: All passwords stored using BCrypt with salt
- **Login Verification**: `BCrypt.Net.BCrypt.Verify()` for authentication
- **No Plain Text**: Passwords never stored in plain text

### Authentication Flow
1. User submits email/username and password
2. System locates user by email or full name
3. BCrypt verifies password against stored hash
4. Returns JWT-compatible response with user data

### Authorization
- **Role-Based Access**: student, teacher, admin roles
- **Course Enrollment**: Users must be enrolled to access course content
- **Progressive Access**: Chapter completion gates access to subsequent content

---

## Database Initialization

### Automatic Database Creation
```csharp
// In Program.cs
context.Database.EnsureCreated();
```

### Sample Data Seeding
The system includes comprehensive test data seeding:
- Default admin and student accounts
- Sample courses (JavaScript, Python)
- Chapter structure with resources
- Sample questions and flashcards

---

## Performance Considerations

### Indexing Strategy
- Primary keys (Guid) automatically indexed
- Foreign keys optimized for joins
- Email field should be indexed for login performance

### Connection Management
- Uses connection pooling via Entity Framework
- Supports multiple active result sets
- LocalDB provides good development performance

### Query Optimization
- Eager loading for related data: `.Include()`
- Pagination for large result sets
- Async operations for better scalability

---

## Backup & Recovery

### Development Environment
- LocalDB files stored in user profile
- Automatic transaction log management
- Easy database reset via `EnsureDeleted()` + `EnsureCreated()`

### Production Considerations
- Regular automated backups recommended
- Transaction log management
- Point-in-time recovery capabilities

---

## Migration Strategy

### Code-First Approach
```bash
# Create new migration
dotnet ef migrations add MigrationName

# Update database
dotnet ef database update
```

### Database Versioning
- Entity Framework handles schema changes
- Automatic migration support
- Data preservation during updates

---

This documentation provides a complete overview of the CodeSage database architecture, suitable for technical documentation and future development reference.