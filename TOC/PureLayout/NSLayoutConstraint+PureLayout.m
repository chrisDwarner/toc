//
//  NSLayoutConstraint+PureLayout.m
//  v2.0.5
//  https://github.com/smileyborg/PureLayout
//
//  Copyright (c) 2013-2015 Tyler Fox
//
//  This code is distributed under the terms and conditions of the MIT license.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//

#import "NSLayoutConstraint+PureLayout.h"
#import "UIView+PureLayout.h"
#import "PureLayout+Internal.h"


#pragma mark - NSLayoutConstraint+PureLayout

@implementation NSLayoutConstraint (PureLayout)


#pragma mark Installing & Removing Constraints

/**
 Activates the constraint.
 */
- (void)autoInstall
{
#if __PureLayout_MinBaseSDK_iOS_8_0 || __PureLayout_MinBaseSDK_OSX_10_10
    if ([self respondsToSelector:@selector(setActive:)]) {
        [UIView al_applyGlobalStateToConstraint:self];
        if ([UIView al_preventAutomaticConstraintInstallation]) {
            [[UIView al_currentArrayOfCreatedConstraints] addObject:self];
        } else {
            self.active = YES;
        }
        return;
    }
#endif /* __PureLayout_MinBaseSDK_iOS_8_0 || __PureLayout_MinBaseSDK_OSX_10_10 */
    
    NSAssert(self.firstItem || self.secondItem, @"Can't install a constraint with nil firstItem and secondItem.");
    if (self.firstItem) {
        if (self.secondItem) {
            NSAssert([self.firstItem isKindOfClass:[UIView class]] && [self.secondItem isKindOfClass:[UIView class]], @"Can only automatically install a constraint if both items are views.");
            UIView *commonSuperview = [self.firstItem al_commonSuperviewWithView:self.secondItem];
            [commonSuperview al_addConstraint:self];
        } else {
            NSAssert([self.firstItem isKindOfClass:[UIView class]], @"Can only automatically install a constraint if the item is a view.");
            [self.firstItem al_addConstraint:self];
        }
    } else {
        NSAssert([self.secondItem isKindOfClass:[UIView class]], @"Can only automatically install a constraint if the item is a view.");
        [self.secondItem al_addConstraint:self];
    }
}

/**
 Deactivates the constraint.
 */
- (void)autoRemove
{
#if __PureLayout_MinBaseSDK_iOS_8_0 || __PureLayout_MinBaseSDK_OSX_10_10
    if ([self respondsToSelector:@selector(setActive:)]) {
        self.active = NO;
        return;
    }
#endif /* __PureLayout_MinBaseSDK_iOS_8_0 || __PureLayout_MinBaseSDK_OSX_10_10 */
    
    if (self.secondItem) {
        UIView *commonSuperview = [self.firstItem al_commonSuperviewWithView:self.secondItem];
        while (commonSuperview) {
            if ([commonSuperview.constraints containsObject:self]) {
                [commonSuperview removeConstraint:self];
                return;
            }
            commonSuperview = commonSuperview.superview;
        }
    }
    else {
        [self.firstItem removeConstraint:self];
        return;
    }
    NSAssert(nil, @"Failed to remove constraint: %@", self);
}


#pragma mark Identify Constraints

#if __PureLayout_MinBaseSDK_iOS_8_0 || __PureLayout_MinBaseSDK_OSX_10_10

/**
 Sets the string as the identifier for this constraint. Available in iOS 7.0 and OS X 10.9 and later.
 The identifier will be printed along with the constraint's description.
 This is helpful to document a constraint's purpose and aid in debugging.
 
 @param identifier A string used to identify this constraint.
 @return This constraint.
 */
- (instancetype)autoIdentify:(NSString *)identifier
{
    if ([self respondsToSelector:@selector(setIdentifier:)]) {
        self.identifier = identifier;
    }
    return self;
}

#endif /* __PureLayout_MinBaseSDK_iOS_8_0 || __PureLayout_MinBaseSDK_OSX_10_10 */


#pragma mark Internal Methods

