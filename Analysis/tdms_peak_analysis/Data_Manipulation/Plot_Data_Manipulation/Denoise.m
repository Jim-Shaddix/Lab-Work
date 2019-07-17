function denoised = Denoise(data)
    % This complicated function denoises the data
    denoised = wdenoise(data, 1);
end
