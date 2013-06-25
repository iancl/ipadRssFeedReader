//
//  RNRNavigationController.m
//  RSSNewsReader
//
//  Created by Ian Calderon on 6/24/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import "RNRNavigationController.h"
#import "RNRHomeViewController.h"


@interface RNRNavigationController ()

@end

@implementation RNRNavigationController

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
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    
    
    homeView = [[RNRHomeViewController alloc] init];
    [self pushViewController:homeView animated:YES];
    
    
}

@end
