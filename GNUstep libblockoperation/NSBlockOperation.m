//
//  NSBlockOperation.m
//  NSOGNUStepTools
//
//  Created by Jaufré Thumerel on 03/03/2015.
//  GNU LESSER GENERAL PUBLIC LICENSE
//  Version 3, 29 June 2007

#import "NSBlockOperation.h"

@implementation NSBlockOperation

-(NSMutableArray *)blockArray
{
    return blockArray;
}

-(id)init
{
    self = [super init];
    if (self) {
        blockArray = [[NSMutableArray alloc] init];
        lock = [[NSRecursiveLock alloc] init];
        addBlockLock = [[NSRecursiveLock alloc] init];
    }
    return self;
}

+ (id)blockOperationWithBlock:(void (^)(void))block
{
    id blockOperation = [[[self class] alloc] init];
    [[blockOperation blockArray] addObject:block];
    return blockOperation;
}

- (void)addExecutionBlock:(void (^)(void))block
{
    if ([addBlockLock lockBeforeDate:[NSDate distantFuture]]) {
        if ([lock tryLock]) {
            if ([self isFinished]) {
                [lock unlock];
                @throw [NSException exceptionWithName:NSInvalidArgumentException
                                               reason:@"Add block to executing Block Operation"
                                             userInfo:nil];
            }else{
                [blockArray addObject:block];
                [lock unlock];
            }
        }else{
            @throw [NSException exceptionWithName:NSInvalidArgumentException
                                           reason:@"Add block to executing Block Operation"
                                         userInfo:nil];
        }
        [addBlockLock unlock];
    }
}

-(NSArray *) executionBlocks
{
    return [NSArray arrayWithArray:blockArray];
}

-(void)main
{
    if ([lock lockBeforeDate:[NSDate distantFuture]]) {
        if(![self isCancelled]){
            for (int i = 0; i < [blockArray count]; i++) {
                if ([self isCancelled]) break;
                void (^block)() = [blockArray objectAtIndex:i];
                block();
            }
        }
        [lock unlock];
    }
}

@end
