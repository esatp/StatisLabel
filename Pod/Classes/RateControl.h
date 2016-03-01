//
//  RateControl.h
//  SatisMeter
//
//  Created by Esat Pllana on 2/19/16.
//  Copyright © 2016 Appsix LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ratingControlDelegate <NSObject>

-(void)rateControlDidChangeValue :(int)Value;
-(void)rateControlDidFinish :(int)Value;

@end
@interface RateControl : UIView
@property (nonatomic,weak) id delegate;
@property(nonatomic, strong) UIColor *mainColor;
@property int currentRateValue;

-(void)initSettings;
-(void)layoutFrame;
@end