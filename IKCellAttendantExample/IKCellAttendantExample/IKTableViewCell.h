//
//  IKTableViewCell.h
//  IKCellAttendantExample
//
//  Created by Pablo Villar on 7/11/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const IKTableViewCellIdentifier;
extern CGFloat const IKTableViewCellHeight;

@class IKTableViewCell;

@protocol IKTableViewCellDelegate <NSObject>
- (void)tableViewCellDidGetFocus:(IKTableViewCell *)cell;
@end

@interface IKTableViewCell : UITableViewCell

@property (readwrite, nonatomic) NSInteger indexNumber;
@property (weak, nonatomic) id <IKTableViewCellDelegate> delegate;

+ (instancetype)cell;

@end
