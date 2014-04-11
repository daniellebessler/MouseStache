//
//  ShowCageViewController.h
//  MouseStache
//
//  Created by Danielle Bessler on 3/22/14.
//  Copyright (c) 2014 Danielle Bessler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddRelationViewController.h"

@class Cage;
@class AllMice;

@interface ShowCageViewController : UITableViewController <AddRelationViewControllerDelegate>

@property (nonatomic, strong) Cage *cage;

@property (nonatomic, strong) AllMice *allMice;



@end
