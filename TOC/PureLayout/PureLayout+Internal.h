//
//  PureLayout+Internal.h
//  v2.0.5
//  https://github.com/smileyborg/PureLayout
//
//  Copyright (c) 2014-2015 Tyler Fox
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

#import "PureLayoutDefines.h"

/** A constant that represents the smallest valid positive value for the multiplier of a constraint,
    since a value of 0 will cause the second item to be lost in the internal auto layout engine. */
static const CGFloat kMULTIPLIER_MIN_VALUE = 0.00001; // very small floating point numbers (e.g. CGFLOAT_MIN) can cause problems


/**
 A category that exposes the internal (private) helper methods of the UIView+PureLayout category.
 */
@interface UIView (PureLayoutInternal)

+ (BOOL)al_preventAutomaticConstraintInstallation;
+ (NSMutableArray *)al_currentArrayOfCreatedConstraints;
+ (BOOL)al_isExecutingPriorityConstraintsBlock;
+ (UILayoutPriority)al_currentGlobalConstraintPriority;
+ (NSString *)al_currentGlobalConstraintIdentifier;
+ (void)al_applyGlobalStateToConstraint:(NSLayoutConstraint *)constraint;
- (void)al_addConstraint:(NSLayoutConstraint *)constraint;
- (UIView *)al_commonSuperviewWithView:(UIView *)otherView;
- (NSLayoutConstraint *)al_alignAttribute:(NSInteger)attribute toView:(UIView *)otherView forAxis:(NSInteger)axis;

@end


/**
 A category that exposes the internal (private) helper methods of the NSArray+PureLayout category.
 */
@interface NSArray (PureLayoutInternal)

- (UIView *)al_commonSuperviewOfViews;
- (BOOL)al_containsMinimumNumberOfViews:(NSUInteger)minimumNumberOfViews;
- (NSArray *)al_copyViewsOnly;

@end


/**
 A category that exposes the internal (private) helper methods of the NSLayoutConstraint+PureLayout category.
 */
@interface NSLayoutConstraint (PureLayoutInternal)

+ (NSLayoutAttribute)al_layoutAttributeForAttribute:(NSInteger)attribute;
+ (UILayoutConstraintAxis)al_constraintAxisForAxis:(NSInteger)axis;
#if __PureLayout_MinBaseSDK_iOS_8_0
+ (NSInteger)al_marginForEdge:(NSInteger)edge;
+ (NSInteger)al_marginAxisForAxis:(NSInteger)axis;
#endif /* __PureLayout_MinBaseSDK_iOS_8_0 */

@end
