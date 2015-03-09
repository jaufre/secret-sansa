//
//  NSOperationQueue+BlockOperation.h
//  PANGOGNUStepTools
//
//  Created by Jaufré Thumerel on 03/03/2015.
//

#import <Foundation/Foundation.h>

@interface NSOperationQueue (BlockOperation)

- (void)addOperationWithBlock:(void (^)(void))block;


@end
