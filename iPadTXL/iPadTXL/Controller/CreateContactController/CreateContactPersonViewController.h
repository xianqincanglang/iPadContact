//
//  CreateContactPersonViewController.h
//  iPadTXL
//
//  Created by marchsoft on 15/9/24.
//  Copyright © 2015年 chentianyu. All rights reserved.
//

#import "BaseViewController.h"

@interface CreateContactPersonViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong)NSMutableArray *phoneArray;
@property (nonatomic,strong)NSMutableArray *emailArray;
@property (nonatomic,strong)NSMutableArray *URLArray;
@property (nonatomic,strong)NSMutableArray *addressArray;
@property (nonatomic,strong)NSMutableArray *birthdayArray;


@property (nonatomic,strong)NSString *familyText;
@property (nonatomic,strong)NSString *nameText;
@property (nonatomic,strong)NSString *companyText;


@property (nonatomic,strong)NSString *phoneHomeText;
@property (nonatomic,strong)NSString *phoneWorkText;
@property (nonatomic,strong)NSString *phoneIphoneText;
@property (nonatomic,strong)NSString *phoneMoveText;


@property (nonatomic,strong)NSString *emailHomeText;
@property (nonatomic,strong)NSString *emailWorkText;
@property (nonatomic,strong)NSString *emailIcloudText;
@property (nonatomic,strong)NSString *emailMoveText;


@property (nonatomic,strong)NSString *urlHomeText;
@property (nonatomic,strong)NSString *urlWorkText;
@property (nonatomic,strong)NSString *urlHouseText;

@property (nonatomic,strong)NSString *addressText;

@property (nonatomic,strong)NSString *birthdayText;



@end
