using Plots



function collatz(x)
    # compute collatz(x) for some integer x
    if x % 2 == 0
        return x/2
    else
        return 3*x + 1
    end
end


function collatz_cycle(x0)
    # repeatedly compute collatz(x) until the cycle terminates
    x = [x0]
    i = 2
    while x0 != 1
        x0 = collatz(x0)
        append!(x, x0)
        i += 1
    end
    return x
end


function stretchAndBind(data, column)
    #= ensures that a column and a dataset have the same length by
    stretching the shortest of the two with 0's
    =#
    sd = size(data)
    if length(sd) == 1
        sd = (sd[1], 1)
    end
    sc = size(column)

    # if data are longer than column
    if sd[1] > sc[1]
        column = vcat(column, zeros(sd[1]-sc[1], 1))
    # if column is longer than data
    elseif sd[1] < sc[1]
        data = vcat(data, zeros(sc[1]-sd[1], sd[2]))
    end
    return hcat(data, column)
end



data = collatz_cycle(10)
sout = [size(data)[1] 10]

for i=10:1000:100000
    s = size(data)
    data = stretchAndBind(data, collatz_cycle(i))
    sout = vcat(sout, [s[1] i])
end


plot(data,
     title = "Collatz progressions for various starting points",
     xlab = "n",
     ylab = "x",
     legend = false,
     color = "black",
     lw = 0.2)



plot(sout[:,2], sout[:,1],
     title = "Longest chain",
     xlab = "starting point",
     ylab = "Chain length",
     color = "black")
