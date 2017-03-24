//
//  DBManager.m
//  eSales
//
//  Created by Kieu Cuong on 9/20/16.
//  Copyright © 2016 Huy Le. All rights reserved.
//

#import "DBManager.h"
#import <sqlite3.h>


@interface DBManager()

@end


@implementation DBManager

- (void) openDB{
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    NSString* path = [documentsDirectory stringByAppendingPathComponent:@"currencyApp.sqlite"];
    
    NSLog(@"path : %@", path);
    
    _db = [FMDatabase databaseWithPath:path];
    
    [_db open];
    
}



-(void) closeDB{
    [_db close];
}

-(void) createTable{
    [_db executeUpdate: @"CREATE TABLE CURRENCYRATE (name text, exchangerate long)"];
}


@end
