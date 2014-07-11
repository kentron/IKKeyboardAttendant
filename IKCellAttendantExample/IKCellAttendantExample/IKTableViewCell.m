//
//  IKTableViewCell.m
//  IKCellAttendantExample
//
//  Created by Pablo Villar on 7/11/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import "IKTableViewCell.h"

NSString *const IKTableViewCellIdentifier = @"TableViewCell";
CGFloat const IKTableViewCellHeight = 70;

@interface IKTableViewCell () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation IKTableViewCell

#pragma mark - Cell

+ (instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"IKTableViewCell" owner:nil options:nil] firstObject];
}

#pragma mark - Accessors

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected)
    {
        [self.textField becomeFirstResponder];
    }
}

- (void)setIndexNumber:(NSInteger)indexNumber
{
    _indexNumber = indexNumber;
    [self updatePlaceholder];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.delegate)
    {
        [self.delegate tableViewCellDidGetFocus:self];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Private

- (void)updatePlaceholder
{
    self.textField.placeholder = [NSString stringWithFormat:@"Insert row %d text", self.indexNumber];
}

@end
