//
//  AddRelationViewController.h
//  MouseStache
//
//  Created by Danielle Bessler on 3/5/14.
//  Copyright (c) 2014 Danielle Bessler. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Mouse.h"

@class AllMice;
@class AddRelationViewController;

@protocol AddRelationViewControllerDelegate <NSObject>

- (void)AddRelationViewControllerDidCancel:(AddRelationViewController *)controller;

- (void)AddRelationViewController:(AddRelationViewController *) controller didFinishChoosingItem:(Mouse *)item;

@end


@interface AddRelationViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *miceSearch;
@property (strong, nonatomic) NSMutableArray *filteredMice;
@property (nonatomic, strong) AllMice *mice;
@property (nonatomic, weak) id <AddRelationViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *addedRelation;

- (IBAction)cancel;

@end
