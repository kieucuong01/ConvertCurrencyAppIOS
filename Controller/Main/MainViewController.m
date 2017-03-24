//
//  MainViewController.m
//
//  Created by Kieu Cuong on 18/3/17.
//

#import "MainViewController.h"
#import "ListCurrencyViewController.h"
#import "DBManager.h"

@interface MainViewController ()
@property(strong, nonatomic) DBManager* db;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDB];
    [self setupNavigationBar];
}


- (void) setupDB{
    _db = [[DBManager alloc]init];
    [_db openDB];
    [_db createTable];
    [_db closeDB];
}


- (void)setupNavigationBar {
    //create left button item
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"logo"] forState:UIControlStateNormal];
    UIBarButtonItem* leftButtonBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [leftBtn setFrame:CGRectMake(0, 0, 30, 30)];
    self.navigationItem.leftBarButtonItem = leftButtonBarItem;
    
    //new style
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.barTintColor = [CommonUtils navigationBarBackGroundColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}


- (IBAction)btnViewAspectCurrency:(id)sender {
    UIStoryboard *storyMain = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ListCurrencyViewController* vc_des =   [storyMain instantiateViewControllerWithIdentifier:@"ListCurrencyView"];
    vc_des.hidesBottomBarWhenPushed = false;
    [self.navigationController pushViewController:vc_des animated:true];
}

- (IBAction)btnConvertCurrency:(UIButton *)sender {

}


@end
