#
# from and to_list for Sequence
#

a = [1, 2, 3, 4, 5]
t = from(a)
@test consume(t.chain) == Subject(1)
@test consume(t.chain) == Subject(2)
@test consume(t.chain) == Subject(3)
@test consume(t.chain) == Subject(4)
@test consume(t.chain) == Subject(5)
@test consume(t.chain) == :done

#
# map, filter and reduce
#

t = from(a)(map, x -> x*2)
@test consume(t.chain) == Subject(2)
@test consume(t.chain) == Subject(4)
@test consume(t.chain) == Subject(6)
@test consume(t.chain) == Subject(8)
@test consume(t.chain) == Subject(10)

# (reduce, (x, y) -> x + y)

#
# Assembly line
#

a = [1, 2, 3, 4, 5]
t = from(a)(map, x -> x+5)(map, x -> x*2)
@test to_list(t) == [12, 14, 16, 18, 20]

#
# subscribe
#

# @test from([1, 2, 3, 4, 5])(map, x -> x + 2)(subscribe, to_list)
# @test from([1, 2, 3, 4, 5])(filter, x -> x > 2)(subscribe, to_set)
# @test from([1, 2, 3, 4, 5])(reduce, (x, y) -> x + y)(subscribe)
