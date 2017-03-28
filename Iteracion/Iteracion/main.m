//
//  main.m
//  Iteracion
//
//  Created by Roberto Manuel Halgravez Perea on 3/28/17.
//  Copyright © 2017 RHalgravez. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //NSArray
        NSArray *list = @[@1, @2, @3];
        
        //Iterating classic way
        for (int i = 0; i < list.count; i++) {
            NSLog(@"El elemento %d vale %@", i, list[i]);
        }
        
        //Fast iteration
        for (id element in list) {
            NSLog(@"EL elemento vale %@", element);
        }
        
        //Blocks
        [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"El elemento %lu vale %@", idx, obj);
        }];
    }
    return 0;
}
