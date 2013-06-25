//
//  RNRFeedViewController.m
//  RSSNewsReader
//
//  Created by Ian Calderon on 6/25/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import "RNRFeedViewController.h"
#import "RNRFeedChannel.h"
#import "RNRItem.h"

@interface RNRFeedViewController ()

@end

@implementation RNRFeedViewController
@synthesize channel = channel_;

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [[self navigationItem] setTitle:[[self channel] channelTitle]];
}

#pragma mark UITableViewDataSource protocol methods

//  returns a new cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    RNRItem *item = [[[self channel] allItems] objectAtIndex:[indexPath row]];
    
    
    [[cell textLabel] setText:[item title]];
    
    return cell;
}

//  defines number of rows in table
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.channel.allItems count];
}



@end
