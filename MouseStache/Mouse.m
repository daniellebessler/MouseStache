//
//  Mouse.m
//  MouseStache
//
//  Created by Danielle Bessler on 2/9/14.
//  Copyright (c) 2014 Danielle Bessler. All rights reserved.
//

#import "Mouse.h"
#import "Cage.h"

@implementation Mouse



- (id) init
{
    if (self = [super init]){
        
        self.children = [[NSMutableArray alloc] initWithCapacity:10];
        self.mates = [[NSMutableArray alloc] initWithCapacity:10];
        self.genes = [[NSMutableArray alloc] initWithCapacity:10];
        self.female = YES;
        
    }
    
    
    
    return self;
}
- (id) initWithName:(NSString *)name
{
    if (self = [super init]){
        
        self.name = name;
        self.children = [[NSMutableArray alloc] initWithCapacity:10];
        self.mates = [[NSMutableArray alloc] initWithCapacity:10];
        self.female = YES;
        
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init])) {
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.female = [aDecoder decodeBoolForKey:@"Sex"];
        self.parentFemale = [aDecoder decodeObjectForKey:@"parentFemale"];
        self.parentMale = [aDecoder decodeObjectForKey:@"parentMale"];
        self.children = [aDecoder decodeObjectForKey:@"Children"];
        self.mates = [aDecoder decodeObjectForKey:@"Mates"];
        self.genes = [aDecoder decodeObjectForKey:@"Genes"];
        self.cage = [aDecoder decodeObjectForKey:@"Cage"];
        self.dateOfBirth = [aDecoder decodeObjectForKey:@"DOB"];
        
            }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeBool:self.female forKey:@"Sex"];
    [aCoder encodeObject:self.parentFemale forKey:@"parentFemale"];
    [aCoder encodeObject:self.parentMale forKey:@"parentMale"];
    [aCoder encodeObject:self.children forKey:@"Children"];
    [aCoder encodeObject:self.mates forKey:@"Mates"];
    [aCoder encodeObject:self.genes forKey:@"Genes"];
    [aCoder encodeObject:self.cage forKey:@"Cage"];
    [aCoder encodeObject:self.dateOfBirth forKey:@"DOB"];
    }


-(NSComparisonResult)compare:(Mouse *)otherMouse
{
    return [self.name localizedStandardCompare:otherMouse.name];
}



@end
