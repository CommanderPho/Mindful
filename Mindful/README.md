

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
    - id: Integer
    - userId: Integer // If we will allow for sign-in
    - dayId: Integer
    
    - description: String
    - status: [INCOMPLETE, PAUSED, COMPLETE]: String
    - deadline: Date: nil
    - createdAt: Date
    - completedAt: Date
    
    - has many badges
    - belongs to a User
    - belongs to a Day
    
    - Goal#timeRemaining -> Integer
    - Goal#objectivesMet -> [Badge]
    
### Day
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

