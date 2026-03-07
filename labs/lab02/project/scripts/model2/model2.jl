using DrWatson
@quickactivate "project"
using DifferentialEquations
using Plots
gr(fmt=:png)

k = 18.3

x1 = k/5.9   # для первого случая
x2 = k/3.9   # для второго случая

fi = pi/4  # угол под которым двигается лодка

x_lodka(t) = tan(fi) * t

f(r, p, t) = r / sqrt(23.01)   # n²-1 = 4.9²-1 = 24.01-1 = 23.01

prob = ODEProblem(f, x1, (0.0, 2pi))
sol = solve(prob, saveat=0.01)  # шаг для красивой линии

prob_2 = ODEProblem(f, x2, (-pi, pi))
sol_2 = solve(prob_2, saveat=0.01)

ugol = [fi for i in 0:0.1:15]
x_lims = [x_lodka(i) for i in 0:0.1:15]

y(x) = (k * exp(x / sqrt(23.01))) / 5.9

y_result = y(fi)

println("Точка пересечения лодки и катера для 1 случая: ", y_result)

y2(x) = (k * exp((x + pi) / sqrt(23.01))) / 3.9

y2_result = y2(fi)

println("Точка пересечения лодки и катера для 2 случая: ", y2_result)

p1 = plot(sol.t, sol.u, proj=:polar, lims=(0, 15),
          label="Траектория движения катера (случай 1)",
          linewidth=2, color=:blue)
plot!(p1, ugol, x_lims, proj=:polar, lims=(0, 15),
      label="Траектория движения лодки",
      linewidth=2, color=:red)
title!(p1, "Траектория движения катера и лодки (случай 1)")

p2 = plot(sol_2.t, sol_2.u, proj=:polar, lims=(0, 15),
          label="Траектория движения катера (случай 2)",
          linewidth=2, color=:green)
plot!(p2, ugol, x_lims, proj=:polar, lims=(0, 15),
      label="Траектория движения лодки",
      linewidth=2, color=:red)
title!(p2, "Траектория движения катера и лодки (случай 2)")

display(p1)
display(p2)

p_combined = plot(p1, p2, layout=(1,2), size=(1000,500))
display(p_combined)

#savefig(p1, "variant64_case1.png")
#savefig(p2, "variant64_case2.png")
#savefig(p_combined, "variant64_combined.png")
savefig(p1, plotsdir("variant64_case1.png"))
savefig(p2, plotsdir("variant64_case2.png"))
savefig(p_combined, plotsdir("variant64_combined.png"))
