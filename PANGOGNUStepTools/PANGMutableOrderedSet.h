//
//  PANGMutableOrderedSet.h
//  OrderedSetForGnuStep
//
//  Created by Jaufré Thumerel on 05/02/2015.
//  GNU LESSER GENERAL PUBLIC LICENSE
//  Version 3, 29 June 2007

#import <Foundation/Foundation.h>
#import "PANGOrderedSet.h"

@interface PANGMutableOrderedSet : PANGOrderedSet
{
    NSRecursiveLock *lock;
}

- (id) init;
- (id) initWithObjects:(const id [])objects count:(NSUInteger)cnt;
- (id) initWithArray:(NSArray *)array;
- (id) initWithCapacity:(NSUInteger)numItems;
- (id) initWithCoder:(NSCoder *)aDecoder;

- (void)insertObject:(id)object atIndex:(NSUInteger)idx;
- (void)removeObjectAtIndex:(NSUInteger)idx;
- (void)replaceObjectAtIndex:(NSUInteger)idx withObject:(id)object;

- (void)addObject:(id)object;
- (void)addObjects:(const id [])objects count:(NSUInteger)count;
- (void)addObjectsFromArray:(NSArray *)array;

- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
- (void)moveObjectsAtIndexes:(NSIndexSet *)indexes toIndex:(NSUInteger)idx;

- (void)insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes;

- (void)setObject:(id)obj atIndex:(NSUInteger)idx;
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;

- (void)replaceObjectsInRange:(NSRange)range withObjects:(const id [])objects count:(NSUInteger)count;
- (void)replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects;

- (void)removeObjectsInRange:(NSRange)range;
- (void)removeObjectsAtIndexes:(NSIndexSet *)indexes;
- (void)removeAllObjects;

- (void)removeObject:(id)object;
- (void)removeObjectsInArray:(NSArray *)array;

- (void)intersectOrderedSet:(PANGOrderedSet *)other;
- (void)minusOrderedSet:(PANGOrderedSet *)other;
- (void)unionOrderedSet:(PANGOrderedSet *)other;

- (void)intersectSet:(NSSet *)other;
- (void)minusSet:(NSSet *)other;
- (void)unionSet:(NSSet *)other;

- (void)sortUsingComparator:(NSComparator)cmptr;
- (void)sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr;
- (void)sortRange:(NSRange)range options:(NSSortOptions)opts usingComparator:(NSComparator)cmptr;

+ (id)orderedSetWithCapacity:(NSUInteger)numItems;

@end
