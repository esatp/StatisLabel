//
//  SMService.m
//  SatisMeter
//
//  Created by Esat Pllana on 2/19/16.
//  Copyright © 2016 Appsix LLC. All rights reserved.
//

#import "SMService.h"

@implementation SMService

+ (SMService *)shared {
    
    static dispatch_once_t _singletonPredicate;
    static SMService *_singleton = nil;
    dispatch_once(&_singletonPredicate, ^{
        _singleton = [[super allocWithZone:nil] init];
    });
    return _singleton;
}


-(void)identifyUserWithUserId:(NSString*)Id writeKey:(NSString*)writeKey andTraitsDictionary:(NSDictionary*)traits withBlock:(void(^) (BOOL success, NSDictionary *response))block {
  
    NSString *traitsJsonString=@"";
    if (traits!=nil) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:traits
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        
        if (! jsonData) {
            //NSLog(@"Got an error: %@", error);
        } else {
            traitsJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }

    }
    
    
    
    //Mx3RPRM1IaYltrBQ
    
    NSString *url = [NSString stringWithFormat:@"%@", @"http://app.satismeter.com/api/widget"];
    NSString *jsonString = [NSString stringWithFormat:@"{\"writeKey\": \"%@\",\"userId\": \"%@\",\"traits\": {}}",writeKey,Id ];

    if (![traitsJsonString isEqualToString:@""]) {
        jsonString = [NSString stringWithFormat:@"{\"writeKey\": \"%@\",\"userId\": \"%@\",\"traits\": %@}",writeKey,Id,traitsJsonString ];
    }
    
    
    SMAFURLSessionManager *manager = [[SMAFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *req = [[SMAFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    
    req.timeoutInterval= 10;
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            //NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                //blah blah
                block(YES,responseObject);
            }
        } else {
            //NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            block(NO,nil);

        }
    }] resume];
}


-(void)submitFeedbackWithUserId:(NSString*)Id writeKey:(NSString*)writeKey feedbackMessage:(NSString*)strFeedback rating:(int)RatingValue withBlock:(void(^) (BOOL success, NSString *message))block {
    
    NSString *url = [NSString stringWithFormat:@"%@", @"http://app.satismeter.com/api/responses"];
    NSString *jsonString = [NSString stringWithFormat:@"{\"writeKey\": \"%@\",\"userId\": \"%@\",\"method\": \"Mobile\",\"rating\": %d,\"feedback\": \"%@\"}",writeKey,Id,RatingValue,strFeedback];
    
    
    SMAFURLSessionManager *manager = [[SMAFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *req = [[SMAFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    
    req.timeoutInterval= 10;
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            //NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                //blah blah
            }
        } else {
            //NSLog(@"Error: %@, %@, %@", error, response, responseObject);
        }
    }] resume];
}

@end
