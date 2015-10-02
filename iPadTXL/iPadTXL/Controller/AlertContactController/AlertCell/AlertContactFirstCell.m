//
//  AlertContactFirstCell.m
//  iPadTXL
//
//  Created by marchsoft on 15/9/30.
//  Copyright © 2015年 chentianyu. All rights reserved.
//

#import "AlertContactFirstCell.h"

@implementation AlertContactFirstCell

- (void)awakeFromNib {
    // Initialization code
    
    self.headImage.layer.cornerRadius = self.headImage.frame.size.width/2;
    self.headImage.layer.masksToBounds = true;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
