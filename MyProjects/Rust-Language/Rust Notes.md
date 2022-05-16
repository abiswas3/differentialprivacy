# Some scratch notes made for myself while learning rust 

To modify a variable the scope must own the variable. It's not enough to have access to a reference.

To change data a reference points to we must declare explicitly a mutable reference but can only have 1 mutable reference to data at any point in time. This prevents the dangling pointer from C and prevents race conditions. 

From the book:
-   At any given time, you can have _either_ one mutable reference _or_ any number of immutable references.
-   References must always be valid

## Repositories of interest to me 

- [ ] https://github.com/snipsco/rust-threshold-secret-sharing 
- [ ]  