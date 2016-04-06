//
//  CommonFun.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/25.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "CommonFun.h"

@implementation CommonFun

//判断字符是否为空
+(BOOL)isSpaceCharacter:(NSString*)text{
    BOOL isSpace=YES;
    if (text.length&&[[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]) {
        isSpace=NO;
    }
    return isSpace;
    
}

//日期格式时间
+(NSString*)translateDateWithCreateTime:(NSInteger)createTime{
    NSDateFormatter* f=[[NSDateFormatter alloc]init];
//    [f setDateFormat:@"yyyy.MM.dd HH:mm"];
       [f setDateFormat:@"MM-dd HH:mm"];
    NSDate *date=nil;
    NSString *timeStr=[NSString stringWithFormat:@"%ld",createTime];
    if ([timeStr length]>=10) {
        date = [NSDate dateWithTimeIntervalSince1970:[[timeStr substringToIndex:10] longLongValue]];
    }
    else{
        date = [NSDate dateWithTimeIntervalSince1970:[timeStr longLongValue]];
    }
    timeStr=[f  stringFromDate:date];
    return timeStr;
}


//倒计时
+(NSString*)countdown:(long long)lastTime{
    NSString *str=[NSString string];
    long difference= time(NULL)-lastTime;
    NSInteger i= difference/60;//分钟
        if (i<60) {
//            str=[NSString stringWithFormat:@"%ld分钟前",i];
            NSInteger remaining_time=difference%60;
            str=[NSString stringWithFormat:@"%ld分钟前",i];
        }
        else if(i<60*24){
            NSInteger i= difference/60/60;
            str=[NSString stringWithFormat:@"%ld小时前",i];
        }
        else if(i<60*24*30){
            NSInteger i= difference/60/60/24;
            str=[NSString stringWithFormat:@"%ld天前",i];
        }
        else if(i<60*24*30*12){
            NSInteger i= difference/60/60/24/12;
            str=[NSString stringWithFormat:@"%ld个月前",i-1];
        }
        else{
            NSInteger i= difference/60/60/24/12/30;
            str=[NSString stringWithFormat:@"%ld年前",i];
        }
    
    
    return str;
}

//倒计时
+(NSString*)timerFireMethod:(long long)time{
    
//    NSDateFormatter *f1 = [[NSDateFormatter alloc] init];
//    [f1 setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];
//
//    NSDate *theDay=[NSDate dateWithTimeIntervalSince1970:time];
//    NSCalendar *cal = [NSCalendar currentCalendar];//定义一个NSCalendar对象
//    
//    NSDate *today = [NSDate date];//得到当前时间
//    
//    //用来得到具体的时差
//    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:theDay options:0];
//    
//    NSString *countdown = [NSString stringWithFormat:@"%d日%d小时%d分钟%d秒", [d month],[d day], [d hour], [d minute], [d second]];
//    
////    self.timeLabel.text = countdown;
//    NSLog(@"countdown:%@",countdown);
//    return countdown ;
    NSDate *today = [NSDate date];//得到当前时间
//    NSDate*  startDate  = [ [ NSDate alloc] init ];
      NSDate *startDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSGregorianCalendar ];
    NSUInteger unitFlags =
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
    NSDateComponents *cps = [chineseClendar components:unitFlags fromDate:today  toDate: startDate options:0];
    NSInteger diffHour = [cps hour];
    NSInteger diffMin    = [cps minute];
    NSInteger diffSec   = [cps second];
    NSInteger diffDay   = [cps day];
    NSInteger diffMon  = [cps month];
    NSInteger diffYear = [cps year];
//    NSLog(  @" From Now to %@, diff: Years: %d  Months: %d, Days; %d, Hours: %d, Mins:%d, sec:%d",
//          [today description], diffYear, diffMon, diffDay, diffHour, diffMin,diffSec );
    NSString *countdown = [NSString stringWithFormat:@"距离结束: %ld天 %ld小时 %ld分钟 %ld秒   ", diffDay,diffHour, diffMin, diffSec];
    if (diffSec<0) {
        countdown=[NSString stringWithFormat:@"拍卖已结束   "];
    }
    return countdown;

    
}

+(CGSize)sizeWithString:(NSString *)string font:(UIFont *)font size:(CGSize)contentSize
{
    CGRect rect = [string boundingRectWithSize:contentSize//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}

@end