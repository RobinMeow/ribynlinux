# Game Engine

choosing a game engine (listening only the downsides, as they all have their pros).

## Unreal Editor

Cpp development iteration is absolutly dog****.
in an empty project, expect to lose 30-60s for making a change,
closing the editor, recompiling the editor, opening it back up to see the change.
As the project grows larger, compile time, scene load, and recreating game state for testing
grows larger, this loop also becomes larger.
Verse should be the solution to this, but planned for 2029 (early access 2027 w/e that means)

## Unity

Closed source.
Basic things, like file extensions are missing.
Trust is gone, since they tried to completely nuke indie game dev
just to make more money.

## Godot

Missing features.
gdscript is not ripe yet and doesnt look worthwhile learning either, nor fun.
Csharp support is not full, and already being post-poned (e.g. it lacks browser support)
Cpp is really supported, even tho say it is. (Its supported through GDExtensions, instead of being able to
write based of the engine or having native support like csharp) instead you have to write you own adapter.

## Bevy

good for solo dev I supposed, j4f.

