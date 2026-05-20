using DifferentialEquations
using Plots

#параметры
N = 14987
I0 = 187
R0 = 68
S0 = N - I0 - R0
u0 = [S0, I0, R0]

alpha = 0.5
beta = 0.1
p = [alpha, beta]

tspan = (0.0, 50.0)
I_star = 200 #critical threshold

# I(0) ≤ I*
function sir_isolated(u, p, t)
    S, I, R = u
    alpha, beta = p
    dS = 0.0
    dI = -beta*I
    dR = beta*I
    return [dS, dI, dR]
end

prob1 = ODEProblem(sir_isolated, u0, tspan, p)
sol1 = solve(prob1, Tsit5(), saveat = 0.1)

plot1 = plot(sol1, 
     label = ["Восприимчивые S(t)" "Инфицированные I(t)" "Выздоровевшие R(t)"],
     xlabel = "Время (t)",
     ylabel = "Численность особей",
     title = "Случай 1: I(0) = $I0 ≤ I* = $I_star (Больные изолированы)",
     linewidth = 2,
     framestyle = :box)
savefig(plot1, "epidemic_case1_julia.png")
display(plot1)

#  I(0) > I*
I0_case2 = 250
S0_case2 = N - I0_case2 - R0
u0_case2 = [S0_case2, I0_case2, R0]

function sir_full(u, p, t)
    S, I, R = u
    alpha, beta = p
    dS = -alpha * S 
    dI = alpha * S - beta * I
    dR = beta * I
    return [dS, dI, dR]
end

prob2 = ODEProblem(sir_full, u0_case2, tspan, p)
sol2 = solve(prob2, Tsit5(), saveat = 0.1)

plot2 = plot(sol2, 
     label = ["Восприимчивые S(t)" "Инфицированные I(t)" "Выздоровевшие R(t)"],
     xlabel = "Время (t)",
     ylabel = "Численность особей",
     title = "Случай 2: I(0) = $I0_case2 > I* = $I_star (Эпидемия)",
     linewidth = 2,
     framestyle = :box)
savefig(plot2, "epidemic_case2_julia.png")
display(plot2)
