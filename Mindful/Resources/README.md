
# Features to add
### Edit Badges
### Edit Goals
### Badge earned conditions
### Goal completed conditions

---------------------------------------------------------------------------------------------------------
# Todo
---------------------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------
### Calendar Features
- Use Calendar to find 'n' number of days in a month
- Render 'n' days in one view
- Days line up with day of week [S,M,T,W,Th,F,Su]
- Slow with SCrollView wrapping ForEach
- Fast with List, but navigation is different (each month is its own cell and the navigation is botched)
- Currently optimal is using iOS 14 and wrapping a scrollview->ForEach with a LazyVStack

- Maybe make NewGoal view a presented view that can be dismissed?
- Clean up Calendar code
- Should only need MonthView, WeekView, DayView
---------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------
### Goal Features
---------------------------------------------------------------------------------------------------------
- Edit a goal
- remove a goal
- Create a badge for a goal?
- set a condition where the goal is considered complete?
---------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------
### Badge Features
---------------------------------------------------------------------------------------------------------
- let a badge be checkable (earned/unearned)
- set a condition where the badge is considered earned?
---------------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------------
### Day Features
---------------------------------------------------------------------------------------------------------
- a day view (list of all goals) should have at least 2 sections
- goals due that day
- goals due in the future
---------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------
# Models
---------------------------------------------------------------------------------------------------------
## Goal

### Properties
- id: Int64?
- title: String
- description: String
- status: String
- dateCreated: String
- dateCompleted: String
- dateDue: String

### Associations
- badges: hasMany


## Badge

### Properties
- id: Int64?
- goalId: Int64?
- title: String
- description: String
- imageName: String
- dateEarned: String

### Associations
- goal: belongsTo

---------------------------------------------------------------------------------------------------------
# Views
---------------------------------------------------------------------------------------------------------

## Calendar
### DayView
- Shows list of goals due on a particular day
### WeekView
- HStack of DateCells in a week
### MonthView
- VStack of WeekViews in a month 
### WeekHeaderView
- HStack of WeekHeaderCells displaying a week
### CalendarView
- Wrapper for navigating Months and displaying WeekHeader

## Goal
### NewGoalView
- View to input information for a new Goal
### GoalView
- Shows information described by Goal model


## Badge
### NewBadgeView
- View to input information for a new Badge
### BadgeView
- Shows information described by Badge model
### BadgeRowView
- HStack of DateCells
### BadgeGridView
- VStack of BadgeRowViews



## Cells
### GoalCell
### DateCell
### WeekHeaderCell
### BadgeCell



## Profile
### ProfileRow
### ProfileView

---------------------------------------------------------------------------------------------------------
# Controllers
---------------------------------------------------------------------------------------------------------

