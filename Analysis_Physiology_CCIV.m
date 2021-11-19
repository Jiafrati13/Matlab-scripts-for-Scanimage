%% Sample code to analyze and plot electrophysiology signals acquired fromSscanimage

%%STEP 1: load file from a specific folder and extract data* * *
% MAKE SURE TO ADD THE FOLDER IN THE PATH

% Find names of all files from a specified folder
matfiles = dir(fullfile('E:\New folder\6-8-2021\Cell2\AN'));  % find all the file name in the folder

% Extract data from files of interest
files = zeros(411,10000);            % matrix of zeros, # of rows = # of files in a recording, # of columns = length of recording (1sec at 10000Hz => 100000).
for i=3:158;                         % going sequentially through files of interest % change values depending of recording
    filename = (matfiles(i).name);  % go through the list of file and find all the file name
    c = filename(1:6);              % remove .mat from filename
    f= load (c);                    % load the file in the workplace
    h = getfield (f,c(1:6));        % reduce to a less complex structure
    value = h.data;                 % get the values from the field data of the structure array
    values (i,:) = value            % compile all the values from each sweep into row of the double array - each colum is 1/10000 second of recording
end
finalvalues = values(3:28,:)
toExcelfile = 'Cell_1_CCIV_4_15_2021.xlsx';
totab = 'CCIV2';
xlswrite(toExcelfile, finalvalues, totab, 'B2');

%% Plot traces
figure('Position', [0 0 1000 500]);
for i = 1:size(finalvalues)
    plot(finalvalues(i,:));
    xlabel('Time');
    ylabel('mV');
    hold on
end