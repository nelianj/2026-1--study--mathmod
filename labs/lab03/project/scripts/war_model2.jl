using DifferentialEquations
using Plots
x0 = 118000
y0 = 90000
params = [0.231, 0.785, 0.451, 0.158]
#интервал времени от 0 до 1
tspan = (0,1)
function f2(u,p,t)
 x,y = u
 a,b,c,h = p
 dx = -a*x-b*y+cos(2*t)
 dy = -c*x*y-h*y+sin(3*t)
 return [dx,dy]
end
prob2 = ODEProblem(f2, [x0,y0], tspan, params)
solution2 = solve(prob2, Tsit5(), saveat = 0.000001)
plot(solution2,
     title = "Модель боевых действий №2",
     label = ["Армия X" "Армия Y"],
     xaxis = "t, время",
     yaxis = "Численность армии",
     linewidth = 2,
     legend = :topright)
savefig("war_model2.png")
