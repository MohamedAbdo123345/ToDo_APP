#import "Tasks.h"

@implementation Tasks
+(BOOL)supportsSecureCoding{
    return YES;
}
- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_desc forKey:@"description"];
    [coder encodeInt:_prio forKey:@"priority"];
    [coder encodeInt:_status forKey:@"status"];
    [coder encodeObject:_taskDate forKey:@"date"];
}

- (id)initWithCoder:(nonnull NSCoder *) coder {
    if(self = [super init]){
        _name = [coder decodeObjectOfClass:[NSString class] forKey:@"name"];
        _desc = [coder decodeObjectOfClass:[NSString class] forKey:@"description"];
        _prio = [coder decodeIntForKey:@"priority"];
        _status = [coder decodeIntForKey:@"status"];
        _taskDate = [coder decodeObjectOfClass:[NSDate class] forKey:@"date"];
    }
    return self;
}

- (BOOL)isSameAs:(Tasks*) taskaya{
    bool result = NO;
    if(
          [self.name isEqual:taskaya.name]
       && [self.desc isEqual:taskaya.desc]
       && self.prio == taskaya.prio
       && self.status == taskaya.status
       && [self.taskDate isEqualToDate:taskaya.taskDate]
       ){
        result = YES;
    }
    return result;
}

@end


