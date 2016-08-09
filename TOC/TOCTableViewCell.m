//
//  TOCTableViewCell.m
//  TOC
//
//  Created by chris warner on 3/9/15.
//  Copyright (c) 2015 NarrativeTechnologies. All rights reserved.
//

#import "TOCTableViewCell.h"
#import "UIView+PureLayout.h"

@interface TOCTableViewCell ()

@property (nonatomic, assign) BOOL constraintsSetup;
@end
@implementation TOCTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        self.greyTopBar = [UIImageView newAutoLayoutView];
        [self.greyTopBar setImage:[UIImage imageNamed:@"grayline.png" inBundle:nil compatibleWithTraitCollection:nil]];
        
        self.statusImage = [UIImageView newAutoLayoutView];
        [self.statusImage setImage:[UIImage imageNamed:@"graydot.png" inBundle:nil compatibleWithTraitCollection:nil]];
        
        self.greyBottomBar = [UIImageView newAutoLayoutView];
        [self.greyBottomBar setImage:[UIImage imageNamed:@"grayline.png" inBundle:nil compatibleWithTraitCollection:nil]];

        self.chapterTitle = [UILabel newAutoLayoutView];
        [self.chapterTitle setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.chapterTitle setNumberOfLines:1];
        [self.chapterTitle setTextAlignment:NSTextAlignmentLeft];
        self.chapterTitle.text = @"Chapter Title";

        self.chapterNumber = [UILabel newAutoLayoutView];
        [self.chapterNumber setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.chapterNumber setNumberOfLines:1];
        [self.chapterNumber setTextAlignment:NSTextAlignmentLeft];

        // TODO - setup the fonts and sizes
        self.chapterNumber.text = @"Chapter Number";

        self.pagesLabel = [UILabel newAutoLayoutView];
        [self.pagesLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.pagesLabel setNumberOfLines:1];
        [self.pagesLabel setTextAlignment:NSTextAlignmentLeft];
        self.pagesLabel.text = @"Pages";

        [self.contentView addSubview:self.greyTopBar];
        [self.contentView addSubview:self.statusImage];
        [self.contentView addSubview:self.greyBottomBar];
        [self.contentView addSubview:self.chapterTitle];
        [self.contentView addSubview:self.chapterNumber];
        [self.contentView addSubview:self.pagesLabel];
        
        self.contributers = [NSMutableArray new];
        
        [self updateFonts];
        self.constraintsSetup = NO;
    }
    return self;
}
- (void)prepareForReuse {
    self.constraintsSetup = NO;
    NSInteger length = [self.contributers count];
    if (length) {
        for (NSInteger i=0; i<length; i++)
        {
            ContributerView *contributer = [self.contributers objectAtIndex:i];
            contributer.didSetupContraints = NO;
        }
    }
}