/**
 Returns the corresponding NSLayoutAttribute for the given NSInteger.
 
 @return The layout attribute for the given NSInteger.
 */
+ (NSLayoutAttribute)al_layoutAttributeForAttribute:(NSInteger)attribute
{
    NSLayoutAttribute layoutAttribute = NSLayoutAttributeNotAnAttribute;
    switch (attribute) {
        case NSLayoutAttributeLeft:
            layoutAttribute = NSLayoutAttributeLeft;
            break;
        case NSLayoutAttributeRight:
            layoutAttribute = NSLayoutAttributeRight;
            break;
        case NSLayoutAttributeTop:
            layoutAttribute = NSLayoutAttributeTop;
            break;
        case NSLayoutAttributeBottom:
            layoutAttribute = NSLayoutAttributeBottom;
            break;
        case NSLayoutAttributeLeading:
            layoutAttribute = NSLayoutAttributeLeading;
            break;
        case NSLayoutAttributeTrailing:
            layoutAttribute = NSLayoutAttributeTrailing;
            break;
        case NSLayoutAttributeWidth:
            layoutAttribute = NSLayoutAttributeWidth;
            break;
        case NSLayoutAttributeHeight:
            layoutAttribute = NSLayoutAttributeHeight;
            break;
        case NSLayoutAttributeCenterX:
            layoutAttribute = NSLayoutAttributeCenterX;
            break;
        case NSLayoutAttributeCenterY:
            layoutAttribute = NSLayoutAttributeCenterY;
            break;
        case NSLayoutAttributeBaseline: // same value as ALAxisLastBaseline
            layoutAttribute = NSLayoutAttributeBaseline;
            break;
#if __PureLayout_MinBaseSDK_iOS_8_0
        case NSLayoutAttributeFirstBaseline:
            NSAssert(__PureLayout_MinSysVer_iOS_8_0, @"NSLayoutAttributeFirstBaseline is only supported on iOS 8.0 or higher.");
            layoutAttribute = NSLayoutAttributeFirstBaseline;
            break;
        case NSLayoutAttributeLeftMargin:
            NSAssert(__PureLayout_MinSysVer_iOS_8_0, @"ALEdgeLeftMargin is only supported on iOS 8.0 or higher.");
            layoutAttribute = NSLayoutAttributeLeftMargin;
            break;
        case NSLayoutAttributeRightMargin:
            NSAssert(__PureLayout_MinSysVer_iOS_8_0, @"ALEdgeRightMargin is only supported on iOS 8.0 or higher.");
            layoutAttribute = NSLayoutAttributeRightMargin;
            break;
        case NSLayoutAttributeTopMargin:
            NSAssert(__PureLayout_MinSysVer_iOS_8_0, @"ALEdgeTopMargin is only supported on iOS 8.0 or higher.");
            layoutAttribute = NSLayoutAttributeTopMargin;
            break;
        case NSLayoutAttributeBottomMargin:
            NSAssert(__PureLayout_MinSysVer_iOS_8_0, @"ALEdgeBottomMargin is only supported on iOS 8.0 or higher.");
            layoutAttribute = NSLayoutAttributeBottomMargin;
            break;
        case NSLayoutAttributeLeadingMargin:
            NSAssert(__PureLayout_MinSysVer_iOS_8_0, @"ALEdgeLeadingMargin is only supported on iOS 8.0 or higher.");
            layoutAttribute = NSLayoutAttributeLeadingMargin;
            break;
        case NSLayoutAttributeTrailingMargin:
            NSAssert(__PureLayout_MinSysVer_iOS_8_0, @"ALEdgeTrailingMargin is only supported on iOS 8.0 or higher.");
            layoutAttribute = NSLayoutAttributeTrailingMargin;
            break;
        case NSLayoutAttributeCenterXWithinMargins:
            NSAssert(__PureLayout_MinSysVer_iOS_8_0, @"ALAxisVerticalMargin is only supported on iOS 8.0 or higher.");
            layoutAttribute = NSLayoutAttributeCenterXWithinMargins;
            break;
        case NSLayoutAttributeCenterYWithinMargins:
            NSAssert(__PureLayout_MinSysVer_iOS_8_0, @"ALAxisHorizontalMargin is only supported on iOS 8.0 or higher.");
            layoutAttribute = NSLayoutAttributeCenterYWithinMargins;
            break;
#endif /* __PureLayout_MinBaseSDK_iOS_8_0 */
        default:
            NSAssert(nil, @"Not a valid NSInteger.");
            break;
    }
    return layoutAttribute;
}

