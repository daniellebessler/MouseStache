//
//  Mouse.h
//  MouseStache
//
//  Created by Danielle Bessler on 2/9/14.
//  Copyright (c) 2014 Danielle Bessler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Cage;

@interface Mouse : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSDate *dateOfBirth;

- (id) initWithName:(NSString *)name;


@property (nonatomic, strong) NSMutableArray *genes;

@property (nonatomic, strong) NSMutableArray *mates;

@property (nonatomic, strong) Mouse *parentMale;

@property (nonatomic, strong) Mouse *parentFemale;

@property (nonatomic, strong) NSMutableArray *children;

@property (nonatomic) Boolean female;

@property (nonatomic, strong) Cage *cage;

@end
