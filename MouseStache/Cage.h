//
//  Cage.h
//  MouseStache
//
//  Created by Danielle Bessler on 3/22/14.
//  Copyright (c) 2014 Danielle Bessler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Mouse;


@interface Cage : NSObject

-(id) initWithID:(NSString *) id;

@property (nonatomic, strong) NSString *cageID;





@end
