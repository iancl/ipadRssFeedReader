//
//  RNRItem.h
//  RSSNewsReader
//
//  Created by Ian Calderon on 6/24/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RNRItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *imageUrl;


//designated initializer
-(id)initWithArticleTitle: (NSString *)aTitle description: (NSString *)aDescription link: (NSString *)aLink;

@end
