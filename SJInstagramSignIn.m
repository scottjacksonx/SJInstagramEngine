//
//  SJInstagramSignIn.m
//  instagallery
//
//  Created by Scott Jackson on 11/02/11.
//  Copyright 2011 SJSoftware. All rights reserved.
//

#import "SJInstagramSignIn.h"
#import "JSON.h"


@implementation SJInstagramSignIn

@synthesize receivedData;

- (void)signInWithUsername:(NSString *)username andPassword:(NSString *)password {
    NSString *urlString = @"https://instagr.am/api/v1/accounts/login/";
    
    NSString *post = [NSString stringWithFormat:@"username=%@&password=%@&device_id=%@", username, password, @"0000"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [req setHTTPMethod:@"POST"];
    [req setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"User-Agent"];
    [req setHTTPBody:postData];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    
    if (conn) {
        self.receivedData = [[NSMutableData data] retain];
    } else {
        NSLog(@"Sign-in connection failed.");
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"sign-in connection received");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"sign-in connection succeeded. received %d bytes", [self.receivedData length]);
    SBJSON *jsonParser = [[SBJSON alloc] init];
    
    NSString *jsonString = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSDictionary *jsonResponse = [jsonParser objectWithString:jsonString];
    NSLog(@"here's the data: %@", jsonResponse);
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"signInSuccess" object:jsonResponse];
    
}


@end
