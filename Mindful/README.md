# Todo
    - Make all view controllers/views subclassed to a style 
    view so there is no need to write .backgroundcolor etc. for every page
    - DaysCell onTap should redirect to list of goals due that day and all goals
    due that day and goals in progress (INCOMPLETE/IN-PROGRESS -> decide which one) 
        - ex: 
            Due today:
                - goal 1
                - goal 2
            
            In Progress:
                - goal 3
                - goal 4
    - GoalCell should be made, onTap should redirect to goal description or
    /present/ the goal description and status
        - ex:
            Title
            IN-PROGRESS due May 12, 2020
            Description
    

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

