//
//  SendActivityTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/24.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "SendActivityTableViewCell.h"

@implementation SendActivityTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.line1.backgroundColor=Line_Color;
    self.line2.backgroundColor=Line_Color;
    self.line3.backgroundColor=Line_Color;
    self.line4.backgroundColor=Line_Color;
    self.line5.backgroundColor=Line_Color;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
