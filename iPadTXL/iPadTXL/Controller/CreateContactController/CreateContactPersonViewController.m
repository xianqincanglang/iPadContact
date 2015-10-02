//
//  CreateContactPersonViewController.m
//  iPadTXL
//
//  Created by marchsoft on 15/9/24.
//  Copyright © 2015年 chentianyu. All rights reserved.
//

#import "CreateContactPersonViewController.h"
#import "CreateContactFirstCell.h"
#import "CreateContactSecondCell.h"
#import "DatabaseUsage.h"
#import "MasterViewController.h"

@interface CreateContactPersonViewController ()

@end

@implementation CreateContactPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"新建联系人";
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelCreateContact)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(saveCreateContact:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    self.editing = YES;//设置编辑状态
    
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.tableFooterView = [UIView new];
    _myTableView.backgroundColor = [UIColor whiteColor];
    

    _phoneArray = [[NSMutableArray alloc] init];
    _emailArray = [[NSMutableArray alloc] init];
    _URLArray = [[NSMutableArray alloc] init];
    _addressArray = [[NSMutableArray alloc] init];
    _birthdayArray = [[NSMutableArray alloc] init];

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CreateContactFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"createContactFirstCell"];
        

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
            CreateContactSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"createContactSecondCell"];
            cell.createTitleLabel.text = [self.phoneArray objectAtIndex:indexPath.row];
            cell.createContentTextField.tag = (indexPath.section+1)*10+(indexPath.row+1);
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
            CreateContactSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"createContactSecondCell"];
            cell.createTitleLabel.text = [self.emailArray objectAtIndex:indexPath.row];
            cell.createContentTextField.tag = (indexPath.section+1)*10+(indexPath.row+1);
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
            CreateContactSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"createContactSecondCell"];
            cell.createTitleLabel.text = [self.URLArray objectAtIndex:indexPath.row];
            cell.createContentTextField.tag = (indexPath.section+1)*10+(indexPath.row+1);
            return cell;
        }
    }
    else if(indexPath.section == 4){    //添加地址
        if (indexPath.row == self.addressArray.count) {
            UITableViewCell *cell = [UITableViewCell new];
            cell.textLabel.text = @"添加地址";
            return cell;
        }
        else{
            CreateContactSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"createContactSecondCell"];
            cell.createTitleLabel.text = [self.addressArray objectAtIndex:indexPath.row];
            cell.createContentTextField.tag = (indexPath.section+1)*10+(indexPath.row+1);
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
            CreateContactSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"createContactSecondCell"];
            cell.createTitleLabel.text = [self.birthdayArray objectAtIndex:indexPath.row];
            cell.createContentTextField.tag = (indexPath.section+1)*10+(indexPath.row+1);
            return cell;
        }
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
        case 4:
            rowNums = self.addressArray.count + 1;
            break;
        case 5:
            rowNums = self.birthdayArray.count + 1;
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
    return 6;
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
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    return [UIView new];
//}
//处理行选择事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//设置表视图进入编辑状态
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.myTableView setEditing:editing animated:YES];
    
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
                
                [self.myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.myTableView reloadData];
                
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
                [self.myTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.myTableView reloadData];
            }
        }
    }
    else if (indexPath.section == 3){   //URL
        if (indexPath.row <= 2) {
            if (editingStyle == UITableViewCellEditingStyleDelete) {
                [self.URLArray removeObjectAtIndex:indexPath.row];
                [self.myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.myTableView reloadData];
                
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
                [self.myTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.myTableView reloadData];
            }
        }
    }
    else if (indexPath.section == 4){   //地址
        if(indexPath.row <= 0){
            if (editingStyle == UITableViewCellEditingStyleDelete) {
                [self.addressArray removeObjectAtIndex:indexPath.row];
                [self.myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.myTableView reloadData];
                
            }
            else if(editingStyle == UITableViewCellEditingStyleInsert){
                [self.addressArray insertObject:@"地址" atIndex:[self.addressArray count]];
                [self.myTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.myTableView reloadData];
            }
        }
        
    }
    else if (indexPath.section == 5){   //生日
        if(indexPath.row <= 0){
            if (editingStyle == UITableViewCellEditingStyleDelete) {
                [self.birthdayArray removeObjectAtIndex:indexPath.row];
                [self.myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.myTableView reloadData];
                
            }
            else if(editingStyle == UITableViewCellEditingStyleInsert){
                [self.birthdayArray insertObject:@"生日" atIndex:[self.birthdayArray count]];
                [self.myTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.myTableView reloadData];
            }
        }
    }
}

#pragma mark - 取消新建联系人
- (void)cancelCreateContact
{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CreateContactPersonViewController *create = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewScene"];
    
    
    [self.splitViewController showDetailViewController:create sender:nil];
    
    
}

