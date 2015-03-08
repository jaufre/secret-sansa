//
//  PANGBlockOperation.h
//  PANGOGNUStepTools
//
//  Created by Jaufré Thumerel on 03/03/2015.
//  GNU LESSER GENERAL PUBLIC LICENSE
//  Version 3, 29 June 2007

#import <Foundation/Foundation.h>

@interface PANGBlockOperation : NSOperation
{
    NSMutableArray *blockArray;
    NSRecursiveLock *lock;
    NSRecursiveLock *addBlockLock;
}

+ (id)blockOperationWithBlock:(void (^)(void))block;

- (void)addExecutionBlock:(void (^)(void))block;

-(NSArray *) executionBlocks;

@end
