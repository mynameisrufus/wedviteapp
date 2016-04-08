# WedVite

### The Golden Path

Create, manage a guest list and then invite by electronic means. __stick
to it__

# Heroku

### Deploy

Staging:

    git push staging master:master

Deploy a branch to staging:

    git push staging feature/foo:master

Production:

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

    heroku pg:backups capture --app wedvite
    heroku pg:reset SHARED_DATABASE --app wedvite-staging
    heroku pgbackups:restore SHARED_DATABASE `heroku pgbackups:url --app wedvite` --app wedvite-staging

https://devcenter.heroku.com/articles/pgbackups

Import on local:

    heroku pg:backups capture --app wedvite
    curl -o tmp/latest.dump `heroku pg:backups public-url --app wedvite`
    rake db:drop db:create
    pg_restore --verbose --clean --no-acl --no-owner -d wedding_invitor_development tmp/latest.dump

Nuke staging:

    heroku pg:reset SHARED_DATABASE --app wedvite-staging
    heroku run rake db:setup --app wedvite-staging
    heroku restart --app wedvite-staging

### Running in development

    gem install dotenv
    gem install foreman
    dotenv foreman start

# Font converters

Ensure required deps:

    script/install_font_converters

Then convert files:

    ttf2woff font.ttf font.woff
