# EllipticIntegrals

A high-performance Wolfram Language paclet for evaluating classical Legendre elliptic integrals and Carlson symmetric forms.

## Description

The **EllipticIntegrals** paclet is a high-performance extension for the Wolfram Language that provides lightning-fast evaluation of classical Legendre elliptic integrals and Carlson symmetric forms. By leveraging a highly optimized Rust backend (`ellip` crate) compiled to native machine code and integrated via LibraryLink, the paclet bypasses the overhead of symbolic parsing and arbitrary-precision systems. This makes it an ideal tool for physical simulations, geodesic computations, and engineering pipelines that require evaluating elliptic functions over large numerical datasets at speed.

Benchmarks show substantial performance improvements for computationally intensive functions—for example, executing up to 7x faster than the built-in implementations for integrals like `EllipticPi`. For simpler functions like `EllipticK` and `EllipticE`, the built-in general-purpose implementations are already extremely fast, meaning the overhead of separate LibraryLink calls can make the native wrapper comparable or slower for individual evaluations. By avoiding arbitrary-precision overhead and utilizing efficient AGM algorithms, the package achieves its performance advantages when computation dominates call overhead.

To achieve this level of execution speed, the library is strictly optimized for real-valued arguments in double-precision machine float format (`Real64`). Consequently, it **does not support complex number arguments** or arbitrary-precision evaluation. For complex inputs or arbitrary-precision bounds, the native, built-in Wolfram Language functions should be used as fallback mechanisms.

---

## Functions Supported

The paclet implements the following 17 high-performance functions:
* **Legendre Forms**: `EllipticK`, `EllipticE`, `EllipticF`, `EllipticPi`, `EllipticD`
* **Carlson Forms**: `CarlsonRC`, `CarlsonRD`, `CarlsonRF`, `CarlsonRG`, `CarlsonRJ`
* **Bulirsch Algorithms**: `Cel`, `Cel1`, `Cel2`, `El1`, `El2`, `El3`, `EllipticPiBulirsch`

## Loading and Usage

Load the paclet with an alias prefix (`ei`) to avoid shadowing built-in system functions:

```wolfram
Needs["ArnoudBuzing`EllipticIntegrals`" -> "ei`"]

(* Example evaluation *)
ei`EllipticK[0.5]
```
