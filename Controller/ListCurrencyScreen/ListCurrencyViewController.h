//
//  ListCurrencyViewController.h
//
//  Created by Kieu Cuong on 17/2/2017.
//

#import <UIKit/UIKit.h>
@interface ListCurrencyViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
