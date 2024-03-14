//! Hax-specific helpers for Rust programs. Those helpers are usually
//! no-ops when compiled normally but meaningful when compiled under
//! hax.
//!
//! # Example:
//!
//! ```rust
//! fn sum(x: Vec<u32>, y: Vec<u32>) -> Vec<u32> {
//!   hax_lib::assume!(x.len() == y.len());
//!   hax_lib::assert!(hax_lib::forall(|i: usize| hax_lib::implies(i < x.len(), || x[i] < 4242)));
//!   hax_lib::debug_assert!(hax_lib::exists(|i: usize| hax_lib::implies(i < x.len(), || x[i] > 123)));
//!   x.into_iter().zip(y.into_iter()).map(|(x, y)| x + y).collect()
//! }
//! ```

#![no_std]

#[doc(hidden)]
#[cfg(hax)]
#[macro_export]
macro_rules! proxy_macro_if_not_hax {
    ($macro:path, no, $($arg:tt)*) => {
        ()
    };
    ($macro:path, $f:expr, $cond:expr$(, $($arg:tt)*)?) => {
        $f($cond)
    };
}

#[cfg(not(debug_assertions))]
#[doc(hidden)]
#[cfg(not(hax))]
#[macro_export]
macro_rules! proxy_macro_if_not_hax {
    ($macro:path, $f:expr, $($arg:tt)*) => {};
}

#[cfg(debug_assertions)]
#[doc(hidden)]
#[cfg(not(hax))]
#[macro_export]
macro_rules! proxy_macro_if_not_hax {
    ($macro:path, $f:expr, $($arg:tt)*) => {
        $macro!($($arg)*)
    };
}

#[macro_export]
/// Proxy to `std::debug_assert!`. Compiled with `hax`, this
/// disappears.
macro_rules! debug_assert {
    ($($arg:tt)*) => {
        $crate::proxy_macro_if_not_hax!(::core::debug_assert, no, $($arg)*)
    };
}

#[macro_export]
/// Proxy to `std::assert!`. Compiled with `hax`, this is transformed
/// into a `assert` in the backend.
macro_rules! assert {
    ($($arg:tt)*) => {
        $crate::proxy_macro_if_not_hax!(::core::assert, $crate::assert, $($arg)*)
    };
}

#[doc(hidden)]
#[cfg(hax)]
/// This function exists only when compiled with `hax`, and is not
/// meant to be used directly. It is called by `assert!` only in
/// appropriate situations.
pub fn assert(_formula: bool) {}

#[doc(hidden)]
#[cfg(hax)]
/// This function exists only when compiled with `hax`, and is not
/// meant to be used directly. It is called by `assume!` only in
/// appropriate situations.
pub fn assume(_formula: bool) {}

#[cfg(hax)]
#[macro_export]
macro_rules! assume {
    ($formula:expr) => {
        $crate::assume($formula)
    };
}

/// Assume a boolean formula holds. In Rust, this is expanded to the
/// expression `()`. While extracted with Hax, this gets expanded to a
/// call to an `assume` function.
///
/// # Example:
///
/// ```rust
/// fn sum(x: u32, y: u32) -> u32 {
///   hax_lib::assume!(x < 4242 && y < 424242);
///   x + y
/// }
/// ```
#[cfg(not(hax))]
#[macro_export]
macro_rules! assume {
    ($formula:expr) => {
        ()
    };
}

/// The universal quantifier. This should be used only for Hax code: in
/// Rust, this is always true.
///
/// # Example:
///
/// The Rust expression `forall(|x: T| phi(x))` corresponds to `∀ (x: T), phi(x)`.
pub fn forall<T>(_f: impl Fn(T) -> bool) -> bool {
    true
}

/// The existential quantifier. This should be used only for Hax code: in
/// Rust, this is always true.
///
/// # Example:
///
/// The Rust expression `exists(|x: T| phi(x))` corresponds to `∃ (x: T), phi(x)`.
pub fn exists<T>(_f: impl Fn(T) -> bool) -> bool {
    true
}

/// The logical implication `a ==> b`.
pub fn implies(lhs: bool, rhs: impl Fn() -> bool) -> bool {
    !lhs || rhs()
}
