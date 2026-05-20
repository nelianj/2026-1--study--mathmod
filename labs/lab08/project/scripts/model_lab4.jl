using DifferentialEquations
using Plots

tspan = (0, 88)

#параметры
p1 = [0, 8.8]
p2 = [4, 8]
p3 = [4, 8]

#начальная условия
du0 = [0.8]
u0 = [1.8]

#правая часть для уравнений без внешней силы
function harm_osc(ddu, du, u, p, t)
    g, w = p
    ddu .= -g.*du .-w.*u
end

#внешняя сила
function f(t)
    return 0.8*sin(8.0*t)
end

#правая часть для уравнений с внешней силой
function forced_harm_osc(ddu, du, u, p, t)
    g, w = p
    ddu .= -g.*du .-w.*u .+f(t)
end

#решаем дифф урав
prob1 = SecondOrderODEProblem(harm_osc, du0, u0, tspan, p1)
sol1 = solve(prob1, DPRKN6(), saveat = 0.05)

prob2 = SecondOrderODEProblem(harm_osc, du0, u0, tspan, p2)
sol2 = solve(prob2, DPRKN6(), saveat = 0.05)

prob3 = SecondOrderODEProblem(forced_harm_osc, du0, u0, tspan, p3)
sol3 = solve(prob3, Tsit5(), saveat = 0.05)

#визуализация
function plot_osc(sol, title)
    plot(sol, vars=(0,1), label="x' (скорость)", xlabel="время t", ylabel="", title=title)
     plot!(sol, vars=(0, 2), label="x (смещение)", xlabel="Время t", ylabel="", title=title)
end

#случае 1
plot_osc(sol1, "Случай 1: Колебания без затухания и внешней силы")
savefig("variant64_case1_solution.png")

# Фазовый портрет
plot(sol1, vars=(2, 1), label="", xlabel="x (смещение)", ylabel="x' (скорость)",
     title="Случай 1: Фазовый портрет (без затухания)")
savefig("variant64_case1_phase.png")

#случае 2
plot_osc(sol2, "Случай 2: Колебания с затуханием и без внешней силы")
savefig("variant64_case2_solution.png")

# Фазовый портрет
plot(sol2, vars=(2, 1), label="", xlabel="x (смещение)", ylabel="x' (скорость)",
     title="Случай 2: Фазовый портрет (с затуханием)")
savefig("variant64_case2_phase.png")

#случае 3
plot_osc(sol3, "Случай 3: Колебания с затуханием и внешней силой F = 0.8 sin(8t)")
savefig("variant64_case3_solution.png")

# Фазовый портрет
plot(sol3, vars=(2, 1), label="", xlabel="x (смещение)", ylabel="x' (скорость)",
     title="Случай 3: Фазовый портрет (с затуханием и внешней силой)")
savefig("variant64_case3_phase.png")

