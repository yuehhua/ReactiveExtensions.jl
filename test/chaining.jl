#
# map
#

t = init_task(map, x -> x + 5)
@test consume(t, Subject(1)) == Subject(6)

#
# filter
#

t = init_task(filter, x -> x > 10)
@test consume(t, Subject(11)) == Subject(11)

#
# reduce
#

t = init_task(reduce, (x, y) -> x + y, Subject(0))
@test consume(t, Subject(1)) == Subject(1)
@test consume(t, Subject(2)) == Subject(3)
@test consume(t, Subject(3)) == Subject(6)

#
# bridge
#

t1 = init_task(map, x -> x + 5)
t2 = init_task(map, x -> x * 2)
t3 = init_task(bridge, t1, t2)
@test consume(t3, Subject(2)) == Subject(14)

t4 = init_task(filter, x -> x > 10)
t5 = init_task(bridge, t3, t4)
@test consume(t5, Subject(5)) == Subject(20)

#
# Broadcast
#

parallel = [x -> x+2, x -> x*2, x -> x+2, x -> x*2, x -> x+2, x -> x*2]
answer = [Subject(13), Subject(22), Subject(13), Subject(22), Subject(13), Subject(22)]
t = init_task(bridge, x -> x+1, parallel)
@test consume(t, Subject(10)) == answer

#
# Subject chaining
#

a = Subject(10)
@test a(map, x -> x + 2) == Subject(12)
@test a(map, x -> x + 2)(filter, x -> x > 10) == Subject(12)
