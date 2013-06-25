//
//  RNRChanelViewController.h
//  RSSNewsReader
//
//  Created by Ian Calderon on 6/24/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RNRFeedChannel.h"

@class RNRWebViewController, RNRChanelViewController;

@protocol RNRChanelViewControllerDelegateProtocol <NSObject>

@optional
-(void)channelView: (RNRChanelViewController *)aChannelView shouldShowFeedWithFeedChanel: (RNRFeedChannel *)feedChanel;

@end

@interface RNRChanelViewController : UIViewController<RNRFeedChanelDelegateProtocol>{
    
    RNRFeedChannel *channel;
    
    __weak IBOutlet UIActivityIndicatorView *spinner;
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UITextView *descriptionTextView;
    __weak IBOutlet UILabel *linkLabel;
    IBOutlet UIImageView *imageView;
    
    RNRWebViewController *webView;
}

@property (nonatomic, weak) id<RNRChanelViewControllerDelegateProtocol> delegate;

//desinated initalizer
-(id)initWithFeedUrl: (NSString *)anUrl;

-(IBAction)buttonPressed:(id)sender;


@end
