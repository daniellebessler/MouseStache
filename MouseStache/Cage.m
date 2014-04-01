//
//  Cage.m
//  MouseStache
//
//  Created by Danielle Bessler on 3/22/14.
//  Copyright (c) 2014 Danielle Bessler. All rights reserved.
//

#import "Cage.h"
#import "Mouse.h"
#import "AllMice.h"

@implementation Cage

-(id)init
{
    if (self = [super init]){
        
    }
    return self;
}
- (id) initWithID:(NSString * )id
{
    if (self = [super init]){
        
        self.cageID = id;
        
    }
    
    return self;
}
- (id) initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init])) {
                self.cageID = [aDecoder decodeObjectForKey:@"CageID"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
        [aCoder encodeObject:self.cageID forKey:@"CageID"];
}





@end
