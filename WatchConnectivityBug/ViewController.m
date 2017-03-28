//
//  ViewController.m
//  WatchConnectivityBug
//
//  Created by Matt Robinson on 12/21/16.
//  Copyright © 2016 MattRobinson. All rights reserved.
//

#import "ViewController.h"

#import <WatchConnectivity/WatchConnectivity.h>

@interface ViewController () <WCSessionDelegate>

@property (weak, nonatomic) IBOutlet UILabel *fileCountLabel;

@property (strong, nonatomic) WCSession *session;
@property (assign, nonatomic) NSUInteger fileTransferCount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.session = [WCSession defaultSession];
    self.session.delegate = self;
    [self.session activateSession];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WCSessionDelegate

- (void)session:(WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(nullable NSError *)error
{

}

- (void)sessionDidBecomeInactive:(WCSession *)session
{

}

- (void)sessionDidDeactivate:(WCSession *)session
{

}

- (void)sessionWatchStateDidChange:(WCSession *)session
{

}

/** ------------------------- Interactive Messaging ------------------------- */

- (void)sessionReachabilityDidChange:(WCSession *)session
{

}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message
{
    NSLog(@"didReceiveMessage:\n%@", message);
}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler
{
    NSLog(@"didReceiveMessage:replyHandler:\n%@", message);
    replyHandler(@{ @"REPLY" : @"GOOD" });
}

- (void)session:(WCSession *)session didReceiveMessageData:(NSData *)messageData
{

}

- (void)session:(WCSession *)session didReceiveMessageData:(NSData *)messageData replyHandler:(void(^)(NSData *replyMessageData))replyHandler
{

}

/** -------------------------- Background Transfers ------------------------- */

- (void)session:(WCSession *)session didReceiveApplicationContext:(NSDictionary<NSString *, id> *)applicationContext
{

}

- (void)session:(WCSession * __nonnull)session didFinishUserInfoTransfer:(WCSessionUserInfoTransfer *)userInfoTransfer error:(nullable NSError *)error
{

}

- (void)session:(WCSession *)session didReceiveUserInfo:(NSDictionary<NSString *, id> *)userInfo
{

}

- (void)session:(WCSession *)session didFinishFileTransfer:(WCSessionFileTransfer *)fileTransfer error:(nullable NSError *)error
{

}

- (void)session:(WCSession *)session didReceiveFile:(WCSessionFile *)file
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.fileTransferCount++;

        [self.fileCountLabel setText:[@(self.fileTransferCount) stringValue]];
    });
}

@end
