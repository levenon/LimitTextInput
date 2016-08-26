//
//  NSDate+Categories
//  XLFCommonKit
//
//  Created by Marike Jave on 14-8-28.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//

#import "NSDate+Categories.h"
#import "XLFConstants.h"

XLFLoadCategory(NSDate_Categories)

#define kDEFAULT_DATE_TIME_FORMAT (@"yyyy-MM-dd")

@implementation NSDate(Categories)

- (NSString *)normalizeDateString{

    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [gregorian components:unitFlags fromDate:self toDate:[NSDate date] options:0];

    if ([components day] >= 14) {

        return [self dateStringWithFormat:@"yyyy-MM-dd"];
    }
    else if([components day] >= 7) {

        return @"上周";
    }
    else if([components day] == 6) {

        return @"6天前";
    }
    else if([components day] == 5) {

        return @"5天前";
    }
    else if([components day] == 4) {

        return @"4天前";
    }
    else if([components day] == 3) {

        return @"3天前";
    }
    else if([components day] >= 2) {

        return @"前天";
    }
    else if([components day] >= 1) {

        return @"昨天";
    }
    else {
        return @"今天";
    }
}

- (NSString *)normalizeDateTimeString;{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [gregorian components:unitFlags fromDate:self toDate:[NSDate date] options:0];
    
    if ([components day] >= 14) {
        
        return [self dateStringWithFormat:@"yyyy-MM-dd HH:mm"];
    }
    else if([components day] >= 7) {
        
        return @"上周";
    }
    else if([components day] == 6) {
        
        return @"6天前";
    }
    else if([components day] == 5) {
        
        return @"5天前";
    }
    else if([components day] == 4) {
        
        return @"4天前";
    }
    else if([components day] == 3) {
        
        return @"3天前";
    }
    else if([components day] >= 2) {
        
        return @"前天";
    }
    else if([components day] >= 1) {
        
        return @"昨天";
    }
    else if([components hour] > 0) {
        
        return [NSString stringWithFormat:@"%ld小时前", (long)[components hour]];
    }
    else if([components minute] > 0) {
        
        return [NSString stringWithFormat:@"%ld分钟前", (long)[components minute]];
    }
//    else if([components second] > 0) {
//        
//        return [NSString stringWithFormat:@"%ld秒前", (long)[components second]];
//    }
    else {
        return @"刚刚";
    }
}

+ (NSDate *)clockDate:(NSInteger)clock{

    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *todayComponents = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit) fromDate:[NSDate date]];
    [todayComponents setHour:clock];
    NSDate *theDate = [gregorian dateFromComponents:todayComponents];
    return theDate;
}

#pragma  mark - 日期格式处理

#define DAYSECENDS 86400.0

- (NSString *)dateConvertToFriendlyString{

    NSDate * currentDate=[NSDate date];
    NSCalendar *cal=[NSCalendar currentCalendar];
    NSUInteger unitFlags=kCFCalendarUnitMinute|kCFCalendarUnitHour|NSWeekdayCalendarUnit|NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;

    NSDateComponents * currentConponent= [cal components:unitFlags fromDate:currentDate];
    NSDateComponents * oldConponent = [cal components:unitFlags fromDate:self];

    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];

    NSInteger oldWeekday = [oldConponent weekday];
    NSInteger currentWeekday = [currentConponent weekday];

    NSString *week = @"";
    //NSString *weekday;
    NSInteger spanDays = (NSInteger)(([currentDate timeIntervalSince1970] - [self timeIntervalSince1970])/DAYSECENDS);

    NSString * nsDateString;
    switch (oldWeekday) {

        case 1:
            week = @"星期天";
            //weekday = @"Sunday";
            break;
        case 2:
            week = @"星期一";
            // weekday = @"Monday";
            break;
        case 3:
            week = @"星期二";
            //weekday = @"Tuesday";
            break;
        case 4:
            week = @"星期三";
            // weekday = @"Wednesday";
            break;
        case 5:
            week = @"星期四";
            //weekday = @"Thursday";
            break;
        case 6:
            week = @"星期五";
            //weekday = @"Friday";
            break;
        case 7:
            week = @"星期六";
            //weekday = @"Saturday";
            break;
        default:
            break;
    }

    [outputFormatter setDateFormat:@"HH:mm"];
    NSString *newDateString = [outputFormatter stringFromDate:self];

    if (spanDays == 0) {

        nsDateString = [NSString stringWithFormat:@"%@",newDateString];
    }
    else if (spanDays  == 1) {

        nsDateString = [NSString stringWithFormat:@"昨天 %@",newDateString];
    }
    else if (( 1 < spanDays ) &&  (spanDays < 7)) {

        NSInteger newCurrentWeekday = currentWeekday == 1 ? 8 : currentWeekday;
        NSInteger newOldWeekday = oldWeekday == 1 ? 8 : oldWeekday;

        if (newCurrentWeekday <= newOldWeekday) {

            [outputFormatter setDateFormat:@"MM月dd日"];
            nsDateString = [NSString stringWithFormat:@"%@ %@ %@",[outputFormatter stringFromDate:self],week,newDateString];//处理结果，  星期一、上星期二
        }else{

            nsDateString = [NSString stringWithFormat:@"%@ %@",week,newDateString];
        }
    }
    else{

        [outputFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
        nsDateString = [outputFormatter stringFromDate:self];
    }

    return nsDateString;
}

+(NSDate *)dateFromString:(NSString *)string format:(NSString *)format{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:string];

    return date;
}

- (NSString*)dateStringWithFormat:(NSString *)format{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

@end

@implementation NSDate (TimeInterval)

+ (NSTimeInterval)timeIntervalFromDateComponents:(NSDateComponents*)dateComponents;{
    
    return [[[NSCalendar currentCalendar] dateFromComponents:dateComponents] timeIntervalSince1970];
}

+ (NSDateComponents *)componetsWithTimeInterval:(NSTimeInterval)timeInterval{

    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] initWithTimeInterval:timeInterval sinceDate:date1];

    unsigned int unitFlags =
    NSSecondCalendarUnit | NSMinuteCalendarUnit | NSHourCalendarUnit |
    NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;

    return [calendar components:unitFlags
                       fromDate:date1
                         toDate:date2
                        options:0];
}

+ (NSString *)timeDescriptionOfTimeInterval:(NSTimeInterval)timeInterval{

    NSDateComponents *components = [self.class componetsWithTimeInterval:timeInterval];
    NSInteger roundedSeconds = lround(timeInterval - (components.hour * 60) - (components.minute * 60 * 60));

    if (components.hour > 0) {

        return [NSString stringWithFormat:@"%ld:%02ld:%02ld", (long)components.hour, (long)components.minute, (long)roundedSeconds];
    }

    else {

        return [NSString stringWithFormat:@"%ld:%02ld", (long)components.minute, (long)roundedSeconds];
    }
}

@end
