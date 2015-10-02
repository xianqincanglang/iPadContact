//
//  DatabaseUsage.m
//  iPadTXL
//
//  Created by marchsoft on 15/9/29.
//  Copyright © 2015年 chentianyu. All rights reserved.
//

#import "DatabaseUsage.h"


#define TABLENAME @"contact"
#define DATABASE_NAME @"database.sqlite3"

#define FAMILYNAME_FIELD          @"family_text"
#define NAME_FIELD          @"name_text"
#define COMPANY_FIELD          @"company_text"

#define PHONE_HOUSE_FIELD          @"phone_house_text"
#define PHONE_WORK_FIELD          @"phone_work_text"
#define PHONE_IPHONE_FIELD          @"phone_iphone_text"
#define PHONE_MOVE_FIELD          @"phone_move_text"

#define EMAIL_HOUSE_FIELD          @"email_house_text"
#define EMAIL_WORK_FIELD          @"email_work_text"
#define EMAIL_ICLOUD_FIELD          @"email_icloud_text"
#define EMAIL_MOVE_FIELD          @"email_move_text"

#define URL_HOME_FIELD          @"url_home_text"
#define URL_HOUSE_FIELD          @"url_house_text"
#define URL_WORK_FIELD          @"url_work_text"

#define ADDRESS_FIELD          @"address_text"

#define BIRTHDAY_FIELD          @"birthday_text"

@implementation DatabaseUsage



//打开数据库
- (BOOL)openDB
{
    //获取数据库路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DATABASE_NAME];
    NSLog(@"%@",database_path);
    
    if (sqlite3_open([database_path UTF8String], &database) ==SQLITE_OK) {
        return YES;
    }else{
        NSLog(@"数据库打开失败");
        sqlite3_close(database);
        return NO;
    }
}

//sqlite3_exec的封装
- (BOOL)execSQL:(NSString *)sql
{
    char *error;
    BOOL temp;
    if ([self openDB]) {
        if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, &error)) {
            NSLog(@"数据库操作失败");
//            NSLog(@"%@")
            temp = false;
        }else{
            NSLog(@"%@",sql);
            temp = true;
        }
        sqlite3_close(database);
    }
    return temp;
}

//创建联系人表格
- (void)creatTable
{
    //创建数据库
    NSString *createTableSQL = [NSString stringWithFormat:@"create table if not exists '%@'("
                                "id integer primary key autoincrement,'%@' text,'%@' text,'%@' text,'%@' text,'%@' text,'%@' text,'%@' text,'%@' text,'%@' text,'%@' text,'%@' text,'%@' text,'%@' text,'%@' text,'%@' text,'%@' text)",TABLENAME,FAMILYNAME_FIELD,NAME_FIELD,COMPANY_FIELD,PHONE_HOUSE_FIELD,PHONE_WORK_FIELD,PHONE_IPHONE_FIELD,PHONE_MOVE_FIELD,EMAIL_HOUSE_FIELD,EMAIL_WORK_FIELD,EMAIL_ICLOUD_FIELD,EMAIL_MOVE_FIELD,URL_HOME_FIELD,URL_HOUSE_FIELD,URL_WORK_FIELD,ADDRESS_FIELD,BIRTHDAY_FIELD];
    if ([self execSQL:createTableSQL]) {
        NSLog(@"数据表创建成功");
    }else{
        NSLog(@"创建表失败");
    }
}


///插入数据
- (BOOL)insertDataWithFamily:(NSString *)family name:(NSString *)name company:(NSString *)company phoneHouse:(NSString *)phoneHouse phoneWork:(NSString *)phoneWork phoneIphone:(NSString *)phoneIphone phoneMove:(NSString *)phoneMove emailHouse:(NSString *)emailHouse emailWork:(NSString *)emailWork emailIcloud:(NSString *)emailIcloud emailMove:(NSString *)emailMove urlHome:(NSString *)urlHome urlHouse:(NSString *)urlHouse urlWork:(NSString *)urlWork address:(NSString *)address birthday:(NSString *)birthday
{
    NSString *insertSQL = [NSString stringWithFormat:@"insert into '%@'('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@') values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",TABLENAME,FAMILYNAME_FIELD,NAME_FIELD,COMPANY_FIELD,PHONE_HOUSE_FIELD,PHONE_WORK_FIELD,PHONE_IPHONE_FIELD,PHONE_MOVE_FIELD,EMAIL_HOUSE_FIELD,EMAIL_WORK_FIELD,EMAIL_ICLOUD_FIELD,EMAIL_MOVE_FIELD,URL_HOME_FIELD,URL_HOUSE_FIELD,URL_WORK_FIELD,ADDRESS_FIELD,BIRTHDAY_FIELD, family,name,company,phoneHouse,phoneWork,phoneIphone,phoneMove,emailHouse,emailWork,emailIcloud,emailMove,urlHome,urlHouse,urlWork,address,birthday];
    
    if ([self execSQL:insertSQL]) {
        NSLog(@"创建联系人成功");
        return true;
    }else{
        NSLog(@"创建联系人失败");
        return false;
    }
        
}

