using DrWatson
@quickactivate "project"
using DifferentialEquations
using Plots
gr(fmt=:png)

# расстояние от лодки до катера
k = 18.3

# вычисление x для двух случаев
x1 = k/5.9   # для первого случая
x2 = k/3.9   # для второго случая

fi = pi/4  # угол под которым двигается лодка

# движение лодки браконьеров
x_lodka(t) = tan(fi) * t

# функция, описывающая движение катера береговой охраны (ДУ)
f(r, p, t) = r / sqrt(23.01)   # n²-1 = 4.9²-1 = 24.01-1 = 23.01

# постановка ДУ с ЗК для 1 случая
prob = ODEProblem(f, x1, (0.0, 2pi))
sol = solve(prob, saveat=0.01)  # шаг для красивой линии

# постановка ДУ с ЗК для 2 случая
prob_2 = ODEProblem(f, x2, (-pi, pi))
sol_2 = solve(prob_2, saveat=0.01)

# построим траекторию движения лодки
ugol = [fi for i in 0:0.1:15]
x_lims = [x_lodka(i) for i in 0:0.1:15]

# точное решение ДУ, описывающего движение катера береговой охраны
y(x) = (k * exp(x / sqrt(23.01))) / 5.9
# подставим в точное решение угол, под которым движется лодка браконьеров
y_result = y(fi)

# точка пересечения лодки и катера для 1 случая
println("Точка пересечения лодки и катера для 1 случая: ", y_result)

# точное решение ДУ, описывающего движение катера береговой охраны для 2 случая
y2(x) = (k * exp((x + pi) / sqrt(23.01))) / 3.9
# подставим в точное решение угол, под которым движется лодка браконьеров
y2_result = y2(fi)

# точка пересечения лодки и катера для 2 случая
println("Точка пересечения лодки и катера для 2 случая: ", y2_result)

# отрисовка траектории движения катера (1 случай)
p1 = plot(sol.t, sol.u, proj=:polar, lims=(0, 15), 
          label="Траектория движения катера (случай 1)", 
          linewidth=2, color=:blue)
plot!(p1, ugol, x_lims, proj=:polar, lims=(0, 15), 
      label="Траектория движения лодки", 
      linewidth=2, color=:red)
title!(p1, "Траектория движения катера и лодки (случай 1)")

# отдельный график для 2 случая
p2 = plot(sol_2.t, sol_2.u, proj=:polar, lims=(0, 15), 
          label="Траектория движения катера (случай 2)", 
          linewidth=2, color=:green)
plot!(p2, ugol, x_lims, proj=:polar, lims=(0, 15), 
      label="Траектория движения лодки", 
      linewidth=2, color=:red)
title!(p2, "Траектория движения катера и лодки (случай 2)")

# показать оба графика
display(p1)
display(p2)

# или объединить в один рисунок (как в Scilab)
p_combined = plot(p1, p2, layout=(1,2), size=(1000,500))
display(p_combined)

# СОХРАНИТЬ графики
#savefig(p1, "variant64_case1.png")
#savefig(p2, "variant64_case2.png")
#savefig(p_combined, "variant64_combined.png")
savefig(p1, plotsdir("variant64_case1.png"))
savefig(p2, plotsdir("variant64_case2.png"))
savefig(p_combined, plotsdir("variant64_combined.png"))
