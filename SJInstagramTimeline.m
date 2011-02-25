//
//  SJInstagramTimeline.m
//  instagallery
//
//  Created by Scott Jackson on 11/02/11.
//  Copyright 2011 SJSoftware. All rights reserved.
//

#import "SJInstagramTimeline.h"
#import "SBJSON.h"


@implementation SJInstagramTimeline

@synthesize receivedData;

- (void)getTimeline {
    NSString *urlString = @"http://instagr.am/api/v1/feed/timeline/";
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"Instagram" forHTTPHeaderField:@"User-Agent"];
    [req setHTTPShouldHandleCookies:YES];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    
    if (conn) {
        self.receivedData = [[NSMutableData data] retain];
    } else {
        NSLog(@"Timeline connection failed.");
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"timeline connection received");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"timeline connection succeeded. received %d bytes", [self.receivedData length]);
    SBJSON *jsonParser = [[SBJSON alloc] init];
    
    NSString *jsonString = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSDictionary *jsonResponse = [jsonParser objectWithString:jsonString];
        //NSLog(@"here's the data: %@", jsonResponse);

    NSArray *photos = [jsonResponse objectForKey:@"items"];
    
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"getTimeline" object:photos];
    
}
@end
