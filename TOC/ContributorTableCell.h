//
//  ContributorTableCell.h
//  TOC
//
//  Created by chris warner on 3/18/15.
//  Copyright (c) 2015 NarrativeTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContributorTableCell : UIViewController
@property (strong, nonatomic) IBOutlet UIView *progress;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *subtitle;
@property (strong, nonatomic) IBOutlet UILabel *pages;

@end
