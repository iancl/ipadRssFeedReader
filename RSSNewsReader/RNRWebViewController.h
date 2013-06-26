//
//  RNRWebViewController.h
//  RSSNewsReader
//
//  Created by Ian Calderon on 6/25/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RNRItem;

@interface RNRWebViewController : UIViewController{
    
    __weak IBOutlet UIWebView *webView;
}

@property (nonatomic, strong) RNRItem *item;

@end
