type Sequence
    chain::Task
end

function (seq::Sequence)(f::Function, g::Function)
    seq.chain = init_task(bridge, seq.chain, init_task(f, g))
    return seq
end

function (seq1::Sequence)(seq2::Sequence, f::Function)
    seq = Sequence(init_task(bridge, seq1.chain, init_task(f, se2.chain)))
    return seq
end

function subscribe(s::Sequence, f::Function; debug=false)
    result = Vector()
    x = consume(s.chain)
    while x != :done
        debug && println(x)
        append!(result, get(x))
        x = consume(s.chain)
    end
    return result
end

doc"""
As the constructor of Sequence, turning Vector of something into a iterator Task
wrapped in Sequence.
"""
function from(s::Vector)
    function start()
        produce()
        for x in s
            produce(Subject(x))
        end
        return :done
    end
    return Sequence(init_task(start))
end

function create(func::Function)

end

function to_list(s::Sequence; debug=false)
    result = Vector()
    x = consume(s.chain)
    while x != :done
        debug && println(x)
        append!(result, get(x))
        x = consume(s.chain)
    end
    return result
end

function to_set(s::Sequence; debug=false)
    result = Set()
    x = consume(s.chain)
    while x != :done
        debug && println(x)
        push!(result, get(x))
        x = consume(s.chain)
    end
    return result
end

function to_dict(s::Sequence; debug=false)
    result = Dict()
    x = consume(s.chain)
    while x != :done
        debug && println(x)
        k, v = get(x)
        result[k] = v
        x = consume(s.chain)
    end
    return result
end
