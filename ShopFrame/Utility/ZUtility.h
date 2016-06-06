//
//  ZUtility.h
//  ShopFrame
//
//  Created by 赵瑞生 on 16/5/25.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZUtility : NSObject

+ (CGFloat)heightForLabelWithText:(NSString *)text isWidth:(CGFloat)isWith isTextFont:(CGFloat)isTextFont;
/**
 *  根据label中文字和宽度，计算高度(粗体)
 */
+ (CGFloat)heightForLabelWithText:(NSString *)text isWidth:(CGFloat)isWith isBlodTextFont:(CGFloat)isTextFont;

/**
 *  根据label中文字和高度，计算宽度
 */
+ (CGFloat)widthForLableHeightText:(NSString *)text isHeight:(CGFloat)isHeight isTextFont:(CGFloat)isTextFont;

/**
 *  根据label中文字和高度，计算宽度（uifont）
 */
+ (CGFloat)widthForLableHeightText:(NSString *)text isHeight:(CGFloat)isHeight isFont:(UIFont *)font;

/** 将16进制的色值转成对应的颜色 */
+ (UIColor *)colorForHex:(NSString *)hexColor;
/** color转image */
+ (UIImage*) createImageWithColor: (UIColor*) color;
/** string转Json */
+(id)jsonForString:(NSString*)string;
/** json二进制转换成字符串 */
+(NSString*)stringForJsonData:(id)data;

/** 获得view的MaxY */
+(CGFloat)getEndYForView:(UIView*)view;
/** 获得view的MaxX */
+(CGFloat)getEndXForView:(UIView*)view;
/** 拼接图片路径 */
+(NSString*)getImagePath:(NSString*)subPath;
/** 把NSDate转化成距离1970多少秒 单位是秒数 */
+ (NSString*)timestampFromDate:(NSDate*)date;
/** 把系统返回的距离1970多少秒转化成时间 单位是秒数 */
+ (NSDate*)dateFromTimestamp:(NSString*)timestamp;
/** 把系统返回的秒数转化成格式化时间字符串 默认为yyyy-MM-dd */
+ (NSString*)formatedDateStringWithTimestamp:(NSString*)timestamp;
/** 把系统返回的秒数根据格式转化成格式化时间字符串 */
+ (NSString*)formatedDateStringWithTimestamp:(NSString*)timestamp
                                      format:(NSString*)format;
/** 把时间转化成毫秒数 */
+ (NSString*)timestampFromDateforAndroid:(NSDate*)date;
/** 毫秒数转化成时间 */
+ (NSDate*)dateFromTimestampForAndroid:(NSString*)timestamp;

+ (NSString*)formatedDateStringWithTimestampForAndroid:(NSString*)timestamp
                                                format:(NSString*)format;
+(NSString*)orderTypeWithStatus:(NSString*)type;

+(void)pushOrderListWithNav:(UINavigationController*)nav type:(NSString*)type;

+(void)pushBillListWithNav:(UINavigationController *)nav type:(NSString *)type;

+(void)showLoadingWithTitle:(NSString*)title;

+(void)hiddenLoadingView;

+(void)showPayAlertWithTitle:(NSString*)title;

+(void)hiddenPayAlertView;

+(void)pushCustomerServicesViewWithNav:(UINavigationController*)nav delegate:(id)delegate;




#pragma mark -利用runtime实现任意界面跳转
/**
 *  利用runtime实现任意界面跳转
 */
+ (void)runtimePush:(NSString *)vcName dic:(NSDictionary *)dic nav:(UINavigationController *)nav;
/**
 *  检测对象是否存在该属性
 */
+ (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName;
@end
