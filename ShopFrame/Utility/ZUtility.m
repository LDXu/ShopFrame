//
//  ZUtility.m
//  ShopFrame
//
//  Created by 赵瑞生 on 16/5/25.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "ZUtility.h"

@implementation ZUtility
#pragma mark - 根据label中文字和宽度,计算出高度
+ (CGFloat)heightForLabelWithText:(NSString *)text isWidth:(CGFloat)isWith isBlodTextFont:(CGFloat)isTextFont
{
    CGFloat height = 0.0f;
    if (CURRENTDEVICEVEISION >= 7.0) {
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:isTextFont]};
        CGSize maxSize = CGSizeMake(AI_SCREEN_WIDTH, CGFLOAT_MAX);
        CGRect rect = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
        return rect.size.height;
    } else {
        
        height = ceil([text sizeWithFont:[UIFont systemFontOfSize:isTextFont] constrainedToSize:CGSizeMake(isWith, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height);
        return height;
        
    }
}
+ (CGFloat)widthForLableHeightText:(NSString *)text isHeight:(CGFloat)isHeight isTextFont:(CGFloat)isTextFont
{
    CGFloat width = 0.0f;
    width = [ZUtility widthForLableHeightText:text isHeight:isHeight isFont:[UIFont systemFontOfSize:isTextFont]];
    
    return width;
}

+ (CGFloat)widthForLableHeightText:(NSString *)text isHeight:(CGFloat)isHeight isFont:(UIFont *)font
{
    CGFloat width = 0.0f;
    if (CURRENTDEVICEVEISION >= 7.0) {
        NSDictionary *attribute = @{NSFontAttributeName: font};
        CGSize maxSize = CGSizeMake(AI_SCREEN_WIDTH, CGFLOAT_MAX);
        CGRect rect = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
        return rect.size.width;
    } else {
        width =  ceil([text sizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, isHeight) lineBreakMode:NSLineBreakByWordWrapping].width);
        return width;
    }
}

+ (UIColor *)colorForHex:(NSString *)hexColor
{
    // String should be 6 or 7 characters if it includes '#'
    if ([hexColor length]  < 6)
        return nil;
    
    // strip # if it appears
    if ([hexColor hasPrefix:@"#"])
        hexColor = [hexColor substringFromIndex:1];
    
    // if the value isn't 6 characters at this point return
    // the color black
    if ([hexColor length] != 6)
        return nil;
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    NSString *rString = [hexColor substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [hexColor substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [hexColor substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
    
}

+ (id)jsonForString:(NSString *)string
{
    return [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
}

+ (NSString *)stringForJsonData:(id)data
{
    return [[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:data options:0 error:NULL] encoding:NSUTF8StringEncoding];
}

+ (CGFloat)getEndYForView:(UIView *)view
{
    return view.frame.size.height+view.frame.origin.y;
}

+ (CGFloat)getEndXForView:(UIView *)view
{
    return view.frame.size.width+view.frame.origin.x;
}

//+ (NSString *)getImagePath:(NSString *)subPath
//{
//    NSString* path=[NSString stringWithFormat:@"%@%@",,subPath];
//    return path;
//}

#pragma mark-NSDate转换
#pragma mark 把NSDate转化成距离1970多少秒 单位是秒数
+ (NSString *)timestampFromDate:(NSDate *)date
{
    NSTimeInterval seconds = [date timeIntervalSince1970];
    return [[NSNumber numberWithInt:seconds] stringValue];
}
#pragma mark 把系统返回的距离1970多少秒转化成时间 单位是秒数
+ (NSDate*)dateFromTimestamp:(NSString*)timestamp
{
    if (!timestamp) {
        return nil;
    }
    return [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];
}
#pragma mark 把系统返回的秒数转化成格式化时间字符串 默认为yyyy-MM-dd
+ (NSString*)formatedDateStringWithTimestamp:(NSString*)timestamp
{
    return [ZUtility formatedDateStringWithTimestamp:timestamp format:@"yyyy-MM-dd"];
    
}
#pragma mark 把系统返回的秒数根据格式转化成格式化时间字符串
+ (NSString*)formatedDateStringWithTimestamp:(NSString*)timestamp
                                      format:(NSString*)format
{
    NSDate *date = [ZUtility dateFromTimestamp:timestamp];
    if (!date) {
        return @"";
    }
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setDateFormat:format];
    
    return [dateFormatter stringFromDate:date];
}
#pragma mark 把时间转化成毫秒数
+ (NSString*)timestampFromDateforAndroid:(NSDate*)date
{
    NSTimeInterval seconds = [date timeIntervalSince1970]*1000;
    return [[NSNumber numberWithInteger:seconds] stringValue];
}
#pragma mark 毫秒数转化成时间
+ (NSDate*)dateFromTimestampForAndroid:(NSString*)timestamp
{
    if (!timestamp) {
        return nil;
    }
    
    DLog(@"%@",timestamp);
    DLog(@"%f",[timestamp doubleValue]/1000);
    
    return [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]/1000];
}
#pragma mark 把毫秒数转化成格式化的时间字符串
+ (NSString*)formatedDateStringWithTimestampForAndroid:(NSString*)timestamp
                                                format:(NSString*)format
{
    NSDate *date = [ZUtility dateFromTimestampForAndroid:timestamp];
    if (!date) {
        return @"";
    }
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setDateFormat:format];
    
    return [dateFormatter stringFromDate:date];
    
}


+ (void)runtimePush:(NSString *)vcName dic:(NSDictionary *)dic nav:(UINavigationController *)nav
{
    NSString *class = vcName;
    
    
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    Class newClass = objc_getClass(className);
    if (!newClass) {
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        //注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    //创建对象
    id instance = [[newClass alloc] init];
    
    //传值
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            DLog(@"%@    %@", obj, key);
            [instance setValue:obj forKey:key];
        } else {
            DLog(@"不包含key=%@的属性", key);
        }
       
        
    }];
    [nav pushViewController:instance animated:YES];
}


+ (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    //获取对象的属性列表
    objc_property_t *properties = class_copyPropertyList([instance class], &outCount);
    
    for ( i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        //属性转换成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        //判断属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    
    //遍历父类中的属性
    Class superClass = class_getSuperclass([instance class]);
    
    //通过下面的方法获取属性列表
    unsigned int outCount2;
    objc_property_t *properties2 = class_copyPropertyList(superClass, &outCount2);
    
    for (int i = 0; i < outCount2; i ++) {
        objc_property_t property2 = properties2[i];
        //属性转化为字符串
        NSString *propertyName2 = [[NSString alloc] initWithCString:property_getName(property2) encoding:NSUTF8StringEncoding];
        //判断属性是否存在
        if ([propertyName2 isEqualToString:verifyPropertyName]) {
            free(properties2);
            return YES;
        }
    }
    free(properties2);//释放数组
    
    return NO;
}

@end
