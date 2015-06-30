//
//  RCConversionDataSource.h
//  RongCloud
//
//  Created by Heq.Shinoda on 14-5-8.
//  Copyright (c) 2014年 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCIMClient.h"
#import "RCStatusDefine.h"
#import "RCChatViewController.h"

@class RCMessageCell;
@interface RCConversionDataSource : NSObject <UITableViewDataSource,UITableViewDelegate> {
    BOOL isLoading;
}

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray* chatCellRepository;
@property(nonatomic,strong) NSMutableArray* chatDataRepository;

@property(nonatomic,strong) NSString *currentTarget;
@property(nonatomic,assign) RCConversationType conversationType;
@property(nonatomic,assign) RCChatViewController *chatViewController;
@property(nonatomic,assign) RCUserAvatarStyle portraitStyle;


-(void)pushOldMessage:(RCMessage*)msgData;
-(void)addMessage:(RCMessage*)msgData;
-(void)loadLatestHistoryMessage;
-(void)loadMoreHistoryMessage;
@end
