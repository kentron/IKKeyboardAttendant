IKCellAttendant
===============
Keep your cells visible in a nice way despite keyboard's visibility on screen.

<img src="https://raw.githubusercontent.com/inaka/IKCellAttendant/master/example.gif"/>

Contact Us
--------
For **questions** or **general comments** regarding the use of this library, please use our public
[hipchat room](https://www.hipchat.com/gpBpW3SsT).

If you find any **bugs** or have a **problem** while using this library, please [open an issue](https://github.com/inaka/IKKeyboardAttendant/issues/new) in this repo (or a pull request :)).

And you can check all of our open-source projects at [inaka.github.io](http://inaka.github.io)

Overview
--------
Tired of having to add all that keyboard-notification-related boilerplate code into your UIViewController class in order to just keep your UITableViewCells always visible? IKCellAttendant will do all that boring job for you in a nice way, keeping your UIViewController's code cleaner.

Setup
-----
You can quickly integrate IKCellAttendant into your project via [CocoaPods](http://cocoapods.org/).

Usage
-----
__Initialization:__

`- (id)initWithViewController:(UIViewController *)viewController tableView:(UITableView *)tableView;`

Use this initializer to pass in the arguments that are required to properly setup your IKCellAttendant instance.

- __viewController__: The UIViewController instance where your table view and cells are located.

- __tableView__: The UITableView element that holds the cells you want to keep visible.

__Updating:__

`@property (strong, nonatomic) UITableViewCell *visibleCell;`

 - __visibleCell__: Use this property to set the current cell that you want to keep always visible on the screen despite keyboard's visibility.

Example
-------
_In SomeViewController.m_

```
@interface SomeViewController ()

@property (strong, nonatomic) IKCellAttendant *attendant;

@end

@implementation SomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.attendant = [[IKCellAttendant alloc] initWithViewController:self tableView:self.tableView];
}

- (void)cellTextViewDidBecomeFirstResponder:(UITableViewCell *)cell
{
    self.attendant.visibleCell = cell;	// Update the current cell you want to be visible.
}
```
