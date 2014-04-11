//
//  AddMouseViewController.m
//  MouseStache
//
//  Created by Danielle Bessler on 2/13/14.
//  Copyright (c) 2014 Danielle Bessler. All rights reserved.
//

#import "AddMouseViewController.h"
#import "Mouse.h"

@interface AddMouseViewController ()



@end

@implementation AddMouseViewController

{

    UILabel *dateLabel;
    UIDatePicker *datePicker;
    NSString *_addedRelation;
    Mouse *_originalMom, *_originalDad;
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
    
    self.view.autoresizesSubviews = UIViewAutoresizingFlexibleHeight;
    self.view.autoresizesSubviews = UIViewAutoresizingFlexibleWidth;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:101.0/255.0 green:44.0/255.0 blue:144.0/255.0 alpha:1.0];
    
    

    
    
    if (self.editMouse) {
        self.title = @"Edit Item";
        
        self.tempName = self.mouse.name;
       
        self.doneBarButton.enabled = YES;
        
        _originalDad = self.mouse.parentMale;
        _originalMom = self.mouse.parentFemale;
        
        
    }
    else {
        
        self.mouse = [[Mouse alloc] init];
    }
    
    //Create label
	dateLabel = [[UILabel alloc] init];
	dateLabel.frame = CGRectMake(270, 10, 250, 60);
	
	
	//Use NSDateFormatter to write out the date in a friendly format
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	df.dateStyle = NSDateFormatterMediumStyle;
	dateLabel.text = [df stringFromDate:[NSDate date]];
    
    UIView *footerContainer = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 300, 500)];
    datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(250, 60, 250, 250)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [footerContainer addSubview:dateLabel];
    [footerContainer addSubview:datePicker];
    
    
    self.tableView.tableFooterView = footerContainer;
    
    [datePicker addTarget:self action:@selector(dateEntered:)forControlEvents:UIControlEventValueChanged];
    self.mouse.dateOfBirth = datePicker.date;
    
    
}

-(void)dateEntered:(id)sender
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
	df.dateStyle = NSDateFormatterMediumStyle;
	dateLabel.text = [df stringFromDate:datePicker.date];
    self.mouse.dateOfBirth = datePicker.date;

    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //UITextField *field = (UITextField *)[self.tableView viewWithTag:2990];
    //[field becomeFirstResponder];
    
    
//    UIView *footerContainer = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 150, 50)];
//    UIButton *btnFooter = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [btnFooter setTitle:@"Delete Mouse" forState:UIControlStateNormal];
//    [btnFooter.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
//    [btnFooter setFrame:CGRectMake(10, 10, 150, 50)];
//    [btnFooter setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    
//    [footerContainer addSubview:btnFooter];
//    
//    
//    self.tableView.tableFooterView = footerContainer;
//    
//    [btnFooter addTarget:self action:@selector(deleteButtonHit:)forControlEvents:UIControlEventTouchUpInside];
//
//    [self.tableView reloadData];
//    
//   }
//-(void)deleteButtonHit:(id)sender
//{
//    [self.mice.items ]
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)cancel
{
    [self.delegate AddMouseViewControllerDidCancel:self];
}

- (IBAction)done
{
    if(self.editMouse) {
        UITextField *field = (UITextField *)[self.tableView viewWithTag:2990];
        self.mouse.name = field.text;
        
        //If either parent has changed, remove this mouse from that changed parent's children array.
        //And add this mouse to new parent's children array.
        
        //Boolean changed = NO;
        if (_originalMom != self.mouse.parentFemale )
        {
            
            [_originalMom.children removeObjectIdenticalTo:self.mouse];
            Mouse *mom = self.mouse.parentFemale;
            [mom.children addObject:self.mouse];
            //changed = YES;
        }
        
        
        if (_originalDad != self.mouse.parentMale)
        {
            [_originalDad.children removeObjectIdenticalTo:self.mouse];
            Mouse *dad = self.mouse.parentMale;
            [dad.children addObject:self.mouse];
            //changed = YES;
        }

        //If either parent has changed, and there is no other mouse that has the original two parents as parents, remove
        //each parent from the other's mates array.

//        if (changed)
//        {
//            Boolean found  = NO;
//            
//            for (int i=0; i<[_originalMom.children count]; i++) {
//            
//                Mouse *child = _originalMom.children[i];
//            
//                if (child.parentMale == _originalDad)
//                found = YES;
//            }
//        
//            if (!found) {
//                [_originalDad.mates removeObjectIdenticalTo:_originalMom];
//                [_originalMom.mates removeObjectIdenticalTo:_originalDad];
//            }
//        }
        
        
            [self.delegate AddMouseViewController:self didFinishEditingItem:self.mouse];

    }else {
    
        UITextField *field = (UITextField *)[self.tableView viewWithTag:2990];
        self.mouse.name = field.text;
     
     
       
        
        
        [self.delegate AddMouseViewController:self didFinishAddingItem:self.mouse];
        
   }
}

- (IBAction)addGene:(id)sender{
    NSIndexPath* path = [NSIndexPath indexPathForRow:[self.mouse.genes count] inSection:3];
    UITableViewCell *cell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:path];
    //^try this views superview, or try setting buttons tag to index path.row to access cell
    UITextField *field = (UITextField *)[cell viewWithTag:3010];
    NSString *gene = field.text;
    [self.mouse.genes addObject:gene];
    
    //NSLog(@" gene at pos 0 %@", self.mouse.genes[0]);
    
    NSIndexSet *sectionIndexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(3, 1)];
    [self.tableView reloadSections:sectionIndexSet withRowAnimation:UITableViewRowAnimationFade];
}




