//
//  AddRelationViewController.m
//  MouseStache
//
//  Created by Danielle Bessler on 3/5/14.
//  Copyright (c) 2014 Danielle Bessler. All rights reserved.
//

#import "AddRelationViewController.h"
#import "AddMouseViewController.h"
#import "AllMice.h"
#import "Mouse.h"


@interface AddRelationViewController ()

@end

@implementation AddRelationViewController

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
    self.title = @"Select a Mouse";
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.filteredMice = [NSMutableArray arrayWithCapacity:[self.mice.items count]];
    
    
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filteredMice count];
    }else{
        return [self.mice.items count];
    }
    
}

- (void) configureTextForCell:(UITableViewCell *) cell withMouseItem:(Mouse *) item
{
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = item.name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MouseItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Mouse *item;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        item = self.filteredMice[indexPath.row];
    }else{
        item = self.mice.items[indexPath.row];
    }
    
    cell.textLabel.text = item.name;
    if (item.female){
        cell.imageView.image = [UIImage imageNamed:@"Female.png"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"Male.png"];
    }
    
    cell.userInteractionEnabled = YES;
    cell.textLabel.enabled = YES;
    
    [self configureTextForCell:cell withMouseItem:item];
    
    if (![self.addedRelation isEqualToString:@"resident"]) {
        if ([self.addedRelation isEqualToString:@"dad"]) {
            if (item.female){
            cell.userInteractionEnabled = NO;
            cell.textLabel.enabled = NO;
            }
        }
        
        if ([self.addedRelation isEqualToString:@"mom"]) {
            if (!item.female){
                cell.userInteractionEnabled = NO;
                cell.textLabel.enabled = NO;
            }
        }
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Mouse *item = self.mice.items[indexPath.row];
    [self.delegate AddRelationViewController:self didFinishChoosingItem:item];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancel {
    [self.delegate AddRelationViewControllerDidCancel:self];
}


#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    
    [self.filteredMice removeAllObjects];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    self.filteredMice = [NSMutableArray arrayWithArray:[self.mice.items filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
  
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    return YES;
}



@end
