//
//  RNRItem.m
//  RSSNewsReader
//
//  Created by Ian Calderon on 6/24/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import "RNRItem.h"

@implementation RNRItem
@synthesize title = title_,
                    description = description_,
                    link = link_;


// overriding default init
-(id)init{
    return [self initWithArticleTitle:@"RSS title" description:@"RSS Desc" link:@"RSS Link"];
}

// Designated Initializer
-(id)initWithArticleTitle: (NSString *)aTitle description: (NSString *)aDescription link: (NSString *)aLink{
    
    self = [super init];
    
    if(self){
        
        // setting default values
        [self setTitle:aTitle];
        [self setDescription:aDescription];
        [self setLink:aLink];
        
    }
    
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"title: %@ || desc: %@ || link: %@",title_, description_, link_];
}

-(void)dealloc{
    
    NSLog(@"destroying item: %@", title_);
    
}

@end
