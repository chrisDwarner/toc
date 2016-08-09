//
//  PureLayoutDefines.h
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

#ifndef PureLayoutDefines_h
#define PureLayoutDefines_h

#import <Foundation/Foundation.h>

#define __PureLayout_MinBaseSDK_iOS_8_0                   TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
#define __PureLayout_MinSysVer_iOS_7_0                    TARGET_OS_IPHONE && floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1
#define __PureLayout_MinSysVer_iOS_8_0                    TARGET_OS_IPHONE && floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1

#import <UIKit/UIKit.h>
#pragma mark PureLayout Attributes

/** A block containing method calls to the PureLayout API. Takes no arguments and has no return value. */
typedef void(^ALConstraintsBlock)(void);

#endif /* PureLayoutDefines_h */
