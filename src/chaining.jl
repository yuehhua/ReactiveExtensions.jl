doc"""
yield result of `f(x)`
"""
function map_(f::Function; debug=false)
    x = produce()
    while x != :done
        y = _map(x, f)
        if debug
            println(x, " -> ", y)
        end
        x = produce(y)
    end
    return :done
end

doc"""
yield x if f(x) is true
"""
function filter_(f::Function; debug=false)
    x = produce()
    while x != :done
        y = _filter(x, f)
        if debug
            println(x, " -> ", y)
        end
        x = produce(y)
    end
    return :done
end

function reduce{T <: Functor}(f::Function, x0::T; debug=false)
    x = x0
    y = produce()
    while true
        if debug
            print(x, ", ", y)
        end
        x = _reduce(x, y, f)
        if debug
            println(" -> ", x)
        end
        y = produce(x)
    end
end

doc"""
bridge makes a task bridging two functions or tasks `f` and `g` executing sequentially.
"""
function bridge(f::Task, g::Task)
    x = produce()
    while true
        y = consume(f, x)
        z = consume(g, y)
        x = produce(z)
    end
end

function bridge(f::Task, gs::Vector{Task})
    x = produce()
    while true
        y = consume(f, x)
        zs = [consume(g, y) for g in gs]
        x = produce(zs)
    end
end

function bridge(fs::Vector{Task}, g::Task)
    x = produce()
    while true
        ys = [consume(f, x) for f in fs]
        z = consume(g, ys)
        x = produce(z)
    end
end

function bridge(f::Function, g::Task)
    a = init_task(map_, f)
    return bridge(a, g)
end

function bridge(f::Task, g::Function)
    b = init_task(map_, g)
    return bridge(f, b)
end

function bridge(f::Task, gs::Vector{Function})
    bs = [init_task(map_, g) for g in gs]
    return bridge(f, bs)
end

function bridge(f::Function, g::Function)
    a = init_task(map_, f)
    b = init_task(map_, g)
    return bridge(a, b)
end

function bridge(f::Function, gs::Vector{Function})
    a = init_task(map_, f)
    bs = [init_task(map_, g) for g in gs]
    return bridge(a, bs)
end

function bridge(fs::Vector{Function}, g::Function)
    as = [init_task(map_, f) for f in fs]
    b = init_task(map_, g)
    return bridge(as, b)
end

function bridge(f::Task, gs::Vararg)
    g, g_tail = gs[1], gs[2:end]
    t = init_task(bridge, f, g)
    return bridge(t, g_tail...)
end

function bridge(f::Function, gs::Vararg)
    return bridge(init_task(map_, f), gs...)
end