/**
 Returns the corresponding UILayoutConstraintAxis for the given NSInteger.
 
 @return The constraint axis for the given axis.
 */
+ (UILayoutConstraintAxis)al_constraintAxisForAxis:(NSInteger)axis
{
    UILayoutConstraintAxis constraintAxis;
    switch (axis) {
        case NSLayoutAttributeCenterX:
            constraintAxis = UILayoutConstraintAxisVertical;
            break;
        case NSLayoutAttributeCenterY:
        case NSLayoutAttributeBaseline: // same value as ALAxisLastBaseline
#if __PureLayout_MinBaseSDK_iOS_8_0
        case NSLayoutAttributeFirstBaseline:
#endif /* __PureLayout_MinBaseSDK_iOS_8_0 */
            constraintAxis = UILayoutConstraintAxisHorizontal;
            break;
        default:
            NSAssert(nil, @"Not a valid NSInteger.");
            constraintAxis = UILayoutConstraintAxisHorizontal; // default to a random value to satisfy the compiler
            break;
    }
    return constraintAxis;
}

#if __PureLayout_MinBaseSDK_iOS_8_0

/**
 Returns the corresponding margin for the given edge.
 
 @param edge The edge to convert to the corresponding margin.
 @return The margin for the given edge.
 */
+ (NSInteger)al_marginForEdge:(NSInteger)edge
{
    NSAssert(__PureLayout_MinSysVer_iOS_8_0, @"Margin attributes are only supported on iOS 8.0 or higher.");
    NSInteger margin;
    switch (edge) {
        case NSLayoutAttributeLeft:
            margin = NSLayoutAttributeLeftMargin;
            break;
        case NSLayoutAttributeRight:
            margin = NSLayoutAttributeRightMargin;
            break;
        case NSLayoutAttributeTop:
            margin = NSLayoutAttributeTopMargin;
            break;
        case NSLayoutAttributeBottom:
            margin = NSLayoutAttributeBottomMargin;
            break;
        case NSLayoutAttributeLeading:
            margin = NSLayoutAttributeLeadingMargin;
            break;
        case NSLayoutAttributeTrailing:
            margin = NSLayoutAttributeTrailingMargin;
            break;
        default:
            NSAssert(nil, @"Not a valid NSInteger.");
            margin = NSLayoutAttributeLeftMargin; // default to a random value to satisfy the compiler
            break;
    }
    return margin;
}

/**
 Returns the corresponding margin axis for the given axis.
 
 @param axis The axis to convert to the corresponding margin axis.
 @return The margin axis for the given axis.
 */
+ (NSInteger)al_marginAxisForAxis:(NSInteger)axis
{
    NSAssert(__PureLayout_MinSysVer_iOS_8_0, @"Margin attributes are only supported on iOS 8.0 or higher.");
    NSInteger marginAxis;
    switch (axis) {
        case NSLayoutAttributeCenterX:
            marginAxis = NSLayoutAttributeCenterXWithinMargins;
            break;
        case NSLayoutAttributeCenterY:
            marginAxis = NSLayoutAttributeCenterYWithinMargins;
            break;
        case NSLayoutAttributeBaseline:
        case NSLayoutAttributeFirstBaseline:
            NSAssert(nil, @"The baseline axis attributes do not have corresponding margin axis attributes.");
            marginAxis = NSLayoutAttributeCenterXWithinMargins; // default to a random value to satisfy the compiler
            break;
        default:
            NSAssert(nil, @"Not a valid NSInteger.");
            marginAxis = NSLayoutAttributeCenterXWithinMargins; // default to a random value to satisfy the compiler
            break;
    }
    return marginAxis;
}

#endif /* __PureLayout_MinBaseSDK_iOS_8_0 */

@end
