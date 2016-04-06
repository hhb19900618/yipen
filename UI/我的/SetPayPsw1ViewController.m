//
//  SetPayPsw1ViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "SetPayPsw1ViewController.h"
#import "SetPayPsw2ViewController.h"
@interface SetPayPsw1ViewController ()
@property(nonatomic,strong)NSString *vcode;
@end

@implementation SetPayPsw1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置支付密码";
    self.line.backgroundColor=Line_Color;
    [self.nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    self.codeBtn.clipsToBounds=YES;
    self.codeBtn.layer.cornerRadius=3;
    [self.codeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.codeBtn.layer.borderWidth=1;
    self.codeBtn.layer.borderColor=[UIColor grayColor].CGColor;
    [self.codeBtn addTarget:self action:@selector(getCodeAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.nextBtn.layer.cornerRadius=5;
    self.nextBtn.clipsToBounds=YES;
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)getCodeAction{
    if ([_mobileTF.text length]!=11) {
        [SVProgressHUD showErrorWithStatus:@"输入正确的手机号"];
        return;
    }
    [SVProgressHUD show];
    [self timerAction];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"uid",_mobileTF.text,@"mobile", nil];
    [HttpConnection getCodeOfPayPsw:dic WithBlock:^(id response, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
               [self invalidateTimer];
        }
        else{
            
            if ([[response objectForKey:@"ok"] boolValue]==YES) {
                NSString *vcode=response[@"vcode"];
                self.vcode=vcode;
                [SVProgressHUD showSuccessWithStatus:[response objectForKey:@"reason"]];
                [SVProgressHUD dismiss];
//                [self nextAction];
            }
            else{
                [SVProgressHUD showErrorWithStatus:[response objectForKey:@"reason"]];
                   [self invalidateTimer];
            }
        }
     
    }];
}


-(void)nextAction{
    if ([[NSString stringWithFormat:@"%@",_vcode] isEqualToString:_codeTF.text]&&_vcode) {
        SetPayPsw2ViewController *ctr=[[SetPayPsw2ViewController alloc] initWithNibName:nil bundle:nil];
        ctr.vcode=_vcode;
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else{
        [SVProgressHUD showErrorWithStatus:@"验证码输入有误"];
    }
    
    
}


-(void)timerAction{
    counter=90;
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCounter) userInfo:nil repeats:YES];
    [timer fire];
}

-(void)invalidateTimer{
    [timer invalidate];
    counter=0;
    [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_codeBtn setEnabled:YES];
}

-(void)timerCounter{
    counter--;
    [_codeBtn setEnabled:NO];
    [_codeBtn setTitle:[NSString stringWithFormat:@"%ld秒后重新获得",counter] forState:UIControlStateNormal];
    if (counter<=0) {
        
        [self invalidateTimer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
