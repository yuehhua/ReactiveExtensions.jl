#
# Subject
#

a = Subject(10)
b = Subject(30)
@test get(a) == 10
@test _map(a, x -> x + 2) == Subject(12)
@test _filter(a, x -> x > 2) == a
@test _filter(a, x -> x > 20) == Subject(nothing)
@test _reduce(a, b, (x, y) -> (x + y)/2) == Subject(20.0)

#
# init_task
#

t = init_task(() -> 5)
@test consume(t) == 5

t = init_task(x -> x + 5, 1)
@test consume(t) == 6

t = init_task((x, y) -> x*y + 5, 2, 3)
@test consume(t) == 11
