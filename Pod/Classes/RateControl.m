//
//  RateControl.m
//  SatisMeter
//
//  Created by Esat Pllana on 2/19/16.
//  Copyright © 2016 Appsix LLC. All rights reserved.
//


#import "RateControl.h"
#define NUMBEROFCIRCLES 10

@implementation RateControl
{
    
}
@synthesize currentRateValue;

-(void)initSettings{
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [self addGestureRecognizer:panRecognizer];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [self addGestureRecognizer:tapRecognizer];
    [self layoutFrame];
}

-(void)layoutFrame{
    CGRect recti = self.frame;
    recti.size.width = 35*NUMBEROFCIRCLES+10;
    recti.origin.x =self.superview.frame.size.width/2-recti.size.width/2;
    self.frame = recti;
}


-(void)move:(UIPanGestureRecognizer*)sender {
    
    CGPoint pika = [sender locationInView:self];
    [self findCurrentRateValue:pika];
    
      if (sender.state == UIGestureRecognizerStateEnded) {
          if (currentRateValue!=0) {
              [_delegate rateControlDidFinish:currentRateValue];
          }
      }

}

-(void)findCurrentRateValue :(CGPoint)currentTouchPoint{
    int p =(currentTouchPoint.x)/(self.frame.size.width/NUMBEROFCIRCLES)+1;

    
    if (p<=NUMBEROFCIRCLES&&p!=currentRateValue) {
        currentRateValue=p;
        [_delegate rateControlDidChangeValue:currentRateValue];
    }
    
       [self setNeedsDisplay];
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(c, 1, 0, 1, 0.1);
    
    // Draw a green solid circle
    int w = self.frame.size.width/NUMBEROFCIRCLES;
    float leftMargin= (int)self.frame.size.width -NUMBEROFCIRCLES*w;

    if (w>35) {
        w=35;
        
        leftMargin= (int)self.frame.size.width -NUMBEROFCIRCLES*w;
    }
    
    CGRect rectCircle = CGRectMake(0, 0, w, w);
    
    for (int i=0; i<NUMBEROFCIRCLES; i++) {
        
        rectCircle =CGRectMake(leftMargin/2+i*w, 0, w, w);
        
        
        CGContextSetFillColorWithColor(c, [[_mainColor colorWithAlphaComponent:0.3f] CGColor]);
        //CGContextSetFillColorWithColor(c,[[[UIColor alloc] initWithRed:255/255.0f green:91/255.0f blue:36/255.0f alpha:1]  CGColor]);
        CGContextFillEllipseInRect(c, CGRectMake(rectCircle.origin.x+2, rectCircle.origin.y+2, rectCircle.size.width-4, rectCircle.size.height-4));
        
        if (i<currentRateValue) {
            //CGContextSetRGBFillColor(c, 238/255.0f, 86/255.0f, 128/255.0f, 1);
            CGContextSetFillColorWithColor(c, [_mainColor CGColor]);

            CGContextFillEllipseInRect(c, CGRectMake(rectCircle.origin.x+2, rectCircle.origin.y+2, rectCircle.size.width-4, rectCircle.size.height-4));
        }
    }
}

@end


