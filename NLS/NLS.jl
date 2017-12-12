
using Plots
using Distributions
using Optim

function simulate_nonlinear(N, sigma_x, b)
    d = Normal(0,sigma_x)
    m = length(b) - 1
    # draw random numbers from d1 and d2
    x1 = rand(d, N, m) + 1       # column of height N
    # calculate y
    x = [ones(N,1) x1]
    lambda = exp(x*b)

    y = zeros(N,1)
    for i =1:N
        y[i] = rand(Exponential(lambda[i]))
    end

    return (y, lambda, x, b)
end


data = simulate_nonlinear(1000,1,1,[1,1])

scatter(data[3][:,2], data[1],
    markercolor = nothing,
    markerstrokecolor = "darkblue",
    markersize = 4)


function OLS(y, x)
    b_hat = (x' * x) \ x' * y
    residuals = y - x*b_hat

    k = length(b_hat)
    N = length(x)

    sigma = 1 /(N - k) * sum(residuals.^2)

    b_covarmat = sigma * (x' * x)^-1
    b_stde = sqrt.(diag(b_covarmat))

    return b_hat, residuals, sigma, b_covarmat, b_stde
end


OLS(data[1], data[3])[1]


q(theta, y, x) = y.* x* theta - exp(x*theta)
Q(theta) = sum(q(theta, data[1], data[3]))
