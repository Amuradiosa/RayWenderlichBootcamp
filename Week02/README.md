\# Discussion choice of struct or class for BullsEyeGame

\### I chose struct from the start for these reasons:

- Apple recommends to start with struct(simpler, faster, deep copies, true immutability, no memory leaks, threadsafe) and change it to class if needed later on<br/>
- we only have one viewController(one owner for the game instance), so we don't pass BullsEyeGame around, it kind of sit in our only controller.<br/>
- didn't need inheritance.<br/>
- There was no need to choose class for backward compatibility, as we didn't work with objective-c code.<br/>