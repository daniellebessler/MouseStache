//
//  ShowMouseViewController.m
//  MouseStache
//
//  Created by Danielle Bessler on 2/20/14.
//  Copyright (c) 2014 Danielle Bessler. All rights reserved.
//

#import "ShowMouseViewController.h"
#import "Mouse.h"
#import "Cage.h"

@interface ShowMouseViewController ()

@end

@implementation ShowMouseViewController

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
    self.title = self.mouse.name;
    
    
    
    UIView *footerContainer = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 150, 50)];
    UIButton *btnFooter = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnFooter setTitle:@"View All Mice" forState:UIControlStateNormal];
    [btnFooter.titleLabel setFont:[UIFont boldSystemFontOfSize:22]];
    [btnFooter setFrame:CGRectMake(10, 10, 150, 50)];
    [btnFooter setTitleColor:[UIColor colorWithRed:101.0/255.0 green:44.0/255.0 blue:144.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [footerContainer addSubview:btnFooter];
    self.tableView.tableFooterView = footerContainer;
    [btnFooter addTarget:self action:@selector(allMiceButtonHit:)forControlEvents:UIControlEventTouchUpInside];
    [self.tableView reloadData];
}

-(void)allMiceButtonHit:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
  //  return 2;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
   // return 0;
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSString *)tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title;
    if(section==1) {
        title = [NSString stringWithFormat:@"Parents of %@", self.mouse.name];
    }else if(section==2){
       title = [NSString stringWithFormat:@"Children of %@", self.mouse.name];
    }else if(section==3){
        title = [NSString stringWithFormat:@"Genes of %@", self.mouse.name];
    }
    return title;
}

- (NSInteger) tableView: (UITableView*) tableView numberOfRowsInSection: (NSInteger) section
{
    
    if (section==0){
        return 1;
    }else if(section==1){
       return 2;
    }else if(section==2){
        if ([self.mouse.children count] != 0) {
            return [self.mouse.children count];
        }
        else {
            return 1;
        }
    }else{
        if ([self.mouse.genes count] != 0) {
            return [self.mouse.genes count];
        }
        else {
            return 1;
        }
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if(indexPath.section==0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"SexCell"];
        UILabel *sexLabel = (UILabel *)[cell viewWithTag:2001];
        UILabel *dobLabel = (UILabel *)[cell viewWithTag:2002];
        UILabel *cageLabel = (UILabel *)[cell viewWithTag:2003];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateStyle = NSDateFormatterMediumStyle;

       // NSDate *birthDate = [[NSDate alloc]init];
       // birthDate = self.mouse.dateOfBirth;
        

       
        dobLabel.text = [NSString stringWithFormat:@"Date Of Birth: %@", [df stringFromDate:self.mouse.dateOfBirth]];
        if (self.mouse.cage.cageID==nil){
        cageLabel.text = @"No Cage";
        }else{
        cageLabel.text = [NSString stringWithFormat:@"Cage ID: %@", self.mouse.cage.cageID];
        }
        if (self.mouse.female) {
            sexLabel.text = @"Sex: Female";
        }
        else {
            sexLabel.text = @"Sex: Male";
        }
    }
    
    else if(indexPath.section==1) {
        if(indexPath.row ==0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"ParentCell"];
        
       Mouse *item = self.mouse.parentFemale;
        UILabel *label = (UILabel *)[cell viewWithTag:2000];
            
            if (self.mouse.parentFemale == nil){
                
                label.text = @"None";
                cell.userInteractionEnabled = NO;
                cell.accessoryType = NO;
            }else{
                label.text = item.name;
            }

        
            UILabel *femaleLabel = (UILabel *)[cell viewWithTag:10];
            femaleLabel.text = @"Mother";
            
            
        }
        if(indexPath.row==1) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"ParentCell"];
            Mouse *item = self.mouse.parentMale;
            UILabel *label = (UILabel *)[cell viewWithTag:2000];
            
            if (self.mouse.parentMale == nil){
                
                label.text = @"None";
                cell.userInteractionEnabled = NO;
                cell.accessoryType = NO;
            }else{
        
            
            label.text = item.name;
            }
            
            
            
            UILabel *maleLabel = (UILabel *)[cell viewWithTag:10];
            maleLabel.text = @"Father";

            
        }
        
        
    }else if (indexPath.section==2){
        if ([self.mouse.children count] != 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"ChildCell"];
            
            Mouse *item = self.mouse.children[indexPath.row];
            
            UILabel *label = (UILabel *)[cell viewWithTag:1001];
            label.text = item.name;
        }else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"ChildCell"];
            UILabel *label = (UILabel *)[cell viewWithTag:1001];
            label.text = @"None";
            cell.userInteractionEnabled=NO;
            cell.accessoryType = NO;
        }
        
    }else{
        if ([self.mouse.genes count] != 0) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"GeneCell"];
            
            NSString *gene = self.mouse.genes[indexPath.row];
            
            UILabel *label = (UILabel *)[cell viewWithTag:1010];
            label.text = gene;
            cell.userInteractionEnabled=NO;
            cell.accessoryType = NO;
        }else {
            cell = [tableView dequeueReusableCellWithIdentifier:@"GeneCell"];
            UILabel *label = (UILabel *)[cell viewWithTag:1010];
            label.text = @"None";
            cell.userInteractionEnabled=NO;
            cell.accessoryType = NO;
        }

    }

    
   return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    Mouse *mouse;
    if (indexPath.section==1){
        if (indexPath.row==0) {
            mouse = self.mouse.parentFemale;
            
        }
        
        if (indexPath.row==1) {
            mouse = self.mouse.parentMale;
           
        }
    }else if (indexPath.section==2){
        
            mouse= self.mouse.children[indexPath.row];
        
        }
    
    ShowMouseViewController *showmouse = (ShowMouseViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ShowMouse"];
    showmouse.mouse = mouse;
    showmouse.title = mouse.name;
    [self.navigationController pushViewController:showmouse animated:YES];
    
}



//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//   
//    
//    ShowMouseViewController *controller = (ShowMouseViewController *) segue.destinationViewController;
//    controller.mouse = sender;
//}

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
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
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
