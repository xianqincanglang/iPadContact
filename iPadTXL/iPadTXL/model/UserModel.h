//
//  UserModel.h
//  iPadTXL
//
//  Created by marchsoft on 15/9/29.
//  Copyright © 2015年 chentianyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property int userId;
@property(nonatomic,strong)NSString *family;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *company;


@property(nonatomic,strong)NSString *phoneHouse;
@property(nonatomic,strong)NSString *phoneWork;
@property(nonatomic,strong)NSString *phoneIphone;
@property(nonatomic,strong)NSString *phoneMove;

@property(nonatomic,strong)NSString *emailHouse;
@property(nonatomic,strong)NSString *emailWork;
@property(nonatomic,strong)NSString *emailIcloud;
@property(nonatomic,strong)NSString *emailMove;

@property(nonatomic,strong)NSString *urlHome;
@property(nonatomic,strong)NSString *urlHouse;
@property(nonatomic,strong)NSString *urlWork;

@property(nonatomic,strong)NSString *address;

@property(nonatomic,strong)NSString *birthday;


@end
