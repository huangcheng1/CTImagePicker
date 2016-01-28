//
//  CTConfig.h
//  Pods
//
//  Created by 黄成 on 16/1/6.
//
//

#ifndef CTConfig_h
#define CTConfig_h

#define CTImagePickerLoc(key) NSLocalizedStringWithDefaultValue((key), @"Loc",[NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:@"CTImagePicker" ofType:@"bundle"]]?:[NSBundle mainBundle], nil, nil)

#define CTImagePickerImg(key)  [NSString stringWithFormat:@"CTImagePicker.bundle/%@",(key)]

#define kCTSelectedImageKey @"kCTSelectedImageKey"

#define TARGET_VERSION_8_0 [[[UIDevice currentDevice]systemVersion] floatValue] > 7.9 ? YES : NO

#endif /* CTConfig_h */
