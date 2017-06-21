# TKO Seat Geek
### aka, Event Tracker
Use the Seat Geek API for event lookups

## App Store
This project has been accepted by Apple and is available for free in the [App Store](https://itunes.apple.com/us/app/tko-event-tracker/id1244792509?ls=1&mt=8). I have it available for download so you can play with it. The source code is available here and you can see it in action as well what the back end is doing. 

## About the code
There is a lot going on in the program. I use SwiftyJSON and PromiseKit, both of these pods are used regularly in my projects. They add value without being overly bloated. Well, PromiseKit is a handfull, but for asynchronous calls it can really be worth it. My project structure typically consists of an API folder for accessing data, Models for holding on to the data, ViewControllers for, well, view controllers, and Views for anything reusable, like table cells of specialty views. 

I typically use a one storyboard per view controller model. While I like seeing the big picture you get when all the scenes are in one storyboard view, there are major issues when working in a collaborative environment. Additionally, With a storyboard instead of a XIB, you can sometimes leverage the segues to make the code cleaner and simpler.

Ultimately all I am doing is accessing public API's, which is what the majority of mobile apps need to do, if they need access to any information at all. The API class combined with the Endpoint class do most of the heavy lifting for accessing data.

## Installation

Clone the project using the 'Clone or Download' link

## Dependencies

You will need Cocoapods install on your development computer, see: [Cocoapods](https://cocoapods.org)

Then run the usual 'pod install' to install the required modules. You need to close the project and open the workspace from now on.

## Watch your language!

I use SwiftLint to enforce good hygene. If you do not have SwiftLint installed it skips the check. To get SwiftLint go [here](https://github.com/realm/SwiftLint) and follow the instructions.

## Updating the Seat Geek API Key

Follow the instructions to obtain your free API key [here](https://seatgeek.com/account/develop)

### Then, in your project directory:

Copy 'TKOSeatGeek/APIinfo.plist.template' to 'TKOMapApp/APIinfo.plist'

Add 'TKOSeatGeek/APIinfo.plist' to your project

Open and edit the file, add your key value to the SeatGeekAPIKey entry under Root

### Build and run

If there is a problem with the API key setup, the program will tell you
