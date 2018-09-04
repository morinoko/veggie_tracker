# Veggie Tracker

This is a simple Ruby app built with Sinatra that will allow you to keep track of what vegetables you want to plant and when.

User have the ability to:
- Create one or more farms/gardens
- Add vegetables to their farms. Vegetables can be assigned to all farms or specific farms.
- Keep track of what month the vegetables need to be planted by specifying the planting season for each vegetable.
- Edit or delete farms and vegetables as needed.
- See the vegetables to plant this month upon logging in.

Localized to English and Japanese. You can try the app out here:
 - English: https://veggie-tracker.herokuapp.com/en/
 - Japanese: https://veggie-tracker.herokuapp.com/ja/
 
 Future improvements planned:
 - Ability to see vegetables to plant by month (not just this month)
 - Possibly more specific planting seasons, e.g. beginning/middle/end of month and season range.
 - Better design


## Contributing

You can make a request or report a bug by creating an issue. Or write your own code an submit a pull request:

1. Fork and clone the repository, following the steps below.
2. Create a branch named after the feature or bug. For example: `git checkout -b feature/new-feature` or `git checkout -b bug/bug-fix`.
3. Write your code and commit changes with an understandable commit message.
4. Push to the branch with `git push origin feature/new-feature`.
5. Create a pull request: Explain the reason for the change, why the code was written the way it was, etc.

## Set up

### Prerequisites

- Ruby
- SQLite3

### Installation

1. Fork the repository and clone it.
2. Run `bundle install` to install gems (If you don't have bundler, first run `gem install bundler`)
3. Set up the database with `rake db:migrate`.
4. The app uses the dotenv gem for environment variables (currently only one for the session_secret). Create a `.env` file in the root of the app and add `SESSION_SECRET=your_secret` (replace the your_secret with your own secret. Check Sinatra's "Session Secret Generation" section in their [Readme](http://sinatrarb.com/intro.html) for recommendations.
5. Run `shotgun` to run the app locally at `http://localhost:9393/`. That should be it!

### Tests

This app has a simple test suite that uses Rspec. Tests can be run with `rspec spec`.
