__precompile__(true)

module ReactiveExtensions
    import Base: get, reduce

    export

    # subject
    Functor,
    Subject,
    get,
    init_task,
    _map,
    _filter,
    _reduce,

    # chaining
    map_,
    filter_,
    reduce,
    bridge,

    # sequence
    Sequence,
    from,
    to_list

    include("subject.jl")
    include("chaining.jl")
    include("sequence.jl")

end # module
