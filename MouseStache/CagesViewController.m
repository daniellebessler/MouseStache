//
//  CagesViewController.m
//  MouseStache
//
//  Created by Danielle Bessler on 3/27/14.
//  Copyright (c) 2014 Danielle Bessler. All rights reserved.
//

#import "CagesViewController.h"
#import "AllMice.h"
#import "Mouse.h"
#import "Cage.h"
#import "ShowCageViewController.h"

@interface CagesViewController ()

@end


@implementation CagesViewController
{
    NSMutableArray *cages;
    NSString *_ID;
    Boolean addMode;
    UITextField *textField;
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    cages = [[NSMutableArray alloc] initWithCapacity:[self.mice.items count]];
    _ID = @"";

}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    int i = 0;
    
    Boolean found = NO;
    Mouse *mouse;
    
    while (i < [self.mice.items count]){
        mouse = self.mice.items[i];
        int j = 0;
        while (!found && j<[cages count]){
            
            if (mouse.cage == cages[j]){
                found = YES;
            }
            
            j++;
        }
        if (!found && mouse.cage.cageID != nil){
            [cages addObject:mouse.cage];
        }
        found = NO;
        
        i++;
        
        }
    
    addMode = NO;
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cages count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell;
    
    if ([cages count]==indexPath.row){
        UITableViewCell *addCageCell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddCage"];
        addCageCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!addMode){
            UILabel *label = [[UILabel alloc] init];
            [addCageCell addSubview:label];
            
            [label setFrame:CGRectMake(0, 40, tableView.bounds.size.width, 20)];
            [label setFont:[UIFont boldSystemFontOfSize:20]];
            label.text = @"Touch and hold to add a cage";
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor colorWithRed:101.0/255.0 green:44.0/255.0 blue:144.0/255.0 alpha:1.0];	UILongPressGestureRecognizer *longPressGesture =[[UILongPressGestureRecognizer alloc]
                                                          initWithTarget:self action:@selector(longPress:)];
            longPressGesture.minimumPressDuration = .5;
            [self.tableView addGestureRecognizer:longPressGesture];
            cell=addCageCell;
        }else{
            textField = [[UITextField alloc] init];
            [addCageCell addSubview:textField];
            [textField setFrame:CGRectMake(20, 40, 200, 20)];
            textField.placeholder = @"Enter Cage ID here";
            textField.adjustsFontSizeToFitWidth = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
            [self.tableView addGestureRecognizer:tapGesture];
            tapGesture.cancelsTouchesInView = NO;
        
        
            UIButton *add = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [add setFrame:CGRectMake(600, 40, 200, 20)];
            [add setTitle:@"Add Cage" forState:UIControlStateNormal];
            [add.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
            add.titleLabel.adjustsFontSizeToFitWidth=YES;
            [add setTitleColor:[UIColor colorWithRed:101.0/255.0 green:44.0/255.0 blue:144.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [addCageCell addSubview:add];
            add.tag = 30;
            add.userInteractionEnabled = NO;
            textField.delegate = self;
            textField.userInteractionEnabled=YES;
            [textField becomeFirstResponder];
            [add addTarget:self action:@selector(addButtonHit:)forControlEvents:UIControlEventTouchUpInside];
            cell=addCageCell;
            
        }
    }else {
        static NSString *CellIdentifier = @"CageItem";
        
        UITableViewCell *CageCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (CageCell == nil) {
            CageCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        Cage *cage;
        cage = cages[indexPath.row];
        CageCell.textLabel.text = cage.cageID;
        CageCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell = CageCell;
    }
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (void) hideKeyboard {
    [self.view endEditing:NO];
    addMode=NO;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[cages count] inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:NO];
}

-(void)addButtonHit:(id)sender
{
    Cage *cage = [[Cage alloc] initWithID:_ID];
    [cages addObject:cage];
    _ID = @"";
    [self.tableView reloadData];
    addMode = NO;
}

-(void)longPress:(UILongPressGestureRecognizer *)sender
{
    if (sender.state != UIGestureRecognizerStateEnded)
        return;
    CGPoint location = [sender locationInView:self.view];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    if (indexPath.row == [cages count]){
        addMode = YES;
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:YES];
    }
    
}


-(BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange) range
replacementString:(NSString *)string
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[cages count] inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UIButton *addCage = (UIButton *)[cell viewWithTag:30];
    _ID = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    addCage.userInteractionEnabled = ([_ID length]>0);
    
    
    return YES;
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cages count]!= indexPath.row){
        return indexPath;
    }else{
        return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cages count]!= indexPath.row){
        //UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        //cell.userInteractionEnabled = YES;
        Cage *cage = cages[indexPath.row];
        [self performSegueWithIdentifier:@"ShowCage" sender:cage];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowCage"]){
        ShowCageViewController *controller = segue.destinationViewController;
        controller.cage = sender;
        controller.allMice = self.mice;
    }
}



@end
