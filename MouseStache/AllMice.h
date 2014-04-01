//
//  AllMice.h
//  MouseStache
//
//  Created by Danielle Bessler on 2/9/14.
//  Copyright (c) 2014 Danielle Bessler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllMice : NSObject

@property (nonatomic, strong) NSMutableArray *items;

- (void)saveMice;
- (void)sortMice;

@end
