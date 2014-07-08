//
//  IKCellAttendant.m
//  Inaka
//
//  Created by Pablo Villar on 7/8/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IKCellAttendant.h"

@interface IKCellAttendant ()

@property (strong, nonatomic) UITableView *tableView;

@property (readwrite, nonatomic) BOOL notificationsAdded;

@end

@implementation IKCellAttendant

#pragma mark - Lifecycle

- (id)initWithViewController:(UIViewController *)viewController tableView:(UITableView *)tableView
{
    self = [super init];
    if (self)
    {
        _tableView = tableView;
        
        viewController.automaticallyAdjustsScrollViewInsets = NO;
        [self addKeyboardNotifications];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Accessors

- (void)setVisibleCell:(UITableViewCell *)visibleCell
{
    _visibleCell = visibleCell;
    
    [self.tableView scrollRectToVisible:visibleCell.frame animated:YES];
}

#pragma mark - Keyboard observing

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    
    [self animateTableViewWithDuration:duration bottomValue:keyboardHeight];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [self animateTableViewWithDuration:duration bottomValue:0];
}

#pragma mark - Private

- (void)addKeyboardNotifications
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)animateTableViewWithDuration:(CGFloat)duration bottomValue:(CGFloat)bottomValue
{
    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.bottom = bottomValue;
    UIEdgeInsets scrollIndicatorInsets = self.tableView.scrollIndicatorInsets;
    scrollIndicatorInsets.bottom = bottomValue;
    
    [UIView animateWithDuration:duration animations:^{
        self.tableView.contentInset = contentInset;
        self.tableView.scrollIndicatorInsets = scrollIndicatorInsets;
    }];
}

@end
