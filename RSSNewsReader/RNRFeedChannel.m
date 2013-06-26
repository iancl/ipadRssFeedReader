//
//  RNRFeedChannel.m
//  RSSNewsReader
//
//  Created by Ian Calderon on 6/24/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import "RNRFeedChannel.h"
#import "RNRItem.h"

/**
 *Creating Category to declare all private methods and variables
 */
@interface RNRFeedChannel()

// method will start fechting the xmlData
-(void)fetchAllItems;

// method will create a parser to start parsing the data and will set self as the delegate
-(void)parseXMLData;

// will release the allItems list
-(void)releaseAllItems;

@end



@implementation RNRFeedChannel
@synthesize channelTitle = channelTitle_,
            channelLink = channelLink_,
            channelDescription = channelDescription_,
            channelImageUrl = channelImageUrl_,
            channelURL = channelURL_,
            allItems = allItems_,
            delegate = delegate_,
isFirstFetch = isFirstFetch_;

#pragma mark initializers

// overriding default init
// default url channel will be Apple's rss feed url
-(id)init{
    return [self initWithChannelURL:@"http://www.apple.com/pr/feeds/pr.rss"];
}


// Designated initializer
-(id)initWithChannelURL: (NSString *)anURL{
    
    self = [super init];
    
    if (self) {
        
        [self setChannelURL:anURL];
        isCurrentlyOnChannel = YES;
        isFirstFetch_ = YES;
        allItems_ = [NSMutableArray array];
        
        //get all items on init
        [self fetchAllItems];
        
    }
    
    return self;
}

// Overriding delegate setter
-(void)setDelegate:(id<RNRFeedChanelDelegateProtocol>)aDelegate{
    if(delegate_ != aDelegate){
        delegate_ = aDelegate;
    }
}

#pragma mark private mehods

// this will empty the allItems array
-(void)releaseAllItems{
    allItems_ = [NSMutableArray array];
}

#pragma mark public methods

//this will be called to reload the feed list
-(void)reloadFeedList{
    [self releaseAllItems];
    [self fetchAllItems];
}

#pragma mark NSXMLParser related

// this will create and parse the xmlData received and set self as the parser delegate
-(void)parseXMLData{
    
    // creating parser object
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    
    //set the parser's delegate
    [parser setDelegate:self];
    
    //start parsing
    [parser parse];
    
    //release xmlData object
    xmlData = nil;
    
    //release connection
    connection = nil;
}

// NSXMLParser delegate method
// will be called when the parser starts reading an element
//
// will store the current tag name
// will init the mutable strings
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    //storing current element tag name
    currentTag = elementName;
    
    //getting image src attribute for channel only
    // image wont be provided on all feeds
    if ([elementName isEqual:@"img"] && isCurrentlyOnChannel) {
        [self setChannelImageUrl:[attributeDict objectForKey:@"src"]];
    }
    
    // intantiate strings only if the element is an Item
    // change isCurrentlyOnChannel to NO on everyItem
    // value is YES on init so we can get the channel title, image, link and description
    // the rest of the time this is executes, the strings will be used for the items only
    if([elementName isEqual:@"item"]){
        title = [[NSMutableString alloc] init];
        link = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc] init];
        isCurrentlyOnChannel = NO;
    }
}

// NSXMLParser delegate method
// will be called when the parser find characters
//
// will append the received string to title, description or link
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    if ([currentTag isEqual:@"title"]) {
        [title appendString:string];
    } else if([currentTag isEqual:@"description"]){
        [description appendString:string];
    } else if ([currentTag isEqual:@"link"]){
        [link appendString:string];
    }
}

// NSXMLParser delegate method
// will be called when the parser is reading a closing element
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    // This will be executed only for the channel information and will set the propertie values
    if (isCurrentlyOnChannel) {
        
        if ([elementName isEqual:@"title"]) {
            [self setChannelTitle:title];
        } else if([elementName isEqual:@"description"]){
            [self setChannelDescription:description];
        } else if ([elementName isEqual:@"link"]){
            [self setChannelLink:link];
        }

    }
    
    // this will be executed for each items
    if ([elementName isEqual:@"item"]) {
        
        //creating new item
        RNRItem *newItem = [[RNRItem alloc] initWithArticleTitle:title description:description link:[link stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        
        //adding item to allItems array
        [[self allItems] addObject:newItem];

    }
}

// NSXMLParser delegate method
// will be called when the parser is done reading a document
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    
    //releasing parser delegate reference to this object
    [parser setDelegate:nil];


    NSLog(@"%i", [[self allItems] count]);
    
    if ([delegate_ respondsToSelector:@selector(feedChanel:didCompleteFetchingItems:)]) {
        [delegate_ feedChanel:self didCompleteFetchingItems:[self allItems]];
    }
    
    isFirstFetch_ = NO;
}

#pragma mark NSURLConnection related

// Fetching all RSS items in xml form
-(void)fetchAllItems{
    
    //init mutable strings for channel element
    title = [[NSMutableString alloc] init];
    link = [[NSMutableString alloc] init];
    description = [[NSMutableString alloc] init];
    
    // creating data container
    xmlData = [NSMutableData data];
    
    // creating url object usin the channelURL string
    NSURL *url = [NSURL URLWithString:[self channelURL]];
    
    // putting the url in a request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    // create the data connection instance that request the data from the server
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}


// this will be called more than once as the data is received
// NSURLConnection data protocol method
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData{
    
    //adding the data tot he data object
    [xmlData appendData:theData];
}

// this will be called when all the data has arrived
// NSURLConnection data protocol method 
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    //parse the received data
    [self parseXMLData];
}

// method will be called if the connection fails for some reason
// NSURLConnection data protocol method
-(void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error{
    
    //release the connection object
    connection = nil;
    
    //release the xmlData object
    xmlData = nil;
    
    //store error message
    NSString *errorString = [NSString stringWithFormat:@"Fetch failed: %@", [error localizedDescription]];
    
    //display error on alertView
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}

//Overriding description method
-(NSString *)description{
    return [NSString stringWithFormat:@"title: %@ || link: %@ || description: %@ || image: %@", channelTitle_, channelLink_, channelDescription_, channelImageUrl_];
}

@end







