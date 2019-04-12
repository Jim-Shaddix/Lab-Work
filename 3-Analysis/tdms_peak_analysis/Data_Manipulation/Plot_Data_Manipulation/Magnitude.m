function processed_data = Magnitude(x,y)
% Dataplay:  returns data added in quadature

    processed_data = zeros(1,length(x));

    for i = 1:length(x)
        processed_data(i) = sqrt(x(i).^2 + y(i).^2);
    end