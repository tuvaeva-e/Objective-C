#import "Robot.h"


@implementation Robot

- (instancetype)init:(NSString *)name x:(NSInteger)x y:(NSInteger)y
{
    self = [super init];
    if (self)
    {
        _name = name;
        _x = x;
        _y = y;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self)
    {
        [self setName:[coder decodeObjectOfClass:[NSString class]
                                          forKey:@"RobotName"]];
        [self setX:[coder decodeIntegerForKey:@"RobotX"]];
        [self setY:[coder decodeIntegerForKey:@"RobotY"]];
    }
    return self;
}

+ (BOOL)supportsSecureCoding
{
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"RobotName"];
    [coder encodeInteger:self.x forKey:@"RobotX"];
    [coder encodeInteger:self.y forKey:@"RobotY"];
}

- (NSString *)description
{
    return [NSString
        stringWithFormat:@"Робот по имени: %@, x: %ld, y: %ld", _name, _x, _y];
}

@end