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

## Generic Types

```rust
#[derive(Debug)]
struct Money<T> {
  amount: T,
  currency: String,
}

fn main() {
  let whole_euros: Money<u8> = Money {
    amount: 42,
    currency: "EUR".to_string(),
  };
  let floating_euros: Money<f32> = Money {
    amount: 24.312,
    currency: "EUR".to_string(),
  };

  println!("whole_euros: {:?}", whole_euros);
  println!("floating_euros: {:?}", floating_euros);
}
```

Output:

```
whole_euros: Money { amount: 42, currency: "EUR" }
floating_euros: Money { amount: 24.312, currency: "EUR" }
```

## Traits Add

```
// Lets us overload the +operator
use std::ops::Add;

// pub trait Add<RHS = Self> { // trait has a generic type RHS that needs to be equal to the Self type
//   type Output; // Any implementation needs to declare an `Output` type
//   // Any implementations needs to implement an add method that takes a right-hand side parameter
//   // that was declared on the first line to be the same as the `Self` type
//   fn add(self, rhs: RHS) -> Self::Output;
// }

#[derive(Debug)]
struct Money<T> {
  amount: T,
  currency: String,
}

// impl<T: Add<T, Output=T>> says that our implementation has a generic type T
// Add for Money says we are implementing the Add trait for the type Money<T>
// <T: Add> says this has to implement the Add trait
// <T, Output=T> Furthermore, the implementation of the Add trait must have
// it's input and output types as the same
impl<T: Add<T, Output = T>> Add for Money<T> {
  type Output = Money<T>;
  fn add(self, rhs: Money<T>) -> Self::Output {
    assert!(self.currency == rhs.currency);
    Money {
      currency: rhs.currency,
      amount: self.amount + rhs.amount,
    }
  }
}

fn main() {
  let rm10: Money<u8> = Money {
    amount: 10,
    currency: "RM".to_string(),
  };
  let rm50: Money<u8> = Money {
    amount: 50,
    currency: "RM".to_string(),
  };
  println!("{:?}", rm10 + rm50);
}
```

Output:

```
Money { amount: 60, currency: "RM" }
```

## Traits Into

```rust
// This trait allows use to specify conversion methods from and to arbirary types
use std::convert::Into;

#[derive(Debug)]
struct Money<T> {
  amount: T,
  currency: String,
}

#[derive(Debug)]
struct CurrencylessMoney<T> {
  amount: T,
}

impl<T> Into<CurrencylessMoney<T>> for Money<T> {
  fn into(self) -> CurrencylessMoney<T> {
    CurrencylessMoney {
      amount: self.amount,
    }
  }
}

fn main() {
  let rm10: Money<f32> = Money {
    amount: 10.50,
    currency: "RM".to_string(),
  };
  let currencyless: CurrencylessMoney<f32> = rm10.into();
  println!("{:?}", currencyless);

  // This will throw error
  // type annotations required: cannot resolve `Money<f32>: std::convert::Into<_>`
  // println!("{:?}", rm10.into());
}
```

Output:

```
CurrencylessMoney { amount: 10.5 }
```

## Trait Display

```rust
use std::fmt::{Display, Formatter, Result};

// pub trait Display {
//   fn fmt(&self, &mut Formatter) -> Result<(), Error>;
// }

// #[derive(Debug)]
struct Money<T> {
  amount: T,
  currency: String,
}

impl<T: Display> Display for Money<T> {
  fn fmt(&self, f: &mut Formatter) -> Result {
    write!(f, "{} {}", self.amount, self.currency)
  }
}

fn main() {
  let rm5: Money<i8> = Money {
    amount: 10,
    currency: "RM".to_string(),
  };
  print!("{}", rm5);
}
```

Output:

```
10 RM%
```

## Read File

```rust
use std::io::Read;
use std::path::Path;
use std::fs::File;

fn main() {
  let path = Path::new("data.txt");
  let mut file = match File::open(&path) {
    Ok(file) => file,
    Err(e) => {
      println!("Error while opening file: {}", e);
      panic!();
    }
  };
  let mut s = String::new();
  file.read_to_string(&mut s);
  println!("Read the string: {}", s);
}
```

## Mapping Errors

