//
//  PANGBlockOperationForGnuStepTests.m
//  PANGOGNUStepTools
//
//  Created by Jaufré Thumerel on 03/03/2015.
//  GNU LESSER GENERAL PUBLIC LICENSE
//  Version 3, 29 June 2007

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "PANGBlockOperation.h"

@interface PANGBlockOperationForGnuStepTests : XCTestCase
{
    NSOperationQueue *operationQueue;
    NSString *testString;
}

@end

@implementation PANGBlockOperationForGnuStepTests

- (void)setUp {
    [super setUp];
    operationQueue = [[NSOperationQueue alloc] init];
    testString = nil;
}

- (void)tearDown {
    [operationQueue waitUntilAllOperationsAreFinished];
    operationQueue = nil;
    [super tearDown];
}

- (void)testBlockOperationWithBlock {
    XCTAssertNil(testString);
    PANGBlockOperation *op = [PANGBlockOperation blockOperationWithBlock:^{
        testString = @"Hello";
    }];
    [operationQueue addOperation:op];
    [operationQueue waitUntilAllOperationsAreFinished];
    XCTAssertNotNil(testString);
    XCTAssertTrue([testString isEqualToString:@"Hello"]);
    
}

- (void)testBlockOperationWithBlockAdvanced {
    XCTAssertNil(testString);
    __block NSString *testString2 = @"Papy";
    PANGBlockOperation *op = [PANGBlockOperation blockOperationWithBlock:^{
        testString = @"Hello";
         XCTAssertTrue([testString2 isEqualToString:@"Papy"]);
        testString2 = @"Mamy";
        XCTAssertTrue([testString2 isEqualToString:@"Mamy"]);
    }];
    [operationQueue addOperation:op];
    [operationQueue waitUntilAllOperationsAreFinished];
    XCTAssertNotNil(testString);
    XCTAssertTrue([testString isEqualToString:@"Hello"]);
    XCTAssertTrue([testString2 isEqualToString:@"Mamy"]);
}

- (void)testAddExecutionBlock {
    XCTAssertNil(testString);
    PANGBlockOperation *op = [PANGBlockOperation blockOperationWithBlock:^{
        testString = @"Hello";
    }];
    [op addExecutionBlock:^{
        testString = [NSString stringWithFormat:@"%@ Papy",testString];
    }];
    [operationQueue addOperation:op];
    [operationQueue waitUntilAllOperationsAreFinished];
    XCTAssertNotNil(testString);
    XCTAssertTrue([testString isEqualToString:@"Hello Papy"]);
}

-(void)testExecutionsBlock
{
    XCTAssertNil(testString);
    void (^block1)() = ^{
        testString = @"Hello";
    };
    void (^block2)() = ^{
        testString = [NSString stringWithFormat:@"%@ Papy",testString];
    };
    PANGBlockOperation *op = [PANGBlockOperation blockOperationWithBlock:block1];
    [op addExecutionBlock:block2];
    [op addExecutionBlock:block2];
    [operationQueue addOperation:op];
    [operationQueue waitUntilAllOperationsAreFinished];
    XCTAssertNotNil(testString);
    XCTAssertTrue([testString isEqualToString:@"Hello Papy Papy"]);
    NSArray *arrayBlock = [op executionBlocks];
    XCTAssertEqual([arrayBlock count], 3);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
