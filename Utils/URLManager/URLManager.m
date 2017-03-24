#import "URLManager.h"

@implementation URLManager

+(URLManager*)shareURLManager{
    static URLManager *_sharedURLManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedURLManager = [[self alloc] init];
    });
    return _sharedURLManager;
}
+(NSString*) rootURl{
    return opBaseURLString;
}

+(NSString*) getListCurrencyURLString{
    return [[self rootURl] stringByAppendingString:opGetListCurrency];
}

@end
