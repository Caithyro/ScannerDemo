//
//  OpenCVWrapper.h
//  ScannerDemo
//
//  Created by Дмитрий Куприенко on 22.02.2022.
//

#import <Foundation/Foundation.h>
#import "OpenCVWrapper.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenCVWrapper : NSObject

+ (UIImage *)toGray:(UIImage *)source;

@end

NS_ASSUME_NONNULL_END
