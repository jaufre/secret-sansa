//
//  NSOperationQueue+BlockOperation.m
//  PANGOGNUStepTools
//
//  Created by Jaufré Thumerel on 03/03/2015.
//  GNU LESSER GENERAL PUBLIC LICENSE
//  Version 3, 29 June 2007

#import "NSOperationQueue+BlockOperation.h"

@implementation NSOperationQueue (BlockOperation)

- (void)addOperationWithBlock:(void (^)(void))block
{
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:block];
    [self addOperation:blockOperation];
}


@end
