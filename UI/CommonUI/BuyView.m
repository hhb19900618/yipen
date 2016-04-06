//
//  BuyView.m
//  panjing
//
//  Created by 华斌 胡 on 16/3/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BuyView.h"

@implementation BuyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
    
}

-(id)init{
    self=[super init];
    if (self) {
        
    }[self initView];
    return self;
}
-(void)initView{
    self.negotiateBtn=[[UIButton alloc] init];
    float offx=10;
     float offy=5;
    self.buyBtn=[[UIButton alloc] init];
    [self addSubview:_negotiateBtn];
    [self addSubview:_buyBtn];
    float width=(SCREEN_WIDTH/320.f)*100;
    [_negotiateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(offx);
        make.top.offset(offy);
        make.height.offset(35);
        make.width.offset(width);
        
        
    }];
    [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(width+offx+offx);
        make.top.offset(offy);
        make.height.offset(35);
         make.right.offset(-offx);
        
        
    }];
    [_negotiateBtn setTitle:@"议 价" forState:UIControlStateNormal];
    _negotiateBtn.backgroundColor=[UIColor darkGrayColor];
    [_negotiateBtn setTitleColor:WHITEColor forState:UIControlStateNormal];
    _negotiateBtn.layer.cornerRadius=5;
    _negotiateBtn.clipsToBounds=YES;
    [_buyBtn setTitle:@"购 买" forState:UIControlStateNormal];
    _buyBtn.backgroundColor=RedColor;
      [_buyBtn setTitleColor:WHITEColor forState:UIControlStateNormal];
    _buyBtn.layer.cornerRadius=5;
    _buyBtn.clipsToBounds=YES;
}

@end
