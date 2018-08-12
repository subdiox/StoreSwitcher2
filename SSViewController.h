#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "SSHeader.h"
#import "SSTableViewCell.h"

@interface SSViewController: UINavigationController<UITableViewDelegate, UITableViewDataSource>

@property(retain, nonatomic) UITableViewController *tableViewController;
@property(retain, nonatomic) NSMutableArray *accounts;

@end