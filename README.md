DCP Detective
=============
The DCP Detective is a program to read Digital Cinema Package (DCP) files, and
to detect and correct common errors in such files.  The DCP Detective is
privately licensed; all rights reserved.

Glossary
--------
* CPL: Cinema Play List
* DCI: Digital Cinema Initiative
* KDM: Key Delivery Management; used to decrypt files

TODO
----
* Read ext2 filesystems
* Parse MXF and XML files, as well as other DCP components

Architecture
------------
DCPs are collections of files:

__Pictures__ are stored in one or more _reels_:
Reels correspond to MXF files in JPEG2000 format.
TODO: Supported frame rates are...

__Sounds__ are stored in one or more reels, corresponding to picture reels.
Reels are PCMs having 24-bit samples @ 48 KHz or 96 KHz.

__Asset map files__ are XML manifests listing all other files in the DCP.

__CPL files__ are _composition playlist_ XML files defining the playback sequence.
Each reel is defined by a distinct UUID, and contains both picture and sound.

__PKL files__ are packing lists, and report hashes, sizes, and types of other files.
