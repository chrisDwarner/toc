//
//  ContributerView.h
//  TOC
//
//  Created by chris warner on 3/9/15.
//  Copyright (c) 2015 NarrativeTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContributerView : UIView
@property (strong, nonatomic) IBOutlet UILabel *contributerTitle;
@property (strong, nonatomic) IBOutlet UIView *readImageProgress;
@property (strong, nonatomic) IBOutlet UILabel *subtitle;
@property (strong, nonatomic) IBOutlet UILabel *pages;

@property (assign) BOOL didSetupContraints;

-(void) updateFonts;
@end
