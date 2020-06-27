

# Resources
    - Storyboards
    - Assets
    - JSON storage files



# Models
    - Badge
    - CalendarDay
    - Goal
    - DatabaseManager

### Badge
    - id: Integer
    - goalId: Integer
    
    - description: String
    - iconName: String
    - earnedAt: Date

    - belongs to a Goal
    
### Goal
    - var id: Int64?
    - var userId: Int
    - var description: String
    - var status: String

    - var createdDayId: Int
    - var completedDayId: Int
    - var deadlineDayId: Int
    
    - has many badges
    - belongs to a User
    - belongs to dayCreated
    - belongs to dayCompleted
    - belongs to dueDate
    
    - Goal#timeRemaining -> Integer
    - Goal#objectivesMet -> [Badge]
    
### Day
    - id: Integer
    - date: Date
    
    - has many Goals

# Views
    - BadgePopup
    - CalendarDayView
    - Cells
        - BadgeCell
            - It should have access to a badge
            - It should open a badge detail popup on tap
    
        - CalendarDayCell
            - It should expand to 



# Controllers
    - BadgesController
    - CalendarDaysController

### BadgesController < CollectionViewController
    - It should list all the badges a user has earned

### CalendarDaysController < CollectionViewController

