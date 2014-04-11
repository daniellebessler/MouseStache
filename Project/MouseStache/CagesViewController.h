//
//  CagesViewController.h
//  MouseStache
//
//  Created by Danielle Bessler on 3/27/14.
//  Copyright (c) 2014 Danielle Bessler. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AddCageViewController.h"

@class AllMice;

//AddCageViewControllerDelegate, UISearchBarDelegate, UISearchDisplayDelegate>


@interface CagesViewController : UITableViewController <UINavigationControllerDelegate, UITextFieldDelegate>

//@property (weak, nonatomic) IBOutlet UISearchBar *cageSearch;
//@property (strong, nonatomic) NSMutableArray *filteredCages;
@property (nonatomic, strong) AllMice *mice;


@end
