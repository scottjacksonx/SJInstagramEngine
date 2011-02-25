//
//  SJInstagramSignIn.h
//  instagallery
//
//  Created by Scott Jackson on 11/02/11.
//  Copyright 2011 SJSoftware. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SJInstagramSignIn : NSObject {
    NSMutableData *receivedData;
}

@property(readwrite, retain) NSMutableData *receivedData;

/*
 Create an SJInstagramSignIn object and call signInWith:username andPassword:
 
 Then, use NSNotification Center to listen for a "signInSuccess" notification.
 */
- (void)signInWithUsername:(NSString *)username andPassword:(NSString *)password;

@end
