```objectivec
#import <Foundation/Foundation.h>

@interface MyClass : NSObject
@property (nonatomic, strong) NSString *myString;
@end

@implementation MyClass
- (void)dealloc {
    NSLog(@"MyClass deallocated");
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        MyClass *obj = [[MyClass alloc] init];
        NSObject *observer = [[NSObject alloc] init];

        // Observe the myString property
        [obj addObserver:observer forKeyPath:@"myString" options:NSKeyValueObservingOptionNew context:nil];

        // Set the observed property
        obj.myString = @"Hello";

        // Remove the observer before releasing the observed object
        [obj removeObserver:observer forKeyPath:@"myString"];

        // Release the observed object
        [obj release];
        obj = nil;
        [observer release];
    }
    return 0;
}
```

**Key Change:** The solution adds `[obj removeObserver:observer forKeyPath:@"myString"];` before releasing `obj`.  This ensures that the observer is properly removed, preventing any issues when the observed object is deallocated.