```rust
use std::string::FromUtf8Error;

fn bytestring_to_string_with_match(str: Vec<u8>) -> Result<String, FromUtf8Error> {
  match String::from_utf8(str) {
    Ok(str) => Ok(str.to_uppercase()),
    Err(err) => Err(err),
  }
}

fn bytestring_to_string(str: Vec<u8>) -> Result<String, FromUtf8Error> {
  String::from_utf8(str).map(|s| s.to_uppercase())
}

fn main() {
  let faulty_bytestring = vec![130, 131, 132, 133];
  let ok_bytestring = vec![80, 82, 84, 85, 86];

  let s1_faulty = bytestring_to_string_with_match(faulty_bytestring.clone());
  let s1_ok = bytestring_to_string_with_match(ok_bytestring.clone());
  println!("s1_faulty: {:?}", s1_faulty);
  println!("s1_ok: {:?}", s1_ok);

  let s2_faulty = bytestring_to_string(faulty_bytestring.clone());
  let s2_ok = bytestring_to_string(ok_bytestring.clone());
  println!("s2_faulty: {:?}", s2_faulty);
  println!("s2_ok: {:?}", s2_ok);
}
```

## Early returns and !try macro

```rust
use std::string::FromUtf8Error;

fn bytestring_to_string_with_match(str: Vec<u8>) -> Result<String, FromUtf8Error> {
  let ret = match String::from_utf8(str) {
    Ok(str) => str.to_uppercase(),
    Err(err) => return Err(err),
  };
  Ok(ret)
}

fn bytestring_to_string_with_try(str: Vec<u8>) -> Result<String, FromUtf8Error> {
  let ret = try!(String::from_utf8(str));
  Ok(ret)
}

fn main() {
  let faulty_bytestring = vec![130, 131, 132, 133];
  let ok_bytestring = vec![80, 82, 84, 85, 86];

  let s1_faulty = bytestring_to_string_with_match(faulty_bytestring.clone());
  let s1_ok = bytestring_to_string_with_match(ok_bytestring.clone());
  println!("s1_faulty: {:?}", s1_faulty);
  println!("s1_ok: {:?}", s1_ok);

  let s2_faulty = bytestring_to_string_with_try(faulty_bytestring.clone());
  let s2_ok = bytestring_to_string_with_try(ok_bytestring.clone());
  println!("s2_faulty: {:?}", s2_faulty);
  println!("s2_ok: {:?}", s2_ok);
}
```

## Custom Error

```
use std::error::Error;
use std::fmt;
use std::fmt::{Display, Formatter};

// pub trait Error: Debug + Display + Reflect {
//   fn description(&self) -> &str;
//   fn cause(&self) -> Option<&Error> { None }
// }

#[derive(Debug)]
enum Currency {
  USD,
  EUR,
}

#[derive(Debug)]
struct CurrencyError {
  description: String,
}

impl Display for CurrencyError {
  fn fmt(&self, f: &mut Formatter) -> fmt::Result {
    write!(f, "CurrencyError: {}", self.description)
  }
}

impl Error for CurrencyError {
  fn description(&self) -> &str {
    "Currency Error"
  }
}

impl Currency {
  fn new(currency: &str) -> Result<Self, CurrencyError> {
    match currency {
      "USD" => Ok(Currency::USD),
      "EUR" => Ok(Currency::EUR),
      e => Err(CurrencyError {
        description: e.to_string(),
      }),
    }
  }
}

#[derive(Debug)]
struct Money {
  currency: Currency,
  amount: u64,
}

#[derive(Debug)]
struct MoneyError {
  cause: CurrencyError,
}

impl Display for MoneyError {
  fn fmt(&self, f: &mut Formatter) -> fmt::Result {
    write!(f, "MoneyError due to {}", self.cause)
  }
}

impl Error for MoneyError {
  fn description(&self) -> &str {
    "MoneyError"
  }
  fn cause(&self) -> Option<&Error> {
    Some(&self.cause)
  }
}

impl Money {
  fn new(currency: &str, amount: u64) -> Result<Self, MoneyError> {
    let currency = match Currency::new(currency) {
      Ok(c) => c,
      Err(err) => return Err(MoneyError { cause: err }),
    };
    Ok(Money {
      currency: currency,
      amount: amount,
    })
    // try!(Currency::new(currency))
  }
}

fn main() {
  let money_1 = Money::new("USD", 1000);
  let money_2 = Money::new("MYR", 1000);
  println!("money_1 is: {:?}", money_1);
  println!("money_2 is: {:?}", money_2);
}
```

Output:

```
money_1 is: Ok(Money { currency: USD, amount: 1000 })
money_2 is: Err(MoneyError { cause: CurrencyError { description: "MYR" } })
```

## Cell

