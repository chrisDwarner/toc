//
//  ContributerView.m
//  TOC
//
//  Created by chris warner on 3/9/15.
//  Copyright (c) 2015 NarrativeTechnologies. All rights reserved.
//

#import "ContributerView.h"

@interface ContributerView ()

@end

@implementation ContributerView
@synthesize contributerTitle;
@synthesize readImageProgress;
@synthesize subtitle;
@synthesize pages;
@synthesize didSetupContraints;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)aRect
{
    self = [super initWithFrame:aRect];
    if (self != nil) {
        self.contributerTitle = [UILabel new];
        self.contributerTitle.translatesAutoresizingMaskIntoConstraints = NO;
//        [self.contributerTitle setBackgroundColor:[UIColor colorWithRed:50.0 green:50.0 blue:0.0 alpha:0.9]];
        [self addSubview:self.contributerTitle];
        
        self.readImageProgress = [UIView new];
        self.readImageProgress.translatesAutoresizingMaskIntoConstraints = NO;
        [self.readImageProgress setBackgroundColor:[UIColor colorWithRed:25.0 green:0.0 blue:25.0 alpha:1.0]];
        [self addSubview:self.readImageProgress];
        
        self.subtitle = [UILabel new];
        self.subtitle.translatesAutoresizingMaskIntoConstraints = NO;
        [self.subtitle setBackgroundColor:[UIColor colorWithRed:5.5 green:50.0 blue:50.0 alpha:0.9]];
        [self addSubview:self.subtitle];
        
        self.pages = [UILabel new];
        self.pages.translatesAutoresizingMaskIntoConstraints = NO;
//        [self.pages setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:10.0 alpha:0.9]];
        [self addSubview:self.pages];
        
        [self updateFonts];
        
//        [self setBackgroundColor:[UIColor greenColor]];
        
        self.didSetupContraints = NO;
    }
    return self;
}

-(void) updateConstraints
{
    if (self.didSetupContraints == NO) {
        [self setupConstraints];
    }
    [super updateConstraints];
}

-(void) setupConstraints
{
    NSDictionary *viewsDict = @{ @"title":self.contributerTitle,
                                 @"sub-title":self.subtitle,
                                 @"pages":self.pages,
                                 @"progress":self.readImageProgress};
    NSDictionary *metrics = @{@"vSpacing":@8, @"hSpacing":@8};
    
    // setup the size of the progress bar.
    NSArray *progressConstraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[progress(18)]"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:viewsDict];
    NSArray *progressConstraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[progress(80)]"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:viewsDict];
    [self.readImageProgress addConstraints:progressConstraint_H];
    [self.readImageProgress addConstraints:progressConstraint_V];
    
    // now position the progress bar on the left hand side
    NSArray *progressConstraintLayout_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-vSpacing-[progress(80)]-vSpacing-|"
                                                                                  options:0
                                                                                  metrics:metrics
                                                                                    views:viewsDict];
    NSArray *progressConstraintLayout_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[progress(18)]|"
                                                                                  options:0
                                                                                  metrics:metrics
                                                                                    views:viewsDict];
    
    [self addConstraints:progressConstraintLayout_H];
    [self addConstraints:progressConstraintLayout_V];
    
    // Now we position all the other elements in reference to the progress bar.
    // layout the title
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contributerTitle
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:8.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contributerTitle
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.readImageProgress
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1.0
                                                      constant:8.0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contributerTitle
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    // now layout the sub-title
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.subtitle
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.readImageProgress
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1.0
                                                      constant:8.0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.subtitle
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.contributerTitle
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                      constant:8.0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.subtitle
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:-13.0]];
    // setup the pages label
    NSArray *pagesConstraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[pages(123)]"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:viewsDict];
    NSArray *pagesConstraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[pages(21)]"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:viewsDict];
    [self.pages addConstraints:pagesConstraint_H];
    [self.pages addConstraints:pagesConstraint_V];

    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pages
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.readImageProgress
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1.0
                                                      constant:8.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pages
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.subtitle
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                      constant:8.0]];
    
    self.didSetupContraints = YES;
}

-(void) updateFonts
{
    self.contributerTitle.font = [UIFont fontWithName:@"ScalaSans" size:17.0];
    self.subtitle.font = [UIFont fontWithName:@"ScalaSans" size:11.0];
    self.pages.font = [UIFont fontWithName:@"ScalaSans-Italic" size:11.0];
    
    self.contributerTitle.textColor = [UIColor blackColor];
    self.subtitle.textColor = [UIColor grayColor];
    self.pages.textColor = [UIColor grayColor];
}

@end
