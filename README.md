Skill2Share challenge
========
Skill2Share is about sharing skills and experiences. We have created a first version of the platform for you to build upon & adapt to your communities needs. This contest is for us a way to be inspired from your experiences in developing for & with your communities and learn from your journeys.

Everyone can build a community & participate in this contest.


###Who can participate?
Everyone from all across the world.


### More information
Visit [Skill2Share](http://www.skill2share.org)

For more information or questions <codingchallenge@skill2share.org>

##So what's in it for you?
**The prize is an accommodated journey to Japan where you the winner can present your project & process!** Yes, we will pay your trip to Japan; where you can enjoy for example sushi and other things Japanese.

Demo
========
Visit the url below, register and check it out. [Skill2Share Demo](http://skill2share.herokuapp.com)


Installation Instructions
========
Install RVM with ```Ruby 1.9.3.``` If you have 1.9.3 on your system you're good to go. Please refer to the RVM site for more details.

After this set up ```Postgres 9.3.5.0``` for your platform. Refer to Postgres for details.

Fill in your database variables trough ```config/database.yml```

Generate a secret token with ```rake secret``` and add your secret token to ```.env```

Then cd to the folder of your project and run:

```bundle install```

After completion create, migrate and seed your db with a custom rake command: 

```rake db_tasks:rebuild```

Run

```rails s```

Open your browser and point to:

``` http://localhost:3000 ```