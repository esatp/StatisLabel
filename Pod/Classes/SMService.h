//
//  SMService.h
//  SatisMeter
//
//  Created by Esat Pllana on 2/19/16.
//  Copyright © 2016 Appsix LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMAFHTTPSessionManager.h"
@interface SMService : NSObject
+ (SMService *)shared;


//-(void)identifyUserWithName:(NSString*)name andWriteKey:(NSString*)writeKey withBlock:(void(^) (BOOL success, NSDictionary *response))block;


-(void)identifyUserWithUserId:(NSString*)Id writeKey:(NSString*)writeKey andTraitsDictionary:(NSDictionary*)traits withBlock:(void(^) (BOOL success, NSDictionary *response))block;

-(void)submitFeedbackWithUserId:(NSString*)Id writeKey:(NSString*)writeKey feedbackMessage:(NSString*)strFeedback rating:(int)RatingValue withBlock:(void(^) (BOOL success, NSString *message))block;
@end
