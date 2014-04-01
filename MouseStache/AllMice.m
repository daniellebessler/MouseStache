//
//  AllMice.m
//  MouseStache
//
//  Created by Danielle Bessler on 2/9/14.
//  Copyright (c) 2014 Danielle Bessler. All rights reserved.
//

#import "AllMice.h"
#import "Mouse.h"

@implementation AllMice

- (id) init
{
    if ((self = [super init])) {

        
        [self loadMice];
        
    }
    return self;
}

- (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return documentsDirectory;
}
- (NSString *)dataFilePath {
    return [[self documentsDirectory] stringByAppendingPathComponent:@"MouseStache.plist"];
}
- (void)saveMice {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.items forKey:@"MouseStache"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

- (void)loadMice {
    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path]; NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
                                                                                                      initForReadingWithData:data];
        self.items = [unarchiver decodeObjectForKey:@"MouseStache"];
        [unarchiver finishDecoding];
    } else {
            self.items = [[NSMutableArray alloc] initWithCapacity:20]; }
}

-(void)sortMice
{
    [self.items sortUsingSelector:@selector(compare:)];
}



@end
