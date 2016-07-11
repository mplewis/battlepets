# BattlePets

## Matt Lewis, for Wunder Capital's code challenge

BattlePets is an online battle arena for adorable animals called pets.

## Pets

Pets have four attributes:

* Strength
* Agility
* Wit
* Perception

Trainers can recruit pets from the wilderness. Pets come from the wilderness with names they pick themselves and stats they've had since birth.

## Training

Once recruited, the pets' stats can be trained using the following [regimens](config/training.yml):

* Sprinting: Agility ++++, Perception +
* Lifting: Strength ++++
* Hunting: Perception ++, Wit +++

For example, training in Sprinting will increase Agility greatly and increase Perception slightly.

## Contests

Once trained, pets can battle in the arena in three different types of [contests](config/contest.yml). Each contest tests different sets of attributes:

* Power: Strength •••, Agility •
* Evasion: Wit •••, Perception ••, Agility •
* Speed: Agility •••, Perception •

For example, if two pets enter a Power contest, Strength is the attribute that has the most influence on who wins, but Agility also counts toward the final score.

## Variability

Pets aren't perfect - they're living digital organisms. Some days they train more effectively, and some days they get nothing done at all. Their contest performance varies too - a pet with 6 strength may lose to a pet with 4 strength if it does poorly and the competitor does really well.

## Experience

Pets gain experience as they compete. Every contest win is worth 100 experience and every loss is worth 25 experience. Experience doesn't translate into ability or stats – it simply indicates how much a pet has competed.

# Asynchronous Matches

A match of a contest takes a while. Each pet has to be evaluated on its abilities, and the judges are lazy. When a match is kicked off, it won't complete right away - the pets are tested one at a time while the judges evaluate them. Each evaluation can take anywhere from 0 to 5 seconds.

A contest is made up of performances from different pets. A contest is complete (`contest.complete == true`) when all of its performances are complete (`performance.complete == true`).

For convenience, a `progress` attribute is present on Match object that indicates the current count of complete and incomplete performances.

Async match evaluation lives in [app/jobs/pet_evaluator.rb](app/jobs/pet_evaluator.rb).

# Get Started

This app runs on Postgres. It runs fine in dev mode. It's running on Heroku, but the worker process isn't yet online because it costs money.

## Development

```sh
# Install gems
bundle install

# Set up your DB in the usual Rails way
rake db:create db:migrate db:seed

# After seeding the DB with pets, trainings, and matches, we need to start an
# async worker to run the match evaluations

# DO ONE AND ONLY ONE OF THESE:
# Start an asynchronous worker to handle contest scoring
bin/delayed_job start
# OR, start a few of them to run jobs in parallel
bin/delayed_job start -n 10
# OR, start just one in debug mode
rake jobs:work

# Start the Passenger server on port 3000
bundle exec passenger start -p 3000 --max-pool-size 3
```

Finally, visit http://localhost:3000. You should see an empty leaderboard.

Check out the REST API below to see how to work with the app. You'll probably want to start by creating a few pets and training them. Once that's done, you can start a contest!

## Production

If you put this app on Heroku, you'll need to set some environment variables for production mode. Here's an easy way to do that:

```sh
heroku config:set SECRET_TOKEN=`rake db:secret` SECRET_KEY_BASE=`rake db:secret`
```

# REST API

See [api_docs.py](api_docs.py) for runnable examples of the important REST calls:

```
Leaderboard - top ten pets, sorted by win count
    GET https://battlepets-mplewis.herokuapp.com/

Create New Pet
    POST https://battlepets-mplewis.herokuapp.com/pets

List All Pets
    GET https://battlepets-mplewis.herokuapp.com/pets

Get Info on Pet
    GET https://battlepets-mplewis.herokuapp.com/pets/1

Train Pet
    POST https://battlepets-mplewis.herokuapp.com/pets/1/train
    Params: training type

Start a Match
    POST https://battlepets-mplewis.herokuapp.com/matches
    Params: match type, pets competing

Get Match Results
    GET https://battlepets-mplewis.herokuapp.com/matches/1
```

# Testing

Test coverage is minimal, but the goal is to cover the important stuff – business logic that can make or break the app. Here's what's covered and what needs to be:

- [x] Pets can be trained and their stats increase
- [ ] Contest scoring allows variability in pet performance
- [ ] Pet training increases stats with some variability
- [ ] Pet training should never decrease pet stats

# Tech Debt

* The JSON views are kind of a mess. I'd like it if Match only showed winner and performance info when all performances are complete.
* It would be really nice to make the JSON views consistent. The Active Model Serializer works pretty well but misses some edge cases in associations.
* I'd like to break out the leaderboard into an Active Model Serializer for consistency.
* This app is SO SLOW. There are about a million places to optimize DB accesses.
* It's kind of gross to create a Pet's attributes in the model before_create callback.
* There's no checking for null attributes anywhere or enforcing that attributes are non-null. If you make an attribute null with PUT, you'll probably crash the app.
* PetTrainer and MatchRunner are inconsistent re: which class is responsible for reading the YAML. This should be refactored so they both look the same.
