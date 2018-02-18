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
  let string: String = string_slice.into(); // `String` reference

  say_hello(string_slice);
  say_hello(&string);
}
```
