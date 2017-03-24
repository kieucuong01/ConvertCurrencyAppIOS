//
//  DBManager.h
//  eSales
//
//  Created by Kieu Cuong on 9/20/16.
//  Copyright © 2016 Huy Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface DBManager : NSObject

@property (nonatomic, strong) FMDatabase *db;

-(void) openDB;
-(void) closeDB;
-(void) createTable;
    
@end

