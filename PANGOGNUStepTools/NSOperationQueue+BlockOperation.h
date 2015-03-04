//
//  NSOperationQueue+BlockOperation.h
//  PANGOGNUStepTools
//
//  Created by Jaufré Thumerel on 03/03/2015.
//  GNU LESSER GENERAL PUBLIC LICENSE
//  Version 3, 29 June 2007

#import <Foundation/Foundation.h>

@interface NSOperationQueue (BlockOperation)

- (void)addOperationWithBlock:(void (^)(void))block;


@end
