//
// Created by Sidharth Juyal on 04/07/2022.
// Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
// 

#ifndef GGB_h
#define GGB_h

#ifdef __OBJC__
  #import <TargetConditionals.h>
  #import <Foundation/Foundation.h>

  #if TARGET_OS_IPHONE
    #import <UIKit/UIKit.h>
    #import <QuartzCore/QuartzCore.h>
  #else
    #import <Cocoa/Cocoa.h>
    #import <Quartz/Quartz.h>
  #endif
#endif

#endif /* GGB_h */
