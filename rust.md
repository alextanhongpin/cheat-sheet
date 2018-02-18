## Editor integration

```bash
$ cargo install rustfmt
$ cargo install racer

# Add to rutup
$ rustup component add rust-src
```

At your Visual Studio Code settings, enable autofmt for Rust:

```
"[rust]": {
    "editor.formatOnSave": true
}
```

## Types

- bool: Booleans `true`, `false`
- u8/u16/u32/u64: Fixed size unsigned integers
- i8, i16, i32, i64: Fixed size signed integers
- f32, f64: Fixed size floats
- usize: Architecture-dependant unsigned integer
- isize: Architecture-dependant signer integer
- char: Single unicode character
- str: String slice
- [T; N]: Fixed-size array. N number of T values
- &[T]: Slices
- (T1, T2, ...): Tuples
- fn(T1, T2, ...) -> R: Functions that take types `T1, T2, ...` as parameters, returns value of type `R`


## Basic Test

```rust
pub fn sum(a: i8, b: i8) -> i8 {
    a + b
}

#[cfg(test)]
mod tests {
    // use sum;
    fn sum_inputs_and_outputs() -> Vec<((i8, i8), i8)> {
        vec![
            ((1, 2), 3),
            ((2, 3), 5),
            ((4, 5), 9)
        ]
    }

    #[test]
    fn it_works() {
        for (input, output) in sum_inputs_and_outputs() {
            assert_eq!(::sum(input.0, input.1), output);
        }
    }

    #[test]
    #[ignore]
    fn ignore_this_test() {
        println!("tested");
        assert!(true);
    }
}
```

## Pass in string slice

If you are passing a string to a function, use the `&str` type - a string slice is an acceptable input parameter not only for actual string slice referefences but also for `String` references.
```rust
fn say_hello(to_whom: &str) {
  println!("Hey {}", to_whom);
}

fn main() {
  let string_slice: &'static str = "you";
  let string: String = string_slice.into(); // Requet a new `String` type to be created from a string slice

  say_hello(string_slice);
  say_hello(&string);
}
```

## String methods
```rust
fn main() {
  let mut empty_string = String::new();
  let empty_string_with_capacity = String::with_capacity(50);
  let string_from_bytestring: String =
    String::from_utf8(vec![82, 85, 83, 84]).expect("Creating string from bytestring failed");

  println!("empty_string: {}", empty_string);
  println!(
    "empty_string_with_capacity: |{}|",
    empty_string_with_capacity
  );
  println!("string_from_bytestring: {}", string_from_bytestring);

  empty_string.push('a');
  println!(
    "empty string is now {} with len {}",
    empty_string,
    empty_string.len()
  );

  empty_string.push_str("hi! world!");
  println!(
    "empty string is now {} with len {}",
    empty_string,
    empty_string.len()
  );
}
```

Output: 

```
empty_string:
empty_string_with_capacity: ||
string_from_bytestring: RUST
empty string is now a with len 1
empty string is now ahi! world! with len 11
```

## Array
```rust
fn main() {
  let mut integer_array_1 = [1, 2, 3];
  let integer_array_2: [u64; 3] = [1, 2, 3];
  let integer_array_3: [u64; 32] = [0; 32];
  // let integer_array_4: [i32; 16438] = [-5; 16438];
  integer_array_1[0] = 255;

  println!("1: {:?}", integer_array_1);
  println!("2: {:?}", integer_array_2);
  println!("3: {:?}", integer_array_3);
  // println!("4: {:?}", integer_array_4);
}
```
Output:

```
1: [255, 2, 3]
2: [1, 2, 3]
3: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
```

## Slice Usage

```rust
use std::fmt::Debug;

fn print_slice<T: Debug>(slice: &[T]) {
  println!("{:?}", slice);
}

fn main() {
  let array: [u8; 5] = [1, 2, 3, 4, 5];

  println!("Whole array just borrowed:");
  print_slice(&array);

  println!("Whole array sliced:");
  print_slice(&array[..]);

  println!("Without the first element:");
  print_slice(&array[1..]);

  println!("One element from the middle:");
  print_slice(&array[3..4]);

  println!("First three element:");
  print_slice(&array[..3]);

  println!("Oops, going too far");
  print_slice(&array[..900]);
}
```

Output:

```
Whole array just borrowed:
[1, 2, 3, 4, 5]
Whole array sliced:
[1, 2, 3, 4, 5]
Without the first element:
[2, 3, 4, 5]
One element from the middle:
[4]
First three element:
[1, 2, 3]
Oops, going too far
thread 'main' panicked at 'index 900 out of range for slice of length 5', src/libcore/slice/mod.rs:745:4
note: Run with `RUST_BACKTRACE=1` for a backtrace.
```
