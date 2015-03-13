# secret-sansa
Complement for GNUStep

This repository propose dirty implementation of missed class for GNUStep.
For the moment : NSOrderedSet, NSMutableOrderedSet, NSBlockOperation, and a categorie for NSOperationQueue (NSOperationQueue+BlockOperation).

Warning : this dirty implementation of NSMutableOrderedSet is not realy thread safe.

In xcode-project, there are the four class and unit- test. The NS Prefix is replaced by PANG.

There is two folder for GNUstep version : GNUstep_libblockoperation and GNUstep_liborderedset.
In this folder, GNUmakefile.preamble should be adapted to the setup environment. 
Compile liborderedset and libblockoperation need clang and objective c runtime compiled with clang, block support, arc, ...

To compile liborderedset:

    $cd ~
    $git clone https://github.com/jaufre/secret-sansa
    $cd ~/secret-sansa/GNUstep_liborderedset
    $make  
    $sudo make install  
    $sudo ldconfig  
  
Usage :  

    #import <orderedSet/NSOrderedSet.h>  
    #import <orderedSet/NSMutableOrderedSet.h>  
    
To compile libblockoperation:  

    $cd ~/secret-sansa/GNUstep_libblockoperation
    $make  
    $sudo make install  
    $sudo ldconfig
  
Usage :    

    #import <blockOperation/NSBlockOperation.h>
    #import <blockOperation/NSOperationQueue+BlockOperation>
