

# Resources
    - Storyboards
    - Assets
    - JSON storage files



# Models
    - Badge
    - CalendarDay
    - DatabaseManager

### Badge
	-------------------------------------------------------------
	|     id		|   name   	|  description  	| earnedAt 	|
	| ------------- | ---------	| -----------------	| ---------	|
	|   Integer   	|  String   |    String        	|   Date    |
	-------------------------------------------------------------

    - belongs to a User ( If we end up having a User)
    
### CalendarDay



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

