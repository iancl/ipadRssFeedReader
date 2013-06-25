//
//  RNRHomeViewController.m
//  RSSNewsReader
//
//  Created by Ian Calderon on 6/24/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import "RNRHomeViewController.h"
#import "RNRFeedViewController.h"

@interface RNRHomeViewController ()

//  this will extract all url strings from the feeds plist and create a new feed using each of them
-(void)parseFeedsPlist;

//  this will calculate the position for each channel view
-(CGRect)positionFeedChanelViewWithFrame: (CGRect)aFrame positionIndex: (int)anIndex;

@end


//  CONSTANTS

// each channel view separation
#define CHANNEL_SEPARATION 5.0


@implementation RNRHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        allFeeds = [NSMutableArray array];
        totalChannelHeight = 0.0;
        
        // parsing feeds.plist
        [self parseFeedsPlist];
        
    }
    return self;
}


//  this will extract all url strings from the feeds plist and create a new feed using each of them
-(void)parseFeedsPlist{
    
    //  loading and parsing plist
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"feeds" ofType:@"plist"];
    NSArray *feedUrls = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    
    
    //  loop through each feedUrl and create a channel view controller with using each url string
    for (int i = 0; i < [feedUrls count]; i++) {
        
        //  storing current url string
        NSString *feedUrl = [feedUrls objectAtIndex:i];
        
        //  creating new channel controller instance
        RNRChanelViewController *newFeed = [[RNRChanelViewController alloc] initWithFeedUrl:feedUrl];
        
        //  calculating position for each channel view controller
        CGRect feedFrame = [newFeed.view frame];
        CGRect newFrame = [self positionFeedChanelViewWithFrame:feedFrame positionIndex:i];
        [newFeed.view setFrame:newFrame];
        
        //setting channel delegate
        [newFeed setDelegate:self];
        
        //  adding channel controller reference to allFeeds
        [allFeeds addObject:newFeed];
        
        //  incrementing this var so we can know what will be the height of the contents uiScrollView
        totalChannelHeight += newFeed.view.frame.size.height;
    }
    
    // adding the separation height for each channel view
    totalChannelHeight += ( [feedUrls count] - 1) * CHANNEL_SEPARATION ;
}


//  this will calculate the position for each channel view
-(CGRect)positionFeedChanelViewWithFrame: (CGRect)aFrame positionIndex: (int)anIndex{
    
    // calculating channel view frame position
    float height = aFrame.size.height;
    CGRect newFrame = aFrame;
    
    // taking adding CHANNEL_SEPARATION distance to formula
    newFrame.origin.y = (height + CHANNEL_SEPARATION) * anIndex;
    
    return newFrame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // setting nav bar title
    [[self navigationItem] setTitle:@"ALL FEEDS"];
    
    // instantiating and adding scroll view to self view
    scrollView = [[UIScrollView alloc] initWithFrame:[self.view frame]];
    [scrollView setShowsVerticalScrollIndicator:YES];
    [self.view addSubview:scrollView];
    
    // adding each feed to the scrollView
    for (int i=0; i < [allFeeds count]; i++) {
        RNRChanelViewController *chan = [allFeeds objectAtIndex:i];
        [scrollView addSubview:chan.view];
    }
    
    // adding navigationController Bar height to all height formula
    totalChannelHeight += [[[self navigationController] navigationBar] frame].size.height;
    
    
    //setting scrollView content size
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, totalChannelHeight)];
    
}


#pragma mark RNRChannelViewDelegateProtocol methods

-(void) channelView:(RNRChanelViewController *)aChannelView shouldShowFeedWithFeedChanel:(RNRFeedChannel *)feedChanel{
    
    RNRFeedViewController *fv = [[RNRFeedViewController alloc] init];
    [fv setChannel:feedChanel];
    [self.navigationController pushViewController:fv animated:YES];
}

@end
