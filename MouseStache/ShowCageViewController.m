//
//  ShowCageViewController.m
//  MouseStache
//
//  Created by Danielle Bessler on 3/22/14.
//  Copyright (c) 2014 Danielle Bessler. All rights reserved.
//

#import "ShowCageViewController.h"
#import "AllMice.h"
#import "Mouse.h"
#import "Cage.h"

@interface ShowCageViewController ()

@end

@implementation ShowCageViewController
{
    //int _miceNum;
    NSMutableArray *_myMice;
    
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getMiceInCage];
    self.title=self.cage.cageID;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getMiceInCage
{
    
    _myMice = [[NSMutableArray alloc] init];
    //_miceNum = 0;
    
    int i=0;
    
    
    while (i<[self.allMice.items count])
    {
        Mouse *mouse = self.allMice.items[i];
        
        if (self.cage == mouse.cage) {
            [_myMice addObject:mouse];
            //_miceNum ++;
        }
        
        i++;
    }

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return _miceNum;
    return [_myMice count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CageCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CageCell"];
    }
    Mouse *mouse = _myMice[indexPath.row];
    cell.textLabel.text = mouse.name;
    if (mouse.female){
        cell.imageView.image = [UIImage imageNamed:@"Female.png"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"Male.png"];
    }

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"AddResident"]) {
    
        
        AddRelationViewController *controller = (AddRelationViewController *) segue.destinationViewController;
       
        controller.delegate = self;
        controller.mice = self.allMice;
        controller.addedRelation = @"resident";
        
        
    }
}

    
- (void)AddRelationViewControllerDidCancel:(AddRelationViewController *)controller
{
         [self dismissViewControllerAnimated:YES completion:nil];
}
    
- (void)AddRelationViewController:(AddRelationViewController *) controller didFinishChoosingItem:(Mouse *)item
{
    
    item.cage = self.cage;
    [_myMice addObject:item];
    
    [self.tableView reloadData];
    
}

@end
