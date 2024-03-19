#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Robot : NSObject <NSCoding, NSSecureCoding>

@property(nonatomic) NSString *name;
@property(nonatomic) NSInteger x;
@property(nonatomic) NSInteger y;

- (instancetype)init:(NSString *)name x:(NSInteger)x y:(NSInteger)y;
- (id)initWithCoder:(NSCoder *)coder;

@end

NS_ASSUME_NONNULL_END