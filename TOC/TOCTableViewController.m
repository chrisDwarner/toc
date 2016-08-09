//
//  TOCTableViewController.m
//  TOC
//
//  Created by chris warner on 3/9/15.
//  Copyright (c) 2015 NarrativeTechnologies. All rights reserved.
//

#import "TOCTableViewController.h"
#import "TOCTableViewCell.h"
#import "ContributerView.h"

static NSString *CellId = @"TOCTableViewCell";

@interface TOCTableViewController ()

@end

@implementation TOCTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[TOCTableViewCell class] forCellReuseIdentifier:CellId];

    // setup self sizing table cells
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

// This method is called when the Dynamic Type user setting changes (from the system Settings app)
- (void)contentSizeCategoryChanged:(NSNotification *)notification
{
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TOCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId ];
    
    if (indexPath.row == 0) {
        cell.chapterTitle.text = @"Introduction";
        cell.chapterNumber.text = @"--";
    }else{
        cell.chapterNumber.text = [NSString stringWithFormat:@"chapter Number %ld", (long)indexPath.row];
        cell.chapterTitle.text = [NSString stringWithFormat:@"chapter title %ld", (long)indexPath.row];
    }
    cell.pagesLabel.text = [NSString stringWithFormat:@"pages %ld", (long)indexPath.row+1];

    // Configure the cell...
    for (NSInteger i=0; i<indexPath.row; i++)
    {
        ContributerView *contributer = [ContributerView new];
        contributer.translatesAutoresizingMaskIntoConstraints = NO;

        contributer.contributerTitle.text = [NSString stringWithFormat:@"contributer Title %ld", (long)i];
        contributer.subtitle.text = @"sub-title";
        contributer.pages.text = [NSString stringWithFormat:@"pages %ld", (long)i];
        
        [contributer updateFonts];
        [cell.contributers addObject:contributer];
        [cell.contentView addSubview:contributer];
    }
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
