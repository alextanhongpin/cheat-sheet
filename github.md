# Facebook Graph API Explorer

## Get the {page-id} from Graph API

```bash
# at Graph API Explorer
?id=https://www.facebook.com/groups/python.malaysia
```

Output:

```json
{
  "og_object": {
    "id": "1552086488210868",
    "type": "website",
    "updated_time": "2017-10-10T05:14:51+0000"
  },
  "id": "https://www.facebook.com/groups/python.malaysia"
}
```

## Get the facebook page events
```bash
{page-id}/events

#e.g. 
32572091379/events
```

Output:
```json
{
  "data": [
    {
      "description": "Ever wondered a Neural Nets work? Been hearing of deep nets, Convolutional Nets, Recurrent Nets, Activation Functions and all sorts of mumbo jumbo in the ML/DL/AI world. 

Well, to gain full understanding of these concepts, the best way is to build your own Net from scratch. You will get a good depth of understanding of how Neural nets work and how they predict amazing results with high precision and accuracy. 

This is a casual study group. We shall work and build a simple neural net together and train a handwriting classifier. 

Targeted towards beginners, although prior knowledge of neural nets is very useful. 

RSVP so we know numbers coming. 
Any questions, feel free to post in the comments section.

Transportation: TTDI MRT (5 mins walk)
Parking: RM3 flat rate in the office building",
      "end_time": "2017-05-06T18:00:00+0800",
      "name": "Build a neural net from scratch HANDS on",
      "place": {
        "name": "Oval Tower Damansara",
        "location": {
          "city": "Damansara",
          "country": "Malaysia",
          "latitude": 3.131598975515,
          "longitude": 101.63142242537,
          "street": "No. 685 Jalan Damansara, 60000 Kuala Lumpur, Malaysia",
          "zip": "60000"
        },
        "id": "604741896236088"
      },
      "start_time": "2017-05-06T12:00:00+0800",
      "id": "620018374854324"
    },
    {
      "description": "This is another casual coffee meetup. Join us if you want to know the python community, or if you have question etc.",
      "end_time": "2017-03-25T18:00:00+0800",
      "name": "Python Malaysia Meetup: 23-March-2017",
      "place": {
        "name": "Cafe Coffee Day - Malaysia",
        "location": {
          "city": "Kuala Lumpur",
          "country": "Malaysia",
          "latitude": 3.1332758710375,
          "longitude": 101.687683753,
          "street": "NU Sentral Grounc Floor #39 Jalan Sambanthan",
          "zip": "50470"
        },
        "id": "288991477975930"
      },
      "start_time": "2017-03-25T17:00:00+0800",
      "id": "277833265971850"
    },
    {
      "description": "Ever wondered how to build a full scale production architecture?
Puzzled when you saw those large scary diagrams of squares and triangles with arrows pointing all over?

Well fear no more. 
This is an introductory session to software architecture fundamentals and principles taught by Chee Leong Chow who has a wealth of experience in software engineering and design architecture. 

We shall be focusing principles related to microservices as well as design patterns for data intensive and machine learning applications.

We shall go through questions such as 
- What is an RPC. Are they good?
- How do we decouple applications
- Whats all this rage about microservices and why its good. and Bad. 
- How can we draw and analyze an architecture chat and detect its bottlenecks in big data applications

Beginners are welcome. No coding is required at this event. Come with pens and papers to take notes and write.

Our location is next to Glo Damansara (5 min walk from Next Academy)

Click here for map https://goo.gl/IhrDoa 
MRT Directions: MRT Sungai Buloh-Kajang (SBK) (Taman Tun Dr Ismail Station) - 10 min walk

Parking at glo damansara is rm1 

Kindly RSVP so we know numbers.",
      "end_time": "2017-03-12T18:00:00+0800",
      "name": "Designing Software Architecture for Big Data",
      "place": {
        "name": "15-1 Oval Tower Damansara"
      },
      "start_time": "2017-03-12T13:00:00+0800",
      "id": "277287309371908"
    },
    {
      "description": "Hey guys, 
We will have having an Introduction to Algorithms taught by Chee Leong Chow
We will cover the fundamental data structures and algorithms over coder requires. Regardless if you are new to algos, or its been a while since you last reviewed it, all are welcome. 

We shall be using the famous Algorithm book CLRS (Introduction to Algorithms) by Cormen

Come if you want to learn from the master  :)

Kindly RSVP if you are coming so we know the numbers",
      "end_time": "2017-03-05T19:00:00+0800",
      "name": "Grokking Algorithms",
      "place": {
        "name": "The Sudo Brew",
        "location": {
          "city": "Petaling Jaya",
          "country": "Malaysia",
          "latitude": 3.13173,
          "longitude": 101.62117,
          "street": "7 Jalan SS22/11, Damansara Jaya",
          "zip": "47400"
        },
        "id": "951057818292283"
      },
      "start_time": "2017-03-05T13:00:00+0800",
      "id": "772746726223233"
    },
    {
      "description": "Get your free ticket @ http://pyladies-my-20170304.peatix.com

---

Our first inaugural PyLadies meetup in Malaysia.

Our 3-hour workshop will be conducted in the following format:

Part 1. Setup python virtual environment
Part 2. Understand the basic of python
Part 3. Create a python web app using Flask

The workshop is designed for anyone who is interested to explore leaning a new programming language and no prior experience is required. The workshop will be facilitated by Sian Lerk (OnApp) and Mohd. Fadhil (UM).

As we have limited workspace in OnApp Malaysia home office, and we would like to maximise our available resources on our focus group, the current workshop is only opened for ladies and up to a maximum of 10 lady participants.

If you wish to attend this workshop by public transport, OnApp Malaysia office is located 3 minutes away from Lembah Subang LRT station.

A light refreshment will be served for all participants, courtesy of our sponsor OnApp Malaysia.

We hope to see you on 4th March 2017.


On behalf of,
Alies Yap and Pei Pei

aliess.yap@onapp.com
peipei.teah@onapp.com",
      "end_time": "2017-03-04T12:30:00+0800",
      "name": "PyLadies Malaysia Workshop #1: Learning python with Flask",
      "place": {
        "name": "OnApp Malaysia"
      },
      "start_time": "2017-03-04T09:30:00+0800",
      "id": "1585393211487342"
    },
    {
      "description": "Whats the event about
Bunch of guys (and girl/s) coming together to build some awesome mini projects together. 

How it works
Everyone give 1 min pitch on their mini project idea to everyone. Majority vote wins and everyone works on that project for the session

Outome
1) Develop your coding chops
2) You learn way faster working in a group on a project
3) Teamwork skills
4) Build an awesome portfolio

Requirements
1) You must be able to program at least 1 language

Open to everyone from beginners to advanced. Beginners you have a great opportunity to learn from the experienced devs. And experienced devs can propose exciting projects that let beginners work on cool stuff  :)

RSVP on FB to join",
      "end_time": "2017-02-12T17:00:00+0800",
      "name": "Codejam Session 1",
      "place": {
        "name": "The Sudo Brew",
        "location": {
          "city": "Petaling Jaya",
          "country": "Malaysia",
          "latitude": 3.13173,
          "longitude": 101.62117,
          "street": "7 Jalan SS22/11, Damansara Jaya",
          "zip": "47400"
        },
        "id": "951057818292283"
      },
      "start_time": "2017-02-12T12:00:00+0800",
      "id": "1550761464951799"
    },
    {
      "description": "Just a casual meetup while I am in Penang, I wanted to know how many people are using or are interested in using python, then we can chat. 

As like everything, it is all tentative, I still trying to find a good date and venue as I am not familiar with penang.",
      "end_time": "2017-01-14T16:00:00+0800",
      "name": "Python My Meetup: Penang",
      "place": {
        "name": "China House, Chulia Street, Penang",
        "location": {
          "city": "Penang",
          "country": "Malaysia",
          "latitude": 5.4147716481818,
          "longitude": 100.33878325364
        },
        "id": "1418431485081492"
      },
      "start_time": "2017-01-14T13:00:00+0800",
      "id": "799040330234840"
    },
    {
      "description": "Whats the difference between an average programmer and a great programmer? 
Well, lots of people will say having a strong grasp on algorithms is one of them. 

And its true. Knowledge of algorithms will allow a coder to write efficient good code. It helps to solve lots of common problems and figure out new ways to optimize code. 

This meetup is for people to come together to code and solve algorithmic problems on Hackerrank, a well known site for algorithm challenges. Link here. 
https://www.hackerrank.com/

Agenda
You are open to use any language you prefer. Once each challenge is done, we can compare each other's code from different languages and learn from each other, in regards to method and performance. We may also pair program depending on the skill levels of attendees. 

Prior knowledge of algorithms is not required. However, you must already know how to code, at least in 1 language. 

Benefits of working in a meetup group like this? 
1) You learn from others code
2) You can discuss with like minded people
3) Make new friends along the way. 
Above all, its always more fun solving challenges together in a group :)

As always, RSVP if you are coming. Cheers

PS: Also a good opportunity to build up your profile on hackerrank as lots of companies lookout for hackerrank profiles for hiring.",
      "end_time": "2016-12-17T18:00:00+0800",
      "name": "Grokking Algorithms for Beginners Hackerrank",
      "place": {
        "name": "The Sudo Brew",
        "location": {
          "city": "Petaling Jaya",
          "country": "Malaysia",
          "latitude": 3.13173,
          "longitude": 101.62117,
          "street": "7 Jalan SS22/11, Damansara Jaya",
          "zip": "47400"
        },
        "id": "951057818292283"
      },
      "start_time": "2016-12-17T10:00:00+0800",
      "id": "1281207911901666"
    },
    {
      "description": "Hey guys, 
They say programmers learn best by practice. 
So I figured lets build a scalable web crawler that can traverse the web and extract data / metadata. 
The bot shall be run on distributed cloud servers, and crawl through as much sites as possible. One example used Alexa top 1m sites as a seed urls. 

Its fun, very useful for data scientists and it covers a wide range of fields from devops to algorithms to databases and architectures. 

The agenda of the meeting is coders coming together and coding up parts of the project. Areas include
1) AWS / Axure / Google Cloud
2) Algorithms & Filters
3) Database Admin
4) Message Brokers (RabbitMQ, ZeroMQ)
5) Web crawlers / Bots
6) and others...

The goal is to code up a mini prototype of the project in a single afternoon sitting (hopefully...). Or more likely in 2 afternoon sittings.

Whether you are experienced or new, everyone is welcome and there's a place for each person to participate meaningfully in the project. 
If you are :
an experienced Dev: please come. we need you guys to lead the rest 
a new / intermediate dev: learn from the experienced devs and get directions from the experienced devs. You must have had some coding experience already and able to learn by youself new concepts/api.

Example of the project we will be working on. Or a mini version of it
http://www.michaelnielsen.org/ddi/how-to-crawl-a-quarter-billion-webpages-in-40-hours/

Kindly RSVP so as we know how many are coming. The more we have the better. Everyone that comes shall get access to the private code on github.

Regards
Ming",
      "end_time": "2016-12-03T18:00:00+0800",
      "name": "Building a distributed web crawler",
      "place": {
        "name": "The Sudo Brew",
        "location": {
          "city": "Petaling Jaya",
          "country": "Malaysia",
          "latitude": 3.13173,
          "longitude": 101.62117,
          "street": "7 Jalan SS22/11, Damansara Jaya",
          "zip": "47400"
        },
        "id": "951057818292283"
      },
      "start_time": "2016-12-03T11:00:00+0800",
      "id": "345033879188926"
    },
    {
      "description": "We have a visitor from Stockhom, Sweden. His name is Hasan Mian. The plan is we just have a casual coffee session at Kinokuniya cafe on 26th Sept Monday. 

The agenda is a chat on python experience and community, maybe about how he work. Also for anyone new in the community get to know each other, ask question etc",
      "name": "Python Malaysia Casual Meetup 26/09/2016",
      "place": {
        "name": "Quizinn Food Court, Nu Sentral",
        "location": {
          "city": "Kuala Lumpur",
          "country": "Malaysia",
          "latitude": 3.1344212328387,
          "longitude": 101.68824026278
        },
        "id": "246842488859281"
      },
      "start_time": "2016-09-26T19:30:00+0800",
      "id": "1781995665377340"
    },
    {
      "description": "Ask on stackoverflow on how to be a good programmer, and the common answer is PRACTICE, PRACTICE, PRACTICE. 
There really is no shortcut for it. 

This meetup is aimed at practicing your programming skills by building mini scripts in python. They will test your code development skills, syntax, design structures and a lot of programming essentials. 

The book we will use is Exercises for Programmers: 57 Challenges to Develop Your Coding Skills by Brian Hogan. 
He walks through on the thinking behind building all sorts of mini programs from a BMI Calculator to a Full Blown Tracking Inventory. 
The exercises start easy just to get you warmed up and progressively get harder. 

The fun part is meeting likeminded programmers and solving challenges together. Thats the best way to being a programming rock star  :)  Hope to see you soon. 

Any questions, just post in the comments below.",
      "end_time": "2016-06-25T18:00:00+0800",
      "name": "Build a Calculator and many More in python or javascript",
      "place": {
        "name": "The Sudo Brew",
        "location": {
          "city": "Petaling Jaya",
          "country": "Malaysia",
          "latitude": 3.13173,
          "longitude": 101.62117,
          "street": "7 Jalan SS22/11, Damansara Jaya",
          "zip": "47400"
        },
        "id": "951057818292283"
      },
      "start_time": "2016-06-25T13:00:00+0800",
      "id": "1072761632789085"
    },
    {
      "description": "Find yourself having too little time and too many things to learn? 
Spending hours or days debugging or figuring out a certain platform? 
Ever use Virtualenv? New to Node JS? Getting started on Ruby, GO, ElasticSearch, Tableau,..or the hundreds of other libraries? Don't reinvent the wheel and learn it by yourself. Hear from someone who has already done it and jump start your learning curve. 

Come join our programmers sharing session where we share each of our various platforms, ideas and programming stacks we are working on. 

All welcome to join. However, requirements are everyone must share something. It can be anything. You do not have to be an expert to share it. 

Those who are interested, please RSVP and feel free share what you intend to speak in the comments or PM me. No hard and fast rules. We are all flexible and will decide on the day itself  in regards to the actual topics. 

Looking forward to meeting you guys.",
      "end_time": "2016-04-10T17:00:00+0800",
      "name": "Coders Sharing Session",
      "place": {
        "name": "The Sudo Brew",
        "location": {
          "city": "Petaling Jaya",
          "country": "Malaysia",
          "latitude": 3.13173,
          "longitude": 101.62117,
          "street": "7 Jalan SS22/11, Damansara Jaya",
          "zip": "47400"
        },
        "id": "951057818292283"
      },
      "start_time": "2016-04-10T12:00:00+0800",
      "id": "992044944198702"
    },
    {
      "description": "EVENT POSTPONED TO A LATER DATE DUE TO NOT ENOUGH ATTENDEES. 

Hey guys, 
We'll be working on Project Euler code exercises again. 
These exercises employ a great mix of math algorithm puzzles as well as programming knowledge, the basic essentials for anyone wanting to excel in programming. 

Come join this beginner class and work on Project Euler problems together. 
Check out the problems here
https://projecteuler.net/archives 
If any questions, feel free to PM me. 

All you need is curiosity and sparks of insight.  :)

Best,
Ming",
      "end_time": "2016-03-26T18:00:00+0800",
      "name": "Python Code Challenges - Proj Euler",
      "place": {
        "name": "The Sudo Brew",
        "location": {
          "city": "Petaling Jaya",
          "country": "Malaysia",
          "latitude": 3.13173,
          "longitude": 101.62117,
          "street": "7 Jalan SS22/11, Damansara Jaya",
          "zip": "47400"
        },
        "id": "951057818292283"
      },
      "start_time": "2016-03-26T13:00:00+0800",
      "id": "1076247662437695"
    },
    {
      "description": "Hey guys, 
Scrapy is a powerful framework with scraping. However, it is not exactly the easiest framework to wrap your head around it. 

We are having an intro coding session with scrapy. Preferbly you would have read the scrapy docs and built some spiders beforehand. 

If not, its fine too. We hope to start with some basic crawlers and move into the more advanced stuff  of scrapy. 

All is welcome. Just come with an open mind and ready to contribute. ----- Please read the docs before coming. 

Please RSVP so we know how many people are coming.   :)

Any questions, feel free to PM me.",
      "end_time": "2016-03-20T17:00:00+0800",
      "name": "Scrapy : A Powerful Web scraping Framework Coding Session",
      "place": {
        "name": "The Sudo Brew",
        "location": {
          "city": "Petaling Jaya",
          "country": "Malaysia",
          "latitude": 3.13173,
          "longitude": 101.62117,
          "street": "7 Jalan SS22/11, Damansara Jaya",
          "zip": "47400"
        },
        "id": "951057818292283"
      },
      "start_time": "2016-03-20T13:00:00+0800",
      "id": "971036459638717"
    },
    {
      "description": "Hey guys, 
Python Exercises meetup. Aimed at people who know python basics at least. We will be working on finishing hackerrrank exercises together. 

Site is : hackerrank.com 

See you guys then. Please RSVP FB so we can estimate space at SudoBrew. It ain't big. 

Anything, can PM me.",
      "end_time": "2016-03-06T17:00:00+0800",
      "name": "Beginners Python Exercises",
      "place": {
        "name": "The Sudo Brew",
        "location": {
          "city": "Petaling Jaya",
          "country": "Malaysia",
          "latitude": 3.13173,
          "longitude": 101.62117,
          "street": "7 Jalan SS22/11, Damansara Jaya",
          "zip": "47400"
        },
        "id": "951057818292283"
      },
      "start_time": "2016-03-06T13:00:00+0800",
      "id": "1699557230323540"
    },
    {
      "description": "Hey Guys, 
Creating Poker Bots is a very famous challenge in programming circles. There are numerous tournaments around creating the ultimate AI Poker Bot that can successfully win against human players. 
It requires knowledge is many fields including algorithms, machine learning, neural networks, logic, data mining as well as speed of processing data.
For our poker bot meetup, we will build a Poker Bot from scratch, although a basic one. It will be able to successfully play a game with humans as well as perform all calculations that an average human player does. 

This is a great way to learn lots about Python, Data Structures and algorithms. 
It won't be easy, but I'm looking forward to creating an awesome poker bot. 

Agenda: 
1) Discuss and analyze the Poker Bot System Structure and how it works
2) Code individual Modules of the Program 
3) Combine all modules together to complete the program

FYI: MIT holds PokerBot competitions if you're interested. http://mitpokerbots.com/ 

Pls RSVP facebook if coming so we can plan.",
      "end_time": "2016-02-28T17:00:00+0800",
      "name": "Poker Bot Challenge",
      "place": {
        "name": "The Sudo Brew",
        "location": {
          "city": "Petaling Jaya",
          "country": "Malaysia",
          "latitude": 3.13173,
          "longitude": 101.62117,
          "street": "7 Jalan SS22/11, Damansara Jaya",
          "zip": "47400"
        },
        "id": "951057818292283"
      },
      "start_time": "2016-02-28T10:00:00+0800",
      "id": "1149967811695037"
    },
    {
      "description": "SO we will have a python meetup on the 27th Feb. We will be holding this in Microsoft Auditorium. 

Our speaker is Aaron Myatt. He is an English and a web developer, currently work at Softworks with Jeremy. My background/education is not computer related, but rather science! And i have a rather unhealthy affection for testing and tdd tongue emoticon.

We will have a talk about testing in python",
      "name": "Python Malaysia Meetup Feb 2016",
      "place": {
        "name": "Microsoft Auditorium 26th Floor, Tower 3. KLCC"
      },
      "start_time": "2016-02-27T12:30:00+0800",
      "id": "998813993475120"
    },
    {
      "description": "Hey guys, 
Python is known to be a very powerful tool for scraping. 
For this upcoming meetup, we will be coding basic scrapers to run through various sites. 
The goal is for us to code together and compare scrapers scripts among each other. The final aim is to be able to create better scrapers that are faster in performance and without breaking a site. 

Please note: you will be expected to have some knowledge of 
- Requests
- BeautifulSoup
- Regex
- XPATH
If you do not, please refresh/learn up the basics of these libraries. If you do, then you will be able to get by and learn from the rest. 

We will go through various sites, and together develop scrapers to scrape specific data. 

Any questions, feel free to post in the comments. 

Best
Ming",
      "end_time": "2016-02-20T17:45:00+0800",
      "name": "Python Scrapers Meetup",
      "place": {
        "name": "The Sudo Brew",
        "location": {
          "city": "Petaling Jaya",
          "country": "Malaysia",
          "latitude": 3.13173,
          "longitude": 101.62117,
          "street": "7 Jalan SS22/11, Damansara Jaya",
          "zip": "47400"
        },
        "id": "951057818292283"
      },
      "start_time": "2016-02-20T12:45:00+0800",
      "id": "980241738731176"
    },
    {
      "description": "Hey guys, 
For those that can wake up early on a Saturday, if you are interested in working on basic python Exercises to improve your skills in Python, do come by. 

We will be working on the famous python challenges from Project Euler (https://projecteuler.net/archives )
These are problem sets designed specifically for programming and are mathematical in nature. 
Take a look at some solutions that others have tried, all in python of course. 
http://www.s-anand.net/euler.html 

If you find these questions challenging and interesting, then lets work on them together generate best quality pthon code. 

You can continue on to the next session Python Scrapping Meetup. Trust me, you aint gona want to miss that one.

See you guys soon
Ming
anything just comment in the event page    :)",
      "end_time": "2016-02-20T12:00:00+0800",
      "name": "Python Beginners Meetup 2 (Code Exercises)",
      "place": {
        "name": "The Sudo Brew",
        "location": {
          "city": "Petaling Jaya",
          "country": "Malaysia",
          "latitude": 3.13173,
          "longitude": 101.62117,
          "street": "7 Jalan SS22/11, Damansara Jaya",
          "zip": "47400"
        },
        "id": "951057818292283"
      },
      "start_time": "2016-02-20T09:00:00+0800",
      "id": "1682680278673331"
    },
    {
      "description": "This event is aimed at beginners of Python Language. 
Definition of beginners. 
1) You have done Codecademy (or able to easily complete all exercises)
2) You know Loops, Definitions and Classes. 

We will be working on Python Exercises together from practicepython.org. http://www.practicepython.org/ 

This is a casual meet with the aim for discussion and learning python together. Whether you are a beginner or intermediate python user, you can always learn from teaching others and gain new insights into this awesome language. 

This is a casual meet aimed to jump start python coding sessions. 

Come on by and look forward to see you then. Please RSVP in the event page if you are coming as SudoBrew Cafe has limited spaces. Unless you want to be sitting by yourself in the corner far away.  
Anything, just PM me or contact at 017-4750987

Cheers
Ming

PS: if anyone needs transport from train, I can pick them up at Paramount LRT station at 12.45pm sharp only.",
      "end_time": "2016-02-14T16:00:00+0800",
      "name": "Python Beginners Meetup (Code Exercises)",
      "place": {
        "name": "The Sudo Brew",
        "location": {
          "city": "Petaling Jaya",
          "country": "Malaysia",
          "latitude": 3.13173,
          "longitude": 101.62117,
          "street": "7 Jalan SS22/11, Damansara Jaya",
          "zip": "47400"
        },
        "id": "951057818292283"
      },
      "start_time": "2016-02-14T13:00:00+0800",
      "id": "675241225952450"
    },
    {
      "description": "Just a casual meetup and some announcement of things to do next year and call for help along the way",
      "name": "Python Malaysia Casual Meetup 2015",
      "place": {
        "name": "Old Town White Coffee, Menara UOA Bangsar",
        "location": {
          "city": "Kuala Lumpur",
          "country": "Malaysia",
          "latitude": 3.1273659721211,
          "longitude": 101.6787522,
          "zip": "59000"
        },
        "id": "173703272678089"
      },
      "start_time": "2015-12-12T12:00:00+0800",
      "id": "1649314948643602"
    },
    {
      "description": "Basically it will be raspberry pi jam, on the same day and same place. We just have an unofficial meet during the lunch break(I think) and discuss and plan out our meetup for 2016",
      "name": "Python Malaysia Meetup 2015",
      "place": {
        "name": "APIIT & UCTI",
        "location": {
          "latitude": 3.0479219721,
          "longitude": 101.6928970814
        },
        "id": "146014918774005"
      },
      "start_time": "2015-12-05T10:30:00+0800",
      "id": "424580974414982"
    },
    {
      "description": "To catchup on remaining task. Mostly for crew, but people are welcome to join.",
      "end_time": "2015-08-12T21:30:00+0800",
      "name": "20th PyCon My 2015 planning meeting",
      "place": {
        "name": "google hangout"
      },
      "start_time": "2015-08-12T21:00:00+0800",
      "id": "520979441383811"
    },
    {
      "description": "Keep track of what is being done. Mostly for crew only",
      "end_time": "2015-08-05T21:30:00+0800",
      "name": "19th PyCon My planning meeting",
      "start_time": "2015-08-05T21:00:00+0800",
      "id": "431986040319079"
    },
    {
      "description": "As the event getting close we need to find out the status of things that need to be done",
      "end_time": "2015-07-29T21:30:00+0800",
      "name": "18th PyCon My 2015 planning meeting",
      "place": {
        "name": "google hangout"
      },
      "start_time": "2015-07-29T21:00:00+0800",
      "id": "854424177980814"
    }
  ],
  "paging": {
    "cursors": {
      "before": "QVFIUlBqQ2lmR0RWOWc5MW9scEZAicHdRTTlJd0k1NnhBRFU2ZAXNFYVAtTTU2LVFmU0oxdWFzMVp5eTE3VEhUR3BhTUM3UF9JWXhhbTlYZA28ybGtfM240d2RR",
      "after": "QVFIUnFEUjhmajZAUcVlzYjJjQXFJcl9pRVo3ekR5dnl1SndDbUhldzdaVElCUjFzNExsLXZAqRURBb0dweEprbU1nd0RkMWJmcmZAnREt3eEJ0dk96ZAnUzbm13"
    },
    "next": "https://graph.facebook.com/v2.10/32572091379/events?access_token=EAACEdEose0cBAOYEHyEOdZBWbOEb82j8N6KiW4L8C0EdrD9Ks7Yawdys4Bu5WPIC95N3D9mmCrkfm8R03v0QXNVZBM0t7iHY3M6XSl2XQBYTZCCY5lVGv28ZAgsUkZCx79WgmDZCILz2w6gmTYpjhkyH76ZC4IlzD7gqDZBCo555NI6lTtFhDdfrt8S7XSSyoZBgZD&pretty=0&limit=25&after=QVFIUnFEUjhmajZAUcVlzYjJjQXFJcl9pRVo3ekR5dnl1SndDbUhldzdaVElCUjFzNExsLXZAqRURBb0dweEprbU1nd0RkMWJmcmZAnREt3eEJ0dk96ZAnUzbm13"
  }
}
```