///更新数据
- (BOOL)updateDataWithFamily:(NSString *)family name:(NSString *)name company:(NSString *)company phoneHouse:(NSString *)phoneHouse phoneWork:(NSString *)phoneWork phoneIphone:(NSString *)phoneIphone phoneMove:(NSString *)phoneMove emailHouse:(NSString *)emailHouse emailWork:(NSString *)emailWork emailIcloud:(NSString *)emailIcloud emailMove:(NSString *)emailMove urlHome:(NSString *)urlHome urlHouse:(NSString *)urlHouse urlWork:(NSString *)urlWork address:(NSString *)address birthday:(NSString *)birthday userId:(int)userId
{
    NSString *insertSQL = [NSString stringWithFormat:@"update '%@' set '%@' = '%@' ,'%@' = '%@' , '%@' = '%@' , '%@' = '%@' , '%@' = '%@' , '%@' = '%@' , '%@' = '%@' , '%@' = '%@' , '%@' = '%@' , '%@' = '%@' , '%@' = '%@' , '%@' = '%@' , '%@' = '%@' , '%@' = '%@' , '%@' = '%@' , '%@' = '%@' where id = %d",TABLENAME,FAMILYNAME_FIELD,family,NAME_FIELD,name,COMPANY_FIELD,company,PHONE_HOUSE_FIELD,phoneHouse,PHONE_WORK_FIELD,phoneWork,PHONE_IPHONE_FIELD,phoneIphone,PHONE_MOVE_FIELD,phoneMove,EMAIL_HOUSE_FIELD,emailHouse,EMAIL_WORK_FIELD,emailWork,EMAIL_ICLOUD_FIELD,emailIcloud,EMAIL_MOVE_FIELD,emailMove,URL_HOME_FIELD,urlHome,URL_HOUSE_FIELD,urlHouse,URL_WORK_FIELD,urlWork,ADDRESS_FIELD,address,BIRTHDAY_FIELD,birthday,userId];
    NSLog(@"%@",insertSQL);
    
    if ([self execSQL:insertSQL]) {
        NSLog(@"更新联系人成功");
        return true;
    }else{
        NSLog(@"更新联系人失败");
        return false;
    }
}

///查询数据
- (NSMutableArray *)selectData
{ 
    [self openDB];
    NSString *querySQL = [NSString stringWithFormat:@"select * from %@",TABLENAME];
    
    sqlite3_stmt *statement;
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];

    
    if (sqlite3_prepare_v2(database, [querySQL UTF8String], -1, &statement, nil) == SQLITE_OK) {
        //查询结果集中一条一条的遍历所有的记录,这里的数字对应的是列值
        while (sqlite3_step(statement) == SQLITE_ROW) {
            UserModel *userModel = [[UserModel alloc] init];
            
           int userId =  sqlite3_column_int(statement, 0);
            userModel.userId = userId;
            
            char *family = (char *)sqlite3_column_text(statement, 1);
            NSString *familyStr = [[NSString alloc] initWithUTF8String:family];
            userModel.family = familyStr;
            
            char *name = (char *)sqlite3_column_text(statement, 2);
            NSString *nameStr  = [[NSString alloc] initWithUTF8String:name];
            userModel.name = nameStr;
            
            userModel.company = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
            
            //电话
            userModel.phoneHouse = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
            userModel.phoneWork = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
            userModel.phoneIphone = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
            userModel.phoneHouse = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
            
            
            //电子邮件
            userModel.emailHouse = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
            userModel.emailWork = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
            userModel.emailIcloud = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 10)];
            userModel.emailMove = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 11)];
            
            
            //URL
            userModel.urlHome = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 12)];
            userModel.urlHouse = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 13)];
            userModel.urlWork = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 14)];
            
            //地址
            userModel.address = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 15)];
            
            //生日
            userModel.birthday= [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 16)];
            
            
            
            
            
            
//            NSString *objStr = [NSString stringWithFormat:@"%@·%@",familyStr,nameStr];
//            [dataArray addObject:objStr];
            
            [dataArray addObject:userModel];
            
        }
    }else
    {
        NSLog(@"select error :%@",querySQL);
    }
    sqlite3_close(database);
    return dataArray;
}


///根据用户ID查询数据
- (UserModel *)selectDataByUserId:(int)userId
{
    [self openDB];
    NSString *querySQL = [NSString stringWithFormat:@"select * from %@ where id=%d",TABLENAME,userId];
    
    sqlite3_stmt *statement;
    UserModel *model = [UserModel new];
    if (sqlite3_prepare_v2(database, [querySQL UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *family = (char *)sqlite3_column_text(statement, 1);
            NSString *familyStr = [[NSString alloc] initWithUTF8String:family];
            model.family = familyStr;
            
            char *name = (char *)sqlite3_column_text(statement, 2);
            NSString *nameStr  = [[NSString alloc] initWithUTF8String:name];
            model.name = nameStr;
            
            model.company = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
            
            //电话
            model.phoneHouse = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
            model.phoneWork = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
            model.phoneIphone = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
            model.phoneMove = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
            
            
            //电子邮件
            model.emailHouse = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
            model.emailWork = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
            model.emailIcloud = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 10)];
            model.emailMove = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 11)];
            
            
            //URL
            model.urlHome = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 12)];
            model.urlHouse = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 13)];
            model.urlWork = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 14)];
            
            //地址
            model.address = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 15)];
            
            //生日
            model.birthday= [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 16)];
        }
    }else{
        NSLog(@"无法查阅数据,请联系管理员");
    }
    sqlite3_close(database);
    
    return model;
    
}

////删除联系人
- (BOOL)deletContact:(int)userId
{
    
    NSString *deleteSQL = [NSString stringWithFormat:@"delete from '%@' where id = %d",TABLENAME,userId];
    
    if ([self execSQL:deleteSQL]) {
        NSLog(@"删除联系人成功");
        return true;
    }else{
        NSLog(@"删除联系人失败");
        return false;
    }
    
}


@end
