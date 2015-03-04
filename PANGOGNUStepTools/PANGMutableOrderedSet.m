//
//  PANGMutableOrderedSet.m
//  OrderedSetForGnuStep
//
//  Created by Jaufré Thumerel on 05/02/2015.
//  GNU LESSER GENERAL PUBLIC LICENSE
//  Version 3, 29 June 2007

#import "PANGMutableOrderedSet.h"

@implementation PANGMutableOrderedSet

-(NSMutableArray *)mutableArray
{
    if ([array isKindOfClass:[NSMutableArray class]]) {
        return (NSMutableArray *) array;
    }
    return nil;
}

-(NSMutableSet *)mutableSet
{
    if ([set isKindOfClass:[NSMutableSet class]]) {
        return (NSMutableSet *) set;
    }
    return nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        lock = [[NSRecursiveLock alloc] init];
        array = [NSMutableArray array];
        set = [NSMutableSet set];
    }
    return self;
}

- (id) initWithObjects:(const id [])objects count:(NSUInteger)cnt
{
    self = [super init];
    if (self) {
        lock = [[NSRecursiveLock alloc] init];
        NSArray *tempArray = [[NSArray alloc] initWithObjects:objects count:cnt];
        NSMutableSet *mSet = [NSMutableSet set];
        NSMutableArray *mArray = [NSMutableArray array];
        for (int i = 0; i < [tempArray count]; i++) {
            id obj = [tempArray objectAtIndex:i];
            if (!obj) {
                [NSException raise: NSInvalidArgumentException
                            format: @"Tried to add nil to set"];
            }
            if (![mSet containsObject:obj]) {
                [mSet addObject:obj];
                [mArray addObject:obj];
            }
        }
        array = mArray;
        set = mSet;
    }
    return self;
}

- (id)initWithArray:(NSArray *)nArray
{
    self = [super init];
    if (self) {
        lock = [[NSRecursiveLock alloc] init];
        NSMutableSet *mSet = [NSMutableSet set];
        NSMutableArray *mArray = [NSMutableArray array];
        for (int i = 0; i < [nArray count]; i++) {
            id obj = [nArray objectAtIndex:i];
            if (!obj) {
                [NSException raise: NSInvalidArgumentException
                            format: @"Tried to add nil to set"];
            }
            if (![mSet containsObject:obj]) {
                [mSet addObject:obj];
                [mArray addObject:obj];
            }
        }
        array = mArray;
        set = mSet;
    }
    return self;
}

- (id) initWithCapacity:(NSUInteger)numItems
{
    self = [super init];
    if (self) {
        lock = [[NSRecursiveLock alloc] init];
        array = [[NSMutableArray alloc] initWithCapacity:numItems];
        set = [[NSMutableSet alloc] initWithCapacity:numItems];
    }
    return self;}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        lock = [[NSRecursiveLock alloc] init];
        array = [aDecoder decodeObjectForKey:@"array"];
        if (![array isKindOfClass:[NSMutableArray class]]) {
            return nil;
        }
        set = [NSMutableSet setWithArray:array];
    }
    return self;
}

- (void)insertObject:(id)object atIndex:(NSUInteger)idx
{
    if (!object) {
        [NSException raise: NSInvalidArgumentException
                    format: @"Tried to add nil to set"];
    }
    [lock lockBeforeDate:[NSDate distantFuture]];
    if (![self containsObject:object]) {
        [[self mutableArray] insertObject:object
                                  atIndex:idx];
        [[self mutableSet] addObject:object];
    }
    [lock unlock];
}

- (void)removeObjectAtIndex:(NSUInteger)idx
{
    if([lock lockBeforeDate:[NSDate distantFuture]]){
        id obj = [array objectAtIndex:idx];
        if (obj) {
            [[self mutableArray] removeObjectAtIndex:idx];
            [[self mutableSet] removeObject:obj];
        }
        [lock unlock];
    }
}

- (void)replaceObjectAtIndex:(NSUInteger)idx withObject:(id)object
{
    if (!object) {
        [NSException raise: NSInvalidArgumentException
                    format: @"Tried to add nil to set"];
    }
    if ([lock lockBeforeDate:[NSDate distantFuture]]) {
        if (![self containsObject:object]) {
            id obj = [array objectAtIndex:idx];
            if (obj) {
                [[self mutableArray] replaceObjectAtIndex:idx withObject:object];
                [[self mutableSet] removeObject:obj];
                [[self mutableSet] addObject:object];
            }
        }
        [lock unlock];
    }
}

