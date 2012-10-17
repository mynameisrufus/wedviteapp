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

### Mail

This app sends out quite a bit of mail, you can preview the emails at
http://wedvite.dev/mail-preview the emails are populated using
`app/mailers/mail_preview.rb` and `extras/spoof.rb`.

### Migrations

Staging:

    heroku run rake db:migrate --remote staging
    heroku restart --app wedvite-staging

Production:

    heroku run rake db:migrate --remote production
    heroku restart --app wedvite

### Backups

Copy production data to staging:

    heroku pgbackups:capture --app wedvite
    heroku pg:reset SHARED_DATABASE --app wedvite-staging
    heroku pgbackups:restore SHARED_DATABASE `heroku pgbackups:url --app wedvite` --app wedvite-staging

https://devcenter.heroku.com/articles/pgbackups

Import on local:

    rake db:drop db:create
    curl -o tmp/latest.dump `heroku pgbackups:url`
    pg_restore --verbose --clean --no-acl --no-owner -d wedding_invitor_development tmp/latest.dump

Nuke staging:

    heroku pg:reset SHARED_DATABASE --app wedvite-staging
    heroku run rake db:setup --app wedvite-staging
    heroku restart --app wedvite-staging

# PayPal

Payments are made using PayPal, see

    config/initializers/pay_pal.rb
