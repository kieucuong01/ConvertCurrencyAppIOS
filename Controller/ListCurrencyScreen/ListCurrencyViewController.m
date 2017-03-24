//
//  ListCurrencyViewController
//
//  Created by Kieu Cuong on 17/2/2017.
//

#import "ListCurrencyViewController.h"
#import "DBManager.h"
#import "FMDB.h"
#import "mCurrency.h"
#import "CurrencyCell.h"
#import "ConvertCurrencyViewController.h"

@interface ListCurrencyViewController ()
@property NSMutableArray *listCurrency;
@property(strong,nonatomic) MBProgressHUD* HUD;
@property (nonatomic, strong) DBManager *db;

@end

@implementation ListCurrencyViewController
mCurrency* selectedCurrency1;
mCurrency* selectedCurrency2;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initListCurrencyFromAPI];
}

-(void) viewDidAppear:(BOOL)animated{
    selectedCurrency1 = nil;
    selectedCurrency2 = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)done:(id)sender{
 
}

-(void) initListCurrencyFromAPI{
    self.HUD = [CommonUtils createProgressViewInView:self.view];
    _listCurrency = [[NSMutableArray alloc] init];

    NSString* param = @"?access_key=c4938186919ee261aab9e354d1ada8f8";
    [[AFNetworkingHelper sharedClient] getListCurrency:param SuccessBlock:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary* dictExchangeRate = responseObject[@"quotes"];
            for(int i = 0 ; i< dictExchangeRate.count ; i ++){
                mCurrency* currency = [[mCurrency alloc]init];
                currency.name = [dictExchangeRate.allKeys[i] substringFromIndex:3];
                currency.exchangeRate = dictExchangeRate.allValues[i];
                
                [_db.db executeUpdate:@"INSERT INTO CURRENCYRATE (name, exchangerate) VALUES (?, ?)", currency.name, currency.exchangeRate];

                
                [_listCurrency addObject:currency];
            [self.HUD setHidden:YES];
            [_tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.HUD setHidden:YES];
        [self initListCurrencyFromSQLite];
    }];
    
}



-(void) initListCurrencyFromSQLite{
    _listCurrency = [[NSMutableArray alloc] init];
    FMResultSet *rs = [_db.db executeQuery:@"SELECT DISTINCT name, exchangerate FROM CURRENCYRATE"];
    while ([rs next]){
        mCurrency* currency = [[mCurrency alloc]init];
        currency.name = [rs stringForColumn:@"name"];
        currency.exchangeRate = [NSNumber numberWithLong:[rs longForColumn:@"exchangerate"]];
        [_listCurrency addObject: currency];
    }
    [self.tableView reloadData];
}


#pragma mark - <UITableViewDataSource> / <UITableViewDelegate> -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listCurrency.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CurrencyCell* cell = (CurrencyCell*)[self.tableView dequeueReusableCellWithIdentifier:@"CurrencyCell" forIndexPath:indexPath];
    mCurrency* currency = _listCurrency[indexPath.row];
    if([UIImage imageNamed:currency.name] != nil)
        cell.imageFlagView.image = [UIImage imageNamed:currency.name];
    else
        cell.imageFlagView.image = [UIImage imageNamed:@"LOGOAPP"];
    
    cell.nameCurrency.text = currency.name;
    cell.exchangeRateCurrency.text = currency.exchangeRate.stringValue;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(selectedCurrency1 == nil){
        selectedCurrency1 = _listCurrency[indexPath.row];
        
        [CommonUtils alert:@"Chọn đơn vị tiền còn lại để đổi" :@""];
    }
    else {
        selectedCurrency2 = _listCurrency[indexPath.row];
        
        UIStoryboard *storyMain = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ConvertCurrencyViewController* vc_des =   [storyMain instantiateViewControllerWithIdentifier:@"ConvertCurrencyView"];
        vc_des.hidesBottomBarWhenPushed = false;
        vc_des.currency1 = selectedCurrency1;
        vc_des.currency2 = selectedCurrency2;
        
        [self.navigationController pushViewController:vc_des animated:true];
    }
    
}
@end
