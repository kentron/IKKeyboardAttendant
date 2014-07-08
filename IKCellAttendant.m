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
@property (strong, nonatomic) UIViewController *viewController;

@property (readwrite, nonatomic) BOOL notificationsAdded;

@end

@implementation IKCellAttendant

#pragma mark - Lifecycle

- (id)initWithViewController:(UIViewController *)viewController tableView:(UITableView *)tableView
{
    self = [super init];
    if (self)
    {
        _viewController = viewController;
        _tableView = tableView;
    }
    return self;
}

#pragma mark - Accessors

- (void)setVisibleCell:(UITableViewCell *)visibleCell
{
    _visibleCell = visibleCell;
    
    if (visibleCell)
    {
        self.viewController.automaticallyAdjustsScrollViewInsets = NO;
        [self addKeyboardNotificationsIfNecessary];
    }
    else
    {
        self.viewController.automaticallyAdjustsScrollViewInsets = YES;
        [self removeKeyboardNotificationsIfNecessary];
    }
    
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

- (void)addKeyboardNotificationsIfNecessary
{
    if (!self.notificationsAdded)
    {
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [notificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        self.notificationsAdded = YES;
    }
}

- (void)removeKeyboardNotificationsIfNecessary
{
    if (self.notificationsAdded)
    {
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        [notificationCenter removeObserver:self forKeyPath:UIKeyboardWillShowNotification];
        [notificationCenter removeObserver:self forKeyPath:UIKeyboardWillHideNotification];
        self.notificationsAdded = NO;
    }
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
