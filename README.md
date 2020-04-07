# nerdgeschoss Office App

## How to maintain the door sidekiq worker

This application contains a sidekiq runner that is supposed to work on a raspberry pi connected to
the office door. This runner executes hardware commands on the GPIO to trigger the door buzzer.

To update the worker, ssh into the pi, cd into the app's folder and execute

```bash
git pull
cd ..
./sidekiq
```

The sidekiq command will reload the config from heroku and then trigger systemd to reload the sidekiq process. To see if everything is working, check http://nerdgeschoss-office.herokuapp.com/sidekiq.