- (void)addObject:(id)object
{
    if (!object) {
        [NSException raise: NSInvalidArgumentException
                    format: @"Tried to add nil to set"];
    }
    if([lock lockBeforeDate:[NSDate distantFuture]]){
        if (![self containsObject:object]) {
            [[self mutableArray] addObject:object];
            [[self mutableSet] addObject:object];
        }
        [lock unlock];
    }
}

- (void)addObjects:(const id [])objects count:(NSUInteger)count
{
    NSArray *tempArray = [[NSArray alloc] initWithObjects:objects count:count];
    [self addObjectsFromArray:tempArray];
}

- (void)addObjectsFromArray:(NSArray *)nArray
{
    if([lock lockBeforeDate:[NSDate distantFuture]]){
        for (int i = 0; i < [nArray count]; i++) {
            id obj = [nArray objectAtIndex:i];
            [self addObject:obj];
        }
        [lock unlock];
    }
}

- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2
{
    if ([lock lockBeforeDate:[NSDate distantFuture]]) {
        [[self mutableArray] exchangeObjectAtIndex:idx1
                                 withObjectAtIndex:idx2];
        [lock unlock];
    }
}

- (void)moveObjectsAtIndexes:(NSIndexSet *)indexes toIndex:(NSUInteger)idx
{
    if([lock lockBeforeDate:[NSDate distantFuture]]){
        NSArray *tempArray = [array objectsAtIndexes:indexes];
        for (id obj in tempArray){
            [[self mutableArray] removeObject:obj];
        }
        for (int i = 0; i < [tempArray count]; i++) {
            [[self mutableArray] insertObject:[tempArray objectAtIndex:i]
                                      atIndex:idx + i];
        }
        [lock unlock];
    }
}

- (void)insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes
{
    int i = 0;
    int idx = (int)[indexes firstIndex];
    if([lock lockBeforeDate:[NSDate distantFuture]]){
        while (i < [objects count]) {
            id obj = [objects objectAtIndex:i];
            if (!obj) {
                [NSException raise: NSInvalidArgumentException
                            format: @"Tried to add nil to set"];
            }
            [self insertObject:obj atIndex:idx];
            i++;
            idx = (int)[indexes indexGreaterThanIndex:idx];
        }
        [lock unlock];
    }
}

- (void)setObject:(id)obj atIndex:(NSUInteger)idx
{
    if (!obj) {
        [NSException raise: NSInvalidArgumentException
                    format: @"Tried to add nil to set"];
    }
    if([lock lockBeforeDate:[NSDate distantFuture]]){
        if (idx < [self count]) {
            [self replaceObjectAtIndex:idx withObject:obj];
        }
        else if (idx  == [self count]) {
            [self addObject:obj];
        }
        [lock unlock];
    }
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
    [self insertObject:obj atIndex:idx];
}

- (void)replaceObjectsInRange:(NSRange)range
                  withObjects:(const id [])objects
                        count:(NSUInteger)count
{
    NSArray *tempArray = [NSArray arrayWithObjects:objects
                                             count:count];
    if([lock lockBeforeDate:[NSDate distantFuture]]){
        NSUInteger min = count;
        if (min > range.length) {
            min = range.length;
        }
        for (int i = 0; i < min; i++) {
            id obj = [tempArray objectAtIndex:i];
            if (obj) {
                [self setObject:obj
                        atIndex:range.location + i];
            }
        }
        [lock unlock];
    }
}

- (void)replaceObjectsAtIndexes:(NSIndexSet *)indexes
                    withObjects:(NSArray *)objects
{
    if (!indexes || ! objects) {
        [NSException raise: NSInvalidArgumentException
                    format: @"Tried to add nil to set"];
    }
    if ([indexes count] != [objects count]){
        return;
    }
    NSUInteger i = 0;
    NSUInteger idx = [indexes firstIndex];
    if([lock lockBeforeDate:[NSDate distantFuture]]){
        while (i < [objects count]) {
            id obj = [objects objectAtIndex:i];
            if (obj) {
                [self setObject:obj
                        atIndex:idx];
            }
            i++;
            idx = [indexes indexGreaterThanIndex:idx];
        }
        [lock unlock];
    }
}

