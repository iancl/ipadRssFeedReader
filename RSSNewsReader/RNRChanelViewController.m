//
//  RNRChanelViewController.m
//  RSSNewsReader
//
//  Created by Ian Calderon on 6/24/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import "RNRChanelViewController.h"
#import "RNRWebViewController.h"

@interface RNRChanelViewController ()

// this will add the text, images, etc to each outlet on the view
-(void)setDataToAllOutlets;

@end

@implementation RNRChanelViewController
@synthesize delegate = delegate_;

//designated initializer
-(id)initWithFeedUrl: (NSString *)anUrl{
    self = [super init];
    
    if (self) {
        
        // instantiating channel controller and setting delegate
        channel = [[RNRFeedChannel alloc] initWithChannelURL:anUrl];
        [channel setDelegate:self];
    }
    
    return self;
}

//overriding delegate setter
-(void)setDelegate:(id<RNRChanelViewControllerDelegateProtocol>)aDelegate{
    if(delegate_ != aDelegate){
        delegate_ = aDelegate;
    }
}

// this will add the text, images, etc to each outlet on the view
-(void)setDataToAllOutlets{
    
    // set image if it the url for the image is available
    if ([channel channelImageUrl]) {
        
        //fetching image from web and storing it
        NSString *imageUrl = [NSString stringWithFormat:@"%@%@",[channel channelLink],[channel channelImageUrl]];
        NSURL *url = [NSURL URLWithString:imageUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        
        //set image if it was successfully fetched
        if (img) [imageView setImage:img];
    }
    
    //set other text outlets text
    [titleLabel setText:[channel channelTitle]];
    [descriptionTextView setText:[channel channelDescription]];
    [linkLabel setText:[channel channelLink]];
}


-(IBAction)buttonPressed:(id)sender{
    if ([delegate_ respondsToSelector:@selector(channelView:shouldShowFeedWithFeedChanel:)]) {
        [delegate_ channelView:self shouldShowFeedWithFeedChanel:channel];
    }
}

#pragma mark RNRFeedChannelDelegateProtocol

//  this will be invoked when the chanel has completed fetching the rss data
-(void)feedChanel:(RNRFeedChannel *)theFeedChanel didCompleteFetchingItems:(NSArray *)allItems{
    
    [self setDataToAllOutlets];
    [spinner stopAnimating];
}
@end
