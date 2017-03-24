//
//  ConvertCurrencyViewController.h
//
//  Created by Kieu Cuong on 3/24/17.
//  Copyright © 2017 Cuong Kieu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mCurrency.h"

@interface ConvertCurrencyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFlag1;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFlag2;
@property (weak, nonatomic) IBOutlet UILabel *nameCurrency1;
@property (weak, nonatomic) IBOutlet UILabel *nameCurrency2;
@property (weak, nonatomic) IBOutlet UITextField *tfCurrency1;
@property (weak, nonatomic) IBOutlet UITextField *tfCurrency2;

@property (strong, nonatomic) IBOutlet mCurrency *currency1;
@property (strong, nonatomic) IBOutlet mCurrency *currency2;

@end
