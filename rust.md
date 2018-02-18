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
