function plot_filter_responses()
    % 2-D DFTs of Filters

    % Define all filters
    h_avg = (1/9) * ones(3,3);
    h_cd1 = [0 -1 0; 0 0 0; 0 1 0];
    h_cd2 = [0 0 0; -1 0 1; 0 0 0];
    h_prew1 = [-1 -1 -1; 0 0 0; 1 1 1];
    h_prew2 = [-1 0 1; -1 0 1; -1 0 1];
    h_sob1 = [-1 -2 -1; 0 0 0; 1 2 1];
    h_sob2 = [-1 0 1; -2 0 2; -1 0 1];

    filters = {h_avg, h_cd1, h_cd2, h_prew1, h_prew2, h_sob1, h_sob2};
    titles = {'Average', 'CentralDiff1', 'CentralDiff2', ...
              'Prewitt1', 'Prewitt2', 'Sobel1', 'Sobel2'};

    % Plot all responses in a single figure
    figure('Name','Magnitude Frequency Response of 2D Filters','NumberTitle','off');
    for k = 1:length(filters)
        subplot(2,4,k);
        H = freqz2(filters{k}, [64 64]);
        imagesc(abs(H));
        title(titles{k}, 'Interpreter', 'none');
        axis image; axis off;
        colorbar;
    end
    sgtitle('Magnitude Frequency Response of 2D Filters');

end
