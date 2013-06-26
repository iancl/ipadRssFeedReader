
Ipad RSS Feed Reader
==============

Check your RSS channels from your ipad
--------------


This is a RSS reader that I am currently developing. Right now it is just parsing rss from some newspaper sites and from the apple developer feed.


error handing and appropriate control enabling is pending until creative design and animations are defined


Class structure
--------------

- RSSItem : NSObject

- RSSfeedChanel : NSObject

- UINavigationController

- HomeViewController : UIViewController

- channelViewController : UIViewController

- feedViewController : UITableViewController

- MapViewController : UIViewController


The planned worklow is the following:
--------------

- Home screen will show all the RSS channels in 'cards'. Each card will show the channel info and picture if avaiable

- To see a channel feed list a user will select any channel

- The feedlist channel will show all the feeds and an image if avalable

- If user clicks on any feed item a new view with a webView will slide in and show the article page


Sounds
--------------

- n/a

Graphical Interface
--------------

- Creating is working on that right now


Server Connection
--------------

 - NSURLConnection


Parser:
--------------

- NSXmlParser


Animations
--------------

- will make use of uiview block animations and CALayer animations

*****

