using DifferentialEquations
using Plots

# Начальные условия
u0 = [3,18]

# Параметры
a = 0.48
b = 0.031
c = 0.68
d = 0.031

p = [a,b,c,d]
tspan = (0.0, 50.0)

# система ду
function LV(u,p,t)
    x,y = u
    a,b,c,d = p
    dx = -a*x + b*x*y
    dy = c*y - d*x*y
    return [dx,dy]
end

prob = ODEProblem(LV,u0,tspan,p)
sol = solve(prob, Tsit5())

# график
plot(sol, title = "Модель хищник-жертва",
    xaxis = "время", yaxis = "численность популяции",
    label = ["жертвы" "хищники"])
savefig("lab5_1.png")

plot(sol, vars=(1,2), title = "фазовый портрет",
    xaxis = "x, жертвы", yaxis = "y, хищники",
    label = "y от x")
savefig("lab5_1.1.png")

# Проверка стационарной точки
x_c = 0.68 / 0.031
y_c = 0.48 / 0.031

println("стационарной точки: x_c:", x_c, "y_c: ", y_c)

u0_c = [x_c, y_c]
prob2 = ODEProblem(LV,u0_c,tspan,p)
sol2 = solve(prob2, Tsit5())

# график
plot(sol2, title = "Модель при x0 = x_c и y0 = y_c",
    xaxis = "время", yaxis = "численность популяции",
    label = ["жертвы" "хищники"])
savefig("lab5_1.2.png")

plot(sol2, vars=(1,2), title = "фазовый портрет при x0 = x_c и y0 = y_c",
    xaxis = "x, жертвы", yaxis = "y, хищники",
    label = "y от x", xlimit = [20, 70], ylimit = [0, 25], lw = 5)
savefig("lab5_1.3.png")

