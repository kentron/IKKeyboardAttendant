//
//  IKMainViewController.m
//  IKCellAttendantExample
//
//  Created by Pablo Villar on 7/11/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IKMainViewController.h"
#import "IKTableViewCell.h"
#import "IKCellAttendant.h"

NSInteger const NumberOfRows = 50;

@interface IKMainViewController () <UITableViewDataSource, UITableViewDelegate, IKTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IKCellAttendant *attendant;

@end

@implementation IKMainViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.attendant = [[IKCellAttendant alloc] initWithViewController:self tableView:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return NumberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IKTableViewCellIdentifier];
    
    if (!cell)
    {
        cell = [IKTableViewCell cell];
        cell.delegate = self;
    }
    
    cell.indexNumber = indexPath.row;
    
    NSLog(@"Returning %@", cell);
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return IKTableViewCellHeight;
}

#pragma mark - IKTableViewCellDelegate

- (void)tableViewCellDidGetFocus:(IKTableViewCell *)cell
{
    self.attendant.visibleCell = cell;
}

@end
