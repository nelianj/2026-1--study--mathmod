using DifferentialEquations
using Plots

p_cr = 31 #критическая стоимость продукта
tau1 = 15 #длительность производственного цикла фирмы 1
p1 = 9.7 #себестоимость продукта y фирмы 1
tau2 = 17 #длительность производственного цикла фирмы 2
p2 = 8.4 #себестоимость продукта y фирмы 2
N = 30 #число потребителей производимого продукта
q = 1 #максимальная потребность одного человека в продукте в единицу времени

a1 = p_cr/(tau1^2*p1^2*N*q)
a2 = p_cr/(tau2^2*p2^2*N*q)
b = p_cr/(tau1^2*tau2^2*p1^2*p2^2*N*q)
c1 = (p_cr-p1)/(tau1*p1)
c2 = (p_cr-p2)/(tau2*p2)

u0 = [6.1, 4.5]
p = [a1, a2, b, c1, c2] 
tspan = (0.0, 50.0)

function f(u, p, t)
    M1, M2 = u
    a1, a2, b, c1, c2 = p
    dM1 = M1 - (a1/c1)*M1^2 - (b/c1)*M1*M2
    dM2 = (c2/c1)*M2 - (a2/c1)*M2^2 - (b/c1)*M1*M2
    return [dM1, dM2]
end

using LinearAlgebra
A = [(a1/c1) (b/c1); (b/c1) (a2/c1)]
b1 = [1, (c2/c1)]
x = A \ b1
println("Решение: ", x)

prob = ODEProblem(f, u0, tspan, p)
sol = solve(prob, Tsit5(), saveat = 0.01)
plot1 = plot(sol, yaxis = "Оборотные средства предприятия", label = ["M1" "M2"])
savefig(plot1, "case1.png")

function f2(du, u, p, t)
    a1, a2, b, c1, c2 = p
    du[1] = u[1] - (a1/c1)*u[1]*u[1] - (b/c1+0.00064)*u[1]*u[2]
    du[2] = (c2/c1)*u[2] - (a2/c1)*u[2]*u[2] - (b/c1)*u[1]*u[2]
end

prob2 = ODEProblem(f2, u0, tspan, p)
sol2 = solve(prob2, Tsit5(), saveat = 0.01)
plot2 = plot(sol2, yaxis = "Оборотные средства предприятия", label = ["M1" "M2"])
savefig(plot2, "case2a.png")
plot3 = plot(sol2, yaxis = "Оборотные средства предприятия", label = ["M1" "M2"], ylim = [0, 2])
savefig(plot3, "case2b.png")
