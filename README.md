# WedVite

### The Golden Path

Create, manage a guest list and then invite by electronic means. __stick
to it__

# Heroku

### Nuke

    heroku pg:reset SHARED_DATABASE
    heroku run rake db:setup
    heroku restart

### Migrations

    heroku run rake db:migrate
    heroku restart
