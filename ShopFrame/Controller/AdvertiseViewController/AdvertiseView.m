//
//  AdvertiseView.m
//  ShopFrame
//
//  Created by 赵瑞生 on 16/6/3.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "AdvertiseView.h"

@interface AdvertiseView ()

@property (nonatomic, strong) UIImageView *adView;

@property (nonatomic, strong) UIButton *countBtn;

@property (nonatomic, strong) NSTimer *countTimer;

@property (nonatomic, assign) int count;

@end

static int const showTime = 3;

@implementation AdvertiseView

- (NSTimer *)countTimer
{
    if (!_countTimer) {
        _countTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.adView = [[UIImageView alloc] initWithFrame:frame];
        self.adView.userInteractionEnabled = YES;
        self.adView.contentMode = UIViewContentModeScaleAspectFill;
        self.adView.clipsToBounds = YES;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAd)];
        [self.adView addGestureRecognizer:tap];
        CGFloat btnW = 60;
        CGFloat btnH = 30;
        self.countBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.countBtn.frame = CGRectMake(AI_SCREEN_WIDTH - btnW - 24, btnH, btnW, btnH);
        [self.countBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.countBtn setTitle:[NSString stringWithFormat:@"跳过%d", showTime] forState:UIControlStateNormal];
        self.countBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.countBtn.backgroundColor = RGBACOLOR(38, 38, 38, 0.6);
        self.countBtn.layer.cornerRadius = 4;
        
        [self addSubview:self.adView];
        [self addSubview:self.countBtn];
        self.backgroundColor = [UIColor redColor];
        
        
        
        
    }
    return self;
}



- (void)setFilePath:(NSString *)filePath
{
    _filePath = filePath;
    _adView.image = [UIImage imageWithContentsOfFile:filePath];
}

- (void)pushToAd
{
    [self dismiss];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushtoad" object:nil userInfo:nil];
}

- (void)countDown
{
    _count --;
    [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d", _count] forState:UIControlStateNormal];
    if (_count == 0) {
        [self.countTimer invalidate];
        self.countTimer = nil;
        [self dismiss];
        
    }
}

- (void)show
{
    
    // 倒计时方法1：GCD
    //    [self startCoundown];
    
    // 倒计时方法2：定时器
    [self startTimer];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

- (void)startTimer
{
    _count = showTime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}

// GCD倒计时
- (void)startCoundown
{
    __block int timerout = showTime + 1;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);//每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (timerout <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismiss];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
               [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d",timerout] forState:UIControlStateNormal];
                
            });
            timerout --;
        }
        
    });
    dispatch_resume(_timer);
    
}




- (void)dismiss
{
        [UIView animateWithDuration:0.3f animations:^{
            self.alpha = 0.f;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
}

@end
