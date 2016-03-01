//
//  SatisMeterView.m
//  SatisMeter
//
//  Created by Esat Pllana on 2/24/16.
//  Copyright © 2016 Appsix LLC. All rights reserved.
//

#import "SatisMeterView.h"
#import "RateControl.h"
#import "SMService.h"


@interface SatisMeterView()<ratingControlDelegate,UITextViewDelegate>
{
    BOOL keyboardOpen;
    SMService *service;
    BOOL closeButon;
}
@end
@implementation SatisMeterView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (void)deviceDidRotate:(NSNotification *)notification
{
    closeButon=NO;
    [self layoutSubviewsInCaseOfDeviceRotation];
}

-(void)updateOrientation{
    UIDeviceOrientation currentOrientation = [[UIDevice currentDevice] orientation];
    UIInterfaceOrientation statusBarOrientation;
    switch (currentOrientation) {
        case UIDeviceOrientationFaceDown:
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationUnknown:
            return;
        case UIDeviceOrientationPortrait:
        {
            // AVCaptureConnection *previewLayerConnection=captureVideoPreviewLayer.connection;
            
            // if ([previewLayerConnection isVideoOrientationSupported])
            //    [previewLayerConnection setVideoOrientation:AVCaptureVideoOrientationLandscapeRight];
            
        }
            break;
        case UIDeviceOrientationPortraitUpsideDown:
        {
            // AVCaptureConnection *previewLayerConnection=captureVideoPreviewLayer.connection;
            
            // if ([previewLayerConnection isVideoOrientationSupported])
            //    [previewLayerConnection setVideoOrientation:AVCaptureVideoOrientationLandscapeRight];
            
        }
            break;
        case UIDeviceOrientationLandscapeLeft:
        {
            
        }
            
            break;
        case UIDeviceOrientationLandscapeRight:
        {
            
        }
            break;
    }
}

-(void)initSettings{
    
    //[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceDidRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    
    
    _ratingControl.delegate=self;
    _ratingControl.mainColor = _mainColor;
    [_ratingControl initSettings];
    _txFeedback.delegate=self;
    // typically inside of the -(void) viewDidLoad method
    _txFeedback.layer.borderWidth = 1.0f;
    _txFeedback.layer.borderColor = [[_mainColor colorWithAlphaComponent:0.3f] CGColor];
    _txFeedback.layer.cornerRadius = 8;
    
    _scrollViewContainer.contentSize = CGSizeMake(_viewRatingHolder.frame.size.width, _viewRatingHolder.frame.size.height);
    _scrollViewContainer.scrollEnabled=NO;
    [_submitButton setBackgroundColor:_mainColor];
    
    
    _viewContainer.frame =  CGRectMake(_viewContainer.frame.origin.x, self.frame.size.height-(_viewRatingHolder.frame.size.height-_viewFeedbackViewHolder.frame.size.height+_scrollViewContainer.frame.origin.y+50), _viewContainer.frame.size.width, _viewContainer.frame.size.height);
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if (_translationWords!=nil) {
        [_submitButton setTitle:[_translationWords objectForKey:@"SUBMIT"] forState:UIControlStateNormal];
        _notLikeLabel.text =[_translationWords objectForKey:@"UNLIKELY"];
        _extremeLikeLabel.text =[_translationWords objectForKey:@"LIKELY"];
        _whatImproveLabel.text =[_translationWords objectForKey:@"FOLLOWUP"];
        _thankYouLabel.text =[_translationWords objectForKey:@"THANKS"];
        
        
        if([[[_widgetDictionary objectForKey:@"serviceName"]description]isEqualToString:@""]){
            _howLikelyLabel.text =[_translationWords objectForKey:@"HOW_LIKELY_US"];;
            //NSLog(@"serviceName=nothing");
        }else{
            NSString *HOW_LIKELY_US =[_translationWords objectForKey:@"HOW_LIKELY"];
            
            if ([HOW_LIKELY_US rangeOfString:@"%s"].location == NSNotFound) {
                
                //NSLog(@"%%s not found");
                
                _howLikelyLabel.text =[_translationWords objectForKey:@"HOW_LIKELY_US"];;
                
            } else {
                //NSLog(@"%%s found");
                
                NSString *str =[_translationWords objectForKey:@"US"];
                HOW_LIKELY_US = [HOW_LIKELY_US stringByReplacingOccurrencesOfString:@"%s"
                                                                         withString:str];
                
                _howLikelyLabel.text =HOW_LIKELY_US;
            }

        }
        
        if (_shouldShowPoweredBy) {
            _poweredLabel.alpha=1;
            NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithString:_poweredLabel.text];
            NSRange range=[_poweredLabel.text rangeOfString:@"SatisMeter"];
            
            [string beginEditing];
            [string addAttribute:NSForegroundColorAttributeName value:_mainColor range:range];
            [string addAttribute:NSFontAttributeName
                           value:[UIFont fontWithName:@"Helvetica-Bold" size:_poweredLabel.font.pointSize]
                           range:range];
            [string endEditing];
            [_poweredLabel setAttributedText:string];
            
            
            UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPoweredByLabel:)];
            [_poweredLabel addGestureRecognizer:tapRecognizer];
            
        }
  
    }
}

