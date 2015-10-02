//
//  ShowContactFirstCell.m
//  iPadTXL
//
//  Created by marchsoft on 15/9/30.
//  Copyright © 2015年 chentianyu. All rights reserved.
//

#import "ShowContactFirstCell.h"

@implementation ShowContactFirstCell

- (void)awakeFromNib {
    // Initialization code
    
    self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width/2;
    self.headImageView.layer.masksToBounds = true;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
