//
//  AlertContactViewController.m
//  iPadTXL
//
//  Created by marchsoft on 15/9/30.
//  Copyright © 2015年 chentianyu. All rights reserved.
//

#import "AlertContactViewController.h"

@interface AlertContactViewController ()

@end

@implementation AlertContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"修改联系人";
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelCreateContact)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(saveCreateContact:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    self.editing = YES;//设置编辑状态
    
    self.alertContactTableView.delegate = self;
    self.alertContactTableView.dataSource = self;
    self.alertContactTableView.tableFooterView = [UIView new];

    _phoneArray = [[NSMutableArray alloc] init];
    _emailArray = [[NSMutableArray alloc] init];
    _URLArray = [[NSMutableArray alloc] init];
    _addressArray = [[NSMutableArray alloc] init];
    _birthdayArray = [[NSMutableArray alloc] init];
    
    _phoneTextArray = [[NSMutableArray alloc] init];
    _emailTextArray = [[NSMutableArray alloc] init];
    _URLTextArray = [[NSMutableArray alloc] init];
    _addressTextArray = [[NSMutableArray alloc] init];
    _birthdayTextArray = [[NSMutableArray alloc] init];
    
    
    NSLog(@"%@",self.userModel);
    [self getData];
    

    
}


- (void)getData
{
    //电话
    if (![self.userModel.phoneHouse  isEqualToString:@""]) {
        [self.phoneArray addObject:@"住宅"];
        [self.phoneTextArray addObject:self.userModel.phoneHouse];
    }
    if (![self.userModel.phoneWork  isEqualToString:@""]) {
        [self.phoneArray addObject:@"工作"];
        [self.phoneTextArray addObject:self.userModel.phoneWork];
    }
    if (![self.userModel.phoneIphone  isEqualToString:@""]) {
        [self.phoneArray addObject:@"iPhone"];
        [self.phoneTextArray addObject:self.userModel.phoneIphone];
    }
    
    if (![self.userModel.phoneMove  isEqualToString:@""]) {
        [self.phoneArray addObject:@"手机"];
        [self.phoneTextArray addObject:self.userModel.phoneMove];
    }
    
    
    //电子邮件
    if (![self.userModel.emailHouse  isEqualToString:@""]) {
        [self.emailArray addObject:@"住宅"];
        [self.emailTextArray addObject:self.userModel.emailHouse];
    }
    if (![self.userModel.emailWork  isEqualToString:@""]) {
        [self.emailArray addObject:@"工作"];
        [self.emailTextArray addObject:self.userModel.emailWork];
    }
    if (![self.userModel.emailIcloud  isEqualToString:@""]) {
        [self.emailArray addObject:@"iCloud"];
        [self.emailTextArray addObject:self.userModel.emailIcloud];
    }
    if (![self.userModel.phoneMove  isEqualToString:@""]) {
        [self.emailArray addObject:@"手机"];
        [self.emailTextArray addObject:self.userModel.phoneMove];
    }
    
    ///url
    
    if (![self.userModel.urlHome  isEqualToString:@""]) {
        [self.URLArray addObject:@"首页"];
        [self.URLTextArray addObject:self.userModel.urlHome];
    }
    if (![self.userModel.urlHouse  isEqualToString:@""]) {
        [self.URLArray addObject:@"住宅"];
        [self.URLTextArray addObject:self.userModel.urlHouse];
    }
    if (![self.userModel.urlWork  isEqualToString:@""]) {
        [self.URLArray addObject:@"工作"];
        [self.URLTextArray addObject:self.userModel.urlWork];
    }
    
    //地址
    if (![self.userModel.address  isEqualToString:@""]) {
        [self.addressArray addObject:@"地址"];
        [self.addressTextArray addObject:self.userModel.address];
    }
    
    //生日
    if (![self.userModel.birthday  isEqualToString:@""]) {
        [self.birthdayArray addObject:@"生日"];
        [self.birthdayTextArray addObject:self.userModel.birthday];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        AlertContactFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"alertContactFirstCell"];
        
        cell.familyNameTextField.text  = self.userModel.family;
        cell.nameTextField.text = self.userModel.name;
        cell.companyTextField.text = self.userModel.company;
        
        cell.familyNameTextField.tag = 11;
        cell.nameTextField.tag = 12;
        cell.companyTextField.tag = 13;
        return cell;
    }
    else if(indexPath.section == 1){    //添加电话
        if (indexPath.row == self.phoneArray.count) {
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            cell.textLabel.text = @"添加电话";
            return cell;
        }else{
            AlertContactSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"alertContactSecondCell"];
            cell.alertTitleLabel.text = [self.phoneArray objectAtIndex:indexPath.row];
            if (indexPath.row < self.phoneTextArray.count) {
                cell.alertContentTextField.text = [self.phoneTextArray objectAtIndex:indexPath.row];
            }else{
                cell.alertContentTextField.text = @"";
            }

            cell.alertContentTextField.tag = (indexPath.section+1)*10+(indexPath.row+1);
            return cell;
        }
    }
    else if(indexPath.section == 2){    //添加电子邮件
        if (indexPath.row == self.emailArray.count) {
            UITableViewCell *cell = [UITableViewCell new];
            cell.textLabel.text = @"添加电子邮件";
            return cell;
        }
        else{
            AlertContactSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"alertContactSecondCell"];
            cell.alertTitleLabel.text = [self.emailArray objectAtIndex:indexPath.row];
            if (indexPath.row < self.emailTextArray.count) {
                cell.alertContentTextField.text = [self.emailTextArray objectAtIndex:indexPath.row];
            }else{
                cell.alertContentTextField.text = @"";
            }
            cell.alertContentTextField.tag = (indexPath.section+1)*10+(indexPath.row+1);
            return cell;
        }
    }
    else if(indexPath.section == 3){    //添加URL
        if (indexPath.row == self.URLArray.count) {
            UITableViewCell *cell = [UITableViewCell new];
            cell.textLabel.text = @"添加URL";
            return cell;
        }
        else{
            AlertContactSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"alertContactSecondCell"];
            cell.alertTitleLabel.text = [self.URLArray objectAtIndex:indexPath.row];
            if (indexPath.row < self.URLTextArray.count) {
                cell.alertContentTextField.text = [self.URLTextArray objectAtIndex:indexPath.row];
            }else{
                cell.alertContentTextField.text = @"";
            }

            cell.alertContentTextField.tag = (indexPath.section+1)*10+(indexPath.row+1);
            return cell;        }
    }
    else if(indexPath.section == 4){    //添加地址
        if (indexPath.row == self.addressArray.count) {
            UITableViewCell *cell = [UITableViewCell new];
            cell.textLabel.text = @"添加地址";
            return cell;
        }
        else{
            AlertContactSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"alertContactSecondCell"];
            cell.alertTitleLabel.text = [self.addressArray objectAtIndex:indexPath.row];
            if (indexPath.row < self.addressTextArray.count) {
                cell.alertContentTextField.text = [self.addressTextArray objectAtIndex:indexPath.row];
            }else{
                cell.alertContentTextField.text = @"";
            }
            
            cell.alertContentTextField.tag = (indexPath.section+1)*10+(indexPath.row+1);
            return cell;
        }
    }
    else if(indexPath.section == 5){    //添加生日
        if (indexPath.row == self.birthdayArray.count) {
            UITableViewCell *cell = [UITableViewCell new];
            cell.textLabel.text = @"添加生日";
            return cell;
        }
        else{
            AlertContactSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"alertContactSecondCell"];
            cell.alertTitleLabel.text = [self.birthdayArray objectAtIndex:indexPath.row];
            if (indexPath.row < self.birthdayTextArray.count) {
                cell.alertContentTextField.text = [self.birthdayTextArray objectAtIndex:indexPath.row];
            }else{
                cell.alertContentTextField.text = @"";
            }

            cell.alertContentTextField.tag = (indexPath.section+1)*10+(indexPath.row+1);
            return cell;
        }
    }
    else if(indexPath.section == 6){
        AlertContactThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"alertContactThirdCell"];
        [cell.deleteContactButton addTarget:self action:@selector(deleteContact) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else{
        return [UITableViewCell new];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowNums = 0;
    switch (section) {
        case 0:
            rowNums = 1;
            break;
        case 1: //电话
            rowNums = self.phoneArray.count+1;
            break;
        case 2: //电子邮件
            rowNums = self.emailArray.count + 1;
            break;
        case 3: //URL
            rowNums = self.URLArray.count + 1;
            break;
        case 4: //地址
            rowNums = self.addressArray.count + 1;
            break;
        case 5: //生日
            rowNums = self.birthdayArray.count + 1;
            break;
        case 6:
            rowNums = 1;
            break;
        default:
            rowNums = 0;
            break;
    }
    return rowNums;
}

//设置表视图的节数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

#pragma mark - 表视图委托方法
//设定单元格的高度，否则默认的都是44px高
- (double)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 140;
    }else{
        return 44;
    }
}
//设置节尾的高度
- (double)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}
//处理行选择事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//设置表视图进入编辑状态
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.alertContactTableView setEditing:editing animated:YES];
    
}
//设置表视图编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return UITableViewCellEditingStyleNone;
    }
    else if (indexPath.section == 1) {       //电话
        if (indexPath.row == self.phoneArray.count) {
            return UITableViewCellEditingStyleInsert;
        }else{
            return UITableViewCellEditingStyleDelete;
        }
    }
    else if(indexPath.section == 2){    //电子邮件
        if (indexPath.row == self.emailArray.count) {
            return UITableViewCellEditingStyleInsert;
        }else{
            return UITableViewCellEditingStyleDelete;
        }
    }
    else if (indexPath.section == 3){   //URL
        if (indexPath.row == self.URLArray.count) {
            return UITableViewCellEditingStyleInsert;
        }else{
            return UITableViewCellEditingStyleDelete;
        }
    }
    else if(indexPath.section == 4){    //地址
        if (indexPath.row == self.addressArray.count) {
            return UITableViewCellEditingStyleInsert;
        }else{
            return UITableViewCellEditingStyleDelete;
        }
    }
    else if(indexPath.section == 5){    //生日
        if (indexPath.row == self.birthdayArray.count) {
            return UITableViewCellEditingStyleInsert;
        }else{
            return UITableViewCellEditingStyleDelete;
        }
    }
    else{
        return UITableViewCellEditingStyleNone;
    }
    
}
//表
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//实现插入和删除处理
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //电话：住宅、工作、iPhone、手机
    if (indexPath.section == 1) {
        
        if(indexPath.row <= 3){             //限制子单元格的数目
            if (editingStyle == UITableViewCellEditingStyleDelete) {
                [self.phoneArray removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [tableView reloadData];
            }
            else if(editingStyle == UITableViewCellEditingStyleInsert){
                if (indexPath.row == 0) {
//                    [self.phoneArray addObject:@"住宅"];
                    [self.phoneArray insertObject:@"住宅" atIndex:[self.phoneArray count]];
                }
                else if(indexPath.row == 1){
                    [self.phoneArray insertObject:@"工作" atIndex:[self.phoneArray count]];
                }
                else if(indexPath.row == 2){
                    [self.phoneArray insertObject:@"iPhone" atIndex:[self.phoneArray count]];
                }
                else if(indexPath.row == 3){
                    [self.phoneArray insertObject:@"手机" atIndex:[self.phoneArray count]];
                }
                [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [tableView reloadData];
            }
        }
        
    }
    else if (indexPath.section == 2){   //电子邮件
        if (indexPath.row <= 3) {
            if (editingStyle == UITableViewCellEditingStyleDelete) {
                [self.emailArray removeObjectAtIndex:indexPath.row];
                
                [self.alertContactTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.alertContactTableView reloadData];
                
            }
            else if(editingStyle == UITableViewCellEditingStyleInsert){
                if (indexPath.row == 0) {
                    [self.emailArray insertObject:@"住宅" atIndex:[self.emailArray count]];
                }
                else if(indexPath.row == 1){
                    [self.emailArray insertObject:@"工作" atIndex:[self.emailArray count]];
                }
                else if(indexPath.row == 2){
                    [self.emailArray insertObject:@"iCloud" atIndex:[self.emailArray count]];
                }
                else if(indexPath.row == 3){
                    [self.emailArray insertObject:@"手机" atIndex:[self.emailArray count]];
                }
                [self.alertContactTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.alertContactTableView reloadData];
            }
        }
    }
    else if (indexPath.section == 3){   //URL
        if (indexPath.row <= 2) {
            if (editingStyle == UITableViewCellEditingStyleDelete) {
                [self.URLArray removeObjectAtIndex:indexPath.row];
                [self.alertContactTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.alertContactTableView reloadData];
                
            }
            else if(editingStyle == UITableViewCellEditingStyleInsert){
                if (indexPath.row == 0) {
                    [self.URLArray insertObject:@"首页" atIndex:[self.URLArray count]];
                }
                else if(indexPath.row == 1){
                    [self.URLArray insertObject:@"住宅" atIndex:[self.URLArray count]];
                }
                else if(indexPath.row == 2){
                    [self.URLArray insertObject:@"工作" atIndex:[self.URLArray count]];
                }
                [self.alertContactTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.alertContactTableView reloadData];
            }
        }
    }
    else if (indexPath.section == 4){   //地址
        if(indexPath.row <= 0){
            if (editingStyle == UITableViewCellEditingStyleDelete) {
                [self.addressArray removeObjectAtIndex:indexPath.row];
                [self.alertContactTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.alertContactTableView reloadData];
                
            }
            else if(editingStyle == UITableViewCellEditingStyleInsert){
                [self.addressArray insertObject:@"地址" atIndex:[self.addressArray count]];
                [self.alertContactTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.alertContactTableView reloadData];
            }
        }
        
    }
    else if (indexPath.section == 5){   //生日
        if(indexPath.row <= 0){
            if (editingStyle == UITableViewCellEditingStyleDelete) {
                [self.birthdayArray removeObjectAtIndex:indexPath.row];
                [self.alertContactTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.alertContactTableView reloadData];
                
            }
            else if(editingStyle == UITableViewCellEditingStyleInsert){
                [self.birthdayArray insertObject:@"生日" atIndex:[self.birthdayArray count]];
                [self.alertContactTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.alertContactTableView reloadData];
            }
        }
    }
}



#pragma mark - 取消新建联系人
- (void)cancelCreateContact
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewScene"];
    [self.splitViewController showDetailViewController:detail sender:nil];
    
    
}
#pragma mark - 新建联系人
- (void)saveCreateContact:(UIBarButtonItem *)sender
{
    
    
    //姓氏
    UITextField *familyTextField =(UITextField *)[self.alertContactTableView viewWithTag:11];
    if ([self.alertContactTableView viewWithTag:11] != nil) {
        self.familyText = familyTextField.text;
    }else{
        self.familyText = @"";
    }
    //名字
    UITextField *nameTextField =(UITextField *)[self.alertContactTableView viewWithTag:12];
    if ([self.alertContactTableView viewWithTag:12] != nil) {
        self.nameText = nameTextField.text;
    }else{
        self.nameText = @"";
    }
    //姓氏
    UITextField *companyTextField =(UITextField *)[self.alertContactTableView viewWithTag:13];
    if ([self.alertContactTableView viewWithTag:13] != nil) {
        self.companyText = companyTextField.text;
    }else{
        self.companyText = @"";
    }
    
    ///添加电话
    //姓氏
    UITextField *phoneHomeTextTextField =(UITextField *)[self.alertContactTableView viewWithTag:21];
    if ([self.alertContactTableView viewWithTag:21] != nil) {
        self.phoneHomeText = phoneHomeTextTextField.text;
    }else{
        self.phoneHomeText = @"";
    }
    
    //工作电话
    UITextField *phoneWorkTextTextField =(UITextField *)[self.alertContactTableView viewWithTag:22];
    if ([self.alertContactTableView viewWithTag:22] != nil) {
        self.phoneWorkText = phoneWorkTextTextField.text;
    }else{
        self.phoneWorkText = @"";
    }
    //iPhone电话
    UITextField *phoneIphoneTextTextTextField =(UITextField *)[self.alertContactTableView viewWithTag:23];
    if ([self.alertContactTableView viewWithTag:23] != nil) {
        self.phoneIphoneText = phoneIphoneTextTextTextField.text;
    }else{
        self.phoneIphoneText = @"";
    }
    //手机电话
    UITextField *phoneMoveTextTextTextField =(UITextField *)[self.alertContactTableView viewWithTag:24];
    if ([self.alertContactTableView viewWithTag:24] != nil) {
        self.phoneMoveText = phoneMoveTextTextTextField.text;
    }else{
        self.phoneMoveText = @"";
    }
    
    
    ///添加电子邮件
    //住宅
    UITextField *emailHomeTextTextField =(UITextField *)[self.alertContactTableView viewWithTag:31];
    if ([self.alertContactTableView viewWithTag:31] != nil) {
        self.emailHomeText = emailHomeTextTextField.text;
    }else{
        self.emailHomeText = @"";
    }
    //工作
    UITextField *emailWorkTextTextField =(UITextField *)[self.alertContactTableView viewWithTag:32];
    if ([self.alertContactTableView viewWithTag:32] != nil) {
        self.emailWorkText = emailWorkTextTextField.text;
    }else{
        self.emailWorkText = @"";
    }
    //iCloud
    UITextField *emailIcloudTextTextField =(UITextField *)[self.alertContactTableView viewWithTag:33];
    if ([self.alertContactTableView viewWithTag:33] != nil) {
        self.emailIcloudText = emailIcloudTextTextField.text;
    }else{
        self.emailIcloudText = @"";
    }
    //手机
    UITextField *emailMoveTextTextField =(UITextField *)[self.alertContactTableView viewWithTag:34];
    if ([self.alertContactTableView viewWithTag:34] != nil) {
        self.emailMoveText = emailMoveTextTextField.text;
    }else{
        self.emailMoveText = @"";
    }
    
    ///添加URL
    //首页
    UITextField *urlHomeTextTextField =(UITextField *)[self.alertContactTableView viewWithTag:41];
    if ([self.alertContactTableView viewWithTag:41] != nil) {
        self.urlHomeText = urlHomeTextTextField.text;
    }else{
        self.urlHomeText = @"";
    }
    //住宅URL
    UITextField *urlHouseTextTextField =(UITextField *)[self.alertContactTableView viewWithTag:42];
    if ([self.alertContactTableView viewWithTag:42] != nil) {
        self.urlHouseText = urlHouseTextTextField.text;
    }else{
        self.urlHouseText = @"";
    }
    //工作URL
    UITextField *urlWorkTextTextField =(UITextField *)[self.alertContactTableView viewWithTag:43];
    if ([self.alertContactTableView viewWithTag:43] != nil) {
        self.urlWorkText = urlWorkTextTextField.text;
    }else{
        self.urlWorkText = @"";
    }
    
    ///地址
    UITextField *addressTextTextField =(UITextField *)[self.alertContactTableView viewWithTag:51];
    if ([self.alertContactTableView viewWithTag:51] != nil) {
        self.addressText = addressTextTextField.text;
    }else{
        self.addressText = @"";
    }
    
    ///生日
    UITextField *birthdayTextTextField =(UITextField *)[self.alertContactTableView viewWithTag:61];
    if ([self.alertContactTableView viewWithTag:61] != nil) {
        self.birthdayText = birthdayTextTextField.text;
    }else{
        self.birthdayText = @"";
    }
    
    BOOL temp = [[[DatabaseUsage alloc] init] updateDataWithFamily:self.familyText name:self.nameText company:self.companyText phoneHouse:self.phoneHomeText phoneWork:self.phoneWorkText phoneIphone:self.phoneIphoneText phoneMove:self.phoneMoveText emailHouse:self.emailHomeText emailWork:self.emailWorkText emailIcloud:self.emailIcloudText emailMove:self.emailMoveText urlHome:self.urlHomeText urlHouse:self.urlHouseText urlWork:self.urlWorkText address:self.addressText birthday:self.birthdayText userId:self.userId];
//    BOOL temp = [[[DatabaseUsage alloc] init] insertDataWithFamily:self.familyText name:self.nameText company:self.companyText phoneHouse:self.phoneHomeText phoneWork:self.phoneWorkText phoneIphone:self.phoneIphoneText phoneMove:self.phoneMoveText emailHouse:self.emailHomeText emailWork:self.emailWorkText emailIcloud:self.emailIcloudText emailMove:self.phoneMoveText urlHome:self.urlHomeText urlHouse:self.urlHouseText urlWork:self.urlWorkText address:self.addressText birthday:self.birthdayText];
    if (temp) {
        
        //在详细视图控制器使用如下代码获得主视图控制器
        MasterViewController *master = (MasterViewController *)[[[self.splitViewController viewControllers] objectAtIndex:0] topViewController];
        
        [master getDataList];
        
        
        [self cancelCreateContact];
    }else{
        NSLog(@"更新联系人失败");
    }
    
    
    
    
}

- (void)deleteContact
{
    BOOL temp = [[[DatabaseUsage alloc] init] deletContact:self.userId];
    if (temp) {
        
        //在详细视图控制器使用如下代码获得主视图控制器
        MasterViewController *master = (MasterViewController *)[[[self.splitViewController viewControllers] objectAtIndex:0] topViewController];
        
        [master getDataList];
        
        
        [self cancelCreateContact];
    }else{
        NSLog(@"删除联系人失败");
    }
}

#pragma mark - 文本框委托方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
