Make_Stuff(5)

showfigs()
disp("Finished!")


function Make_Stuff(n)
    a = 1:10;
    for i =1:n
        figure()
        plot(a,a.^i)
    end

end