# wuzup [![Build Status](https://secure.travis-ci.org/drapergeek/wuzup.png)](http://travis-ci.org/drapergeek/wuzup) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/drapergeek/wuzup)
Project setup
-------------

Get the code.

    git clone git@github.com:drapergeek/wuzup.git

Set up the project's dependencies.

    cd project
    bundle --binstubs
    rake db:create
    rake dev:setup

This will automatically add a heroku remote for staging.

Running tests:

    rake


Use [Foreman](http://goo.gl/oy4uw) to run the app locally.

    foreman start

It uses your `.env` file and `Procfile` to run processes just like Heroku's
[Cedar](https://devcenter.heroku.com/articles/cedar/) stack.

Development
-----------

Create a local feature branch based off master.

    git checkout master
    git pull --rebase
    git checkout -b feature-xyz

Rebase frequently to incorporate upstream changes.

    git fetch origin
    git rebase origin/master
    <resolve conflicts>

When feature is complete and tests pass, commit the changes.

    rake
    git add -A
    git status
    git commit

Share your branch.

    git push origin [branch]

Submit a [Github pull request](http://goo.gl/Kmdee).

Code review
-----------

A team member other than the author reviews the pull request.

They make comments and ask questions directly on lines of code in the Github
web interface or in Campfire.

For changes which they can make themselves, they check out the branch.

    git checkout <branch>
    rake db:migrate
    rake
    git diff staging..HEAD

They make small changes right in the branch, test the feature in browser,
run tests, commit, and push.

When satisfied, they comment on the pull request `Ready to squash and merge.`

Deploy
------

If there are multiple commits in the branch, squash them.

    git rebase -i staging/master
    rake

View a list of new commits. View changed files. Merge branch into staging.

    git checkout staging
    git fetch staging
    git reset --hard staging/master
    git log staging..[branch]
    git diff --stat [branch]
    git merge [branch] --ff-only

Deploy to [Heroku](https://devcenter.heroku.com/articles/quickstart).

    git push staging

Run migrations (if necessary).

    heroku run rake db:migrate --app <app>

Restart the dynos if migrations were run.

    heroku restart --app <app>

Test the feature in browser.

Delete your remote feature branch.

    git push origin :[branch]

Delete your local feature branch.

    git branch -d [branch]

Close pull request and comment `Merged.`
