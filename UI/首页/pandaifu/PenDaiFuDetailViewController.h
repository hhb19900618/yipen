//
//  PenDaiFuDetailViewController.h
//  panjing
//
//  Created by 华斌 胡 on 16/4/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"
#import "PenJinInfo.h"
@interface PenDaiFuDetailViewController : BaseViewController{
    UITableView *myTable;
    NSInteger currentPage;
}
@property(nonatomic,strong)PenJinInfo *info;
@property(nonatomic,assign)BOOL isPopKeyBoard;
@end
