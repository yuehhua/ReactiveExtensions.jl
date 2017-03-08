using ReactiveExtensions
using Base.Test

tests = ["subject",
         "chaining",
         "sequence",
         ]

println("Running tests:")

for t in tests
    println(" * $(t)")
    include("$(t).jl")
end
