//
//  NSOperationQueue+BlockOperation.m
//  PANGOGNUStepTools
//
//  Created by Jaufré Thumerel on 03/03/2015.
//

#import "NSOperationQueue+BlockOperation.h"
#import "NSBlockOperation.h"

@implementation NSOperationQueue (BlockOperation)

- (void)addOperationWithBlock:(void (^)(void))block
{
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:block];
    [self addOperation:blockOperation];
}


@end
