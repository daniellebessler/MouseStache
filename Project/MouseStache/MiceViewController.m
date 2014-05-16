//
//  MiceViewController.m
//  MouseStache
//
//  Created by Danielle Bessler on 2/9/14.
//  Copyright (c) 2014 Danielle Bessler. All rights reserved.
//

#import "MiceViewController.h"
#import "AllMice.h"
#import "Mouse.h"
#import "ShowMouseViewController.h"
#import "Cage.h"




@interface MiceViewController ()

@end

@implementation MiceViewController



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
    self.navigationController.delegate = self;
    
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
    
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    Mouse *mouse = self.mice.items[indexPath.row];
    
    [self performSegueWithIdentifier:@"EditMouse" sender:mouse];
}

- (void)AddMouseViewControllerDidCancel:(AddMouseViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)AddMouseViewController:(AddMouseViewController *) controller didFinishAddingItem:(Mouse *)item
{
    item.cage = [[Cage alloc] init];
    [self.mice.items addObject:item];
    [self.mice sortMice];
    [self.tableView reloadData];
    [self.mice saveMice];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)AddMouseViewController:(AddMouseViewController *)controller didFinishEditingItem:(Mouse *)item
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Mouse *mouse = self.mice.items[indexPath.row];
    [self performSegueWithIdentifier:@"ShowMouse" sender:mouse];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddMouse"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        AddMouseViewController *controller = (AddMouseViewController *) navigationController.topViewController;
        controller.delegate = self;
        controller.mice = self.mice;
        
    }else if([segue.identifier isEqualToString:@"ShowMouse"]) {
    
        ShowMouseViewController *controller = (ShowMouseViewController *) segue.destinationViewController;
        controller.mouse = sender;
        
    }else if ([segue.identifier isEqualToString:@"EditMouse"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        AddMouseViewController *controller = (AddMouseViewController *) navigationController.topViewController;
        controller.delegate = self;
        controller.mouse = sender;
        controller.editMouse = YES;
        controller.mice = self.mice;
        
    }
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
