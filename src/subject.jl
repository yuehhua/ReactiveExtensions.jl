#
# Functor pattern
#

abstract Functor

function get{T <: Functor}(f::T) end

#
# Functor utilities
#

_map(x::Type{Val{:done}}, f::Function) = x

_map(x::Symbol, f::Function) = _map(Val{x}, f)

_map{T <: Functor}(x::T, f::Function) = T(f(get(x)))

_filter(x::Type{Val{:done}}, f::Function) = x

_filter(x::Symbol, f::Function) = _filter(Val{x}, f)

_filter{T <: Functor}(x::T, f::Function) = (f(get(x)))? x : T(nothing)

_reduce{T <: Functor}(x::T, y::Type{Val{:done}}, f::Function) = x

_reduce{T <: Functor}(x::T, y::Symbol, f::Function) = _reduce(x, Val{y}, f)

_reduce{T <: Functor}(x::T, y::T, f::Function) = T(f(get(x), get(y)))

#
# Subject
#

immutable Subject <: Functor
    value
end

function get(subject::Subject)
    return subject.value
end

function init_task(f::Function, args::Vararg)
    x = @task f(args...)
    consume(x)
    return x
end

function (subject::Subject)(f::Function, g::Function)
    return subject(init_task(f, g))
end

function (subject::Subject)(t::Task)
    return consume(t, subject)
end
