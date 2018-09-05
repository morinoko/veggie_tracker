# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database
- [x] Include more than one model class: User, Farm, Vegetable, FarmVegetable(for pivot table)
- [x] Include at least one has_many relationship on your User model: User has_many farms, User has_many vegetables through farm_vegetables, Farm has many_vegetables through farm_vegetables, Vegetable has_many farms through farm_vegetables
- [x] Include at least one belongs_to relationship on another model: Farm belongs_to User
- [x] Include user accounts
- [x] Ensure that users can't modify content created by other users (Use sessions to keep track of current user and whether or not users are logged in or out)
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
- [x] Include user input validations (use ActiveRecord validations for email, username, and password. Also, use Bcrypt to validate secure password)
- [x] Display validation failures to user with error message (Use rack-flash to implement flash messages)
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
