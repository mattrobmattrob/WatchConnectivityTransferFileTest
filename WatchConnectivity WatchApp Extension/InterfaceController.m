//
//  InterfaceController.m
//  WatchConnectivity WatchApp Extension
//
//  Created by Matt Robinson on 12/21/16.
//  Copyright © 2016 MattRobinson. All rights reserved.
//

#import "InterfaceController.h"

#import <WatchConnectivity/WatchConnectivity.h>

@interface InterfaceController() <WCSessionDelegate>

@property (weak, nonatomic) IBOutlet WKInterfaceButton *uploadButton;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *fileTransferStatusLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *outstandingFileCountLabel;

@property (strong, nonatomic) WCSession *session;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];

    self.session = [WCSession defaultSession];
    self.session.delegate = self;
    [self.session activateSession];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];

    [self.outstandingFileCountLabel setText:[NSString stringWithFormat:@"Outs files: %lu", (unsigned long)self.session.outstandingFileTransfers.count]];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

#pragma mark - Actions

- (IBAction)uploadFileToPhone
{
    [self.fileTransferStatusLabel setText:@"Starting transfer..."];

    NSArray<NSString *> *fileNames = @[@"stuff", @"stuff1", @"stuff2"];
    for (NSString *fileName in fileNames) {
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        [self.session transferFile:fileURL metadata:@{@"Crap metadata" : @"stuff"}];
    }
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

}

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler
{

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
    dispatch_async(dispatch_get_main_queue(), ^{
        if (nil == error) {
            [self.fileTransferStatusLabel setText:@"Success!"];
        } else {
            [self.fileTransferStatusLabel setText:@"Failure!"];
        }

        [self.outstandingFileCountLabel setText:[NSString stringWithFormat:@"Outs files: %lu", (unsigned long)self.session.outstandingFileTransfers.count]];
    });
}

- (void)session:(WCSession *)session didReceiveFile:(WCSessionFile *)file
{
    
}

@end



