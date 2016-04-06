//
//  AttentionTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/19.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "AttentionTableViewCell.h"

@implementation AttentionTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.attentionBtn.clipsToBounds=YES;
    self.attentionBtn.layer.cornerRadius=3;
    self.headIV.layer.cornerRadius=55/2.f;
    self.headIV.clipsToBounds=YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setInfo:(YPUserInfo *)info{
    _info=info;
    [_headIV sd_setImageWithURL:[NSURL URLWithString:info.UserHeader] placeholderImage:Default_Image];
    _nickNameL.text=info.NickName;
    if ([info.IsFocus boolValue]) {
        [_attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
        
    }
    else{
        [_attentionBtn setTitle:@"+关注" forState:UIControlStateNormal];
    }
    [_levelIV setImage:[UIImage imageNamed:[NSString stringWithFormat:@"lv%@",info.Levels]]];
    
}
@end
