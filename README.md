# Manybots Gmail Pizzahut Agent

Only works in Portugal :)

manybots-gmail-pizzahut is a Manybots Agent that finds Pizzahut order confirmation emails in your Manybots account, parses them and transform them to well structured Meal orders.

As a result, you can use visualizations like Meal Money (available within your Manybots installation) to figure out how much money you're spending at Pizzahut.

This agent requires that you use an email observer like [manybots-gmail](https://github.com/manybots/manybots-gmail) to get emails into your Manybots account.

## Installation instructions

### Setup the gem

You need the latest version of Manybots Local running on your system. Open your Terminal and `cd` into its' directory.

First, require the gem: edit your `Gemfile`, add the following, and run `bundle install`

```
gem 'manybots-gmail-pizzahut', :git => 'git://github.com/manybots/manybots-gmail-pizzahut.git'
```

Second, run the manybots-gmail-pizzahut install generator (mind the underscore):

```
rails g manybots_gmail_pizzahut:install
```

Finaly, migrate the database:

```
bundle exec rake db:migrate
```

### Restart and go!

Restart your server and you'll see the Manybots Pizzahut PT Agent in your `/apps` catalogue. 

Go to the app to start the agent, and take care of your diet!
