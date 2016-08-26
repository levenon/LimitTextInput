//
//  NSDate+Categories
//  XLFCommonKit
//
//  Created by Marike Jave on 14-8-28.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SECONDES_PER_MINUTE         60

#define SECONDES_PER_HOUR           (SECONDES_PER_MINUTE * 60)

#define SECONDES_PER_DAY            (SECONDES_PER_HOUR * 24)

#define SECONDES_PER_WEEK           (SECONDES_PER_DAY * 7)

#define SECONDES_PER_NORMAL_MONTH   (SECONDES_PER_WEEK * 30)

#define SECONDES_PER_NORMAL_YEAR    (SECONDES_PER_DAY * 365)


@interface NSDate (Categories)

- (NSString *)normalizeDateString;

- (NSString *)normalizeDateTimeString;

+ (NSDate *)clockDate:(NSInteger)clock;

+ (NSDate *)dateFromString:(NSString *)string format:(NSString *)format;

- (NSString *)dateConvertToFriendlyString;

- (NSString *)dateStringWithFormat:(NSString *)format;

@end

@interface NSDate (TimeInterval)

+ (NSTimeInterval)timeIntervalFromDateComponents:(NSDateComponents*)dateComponents;
+ (NSDateComponents *)componetsWithTimeInterval:(NSTimeInterval)timeInterval;
+ (NSString *)timeDescriptionOfTimeInterval:(NSTimeInterval)timeInterval;

@end