-(void) updateConstraints
{
    if (!self.constraintsSetup) {
        // setup the grey bar in the center.
        
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.greyTopBar autoSetContentCompressionResistancePriorityForAxis:NSLayoutAttributeCenterX];
        }];
        [self.greyTopBar autoSetDimension:NSLayoutAttributeWidth toSize:2];
        [self.greyTopBar autoPinEdgeToSuperviewEdge:NSLayoutAttributeTop withInset:0.0];
        [self.greyTopBar autoPinEdgeToSuperviewEdge:NSLayoutAttributeCenterX withInset:0.0];
        
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.statusImage autoSetContentCompressionResistancePriorityForAxis:NSLayoutAttributeCenterX];
        }];
        CGSize statusIconSize = {20,19};
        [self.statusImage autoSetDimensionsToSize:statusIconSize];
        [self.statusImage autoPinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeBottom ofView:self.greyTopBar withOffset:0.0];
        [self.statusImage autoPinEdgeToSuperviewEdge:NSLayoutAttributeCenterX withInset:0.0];
        
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.greyBottomBar autoSetContentCompressionResistancePriorityForAxis:NSLayoutAttributeCenterX];
        }];
        
        [self.greyBottomBar autoSetDimension:NSLayoutAttributeWidth toSize:2];
        [self.greyBottomBar autoPinEdgeToSuperviewEdge:NSLayoutAttributeBottom withInset:0.0];
        [self.greyBottomBar autoPinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeBottom ofView:self.statusImage withOffset:0.0];
        [self.greyBottomBar autoPinEdgeToSuperviewEdge:NSLayoutAttributeCenterX withInset:0.0];
        
        
        // now we have the centerline created, so align all the other elements off the centerline elements.
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.chapterTitle autoSetContentCompressionResistancePriorityForAxis:NSLayoutAttributeCenterX ];
        }];
        [self.chapterTitle autoPinEdgeToSuperviewEdge:NSLayoutAttributeLeading withInset:8.0];
        [self.chapterTitle autoPinEdgeToSuperviewEdge:NSLayoutAttributeTop withInset:8.0];
        [self.chapterTitle autoPinEdge:NSLayoutAttributeTrailing toEdge:NSLayoutAttributeLeading ofView:self.statusImage withOffset:8.0];

        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.chapterNumber autoSetContentCompressionResistancePriorityForAxis:NSLayoutAttributeCenterX ];
        }];
        [self.chapterNumber autoSetDimension:NSLayoutAttributeWidth toSize:142];
        [self.chapterNumber autoPinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeBottom ofView:self.chapterTitle withOffset:8.0];
        [self.chapterNumber autoPinEdge:NSLayoutAttributeTrailing toEdge:NSLayoutAttributeLeading ofView:self.statusImage withOffset:-8.0];
    
        [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self.pagesLabel autoSetContentCompressionResistancePriorityForAxis:NSLayoutAttributeCenterX ];
        }];
        [self.pagesLabel autoSetDimension:NSLayoutAttributeWidth toSize:142];
        [self.pagesLabel autoPinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeBottom ofView:self.chapterNumber withOffset:8.0];
        [self.pagesLabel autoPinEdge:NSLayoutAttributeTrailing toEdge:NSLayoutAttributeLeading ofView:self.statusImage withOffset:-8.0];
        
        
        NSInteger length = [self.contributers count];
        if (length) {
            ContributerView *contributer;
            for (NSInteger i=0; i<length; i++)
            {
                contributer = [self.contributers objectAtIndex:i];

                [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
                    [contributer autoSetContentCompressionResistancePriorityForAxis:NSLayoutAttributeCenterX ];
                }];

                if (i == 0) {
                    [contributer autoPinEdgeToSuperviewEdge:NSLayoutAttributeTop];
                    
                }
                else {
                    ContributerView *previous = [self.contributers objectAtIndex:i-1];
                    [contributer autoPinEdge:NSLayoutAttributeTop toEdge:NSLayoutAttributeBottom ofView:previous withOffset:8.0];
                }
                [contributer autoPinEdgeToSuperviewEdge:NSLayoutAttributeTrailing];
                [contributer autoPinEdge:NSLayoutAttributeLeading toEdge:NSLayoutAttributeTrailing ofView:self.statusImage withOffset:8.0];
                
            }
            [contributer autoPinEdgeToSuperviewEdge:NSLayoutAttributeBottom withInset:20.0];
        }
        else
            [self.pagesLabel autoPinEdgeToSuperviewEdge:NSLayoutAttributeBottom withInset:10.0];
        
        self.constraintsSetup = YES;
    }
    [super updateConstraints];
}

-(void) updateFonts
{
    self.chapterTitle.font = [UIFont fontWithName:@"ScalaSans" size:17.0];
    self.chapterNumber.font = [UIFont fontWithName:@"ScalaSans" size:12.0];
    self.pagesLabel.font = [UIFont fontWithName:@"ScalaSans-Italic" size:12.0];
    
    self.chapterTitle.textColor = [UIColor blackColor];
    self.chapterNumber.textColor = [UIColor grayColor];
    self.pagesLabel.textColor = [UIColor grayColor];
}

@end
