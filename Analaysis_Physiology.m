%% Sample code to plot and analyze electrophysiology signals acquired from scanimage

%%STEP 1: load file from a specific folder and extract data* * *
% MAKE SURE TO ADD FOLDER IN THE PATH

% Find all files name from a specified folder
matfiles = dir(fullfile('C:\Users\jilli\Desktop\UCSF\Photmetry\New Scripts\4-15-2021\Cell 1\CCIV2'));  % find all the file name in the folder

% Extract data from files of interest
files = zeros(28,10000);            % matrix of zeros, # of rows = # of files in a recording, # of columns = length of recording (1sec at 10000Hz => 100000).
for i=3:28;                         % going sequentially through files of interest (for CCIV 25 or 26)
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

%% Plot values
figure('Position', [0 0 1000 500]);
for i = 1:size(finalvalues)
    plot(finalvalues(i,:));
    xlabel('Time');
    ylabel('mV');
    hold on
end