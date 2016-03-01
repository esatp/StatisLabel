//
//  SatisMeter.m
//  SatisMeter
//
//  Created by Esat Pllana on 2/24/16.
//  Copyright © 2016 Appsix LLC. All rights reserved.
//

#import "SatisMeter.h"
#import "SatisMeterView.h"
#import "SMService.h"

@interface SatisMeter()
{
    
}
@property(nonatomic, strong) UIColor *mainColor;
@property(nonatomic, strong) NSString *writeKey;
@property(nonatomic, strong) NSString *userId;

@property(nonatomic, strong) NSDictionary *translationWords;
@property(nonatomic, strong) NSDictionary *widgetDictionary;
@property BOOL shouldShowPoweredBy;


@end

@implementation SatisMeter


//SatisMeter
+ (instancetype) sharedInstance {
    static SatisMeter *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}
- (UIColor *)colorFromHexString:(NSString *)hexString
{
    if ([hexString length]>0) {
        unsigned rgbValue = 0;
        NSScanner *scanner = [NSScanner scannerWithString:hexString];
        [scanner setScanLocation:1]; //bypass '#' character
        [scanner scanHexInt:&rgbValue];
        return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
        
    }
    
    return  [UIColor grayColor];
}
-(void)identifyUserWithUserId:(NSString*)Id writeKey:(NSString*)writeKey andTraitsDictionary:(NSDictionary*)traits{
//-(void)identifyUserWithName:(NSString*)name andWriteKey:(NSString*)writeKey{
    SMService *service = [[SMService alloc]init];
    
    [service identifyUserWithUserId:Id writeKey:writeKey andTraitsDictionary:traits withBlock:^(BOOL success, NSDictionary *response) {
        NSDictionary *widget = [response objectForKey:@"widget"];
        NSString *color = [[widget objectForKey:@"colorCode"]description];
        BOOL isVisible = [[widget objectForKey:@"visible"]boolValue];
        BOOL showPoweredBy = [[widget objectForKey:@"showPoweredBy"]boolValue];

        [SatisMeter sharedInstance].isReady=YES;//isVisible;
        [SatisMeter sharedInstance].shouldShowPoweredBy=showPoweredBy;

        [SatisMeter sharedInstance].writeKey =writeKey;
        [SatisMeter sharedInstance].userId =Id;

        [SatisMeter sharedInstance].mainColor=[self colorFromHexString:color];
        [SatisMeter sharedInstance].translationWords =[widget objectForKey:@"translation"];
        [SatisMeter sharedInstance].widgetDictionary =widget;

    }];
    

}

-(void) showSatisMeterViewInViewController:(UIViewController *)viewController {
    /*
    if ([SatisMeter sharedInstance].isReady) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SatisMeterResources" ofType:@"bundle"];
        NSBundle *frameworkBundle = [NSBundle bundleWithPath:path];
        
        SatisMeterView *smView = [[frameworkBundle loadNibNamed:@"SatisMeterView" owner:self options:nil] firstObject];
        smView.alpha=0;
        smView.frame = CGRectMake(0, 0, [viewController.view bounds].size.width, [viewController.view bounds].size.height);
        smView.mainColor = [SatisMeter sharedInstance].mainColor;
        smView.writeKey =[SatisMeter sharedInstance].writeKey;
        smView.userId =[SatisMeter sharedInstance].userId;
        smView.shouldShowPoweredBy= [SatisMeter sharedInstance].shouldShowPoweredBy;
        smView.translationWords = [SatisMeter sharedInstance].translationWords;
        smView.widgetDictionary =[SatisMeter sharedInstance].widgetDictionary;
        [smView initSettings];
        smView.autoresizingMask = viewController.view.autoresizingMask;
        [viewController.view addSubview:smView];
        [UIView animateWithDuration:0.3f animations:^{
            smView.alpha=1.f;
        }];
    }else{
        
        */
        NSLog(@"SatisMeter View is not ready to show");
    //}
    
}


//https://satismeter.com/ powered by


@end
