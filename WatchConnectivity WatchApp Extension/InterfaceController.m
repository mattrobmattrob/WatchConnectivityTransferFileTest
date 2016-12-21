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
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *transferredFileLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *outstandingFileCountLabel;


@property (assign, nonatomic) NSUInteger outstandingFileCount;
@property (assign, nonatomic) NSUInteger completeFileTransfers;
@property (assign, nonatomic) NSUInteger attemptedFileTransfers;

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

    self.outstandingFileCount = self.session.outstandingFileTransfers.count;

    __weak typeof(self) weakSelf = self;
    [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf updateOutstandingFileLabel];
    }];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

#pragma mark - Accessors

- (void)setAttemptedFileTransfers:(NSUInteger)attemptedFileTransfers
{
    if (_attemptedFileTransfers != attemptedFileTransfers) {
        _attemptedFileTransfers = attemptedFileTransfers;

        NSString *fileCountString = [NSString stringWithFormat:@"Attempted: %lu", (unsigned long)attemptedFileTransfers];
        [self.transferredFileLabel setText:fileCountString];
    }
}

- (void)setCompleteFileTransfers:(NSUInteger)completeFileTransfers
{
    if (_completeFileTransfers != completeFileTransfers) {
        _completeFileTransfers = completeFileTransfers;

        NSString *fileCountString = [NSString stringWithFormat:@"Complete: %lu", (unsigned long)completeFileTransfers];
        [self.fileTransferStatusLabel setText:fileCountString];
    }
}

- (void)setOutstandingFileCount:(NSUInteger)outstandingFileCount
{
    if (_outstandingFileCount != outstandingFileCount) {
        _outstandingFileCount = outstandingFileCount;

        NSString *fileCountString = [NSString stringWithFormat:@"Outstanding: %lu", (unsigned long)_outstandingFileCount];
        [self.outstandingFileCountLabel setText:fileCountString];
    }
}

#pragma mark - Actions

- (IBAction)uploadFileToPhone
{
    NSArray<NSString *> *fileNames = @[@"stuff", @"stuff1", @"stuff2"];
    for (NSString *fileName in fileNames) {
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        [self.session transferFile:fileURL metadata:@{@"Crap metadata" : @"stuff"}];
    }

    self.attemptedFileTransfers += 3;
}

- (void)updateOutstandingFileLabel
{
    self.outstandingFileCount = self.session.outstandingFileTransfers.count;
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
        self.completeFileTransfers++;

        [self updateOutstandingFileLabel];
    });
}

- (void)session:(WCSession *)session didReceiveFile:(WCSessionFile *)file
{
    
}

@end



