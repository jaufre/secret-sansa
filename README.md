# secret-sansa
Complement for GNUStep

This repository propose dirty implementation of missed class for GNUStep.
For the moment : NSOrderedSet.h and NSMutableOrderedSet.h

Warning : this dirty implementation is not thread safe.

In xcode-project, there are the booth class and unit- test. The NS Prefix is replaced by PANG.

In GNUStep Version folder, there is a version with normal prefix, GNUMakeFile and GNUmakefile.preamble.
GNUmakefile.preamble should be adapted to the setup environment. GNUMakeFile build and install a library orderedSet in 
GNUStep library with two headers :

orderedSet/NSOrderedSet.h  and orderedSet/NSMutableOrderedSet.h
