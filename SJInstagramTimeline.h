//
//  SJInstagramTimeline.h
//  instagallery
//
//  Created by Scott Jackson on 11/02/11.
//  Copyright 2011 SJSoftware. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SJInstagramTimeline : NSObject {
    NSMutableData *receivedData;
}

@property(readwrite, retain) NSMutableData *receivedData;

/*
 Create an SJInstagramSignIn object and call signInWith:username andPassword:
 
 Then, use NSNotification Center to listen for a "getTimeline" notification.
 The notification's object is an array of photos (which are dictionaries).
 */
- (void)getTimeline;

@end
