//
//  ConvertCurrencyViewController.m
//
//  Created by Kieu Cuong on 3/24/17.
//  Copyright © 2017 Cuong Kieu. All rights reserved.
//

#import "ConvertCurrencyViewController.h"

@interface ConvertCurrencyViewController () <UITextFieldDelegate>

@end

@implementation ConvertCurrencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tfCurrency1.delegate = self;
    [self loadLayout];
}


-(void) loadLayout{
    _nameCurrency1.text = _currency1.name;
    _imageViewFlag1.image = [UIImage imageNamed:_currency1.name];
    
    _nameCurrency2.text = _currency2.name;
    _imageViewFlag2.image = [UIImage imageNamed:_currency2.name];
}

#pragma mark UITextField delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{

}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSInteger  mountNeedChange = [string doubleValue];
    NSInteger  result = mountNeedChange * (_currency2.exchangeRate.doubleValue/_currency1.exchangeRate.doubleValue);
    _tfCurrency2.text = [NSString stringWithFormat:@"%ld", (long)result];
    return YES;
}
@end
