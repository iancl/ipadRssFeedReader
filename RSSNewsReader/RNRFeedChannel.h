//
//  RNRFeedChannel.h
//  RSSNewsReader
//
//  Created by Ian Calderon on 6/24/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import <Foundation/Foundation.h>



@class RNRItem, RNRFeedChannel;


@protocol RNRFeedChanelDelegateProtocol <NSObject>

@optional
-(void)feedChanel: (RNRFeedChannel *)theFeedChanel didCompleteFetchingItems: (NSArray *)allItems;

@end

@interface RNRFeedChannel : NSObject <NSURLConnectionDataDelegate, NSXMLParserDelegate>{
    NSURLConnection *connection;
    NSMutableData *xmlData;
    
    //private
    NSMutableString *title;
    NSMutableString *link;
    NSMutableString *description;
    
    BOOL isCurrentlyOnChannel;
    
    //to store the current element name
    NSString *currentTag;
}


//this will be fetched from the xml
@property (nonatomic, copy) NSString *channelTitle;
@property (nonatomic, copy) NSString *channelImageUrl;
@property (nonatomic, copy) NSString *channelLink;
@property (nonatomic, copy) NSString *channelDescription;
@property (nonatomic, readonly) BOOL isFirstFetch;

//this will be provided when creating a new instance
@property (nonatomic, copy) NSString *channelURL;

//this will hold all the RNRItems
@property (nonatomic, readonly, strong) NSMutableArray *allItems;

//delegate
@property (nonatomic, weak) id<RNRFeedChanelDelegateProtocol> delegate;

// Designated initializer
-(id)initWithChannelURL: (NSString *)anURL;

// will remove and then repopulate the item list
-(void)reloadFeedList;


@end
