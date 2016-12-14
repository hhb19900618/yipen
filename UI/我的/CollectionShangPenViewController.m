//
//  CollectionShangPenViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/7/4.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "CollectionShangPenViewController.h"
#import "CollectionPenJingCell.h"
#import "FenXiangDetailViewController.h"
@interface CollectionShangPenViewController ()<UITableViewDataSource,UITableViewDelegate>{
   NSInteger currentPage;
    UITableView *myTable;
}
@property(nonatomic,strong)NSMutableArray *list;
@end
@implementation CollectionShangPenViewController

static NSInteger pageSie=10;
static NSString *identify=@"identify";
-(void)viewDidLoad{
    [super viewDidLoad];
    [self initTable];
    currentPage=1;
    [self requestData];
    
    
    
}

-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-40) style:UITableViewStyleGrouped];
    [self.view addSubview:myTable];
    myTable.delegate=self;
    myTable.dataSource=self;
    [myTable registerNib:[UINib nibWithNibName:@"CollectionPenJingCell" bundle:nil] forCellReuseIdentifier:identify];
    WS(weakSelf)
    [myTable addLegendHeaderWithRefreshingBlock:^{
        currentPage=1;
        [weakSelf requestData];
    }];
}



-(void)requestData{
    Collect_Type collectType=KCollect_Penjin;
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",[NSNumber numberWithInteger:currentPage],@"Page",[NSNumber numberWithInteger:pageSie],@"PageSize" ,[NSNumber numberWithInteger:collectType],@"Type",nil];
    
    [HttpConnection GetMyCollect:dic WithBlock:^(id response, NSError *error) {
        [SVProgressHUD dismiss];
        [myTable.header endRefreshing];
        [myTable.footer endRefreshing];
        if (!error) {
            if (![response objectForKey:KErrorMsg]) {
                if (currentPage==1) {
                    self.list=response[KDataList];
                }
                else{
                    [self.list addObjectsFromArray:response[KDataList]];
                }
                
                [myTable reloadData];
                currentPage++;
            }
            else{
                
                [SVProgressHUD showInfoWithStatus:[response objectForKey:KErrorMsg]];
            }
        }
        else{
            [SVProgressHUD showInfoWithStatus:ErrorMessage];
        }

    }];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CollectionPenJingCell *cell = [myTable dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    [cell setInfo:_list[indexPath.row]];
    cell.indexPath = indexPath;
    WS(weakSelf)
    [cell setDeleteBlock:^(NSIndexPath *index){
        [weakSelf deleteInfo:index];
    }];
    return cell;
}

-(void)deleteInfo:(NSIndexPath*)indexPath{
    
    [SVProgressHUD show];
    PenJinInfo *info = _list[indexPath.row];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",info.ID,@"BeID",@"1",@"Type", nil];
    [HttpConnection DelCollect:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([response[@"ok"] boolValue]) {
                info.IsCollect = @"0";
                [SVProgressHUD showSuccessWithStatus:@"已取消收藏"];
                [_list removeObjectAtIndex:indexPath.row];
                [myTable reloadData];
            }
            else{
                [SVProgressHUD showErrorWithStatus:response[@"reason"]];
            }
            
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"取消失败"];
        }

        
    }];

    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _list.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [myTable deselectRowAtIndexPath:indexPath animated:NO];
    FenXiangDetailViewController *ctr=[[FenXiangDetailViewController alloc] init];
    ctr.info=_list[indexPath.row];
//    [self hideTabBar:YES animated:NO];
    
    [self.navigationController pushViewController:ctr animated:YES];
}

@end
