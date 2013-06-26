//
//  RNRWebViewController.m
//  RSSNewsReader
//
//  Created by Ian Calderon on 6/25/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import "RNRWebViewController.h"
#import "RNRItem.h"

@interface RNRWebViewController ()

@end

@implementation RNRWebViewController
@synthesize item = item_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //set navigation item title
    [[self navigationItem] setTitle:[[self item] title]];
    
    NSString *fullURL = [[self item] link];
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView setScalesPageToFit:YES];
    [webView loadRequest:requestObj];

    
    
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"%@", [error localizedDescription]);
}



@end
