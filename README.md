# WedVite

### The Golden Path

Create, manage a guest list and then invite by electronic means. __stick
to it__

# Heroku

### Deploy

Push the develop branch into master on staging:

    git push staging develop:master

Push the master branch into master on production:

    git push production master:master


### Migrations

Staging:

    heroku run rake db:migrate --remote staging
    heroku restart --app wedvite-staging

Production:

    heroku run rake db:migrate --remote production
    heroku restart --app wedvite

### Nuke

    heroku pg:reset SHARED_DATABASE
    heroku run rake db:setup
    heroku restart

# PayPal

Payments are made using PayPal, see

    config/initializers/pay_pal.rb
