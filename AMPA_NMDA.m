%% Sample code to plot and analyze electrophysiology signals acquired from scanimage

%%STEP 1: load file from a specific folder and extract data* * *
% MAKE SURE TO ADD FOLDER IN THE PATH

% Find all files name from a specified folder
clc
clear
% matfiles = dir(fullfile('E:\Sophie\4-23-2021_DHPG_HET\Slice 1'));  % find all the file name in the folder

% Retrieving and extracting data from files of interest
                  
a = 'AD0_%d'                        % format specification for sprintf function (Format data into string or character vector)
values = zeros(600,10000);           % matrix of zeros, # of rows = # of files in a recording, # of columns = length of recording (1sec at 10000Hz => 100000).
for list =291:310                   % going sequentially through files of interest (for CCIV 25 or 26)
    filename = sprintf(a,list);     % go through the list of file and find all the file name         
    f= load (filename);             % load the file in the workplace
    h = getfield (f,filename);      % reduce to a less complex structure
    value = h.data;                 % get the values from the field data of the structure array
    values (list,:) = value;           % compile all the values from each sweep into row of the double array - each colum is 1/10000 second of recording
end
finalvalues = values(291:310,:);
%% Calculate current injected to maintain at -70mV and +40mV 
for k= 1:size(finalvalues);
BL (k,:) = mean(finalvalues((k),(4800:5000)));
end
PreBL = mean(BL(1:10,:))
postBL = mean(BL(11:20,:))
%% Offset Normalization 
for k= 1:size(finalvalues);
    BL = zeros(k,1);
    Offset = zeros(k,10000);
end
for k= 1:size(finalvalues);
BL (k,:) = mean(finalvalues((k),(4800:5000)));
Offset(k,:)= finalvalues((k),:) - BL(k,:);
end
%% Plot -70 and +40mV traces 
mean_pre = zeros(1,10000);
pre = Offset(1:10,:);
mean_pre = mean(pre);
mean_post = zeros(1,10000);
post = Offset(11:20,:);
mean_post = mean(post);
x = 1:length(Offset);
plot(x,mean_pre,x,mean_post)
%% Write values to Excel files
toExcelfile = 'AMPA_NMDA.xlsx';
totab = 'C4_11_15_2021';
xlswrite(toExcelfile, finalvalues, totab, 'B2');
xlswrite(toExcelfile, Offset, totab, 'B23');