- (void)removeObjectsInRange:(NSRange)range
{
    NSMutableArray *tempArray = [NSMutableArray array];
    if([lock lockBeforeDate:[NSDate distantFuture]]){
        for (NSUInteger i = range.location; i < range.location + range.length; i++) {
            id obj = [self objectAtIndex:i];
            if (obj) {
                [tempArray addObject:obj];
            }
        }
        [self removeObjectsInArray:tempArray];
        [lock unlock];
    }
}

- (void)removeObjectsAtIndexes:(NSIndexSet *)indexes
{
    if ([lock lockBeforeDate:[NSDate distantFuture]]){
        NSArray *tempArray = [self objectsAtIndexes:indexes];
        [self removeObjectsInArray:tempArray];
        [lock unlock];
    }
}

- (void)removeAllObjects
{
    if([lock lockBeforeDate:[NSDate distantFuture]]){
        [[self mutableArray] removeAllObjects];
        [[self mutableSet] removeAllObjects];
        [lock unlock];
    }
}

- (void)removeObject:(id)object
{
    if (object) {
        if([lock lockBeforeDate:[NSDate distantFuture]]){
            [[self mutableSet] removeObject:object];
            [[self mutableArray] removeObject:object];
            [lock unlock];
        }
    }
}
- (void)removeObjectsInArray:(NSArray *)tempArray
{
    if([lock lockBeforeDate:[NSDate distantFuture]]){
        for (id obj in  tempArray) {
            if (obj) {
                [self removeObject:obj];
            }
        }
        [lock unlock];
    }
}

- (void)intersectOrderedSet:(PANGOrderedSet *)other
{
    NSMutableArray *tempArray = [NSMutableArray array];
    if([lock lockBeforeDate:[NSDate distantFuture]]){
        for (id obj in self) {
            if (![other containsObject:obj]) {
                [tempArray addObject:obj];
            }
        }
        [self removeObjectsInArray:tempArray];
        [lock unlock];
    }
}

- (void)minusOrderedSet:(PANGOrderedSet *)other
{
    if([lock lockBeforeDate:[NSDate distantFuture]]){
        for (id obj in other) {
            if ([self containsObject:obj]) {
                [self removeObject:obj];
            }
        }
        [lock unlock];
    }
}

- (void)unionOrderedSet:(PANGOrderedSet *)other
{
    if([lock lockBeforeDate:[NSDate distantFuture]]){
        for (id obj in other) {
            if (![self containsObject:obj]) {
                [self addObject:obj];
            }
        }
        [lock unlock];
    }
}

- (void)intersectSet:(NSSet *)other
{
    NSMutableArray *tempArray = [NSMutableArray array];
    if([lock lockBeforeDate:[NSDate distantFuture]]){
        for (id obj in self) {
            if (![other containsObject:obj]) {
                [tempArray addObject:obj];
            }
        }
        [self removeObjectsInArray:tempArray];
        [lock unlock];
    }
}

- (void)minusSet:(NSSet *)other;
{
    if([lock lockBeforeDate:[NSDate distantFuture]]){
        for (id obj in other) {
            [self removeObject:obj];
        }
        [lock unlock];
    }
}

- (void)unionSet:(NSSet *)other
{
    if([lock lockBeforeDate:[NSDate distantFuture]]){
        for (id obj in other) {
            if (![self containsObject:obj]) {
                [self addObject:obj];
            }
        }
        [lock unlock];
    }
}

- (void)sortUsingComparator:(NSComparator)cmptr
{
    if([lock lockBeforeDate:[NSDate distantFuture]]){
        [[self mutableArray] sortUsingComparator:cmptr];
        [lock unlock];
    }
}

- (void)sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr
{
    if([lock lockBeforeDate:[NSDate distantFuture]]){
        [[self mutableArray] sortWithOptions:opts
                             usingComparator:cmptr];
        [lock unlock];
    }
}

- (void)sortRange:(NSRange)range
          options:(NSSortOptions)opts
  usingComparator:(NSComparator)cmptr
{
    if([lock lockBeforeDate:[NSDate distantFuture]]){
        NSArray *tempArray = [array subarrayWithRange:range];
        NSArray *tempArraySorted = [tempArray sortedArrayUsingComparator:cmptr];
        for (int i = 0; i < [tempArraySorted count]; i++) {
            id obj = [tempArraySorted objectAtIndex:i];
            if (obj) {
                [[self mutableArray] replaceObjectAtIndex:range.location + i
                                               withObject:obj];
            }
        }
        [lock unlock];
    }
}

+ (id)orderedSetWithCapacity:(NSUInteger)numItems
{
    return[[[self class] alloc] initWithCapacity:numItems];
}

@end
