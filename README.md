# rubymush

A MUSH, MUD, etc. implementation in Ruby.

**Special features:**

* ActiveRecord for storage, so can run against MySQL, sqlite, etc.
* EventMachine for networking
* Uses the V8 JavaScript engine for in-mush coding

**Setup:**

* Install the gems listed in ruby_mush.rb. TODO: Put this all in a Gemfile
* Edit your db info in db/config.yml
* rake db:create
* rake db:migrate

* Setup the first room (TODO, make this happen automatically):
  * Manually create a room in the database: insert into things (name,kind) values ('test room', 'object');
  * Edit ruby_mush.rb and set START_LOCATION to the thing ID, probably 1

* Start the server: ruby ruby_mush.rb development
* Create a user, and you're in!


Type "help" to see the basic commands, which should be somewhat familiar from other MU-style projects.

**Coding:**

Objects can contain code, actions, and attribute values. Codes are values that contain js code to be executed. Actions setup user commands to run that code. Attributes are used for storing data on the object.

A quick example:

create Talker
drop talker
code talker:talk=me.cmd("say Hello!")
action talker:talk=talk
talk
Talker says, "Hello!"

Special notes:

Inside your js code, "me" refers to the object the code is running on. "Me" has some special functions:

* To run normal user commands, use: me.cmd("command")
* Set an attribute: me.set('name', 'value')
* Get an attribute: me.get('name')
   Note: Anything you get will be a string, so you'll need to convert types if needed. i.e. var x = parseInt(m.get('x'))

A "mush" object is also available that provides additional functions:

* Find another object: mush.find('name or id')
* Fetch a JSON URL: mush.fetch('url');

More features to come!
