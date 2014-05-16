//
//  MiceViewController.h
//  MouseStache
//
//  Created by Danielle Bessler on 2/9/14.
//  Copyright (c) 2014 Danielle Bessler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddMouseViewController.h"


@class AllMice;


@interface MiceViewController : UITableViewController <AddMouseViewControllerDelegate, UINavigationControllerDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *miceSearch;
@property (strong, nonatomic) NSMutableArray *filteredMice;
@property (nonatomic, strong) AllMice *mice;


@end
