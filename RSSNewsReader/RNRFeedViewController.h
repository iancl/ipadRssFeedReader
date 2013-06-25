//
//  RNRFeedViewController.h
//  RSSNewsReader
//
//  Created by Ian Calderon on 6/25/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RNRFeedChannel;

@interface RNRFeedViewController : UITableViewController

@property (nonatomic, strong) RNRFeedChannel *channel;

@end
