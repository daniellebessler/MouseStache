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
    self.navigationController.title = @"Choose a Mouse";
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
    } else {
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
    } else {
        item = self.mice.items[indexPath.row];
    }
    
    cell.textLabel.text = item.name;
    if (item.female){
        cell.imageView.image = [UIImage imageNamed:@"Female.png"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"Male.png"];
    }
    
    
    
    
    [self configureTextForCell:cell withMouseItem:item];
    
    if (![self.addedRelation isEqualToString:@"resident"]) {
    if ([self.addedRelation isEqualToString:@"dad"]) {
        if (item.female) {
            cell.userInteractionEnabled = NO;
            cell.textLabel.enabled = NO;
        }
    }
        if ([self.addedRelation isEqualToString:@"mom"]) {
            if (!item.female) {
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
    //  [self.mice setIndexOfSelectedMouse:indexPath.row];
    
    Mouse *item = self.mice.items[indexPath.row];
    [self.delegate AddRelationViewController:self didFinishChoosingItem:item];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancel {
    [self.delegate AddRelationViewControllerDidCancel:self];
}





#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredMice removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    self.filteredMice = [NSMutableArray arrayWithArray:[self.mice.items filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}





/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView co/Users/DanielleBessler/Documents/iOS/Checklists/Checklists/ChecklistViewController.mmmitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */


@end
