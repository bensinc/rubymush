# rubymush

A MUSH, MUD, etc. implementation in Ruby. Includes a Rails web front-end for web services, coding, and other functions.

**Special features:**

* ActiveRecord for storage, so can run against MySQL, sqlite, etc.
* EventMachine for networking
* Uses the V8 JavaScript engine for in-mush coding (maybe it should be called jsMUSH?)
* Rails web interface

**Setup:**

* Setup as a normal Rails app. i.e. bundle install, create db, etc. You don't need to run the Rails app unless you want the web interface.
* Setup the first room (TODO, make this happen automatically):
  * Manually create a room in the database: insert into things (name,kind) values ('test room', 'object');
  * Edit ruby_mush.rb and set START_LOCATION to the thing ID, probably 1

* Start the server, found in the mush directory: ruby ruby_mush.rb development
* telnet localhost 8081
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

Special notes:

The server will "tick" every 5-10 seconds and run any code on your objects in a code attribute named "tick." Use this to make objects that perform tasks on their own.

Any object that receives a "tell" message will have code on its "receive" code executed, with the message as the parameters.

Any object that enters a room will trigger the room's "entered" code, with the entering object ref as the parameter.

More features to come!
