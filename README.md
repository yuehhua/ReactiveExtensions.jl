# ReactiveExtensions

[![Build Status](https://travis-ci.org/yuehhua/ReactiveExtensions.jl.svg?branch=master)](https://travis-ci.org/yuehhua/ReactiveExtensions.jl) [![Coverage Status](https://coveralls.io/repos/yuehhua/ReactiveExtensions.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/yuehhua/ReactiveExtensions.jl?branch=master) [![codecov.io](http://codecov.io/github/yuehhua/ReactiveExtensions.jl/coverage.svg?branch=master)](http://codecov.io/github/yuehhua/ReactiveExtensions.jl?branch=master)

-----

Implementation of reactive extensions for Julia.

I just implement the core functionality of Rx, and need community support.

## Installation

```
Pkg.add("Rx")
```

## Usage

```
a = [1, 2, 3, 4, 5]
t = from(a)(map, x -> x+5)(map, x -> x*2)
to_list(t)  # [12, 14, 16, 18, 20]
```

This script shows applying list `a` by adding 5 and then multiplying 2.

## Functions

* map
* filter
* reduce

## Subscribe

* to_list

## Roadmap

* Implement more functions and subscribers
* Implement scheduler
