//
//  DemoChatViewController.m
//  iOS-IMKit-demo
//
//  Created by xugang on 8/30/14.
//  Copyright (c) 2014 Heq.Shinoda. All rights reserved.
//

#import "DemoChatViewController.h"
#import "DemoChatsettingViewController.h"
#import "DemoPreviewViewController.h"
#import "DemoLocationPickerBaiduMapDataSource.h"
#import "DemoLocationViewController.h"

@implementation DemoChatViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  //自定义导航标题颜色
  [self setNavigationTitle:self.currentTargetName
                 textColor:[UIColor whiteColor]];

  //自定义导航左右按钮
  UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]
      initWithTitle:@"返回"
              style:UIBarButtonItemStyleBordered
             target:self
             action:@selector(leftBarButtonItemPressed:)];
  [leftButton setTintColor:[UIColor whiteColor]];
  self.navigationItem.leftBarButtonItem = leftButton;

  if (!self.enableSettings) {
    self.navigationItem.rightBarButtonItem = nil;
  } else {
    //自定义导航左右按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
        initWithTitle:@"设置"
                style:UIBarButtonItemStyleBordered
               target:self
               action:@selector(rightBarButtonItemPressed:)];
    [rightButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightButton;
  }
  RCUserData *userData_ = [[RCUserData alloc] init];
  userData_.appVersion = @"test.appversion";
  userData_.extra = @"test.extra";

  RCAccountInfo *accountInfo_ = [RCAccountInfo new];
  accountInfo_.userName = @"test.rcaccount.username";
  accountInfo_.nickName = @"test.rcaccount.nickname";
  accountInfo_.appUserId = @"test.personalinfo.appUserId";

  RCPersonalInfo *personalInfo_ = [RCPersonalInfo new];
  personalInfo_.realName = @"test.personalinfo.realname";
  personalInfo_.sex = @"test.personalinfo.sex";
  personalInfo_.birthday = @"test.personalinfo.birthday";
  personalInfo_.age = @"test.personalinfo.age";
  personalInfo_.job = @"test.personalinfo.job";
  personalInfo_.portraitUri = @"test.personalinfo.portraitUri";
  personalInfo_.comment = @"test.personalinfo.comment";

  RCContactInfo *contactInfo_ = [RCContactInfo new];
  contactInfo_.tel = @"test.contactinfo.tel";
  contactInfo_.email = @"test.contactinfo.email";
  contactInfo_.address = @"test.contactinfo.address";
  contactInfo_.qq = @"test.contactinfo.qq";
  contactInfo_.weiBo = @"test.contactinfo.weiBo";
  contactInfo_.weiXin = @"test.contactinfo.weiXin";
  contactInfo_.tel = @"test.contactinfo.tel";
  contactInfo_.tel = @"test.contactinfo.tel";
  contactInfo_.tel = @"test.contactinfo.tel";

  RCClientInfo *clientInfo_ = [RCClientInfo new];
  clientInfo_.network = @"test.rcclientinfo.network";
  clientInfo_.carrier = @"test.rcclientinfo.carrier";
  clientInfo_.systemVersion = @"test.rcclientinfo.systemVersion";
  clientInfo_.os = @"test.rcclientinfo.os";
  clientInfo_.device = @"test.rcclientinfo.device";
  clientInfo_.mobilePhoneManufacturers =
      @"test.rcclientinfo.mobilePhoneManufacturers";

  userData_.accountInfo = accountInfo_;
  userData_.personalInfo = personalInfo_;
  userData_.contactInfo = contactInfo_;
  userData_.clientInfo = clientInfo_;

  [[RCIMClient sharedRCIMClient] syncUserData:userData_
      successCompletion:^{
        NSLog(@"setuserData sucess");
      }
      errorCompletion:^(RCErrorCode status) {
        NSLog(@"setuserData failed >%ld", status);
      }];

  //    [[RCIMClient sharedRCIMClient]getUserData:^(RCUserData *userData) {
  //        NSLog(@"setuserData sucess >>%@", userData);
  //    } error:^(RCErrorCode status) {
  //
  //    }];
}
/**
 * 重写父类方法，接收发送的消息，此方法仅用于简单监听
 */
- (void)sendMessageEventListener:(RCMessage *)message {
  NSLog(@"%s", __FUNCTION__);
}
- (void)leftBarButtonItemPressed:(id)sender {
  [super leftBarButtonItemPressed:sender];
}
- (void)rightBarButtonItemPressed:(id)sender {
  DemoChatsettingViewController *temp =
      [[DemoChatsettingViewController alloc] init];
  temp.targetId = self.currentTarget;
  temp.conversationType = self.conversationType;
  temp.portraitStyle = RCUserAvatarCycle;
  [self.navigationController pushViewController:temp animated:YES];
}

- (void)showPreviewPictureController:(RCMessage *)rcMessage {

  DemoPreviewViewController *temp = [[DemoPreviewViewController alloc] init];
  temp.rcMessage = rcMessage;
  UINavigationController *nav =
      [[UINavigationController alloc] initWithRootViewController:temp];

  //导航和原有的配色保持一直
  UIImage *image = [self.navigationController.navigationBar
      backgroundImageForBarMetrics:UIBarMetricsDefault];

  [nav.navigationBar setBackgroundImage:image
                          forBarMetrics:UIBarMetricsDefault];

  [self presentViewController:nav animated:YES completion:nil];
}

- (void)onBeginRecordEvent {
  DebugLog(@"录音开始");
}
- (void)onEndRecordEvent {
  DebugLog(@"录音结束");
}

- (id<RCLocationPickerViewControllerDataSource>)locationPickerDataSource {
  return [[DemoLocationPickerBaiduMapDataSource alloc] init];
}

- (void)openLocation:(CLLocationCoordinate2D)location
        locationName:(NSString *)locationName {
  DemoLocationViewController *locationViewController =
      [[DemoLocationViewController alloc] initWithLocation:location
                                              locationName:locationName];
  [self.navigationController pushViewController:locationViewController
                                       animated:YES];
}

@end
