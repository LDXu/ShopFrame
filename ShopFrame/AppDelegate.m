//
//  AppDelegate.m
//  ShopFrame
//
//  Created by 赵瑞生 on 16/5/24.
//  Copyright © 2016年 ZRS. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseViewController.h"
#import "HomeViewController.h"
#import "ShopCartViewController.h"
#import "MeViewController.h"
#import <RDVTabBarItem.h>
#import "AdvertiseView.h"

@interface AppDelegate ()<RDVTabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    
    
    BaseViewController *emptyView = [[BaseViewController alloc] init];
    self.window.rootViewController = emptyView;
    
    
    [self initTabBar];
    [self.window makeKeyAndVisible];
    [self.window makeKeyWindow];
    [self initAddvertiseView];
    
    
    
    
    
    
    return YES;
}

- (void)initAddvertiseView
{
    //判断沙盒中是否有广告图片
    NSString *filPath = [self getFilePathWithImageName:[[NSUserDefaults standardUserDefaults] valueForKey:ADIMAGENAME]];
    BOOL isExist = [self isFileExistWithFilePath:filPath];
    if (isExist) {
        AdvertiseView *advertiseView = [[AdvertiseView alloc] initWithFrame:self.window.bounds];
        advertiseView.filePath = filPath;
        [advertiseView show];
    }
    //不存在 需要调用接口并判断是否更新
    [self getAdvertisingImage];
    
}

/**
 *  判断文件是否存在
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *filManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [filManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

/**
 *  根据图片名称拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    if (imageName) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *filPath = [[paths objectAtIndex:ADDVERTISERIAGE] stringByAppendingPathComponent:imageName];
        return filPath;
    }
    return  nil;
}
/**
 *  初始化广告页面
 */
- (void)getAdvertisingImage
{
    CGFloat scale_sceen = [UIScreen mainScreen].scale;
    
    int scaleW = (int)AI_SCREEN_WIDTH * scale_sceen;
    int scaleH = (int)AI_SCREEN_HEIGHT * scale_sceen;
    // 这里采用了美团的广告接口
    NSString *urlStr = [NSString stringWithFormat:@"http://api.meituan.com/config/v1/loading/check.json?app_name=group&app_version=5.7&ci=1&city_id=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-15-15-51824&platform=iphone&resolution=%d%@%d&userid=10086&utm_campaign=AgroupBgroupD100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoquxincelue0630__b__b1___ab_i550poi_xxyl__b__leftflow___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_pindaoshenyang__a__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGhomepage&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7",scaleW,@"%2A",scaleH];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArray = [responseObject safeObjectForKey:@"data"];
        NSDictionary *imageDic = dataArray.firstObject;
        NSString *imageUrl = [imageDic safeObjectForKey:@"imageUrl"];
        NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
        NSString *imageName = stringArr.lastObject;
        NSString *filePath = [self getFilePathWithImageName:imageName];
        BOOL isExist = [self isFileExistWithFilePath:filePath];
        if (!isExist) {//如果图片不存在，删除老图片， 下载新图片
            [self downloadAdImageWithUrl:imageUrl imageName:imageName];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        NSString *filPath = [self getFilePathWithImageName:imageName];
        
        if ([UIImagePNGRepresentation(image) writeToFile:filPath atomically:YES]) {//保存成功
            DLog(@"广告页保存成功");
            [self deleteOldImage];
            [[NSUserDefaults standardUserDefaults] setValue:imageName forKey:adImageName];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        } else {
            DLog(@"广告页保存失败");
        }
        
        
    });
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage
{
    NSString *imageName = [[NSUserDefaults standardUserDefaults] valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}


- (void)initTabBar
{
    HomeViewController *homeVc = [[HomeViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVc];
    
    ShopCartViewController *shopVc = [[ShopCartViewController alloc] init];
    UINavigationController *shopNav = [[UINavigationController alloc] initWithRootViewController:shopVc];
    
    MeViewController *meVc = [[MeViewController alloc] init];
    UINavigationController *meNav = [[UINavigationController alloc] initWithRootViewController:meVc];
    
    self.tabbarVC = [[RDVTabBarController alloc] init];
    self.tabbarVC.delegate = self;
    [self.tabbarVC setViewControllers:[NSArray arrayWithObjects:homeNav, shopNav, meNav , nil]];
    
    NSArray* iconArray = @[@"iconfont-shouye",@"iconfont-caigoudan",@"iconfont-wode"];
    NSArray *titleArray = @[@"首页",@"采购单",@"我的"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys: [UIFont systemFontOfSize:10], NSFontAttributeName,[ZUtility colorForHex:@"929292"],NSForegroundColorAttributeName,nil];
    
    NSDictionary *selectdictionary = [[NSDictionary alloc] initWithObjectsAndKeys: [UIFont systemFontOfSize:10], NSFontAttributeName,[UIColor redColor],NSForegroundColorAttributeName,nil];
    
    for (NSString* str in iconArray) {
        RDVTabBarItem* item = [[self.tabbarVC tabBar].items objectAtIndex:[iconArray indexOfObject:str]];

        
        
        item.selectedTitleAttributes = selectdictionary;
        item.unselectedTitleAttributes = dictionary;
        item.title = [titleArray objectAtIndex:[iconArray indexOfObject:str]];
        item.titlePositionAdjustment = UIOffsetMake(0,3);
        [item setFinishedSelectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",str]] withFinishedUnselectedImage:[UIImage imageNamed:str]];
    }
    
//    RDVTabBarItem *item = [[self.tabbarVC tabBar].items objectAtIndex:2];
//    LBBadgeView *badgeView = [[LBBadgeView alloc] initWithBadgeImageUrl:@"" badgeFont:12 badgeTextColor:[UIColor blackColor]];
//    CGRect rect = badgeView.frame;
//    rect.origin.x = (AI_SCREEN_WIDTH / [titleArray count])/ 2.0 + 5;
//    rect.origin.y = 2;
//    badgeView.frame = rect;
//    [item addSubview:badgeView];
    
    UIImage *image = [UIImage imageNamed:@"home_navigation-bar"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AI_SCREEN_WIDTH, 52)];
    imageView.image = image;
    [[self.tabbarVC tabBar].backgroundView addSubview:imageView];
    
    _window.rootViewController = self.tabbarVC;
    
}

- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    UINavigationController *nav = (UINavigationController *)viewController;
    [nav popToRootViewControllerAnimated:NO];
    
    BOOL isHave = NO;
    for (UIViewController *vc in nav.viewControllers) {
        if ([vc.nibName isEqualToString:@"ShopCartViewController"] || [vc.nibName isEqualToString:@"MeViewController"]) {
            isHave = YES;
        }
        if (isHave) {
//            return [[UserManager shareManager] isLoginWithView];
        }
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "ZRS.ShopFrame" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ShopFrame" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ShopFrame.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
