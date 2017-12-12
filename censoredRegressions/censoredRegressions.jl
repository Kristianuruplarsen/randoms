using Distributions
using Plots
using StatPlots

Pkg.add("Distributions")

plotlyjs()

#&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
#  ---- Exercise 1
#
#&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

srand(123)     # Set the random number generator seed

function simulate_doublecensored(N, sigma_x, sigma_eps, xlim, ylim, b, limtype = "lower")
    #= simulate dataset with a variation of censoring types
    Args:
        N: number of observations
        sigma_x: stdev of x
        sigma_eps: stdev of epsilon
        xlim: min/max x value
        ylim: min/max y value
        b: true beta
        limtype: lower or upper limit
    =#
    # set up normal number generators
    d = Normal(0,sigma_x)

    # draw random numbers from d1 and d2
    x1 = rand(d, N)        # column of height N
    # generate epsilons
    epsilon = rand(Normal(0,sigma_eps), N)

    # calculate y
    y = [ones(N,1) x1]*b + epsilon

    # replace any values that should be censored with cesoring value
    # this can probably be a lot smarter
    if limtype == "lower"
        for i =1:N
            if x1[i] < xlim
                x1[i] = xlim
            end
            if y[i] < ylim
                y[i] = ylim
            end
        end
    elseif limtype == "upper"
        for i =1:N
            if x1[i] > xlim
                x1[i] = xlim
            end
            if y[i] > ylim
                y[i] = ylim
            end
        end
    end
    # x is a matrix of all these columns
    x = [ones(N,1) x1]

    return (y, x, epsilon, b)
end


function OLS(y, x)
    #= estimate OLS
    args:
        y: y
        x: x
    =#
    # calculate OLS estimate
    b_hat = (x' *x)\x'*y
    # get residuals
    residuals = y - x*b_hat
    # calculate estimator of sigma squared
    k = length(b_hat)
    N = length(x)
    sigma = 1/(N-k)* sum(residuals.^2)
    # calculate variance - covariance matrix
    b_covarvarmat = sigma* (x'*x)^-1
    # extract diagonal to get standard errors
    b_stde = sqrt.(diag(b_covarvarmat))
    # collect all the results and return them as tuple
    return b_hat, residuals, sigma, b_covarvarmat, b_stde
end




# begin by running a single simulation of data, and plot
# to see that the simulator is working
beta = [1; 1]

data = simulate_doublecensored(1000, 3, 2, 0, 0, beta)
x = data[2]
y = data[1]

model = OLS(y,x)


plot(x[:, 2],y, seriestype=:scatter,
               title = "Double-censored data\n",
                markercolor = nothing,
                markerstrokecolor = "darkblue",
                markersize = 4,
                markerstrokewidth = 0.8,
                label = "Data")


plot!(x[:,2], y- model[2], color ="red", label = "Estimated")
plot!(x[:,2], x*beta, color = "green", label = "Actual")

#savefig("doublecensored.png")

####### not done below here

function MCsim(runs, N, sigma_x, sigma_eps, xlim, ylim, b, limtype = "lower")

    beta_out = zeros(runs, length(b))

    for i=1:runs
        data = simulate_doublecensored(N, sigma_x, sigma_eps, xlim, ylim, b, limtype)
        x = data[2]
        y = data[1]
        model = OLS(y,x)

        beta_out[i,:] = copy(model[1])
    end

    return beta_out
end


betas = MCsim(100000, 1000, 3, 2, 0, 0, beta)

histogram(betas[:,1], bins = 100)
