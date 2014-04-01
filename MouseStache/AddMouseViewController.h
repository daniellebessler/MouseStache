//
//  AddMouseViewController.h
//  MouseStache
//
//  Created by Danielle Bessler on 2/13/14.
//  Copyright (c) 2014 Danielle Bessler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddRelationViewController.h"

@class AddMouseViewController;
@class Mouse;


@protocol AddMouseViewControllerDelegate <NSObject>

- (void)AddMouseViewControllerDidCancel: (AddMouseViewController *)controller;

- (void)AddMouseViewController:(AddMouseViewController *) controller didFinishAddingItem:(Mouse *)item;

- (void)AddMouseViewController:(AddMouseViewController *)controller didFinishEditingItem:(Mouse *)item;

@end
#import "AddRelationViewController.h"


@interface AddMouseViewController : UITableViewController <AddRelationViewControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *seg;

@property (nonatomic, weak) id <AddMouseViewControllerDelegate> delegate;

@property (nonatomic, strong) Mouse *mouse;

@property (nonatomic, strong) AllMice *mice;
@property (nonatomic, strong) NSString *tempName;
@property (nonatomic) Boolean editMouse;




- (IBAction) cancel;
- (IBAction) done;
- (IBAction)addGene:(id)sender;


- (IBAction)sexChange:(id)sender;



@end
