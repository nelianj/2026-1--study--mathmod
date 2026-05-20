using DifferentialEquations, Plots

f(n, p, t) = (p[1] + p[2]*n)*(p[3] - n)
f3(n, p, t) = (p[1]*sin(t) + p[2]*cos(t)*n)*(p[3] - n)

N = 1515
n0 = 12

p1 = [0.605, 0.000015, N]
p2 = [0.000025, 0.205, N]
p3 = [0.05, 0.31, N]

tspan1 = (0.0, 15.0)
tspan2 = (0.0, 0.2)
tspan3 = (0.0, 8.0)

prob1 = ODEProblem(f, n0, tspan1, p1)
prob2 = ODEProblem(f, n0, tspan2, p2)
prob3 = ODEProblem(f3, n0, tspan3, p3)

sol1 = solve(prob1, Tsit5(), saveat = 0.05)
sol2 = solve(prob2, Tsit5(), saveat = 0.0005)
sol3 = solve(prob3, Tsit5(), saveat = 0.01)

dev = [sol2(i, Val{1}) for i in 0:0.0005:0.2]
max_dev_idx = findall(x -> x == maximum(dev), dev)[1]
t_max = (max_dev_idx - 1) * 0.0005

plot(sol1, yaxis = "N(t)", label = "n", lw=2)
title!("График изменения интенсивности рекламы для первого случая")
savefig("case1.png")

plot(sol2, yaxis = "N(t)", label = "n", lw=2)
scatter!([t_max], [sol2(t_max)], label = "максимальная скорость", color = :red, markersize = 6)
title!("График изменения интенсивности рекламы для второго случая")
savefig("case2.png")

dev3 = [sol3(i, Val{1}) for i in 0:0.01:1]
max_dev3_idx = findall(x -> x == maximum(dev3), dev3)[1]
t_max3 = (max_dev3_idx - 1) * 0.01
println(t_max3)

plot(sol3, yaxis = "N(t)", label = "n", lw=2, ylims = (0, 2000), xlims = (0, 0.2))
scatter!([t_max3], [sol3(t_max3)], label = "максимальная скорость", color = :red, markersize = 6)
title!("График изменения интенсивности рекламы для третьего случая")
savefig("case3.png")

t_range = 0:0.001:2.0
alpha1 = [0.05*sin(t) for t in t_range]
alpha2 = [0.31*cos(t) for t in t_range]

plot(t_range, alpha1, label = "α₁(t) = 0.05·sin(t)", lw=2)
plot!(t_range, alpha2, label = "α₂(t) = 0.31·cos(t)", lw=2)
xlabel!("Время t")
ylabel!("Значения коэффициентов")
title!("График изменения коэффициентов модели для третьего случая")
savefig("coefficients_case3.png")
