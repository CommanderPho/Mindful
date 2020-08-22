Mindful is an iOS app as a tool to assist in increasing the awareness of a user's phone usage by scheduling times where their phones should not be open. Users can create schedules, add goals, and receive rewards for sticking to their goals.

---------------------------------------------------------------------------------------------------------
# Features to add
---------------------------------------------------------------------------------------------------------

- Model DayView after iOS calendar app
- Awareness zones
- Add Awareness Zone Model
- Edit Badges
- Edit Goals
- Badge earned conditions
- Goal completed conditions
- Remove past goals
- Statistics Page
- Calendar Search
- Point System
- Set repeating goals and badges
- Have a 'Today' button that sets the focusDate to Date()
- Potentially remove buttons for last and next month

### Demo Images

```Main Views```

| Home | Schedule | Progress |
| :---: | :---: | :---: |
| <img src="https://user-images.githubusercontent.com/38144750/90966875-b8d62480-e4a5-11ea-85c8-919ce46aa149.png" width=200> |<img src="https://user-images.githubusercontent.com/38144750/90966873-b83d8e00-e4a5-11ea-8acd-e7978ccbe4af.png" width=200> | <img src="https://user-images.githubusercontent.com/38144750/90966874-b83d8e00-e4a5-11ea-81f0-30e4a7bc3122.png" width=200> | 

```Awareness Zones```

| List of Awareness Zones | Create a Zone | Select Goals for Current Zone |
| :---: | :---: | :---: |
| <img src="https://user-images.githubusercontent.com/38144750/90966867-b673ca80-e4a5-11ea-9cf4-33577f16ad6f.png" width=200> | <img src="https://user-images.githubusercontent.com/38144750/90966868-b70c6100-e4a5-11ea-9726-e0e2a68d8223.png" width=200> | <img src="https://user-images.githubusercontent.com/38144750/90966871-b7a4f780-e4a5-11ea-9c7c-2ecc365ecf90.png" width=200> | 


```Goals```

| List of Goals in an Awareness Zone | View a Goal | Create a Goal |
| :---: | :---: | :---: |
| <img src="https://user-images.githubusercontent.com/38144750/90966870-b7a4f780-e4a5-11ea-8114-2c58be7a77f3.png" width=200> | <img src="https://user-images.githubusercontent.com/38144750/90966869-b70c6100-e4a5-11ea-8a69-fb6205216805.png" width=200> | <img src="https://user-images.githubusercontent.com/38144750/90966872-b7a4f780-e4a5-11ea-9aa4-3ea3effa3725.png" width=200> | 

---------------------------------------------------------------------------------------------------------


### Awareness Zone Model (Zone)
- id
- start time: "yyyy-mm-dd hh-mm" floor(mm)
- end time
- minutes of phone use between start and end: defaults to 0
- notes: not null


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