#pragma mark - 新建联系人
- (void)saveCreateContact:(UIBarButtonItem *)sender
{
    

    //姓氏
    UITextField *familyTextField =(UITextField *)[self.myTableView viewWithTag:11];
    if ([self.myTableView viewWithTag:11] != nil) {
        self.familyText = familyTextField.text;
    }else{
        self.familyText = @"";
    }
    //名字
    UITextField *nameTextField =(UITextField *)[self.myTableView viewWithTag:12];
    if ([self.myTableView viewWithTag:12] != nil) {
        self.nameText = nameTextField.text;
    }else{
        self.nameText = @"";
    }
    //姓氏
    UITextField *companyTextField =(UITextField *)[self.myTableView viewWithTag:13];
    if ([self.myTableView viewWithTag:13] != nil) {
        self.companyText = companyTextField.text;
    }else{
        self.companyText = @"";
    }
    
    ///添加电话
    //姓氏
    UITextField *phoneHomeTextTextField =(UITextField *)[self.myTableView viewWithTag:21];
    if ([self.myTableView viewWithTag:21] != nil) {
        self.phoneHomeText = phoneHomeTextTextField.text;
    }else{
        self.phoneHomeText = @"";
    }
    
    //工作电话
    UITextField *phoneWorkTextTextField =(UITextField *)[self.myTableView viewWithTag:22];
    if ([self.myTableView viewWithTag:22] != nil) {
        self.phoneWorkText = phoneWorkTextTextField.text;
    }else{
        self.phoneWorkText = @"";
    }
    //iPhone电话
    UITextField *phoneIphoneTextTextTextField =(UITextField *)[self.myTableView viewWithTag:23];
    if ([self.myTableView viewWithTag:23] != nil) {
        self.phoneIphoneText = phoneIphoneTextTextTextField.text;
    }else{
        self.phoneIphoneText = @"";
    }
    //手机电话
    UITextField *phoneMoveTextTextTextField =(UITextField *)[self.myTableView viewWithTag:24];
    if ([self.myTableView viewWithTag:24] != nil) {
        self.phoneMoveText = phoneMoveTextTextTextField.text;
    }else{
        self.phoneMoveText = @"";
    }
    
    
    ///添加电子邮件
    //住宅
    UITextField *emailHomeTextTextField =(UITextField *)[self.myTableView viewWithTag:31];
    if ([self.myTableView viewWithTag:31] != nil) {
        self.emailHomeText = emailHomeTextTextField.text;
    }else{
        self.emailHomeText = @"";
    }
    //工作
    UITextField *emailWorkTextTextField =(UITextField *)[self.myTableView viewWithTag:32];
    if ([self.myTableView viewWithTag:32] != nil) {
        self.emailWorkText = emailWorkTextTextField.text;
    }else{
        self.emailWorkText = @"";
    }
    //iCloud
    UITextField *emailIcloudTextTextField =(UITextField *)[self.myTableView viewWithTag:33];
    if ([self.myTableView viewWithTag:33] != nil) {
        self.emailIcloudText = emailIcloudTextTextField.text;
    }else{
        self.emailIcloudText = @"";
    }
    //手机
    UITextField *emailMoveTextTextField =(UITextField *)[self.myTableView viewWithTag:34];
    if ([self.myTableView viewWithTag:34] != nil) {
        self.emailMoveText = emailMoveTextTextField.text;
    }else{
        self.emailMoveText = @"";
    }
    
    ///添加URL
    //首页
    UITextField *urlHomeTextTextField =(UITextField *)[self.myTableView viewWithTag:41];
    if ([self.myTableView viewWithTag:41] != nil) {
        self.urlHomeText = urlHomeTextTextField.text;
    }else{
        self.urlHomeText = @"";
    }
    //住宅URL
    UITextField *urlHouseTextTextField =(UITextField *)[self.myTableView viewWithTag:42];
    if ([self.myTableView viewWithTag:42] != nil) {
        self.urlHouseText = urlHouseTextTextField.text;
    }else{
        self.urlHouseText = @"";
    }
    //工作URL
    UITextField *urlWorkTextTextField =(UITextField *)[self.myTableView viewWithTag:43];
    if ([self.myTableView viewWithTag:43] != nil) {
        self.urlWorkText = urlWorkTextTextField.text;
    }else{
        self.urlWorkText = @"";
    }
    
    ///地址
    UITextField *addressTextTextField =(UITextField *)[self.myTableView viewWithTag:51];
    if ([self.myTableView viewWithTag:51] != nil) {
        self.addressText = addressTextTextField.text;
    }else{
        self.addressText = @"";
    }
    
    ///生日
    UITextField *birthdayTextTextField =(UITextField *)[self.myTableView viewWithTag:61];
    if ([self.myTableView viewWithTag:61] != nil) {
        self.birthdayText = birthdayTextTextField.text;
    }else{
        self.birthdayText = @"";
    }
    
    BOOL temp = [[[DatabaseUsage alloc] init] insertDataWithFamily:self.familyText name:self.nameText company:self.companyText phoneHouse:self.phoneHomeText phoneWork:self.phoneWorkText phoneIphone:self.phoneIphoneText phoneMove:self.phoneMoveText emailHouse:self.emailHomeText emailWork:self.emailWorkText emailIcloud:self.emailIcloudText emailMove:self.phoneMoveText urlHome:self.urlHomeText urlHouse:self.urlHouseText urlWork:self.urlWorkText address:self.addressText birthday:self.birthdayText];
    if (temp) {

        //在详细视图控制器使用如下代码获得主视图控制器
        MasterViewController *master = (MasterViewController *)[[[self.splitViewController viewControllers] objectAtIndex:0] topViewController];
        
        [master getDataList];


        [self cancelCreateContact];
    }else{
        NSLog(@"新建联系人失败");
    }
    
    

    
}

#pragma mark - 文本框委托方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end

