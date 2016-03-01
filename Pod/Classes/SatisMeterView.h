//
//  SatisMeterView.h
//  SatisMeter
//
//  Created by Esat Pllana on 2/24/16.
//  Copyright © 2016 Appsix LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RateControl.h"
@interface SatisMeterView : UIView

@property (weak, nonatomic) IBOutlet RateControl *ratingControl;
@property (weak, nonatomic) IBOutlet UILabel *notLikeLabel;
@property (weak, nonatomic) IBOutlet UILabel *extremeLikeLabel;
@property (weak, nonatomic) IBOutlet UITextView *txFeedback;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewContainer;
@property (weak, nonatomic) IBOutlet UIView *viewSuccess;

@property (weak, nonatomic) IBOutlet UIView *viewRatingHolder;
@property (weak, nonatomic) IBOutlet UIView *viewFeedbackViewHolder;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property(nonatomic, strong) UIColor *mainColor;
@property(nonatomic, strong) NSString *writeKey;
@property(nonatomic, strong) NSString *userId;
@property BOOL shouldShowPoweredBy;

@property(nonatomic, strong) NSDictionary *translationWords;
@property(nonatomic, strong) NSDictionary *widgetDictionary;

@property (weak, nonatomic) IBOutlet UILabel *howLikelyLabel;
@property (weak, nonatomic) IBOutlet UILabel *whatImproveLabel;
@property (weak, nonatomic) IBOutlet UILabel *thankYouLabel;
@property (weak, nonatomic) IBOutlet UILabel *poweredLabel;

-(void)initSettings;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@end