```rust
// Interior mutability for Copy types
use std::cell::Cell;

fn main() {
  // cannot borrow immutable local variable `x` as mutable
  // let x = 1;
  // let ref_to_x_1 = &mut x;
  // let ref_to_x_2 = &mut x;

  // *ref_to_x_1 += 1;
  // *ref_to_x_2 += 1;
  // println!("{} {} {}", x, ref_to_x_1, ref_to_x_2);

  let x = Cell::new(1);
  let ref_to_x_1 = &x;
  let ref_to_x_2 = &x;

  ref_to_x_1.set(ref_to_x_1.get() + 1);
  println!("x: {:?}", x.get());
  ref_to_x_2.set(ref_to_x_2.get() + 2);
  println!(
    "{:?} {:?} {:?}",
    x.get(),
    ref_to_x_1.get(),
    ref_to_x_2.get()
  );
  x.set(0);
  println!(
    "{:?} {:?} {:?}",
    x.get(),
    ref_to_x_1.get(),
    ref_to_x_2.get()
  );
}
```

## RefCell

```rust
// Interior mutability for Move types
use std::cell::RefCell;

#[derive(Debug)]
struct Foo {
  number: u8,
}

fn main() {
  let foo_one = RefCell::new(Foo { number: 1 });

  let mut ref_to_foo_1 = foo_one.borrow_mut();
  ref_to_foo_1.number = 10;
  println!("foo_one: {:?}", foo_one);
  drop(ref_to_foo_1); // There can be only one mutable reference

  let mut ref_to_foo_2 = foo_one.borrow_mut();
  println!("{:?}", ref_to_foo_2.number);
  ref_to_foo_2.number = 20;
  println!("{:?}", ref_to_foo_2.number);
  drop(ref_to_foo_2);

  let out = foo_one.borrow();
  println!("foo_one: {:?}", out);
}
```

## Interior Mutability

Demonstrates that the cache is working without needing to make the whole `p` mutable.

```
use std::cell::Cell;

#[derive(Debug)]
struct Point {
  x: u8,
  y: u8,
  cached_sum: Cell<Option<u8>>,
}

impl Point {
  fn sum(&self) -> u8 {
    match self.cached_sum.get() {
      Some(sum) => {
        println!("got from cache: {}", sum);
        sum
      }
      None => {
        let new_sum = self.x + self.y;
        self.cached_sum.set(Some(new_sum));
        println!("set cached: {}", new_sum);
        new_sum
      }
    }
  }
}

fn main() {
  let p = Point {
    x: 10,
    y: 20,
    cached_sum: Cell::new(None),
  };
  println!("Summed result: {}", p.sum());
  println!("Summed result: {}", p.sum());
}
```

## Reference Counter

```rust
use std::cell::RefCell;
use std::rc::Rc;
use std::rc::Weak;

#[derive(Debug)]
struct LinkedList<T> {
  head: Option<Rc<LinkedListNode<T>>>,
}

#[derive(Debug)]
struct LinkedListNode<T> {
  next: Option<Rc<LinkedListNode<T>>>,
  prev: RefCell<Option<Weak<LinkedListNode<T>>>>,
  data: T,
}

impl<T> LinkedList<T> {
  fn new() -> Self {
    LinkedList { head: None }
  }
  fn append(&self, data: T) -> Self {
    let new_node = Rc::new(LinkedListNode {
      data: data,
      next: self.head.clone(),
      prev: RefCell::new(None),
    });

    match self.head.clone() {
      Some(node) => {
        let mut prev = node.prev.borrow_mut();
        *prev = Some(Rc::downgrade(&new_node));
        // node.prev = Some(Rc::downgrade(&new_node));
      }
      None => {}
    }
    LinkedList {
      head: Some(new_node),
    }
  }
}

fn main() {
  let list_of_nums = LinkedList::new().append(1).append(2);
  println!("nums: {:?}", list_of_nums);

  let list_of_strs = LinkedList::new().append("hello").append("world");
  println!("strs: {:?}", list_of_strs);
}
```

## Closures

```rust
fn square(x: u32) -> u32 {
  x * x
}

fn function_without_variables() {
  println!("function without variables");
}

fn main() {
  let square_1 = |x: u32| x * x;
  let square_2 = |x: u32| { x * x };
  let square_3 = |x: u32| -> u32 { x * x };

  let closure_without_variables = || println!("closure without variables");

  println!("square: {}", square(4));
  println!("square_1: {}", square_1(4));
  println!("square_2: {}", square_2(4));
  println!("square_3: {}", square_3(4));

  function_without_variables();
  closure_without_variables();
}
```
