//
//  SameCitySendTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "CollectionPenJingCell.h"

@implementation CollectionPenJingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setInfo:(PenJinInfo *)info{
    _info=info;
    _titleL.text=info.Title;
    _contentL.text=info.Descript;
    [_headIV sd_setImageWithURL:[NSURL URLWithString:info.userInfo.UserHeader] placeholderImage:Default_Image];
    _nameL.text=info.userInfo.NickName;
    if (info.Attach.count) {
       [_treeIV sd_setImageWithURL:[NSURL URLWithString:info.Attach[0]] placeholderImage:Default_Image];
    }
    _timeL.text=info.Createtime;
    _praiseL.text=[NSString stringWithFormat:@"赞%@",info.PraisedNum];
    _viewL.text=[NSString stringWithFormat:@"浏览%@",info.BrowseNum];
    _commentL.text=[NSString stringWithFormat:@"评论%@",info.CommentsNum ];
    if ([_info.userInfo.RoleType isEqualToString:@"1"]||[_info.userInfo.RoleType isEqualToString:@"2"]) {
        
    }
    else{//未开通
        [_memberIV setHidden:YES];
    }
    if (![_info.userInfo.IsCertifi boolValue]) {
//        [_certificateIV setHidden:YES];
    }
    [_delBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];

}
-(void)layoutSubviews{
    [super layoutSubviews];
//    _headIV.clipsToBounds=YES;
//    _headIV.contentMode=UIViewContentModeScaleAspectFit;
}

-(void)deleteAction:(UIButton*)sender{
    if (_deleteBlock) {
        _deleteBlock(_indexPath);
    }
}

@end