-(IBAction)sexChange:(id)sender
{
    if([sender selectedSegmentIndex] == 0) {
        self.mouse.female = YES;
    }
    if([sender selectedSegmentIndex] == 1) {
        self.mouse.female = NO;
    }
    
}




- (NSIndexPath *) tableView:(UITableView *) tableView willSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    return nil;
}

-(BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange) range
replacementString:(NSString *)string
{
    
    if (theTextField.tag==2990){
        self.tempName = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
        
        
        self.doneBarButton.enabled = ([self.tempName length] > 0);

        
    }else if (theTextField.tag==3010){
        NSString *gene = [theTextField.text  stringByReplacingCharactersInRange:range withString:string];
        CGPoint location = [theTextField.superview convertPoint:theTextField.center toView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
//        NSIndexPath* path = [NSIndexPath indexPathForRow:[self.mouse.genes count] inSection:3];
//
        if(indexPath.row == [self.mouse.genes count]){
            if([gene length]>0){
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            UIButton *add = (UIButton *)[cell viewWithTag:3020];
            add.userInteractionEnabled = YES;
            }
        }else{
            self.mouse.genes[indexPath.row] = gene;
        }
        
    }
    return YES;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger) tableView: (UITableView*) tableView numberOfRowsInSection: (NSInteger) section
{
    if(section==3){
        
        return [self.mouse.genes count]+1;
    }

   else {
        return 1;
   }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell;
    
    if (indexPath.section == 3){
        cell = [tableView dequeueReusableCellWithIdentifier:@"gene"];
        
        
       UITextField *field = (UITextField *)[cell viewWithTag:3010];
       UIButton *addGene = (UIButton *)[cell viewWithTag:3020];
        
        if (indexPath.row==[self.mouse.genes count]) {

            addGene.userInteractionEnabled = NO;
            field.placeholder = @"Enter new gene here";
            
        }else{
            addGene.hidden = YES;
            NSString *gene;
            //int row = indexPath.row;
            gene = self.mouse.genes[indexPath.row];
            field.text = gene;
        }
    }else if(indexPath.section == 1) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"mom"];
        
            if (self.mouse.parentFemale != nil)
            {
                
           
            UILabel *label = (UILabel *)[cell viewWithTag:2999];
            label.textColor = [UIColor blackColor];
            label.text = self.mouse.parentFemale.name;
            
            
            //UIImageView *image = (UIImageView *) [cell viewWithTag:10];
            //image.image = [UIImage imageNamed:@"Female"];
            }
            else {
                UILabel *label = (UILabel *)[cell viewWithTag:2999];
                label.textColor = [UIColor grayColor];
                label.text = @"Mother";
            }
            

    }
    else if(indexPath.section == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"dad"];
            
            if (self.mouse.parentMale != nil)
            {
                
                UILabel *label = (UILabel *)[cell viewWithTag:3000];
                label.textColor = [UIColor blackColor];
                label.text = self.mouse.parentMale.name;
                
                
                // UIImageView *image = (UIImageView *) [cell viewWithTag:10];
                // image.image = [UIImage imageNamed:@"Male"];
                
            }
            else {
                UILabel *label = (UILabel *)[cell viewWithTag:3000];
                label.textColor = [UIColor grayColor];
                label.text = @"Father";
            }
    }
    
        
    
//    else if (indexPath.section == 3)
//    {
//        cell = [tableView dequeueReusableCellWithIdentifier:@"addMate"];
//        
 //   }
        else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"name"];
            UITextField *field = (UITextField *)[cell viewWithTag:2990];
            field.delegate = self;
            field.userInteractionEnabled = YES;
            [field becomeFirstResponder];
        
        if (self.mouse.name != nil){
            
            
            
            field.text = self.tempName;
            UISegmentedControl *seg = (UISegmentedControl *)[cell viewWithTag:10];
            if (self.mouse.female){
                [seg setSelectedSegmentIndex:0];
            }
            if (!self.mouse.female) {
                [seg setSelectedSegmentIndex:1];
            }
            

        }
            }
  
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([segue.identifier isEqualToString:@"addMom"]) {
        
            
       
        AddRelationViewController *controller = (AddRelationViewController *) segue.destinationViewController;
        
        _addedRelation = @"mom";
    
        //self.mouse.parentFemale = [[Mouse alloc] init];
        controller.delegate = self;
        controller.mice = self.mice;
        controller.addedRelation = @"mom";
        
        
    }
    
    else if([segue.identifier isEqualToString:@"addDad"]) {
        
        
        
        AddRelationViewController *controller = (AddRelationViewController *) segue.destinationViewController;
        
        _addedRelation = @"dad";
       
        controller.delegate = self;
        controller.mice = self.mice;
        controller.addedRelation = @"dad";
        
        

        
    }
    if ([segue.identifier isEqualToString:@"addMate"]) {
        AddRelationViewController *controller = (AddRelationViewController *) segue.destinationViewController;
        
        _addedRelation = @"mate";
        
        
        controller.delegate = self;
        controller.mice = self.mice;
    }
    
    
}


- (void)AddRelationViewControllerDidCancel:(AddRelationViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)AddRelationViewController:(AddRelationViewController *) controller didFinishChoosingItem:(Mouse *)item
{
    
    

        if ([_addedRelation isEqualToString:@"mom"])
        {
            
            self.mouse.parentFemale = item;
            //self.motherLabel.text = item.name;
        }
    
        if ([_addedRelation isEqualToString:@"dad"])
        {
           self.mouse.parentMale = item;
           //self.fatherLabel.text = item.name;
        }
    if ([_addedRelation isEqualToString:@"mate"])
    {
        [self.mouse.mates addObject:item];
        
        //self.fatherLabel.text = item.name;
    }
    
    [self.tableView reloadData];
   

    
    


   
    
}



@end
