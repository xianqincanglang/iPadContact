//
//  CreateContactFirstCell.m
//  iPadTXL
//
//  Created by marchsoft on 15/9/24.
//  Copyright © 2015年 chentianyu. All rights reserved.
//

#import "CreateContactFirstCell.h"

@implementation CreateContactFirstCell

- (void)awakeFromNib {
    // Initialization code
    
    //设置头像圆角
    self.headImage.layer.cornerRadius = self.headImage.frame.size.width/2;
    self.headImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
