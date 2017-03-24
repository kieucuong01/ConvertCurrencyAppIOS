//
//  CurrencyCell.h
//
//  Created by Kieu Cuong on 3/22/17.
//

#import <UIKit/UIKit.h>
@interface CurrencyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageFlagView;
@property (weak, nonatomic) IBOutlet UILabel *nameCurrency;
@property (weak, nonatomic) IBOutlet UILabel *exchangeRateCurrency;

@end
