# GeekGameBoard

**Originally by [Jens Alfke](http://mooseyard.lighthouseapp.com/projects/23201/home)**  
**Git port by Cherif Yaya**
**Bug fixes by Sidharth Juyal**

GeekGameBoard is an example of using Core Animation to present the user interface of a board or card game. It implements a small framework for implementing such games, with domain-specific classes like "Grid" and "Piece", and examples of several game definitions built on top of the framework.

Some of the generally-useful Core Animation techniques illustrated are:

* Hit testing
* Dragging CALayers with the mouse
* Loading images from files and setting them as layer contents
* 3D "card-flip" animations

## History

I wrote GeekGameBoard in 2007 while at Apple, which published it as sample code. Apple's sample code license allows unrestricted use of the source code, requiring only that you keep their copyright notice in an unmodified distribution.

I am no longer employed by Apple. To encourage further development of this framework, in March 2008 I created this open source project (under a BSD license) based on a slightly-evolved version of the published sample code.

1.0: Original Apple sample code release (12/19/2007)  
2.0: First open source release. (Major version number bumped to avoid conflict with any future Apple revisions.) No longer requires garbage collection. Fixed some memory leaks of CG objects. Fixed a bug when advancing to the 8th row in the Checkers game. (3/7/2008)

## Project Description

#### Important Classes

A __Bit__ is a moveable object in a game, either a __Card __ or a __Piece__.  
A __BitHolder__ is a container for Bits; they can be dragged into and/or out of it. Typical BitHolders are __GridCells__ (the squares/hexes in a board), __Deck__s or __Stack__s of cards, and __Dispenser__s (supplies of new pieces.)  
A __Grid__ is a regular arrangement of GridCells; rectangular and hex grids are implemented.  
__BoardView__ is the _NSView_ whose layer hosts all of the above. It also tracks mouse events so the user can drag Bits.  
__Game__ represents the rules of a particular game. It sets up the pieces/cards/grids that make up the game, decides which moves are legal, keeps track of whose turn it is, and decides when someone's won.  
__Player__ is a passive object that represents one of the players in a Game.

#### Class Hierarchy

(Underlined classes are from external frameworks; italic classes are abstract.)

```
CALayer

|-- Bit
|---- Card
|------ PlayingCard
|---- DraggedStack
|---- Piece
|------ DiscPiece
|-- BitHolder*
|---- GridCell
|------ Hex
|------ Square
|-------- GoSquare
|---- Deck
|---- Dispenser
|---- Stack
|-- Grid
|---- HexGrid
|---- RectGrid
```

```
NSView

|-- BoardView
```

```
NSObject
 
|-- Game
|---- TicTacToeGame (etc...)
|-- Player
```

*BitHolder is actually both a protocol, and a class that implements the protocol. I've combined them here, for simplicity.*


#### Related Information

* [Apple's original GeekGameBoard sample code](http://developer.apple.com/samplecode/GeekGameBoard/)
* [Core Animation Programming Guide](http://developer.apple.com/documentation/Cocoa/Conceptual/CoreAnimation_guide/index.html)
* [Quartz 2D Programming Guide: Creating Images](http://developer.apple.com/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_images/chapter_12_section_4.html)
* [Quartz 2D Programming Guide: Patterns](http://developer.apple.com/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_patterns/chapter_7_section_1.html))
* [Quartz 2D Programming Guide: Paths](http://developer.apple.com/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_paths/chapter_4_section_1.html)
