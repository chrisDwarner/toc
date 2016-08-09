//
//  TOCTableViewCell.h
//  TOC
//
//  Created by chris warner on 3/9/15.
//  Copyright (c) 2015 NarrativeTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContributerView.h"


@interface TOCTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *chapterTitle;
@property (strong, nonatomic) IBOutlet UILabel *chapterNumber;
@property (strong, nonatomic) IBOutlet UILabel *pagesLabel;
@property (strong, nonatomic) IBOutlet UIImageView *statusImage;
@property (strong, nonatomic) IBOutlet ContributerView *currentContributerView;
@property (strong, nonatomic) IBOutlet UIImageView *greyTopBar;
@property (strong, nonatomic) IBOutlet UIImageView *greyBottomBar;

@property (strong, nonatomic) NSMutableArray *contributers;

-(void) updateFonts;
@end
