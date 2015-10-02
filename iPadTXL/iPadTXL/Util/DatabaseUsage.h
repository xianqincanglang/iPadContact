//
//  DatabaseUsage.h
//  iPadTXL
//
//  Created by marchsoft on 15/9/29.
//  Copyright © 2015年 chentianyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "UserModel.h"

@interface DatabaseUsage : NSObject
{
    sqlite3 *database;
}

- (void)creatTable;
- (BOOL)insertDataWithFamily:(NSString *)family name:(NSString *)name company:(NSString *)company phoneHouse:(NSString *)phoneHouse phoneWork:(NSString *)phoneWork phoneIphone:(NSString *)phoneIphone phoneMove:(NSString *)phoneMove emailHouse:(NSString *)emailHouse emailWork:(NSString *)emailWork emailIcloud:(NSString *)emailIcloud emailMove:(NSString *)emailMove urlHome:(NSString *)urlHome urlHouse:(NSString *)urlHouse urlWork:(NSString *)urlWork address:(NSString *)address birthday:(NSString *)birthday;
- (BOOL)updateDataWithFamily:(NSString *)family name:(NSString *)name company:(NSString *)company phoneHouse:(NSString *)phoneHouse phoneWork:(NSString *)phoneWork phoneIphone:(NSString *)phoneIphone phoneMove:(NSString *)phoneMove emailHouse:(NSString *)emailHouse emailWork:(NSString *)emailWork emailIcloud:(NSString *)emailIcloud emailMove:(NSString *)emailMove urlHome:(NSString *)urlHome urlHouse:(NSString *)urlHouse urlWork:(NSString *)urlWork address:(NSString *)address birthday:(NSString *)birthday userId:(int)userId;
- (NSMutableArray *)selectData;

//根据用户id查询
- (UserModel *)selectDataByUserId:(int)userId;

///根据用户id删除联系人
- (BOOL)deletContact:(int)userId;
@end
