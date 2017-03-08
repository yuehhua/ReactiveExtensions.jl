type Sequence
    chain::Task
end

function (seq::Sequence)(f::Function, g::Function)
    seq.chain = init_task(bridge, seq.chain, init_task(f, g))
    return seq
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

function from_iter()

end

function to_list(s::Sequence; debug=false)
    result = Vector()
    while true
        x = consume(s.chain)
        if debug
            println(x)
        end
        if x == :done
            break
        else
            append!(result, get(x))
        end
    end
    return result
end

function to_set(s::Sequence; debug=false)
    result = Set()
    while true
        x = consume(s.chain)
        if debug
            println(x)
        end
        if x == :done
            break
        else
            push!(result, get(x))
        end
    end
    return result
end

function to_dict(s::Sequence; debug=false)
    result = Dict()
    while true
        x = consume(s.chain)
        if debug
            println(x)
        end
        if x == :done
            break
        else
            k, v = get(x)
            result[k] = v
        end
    end
    return result
end