-(void)tapPoweredByLabel:(UIPanGestureRecognizer*)sender {
   
    //[self endEditing:YES];
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://satismeter.com/"]];
}

-(void)layoutSubviewsInCaseOfDeviceRotation{
    
    if (keyboardOpen) {
        _viewContainer.frame =  CGRectMake(_viewContainer.frame.origin.x, self.frame.size.height-(_viewRatingHolder.frame.size.height+_scrollViewContainer.frame.origin.y), _viewContainer.frame.size.width, _viewRatingHolder.frame.size.height+_scrollViewContainer.frame.origin.y);
        
        [UIView animateWithDuration:0.3f animations:^{
            
            
            [_ratingControl layoutFrame];
            
        }completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:0.3f animations:^{
            if (_ratingControl.currentRateValue!=0) {
                _viewContainer.frame =  CGRectMake(_viewContainer.frame.origin.x, self.frame.size.height-(_viewRatingHolder.frame.size.height+_scrollViewContainer.frame.origin.y), _viewContainer.frame.size.width, _viewRatingHolder.frame.size.height+_scrollViewContainer.frame.origin.y);
                
            }else{
                _viewContainer.frame =  CGRectMake(_viewContainer.frame.origin.x, self.frame.size.height-(_viewRatingHolder.frame.size.height-_viewFeedbackViewHolder.frame.size.height+_scrollViewContainer.frame.origin.y+50), _viewContainer.frame.size.width, _viewContainer.frame.size.height);
                
            }
            [_ratingControl layoutFrame];
            
        }completion:^(BOOL finished) {
            
        }];
        
    }
}


#pragma mark RateControl delegate methods

-(void)rateControlDidChangeValue:(int)Value{
    
    //_ratingLabel.text = [NSString stringWithFormat:@"Rating: %d",Value];
}


-(void)rateControlDidFinish:(int)Value{
    
    _ratingControl.userInteractionEnabled=NO;
    [_txFeedback becomeFirstResponder];
    [UIView animateWithDuration:0.3f animations:^{
        
        _viewFeedbackViewHolder.alpha=1;
        
        _notLikeLabel.alpha=0;
        _extremeLikeLabel.alpha=0;
    }];
}

