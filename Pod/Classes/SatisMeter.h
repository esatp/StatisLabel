//
//  SatisMeter.h
//  SatisMeter
//
//  Created by Esat Pllana on 2/24/16.
//  Copyright © 2016 Appsix LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SatisMeter : NSObject


+(instancetype) sharedInstance;
-(void) showSatisMeterViewInViewController:(UIViewController *)viewController;

/// Returns YES if the SatisMeterView is ready to be displayed.
@property BOOL isReady;


-(void)identifyUserWithUserId:(NSString*)Id writeKey:(NSString*)writeKey andTraitsDictionary:(NSDictionary*)traits;


@end
