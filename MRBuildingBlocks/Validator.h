//
//  Validator.h

//

#import <Foundation/Foundation.h>

@interface Validator : NSObject

+ (BOOL)validateEmail:(NSString *)inputText;

+ (BOOL)validateName:(NSString *)inputText;

+ (BOOL)validatePhone:(NSString *)validatePhone;

@end
