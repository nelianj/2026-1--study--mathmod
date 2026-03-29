using DifferentialEquations
using Plots
x0 = 118000
y0 = 90000
params = [0.555, 0.666, 0.444, 0.777]
#интервал времени от 0 до 1
tspan = (0,1)
function f1(u,p,t)
 x,y = u
 a,b,c,h = p
 dx = -a*x-b*y+2*cos(t)
 dy = -c*x-h*y+2*sin(t)
 return [dx,dy]
end
prob1 = ODEProblem(f1, [x0,y0], tspan, params)
solution1 = solve(prob1, Tsit5())
plot(solution1,
     title = "Модель боевых действий №1",
     label = ["Армия X" "Армия Y"],
     xaxis = "t, время",
     yaxis = "Численность армии",
     linewidth = 2,
     legend = :topright)
savefig("war_model1.png")
