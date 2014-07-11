//
//  IKCellAttendant.h
//  Inaka
//
//  Created by Pablo Villar on 7/8/14.
//  Copyright (c) 2014 Inaka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKCellAttendant : NSObject

/**
 Use this property to set the cell you want to keep always visible on the screen despite keyboard's visibility.
 */
@property (strong, nonatomic) UITableViewCell *visibleCell;

/**
 Returns a new IKCellAttendant instance initialized with the parameters passed in.
 
 @param viewController
 The UIViewController instance where your table view and cells are located.
 
 @param tableView
 The UITableView element that holds the cells you want to keep visible.
*/
- (id)initWithViewController:(UIViewController *)viewController tableView:(UITableView *)tableView;

@end