- (IBAction)btClose:(id)sender {
    
    if (keyboardOpen) {
        closeButon=YES;
        
        [self endEditing:YES];
    }else{
        
        
        
        [UIView animateWithDuration:0.3f animations:^{
            
            _viewFeedbackViewHolder.alpha=0;
            
            
            //_viewContainer.frame =  CGRectMake(_viewContainer.frame.origin.x, self.frame.size.height-(_viewRatingHolder.frame.size.height-_viewFeedbackViewHolder.frame.size.height+_scrollViewContainer.frame.origin.y+50), _viewContainer.frame.size.width, _viewContainer.frame.size.height);
            _viewContainer.frame =  CGRectMake(_viewContainer.frame.origin.x, self.frame.size.height, _viewContainer.frame.size.width, _viewContainer.frame.size.height);
            
            
            _notLikeLabel.alpha=1;
            _extremeLikeLabel.alpha=1;
        }completion:^(BOOL finished) {
            //
            if (_ratingControl.currentRateValue!=0) {
                service = [[SMService alloc] init];
                
                [service submitFeedbackWithUserId:_userId writeKey:_writeKey feedbackMessage:_txFeedback.text rating:_ratingControl.currentRateValue withBlock:^(BOOL success, NSString *message) {
                }];

            }
            
            [UIView animateWithDuration:0.3f animations:^{
                
                self.alpha=0;
            }completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }];
    }
}


-(void)hideOtherControls{
    for (UIView *vv in _viewRatingHolder.subviews){
        if (vv.tag!=2) {
            [UIView animateWithDuration:0.3f animations:^{
                vv.alpha=0;
            }];
        }
    }
}
-(void)showOtherControls{
    for (UIView *vv in _viewRatingHolder.subviews){
        if (vv.tag!=2) {
            [UIView animateWithDuration:0.3f animations:^{
                vv.alpha=1;
            }];
        }
    }
}
#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    
    
    if (!keyboardOpen) {
    
    
    
    [UIView animateWithDuration:0.3f animations:^{
        _txFeedback.layer.borderWidth = 2.0f;
        
        _txFeedback.layer.borderColor = [_mainColor CGColor];
        
    }];
    
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    //[self hideOtherControls];
    int y =self.frame.size.height-_viewContainer.frame.size.height-keyboardSize.height;
    int height =_viewContainer.frame.size.height+keyboardSize.height;
    
    if (y<20) {
        _scrollViewContainer.scrollEnabled=YES;
        y=20;
        height=self.frame.size.height-keyboardSize.height-20;
    }
    [UIView animateWithDuration:0.3f animations:^{
        _viewContainer.frame =  CGRectMake(_viewContainer.frame.origin.x, y, _viewContainer.frame.size.width, height);
        
        [_scrollViewContainer scrollRectToVisible:CGRectMake(_scrollViewContainer.contentSize.width - 1,_scrollViewContainer.contentSize.height - 1, 1, 1) animated:NO];
        
    }completion:^(BOOL finished) {
        keyboardOpen=YES;
        
    }];
      }
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    if (!closeButon) {
        return;
    }
    
    if (keyboardOpen) {
        
        
        [UIView animateWithDuration:0.3f animations:^{
            _txFeedback.layer.borderWidth = 1.0f;
            
            _txFeedback.layer.borderColor = [[_mainColor colorWithAlphaComponent:0.3f] CGColor];
            
        }];
        
        //CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        //[self showOtherControls];
        _scrollViewContainer.scrollEnabled=NO;
        [UIView animateWithDuration:0.3f animations:^{
            _viewContainer.frame =  CGRectMake(_viewContainer.frame.origin.x, self.frame.size.height-(_viewRatingHolder.frame.size.height+_scrollViewContainer.frame.origin.y), _viewContainer.frame.size.width, _viewRatingHolder.frame.size.height+_scrollViewContainer.frame.origin.y);
            
        }completion:^(BOOL finished) {
            keyboardOpen=NO;
        }];
    }
}

- (IBAction)submitFeedback:(id)sender {
    
    service = [[SMService alloc] init];
    
    
    
        [self endEditing:YES];
        _scrollViewContainer.userInteractionEnabled = NO;
        
        [service submitFeedbackWithUserId:_userId writeKey:_writeKey feedbackMessage:_txFeedback.text rating:_ratingControl.currentRateValue withBlock:^(BOOL success, NSString *message) {
        }];
        
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        [UIView animateWithDuration:0.3f animations:^{
            // _scrollViewContainer.alpha=0;
            _viewSuccess.alpha=1;
            _viewRatingHolder.alpha=0;
            _viewContainer.frame =  CGRectMake(_viewContainer.frame.origin.x, self.frame.size.height-_viewSuccess.frame.size.height, _viewContainer.frame.size.width, _viewContainer.frame.size.height);
        }completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.3f animations:^{
                    _viewContainer.frame =  CGRectMake(_viewContainer.frame.origin.x, self.frame.size.height, _viewContainer.frame.size.width, _viewContainer.frame.size.height);
                    self.alpha=0;
                }completion:^(BOOL finished) {
                    [self removeFromSuperview];
                }];
            });
        }];
        
  
    
}

@end
