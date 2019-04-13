//
//  KJObjectSerializer.m
//  KJObjectSerialize
//
//  Created by Bhavesh Lathigara on 6/20/2010.
//  Copyright (c) 2010 Bhavesh Lathigara. All rights reserved.
//

#import "NSObject+KJSerializer.h"
#import "objc/runtime.h"

@implementation NSObject (KJObjectSerializer)

NSString* getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T') {
            return [[NSString alloc] initWithBytes:attribute + 3 length:strlen(attribute) - 4 encoding:NSASCIIStringEncoding];
        }
    }
    return @"@";
}

-(NSMutableDictionary *)getDictionary
{
    Class klass = self.class;
    if (klass == NULL) {
        return nil;
    }
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(klass, &outCount);
    NSMutableDictionary * results = [NSMutableDictionary dictionaryWithCapacity:outCount];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            
            NSString * value = [self valueForKey:propertyName];
            if (value) {
                [results setObject:value forKey:propertyName];
            }
        }
    }
    free(properties);
    
    return results;
}


-(void)setDictionary:(NSDictionary*)dictionary
{
    Class klass = self.class;
    if (klass == NULL) {
        return;
    }
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
        // Don't set null objects. Skip "id"
        if (![obj isMemberOfClass:[NSNull class]] && ![key isEqualToString:@"id"]) {
            @try {
                objc_property_t property = class_getProperty(klass, [key UTF8String]);
                if (property) {
                    NSString *properyType = getPropertyType(property);
                    if ([properyType isEqualToString:@"NSNumber"] && [obj isKindOfClass:[NSString class]]) {
                        // Force NSNumber mapping if value is NSString
                        static NSNumberFormatter * f;
                        if (!f) {
                            f = [[NSNumberFormatter alloc] init];
                            [f setNumberStyle:NSNumberFormatterDecimalStyle];
                            [f setMaximumFractionDigits:20];
                        }
                        NSNumber * num = [f numberFromString:obj];
                        [self setValue:num forKey:(NSString *)key];
                    }
                    else {
                        [self setValue:obj forKey:(NSString *)key];
                    }
                }
            }
            @catch (NSException *exception) {
                // Ignore
                //NSLog(@"Exception while enumerating object: %@", exception.description);
            }
        }
    }];
}

@end
