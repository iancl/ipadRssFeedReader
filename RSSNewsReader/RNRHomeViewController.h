//
//  RNRHomeViewController.h
//  RSSNewsReader
//
//  Created by Ian Calderon on 6/24/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNRChanelViewController.h"

@interface RNRHomeViewController : UIViewController<RNRChanelViewControllerDelegateProtocol>{
    
    //array will hold references to all loaded feeds
    NSMutableArray *allFeeds;
    
    UIScrollView *scrollView;
    
    //  this will hold the total height of the channels and separations
    //  so we can set the scrollView content size later
    float totalChannelHeight;
    
}

@end
