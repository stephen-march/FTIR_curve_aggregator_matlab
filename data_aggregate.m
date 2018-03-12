function [] = data_aggregate( desired_output_filename,FTIR_dpt,file_dir )
% DATA_AGGREGATE takes multiple text files produced from some data collection
% hardware and aggregates them into a single csv file. 
% 
% For example, say there are 5 files generated, each having x- and y-axis
% data. Let's assume each file shares a common x-axis. data_aggregate will 
% merge all the data into a single file with the first column as the shared
% x-axis. It will label each y-axis column with the file name from where the
% y-axis data was collected, giving a total of 6 columns in the output file
% 
% Inputs:
%     desired_output_filename --  name of user specified output file, will get
%                                 appended with "_aggregate.txt"
%     FTIR_dpt -- =1 if using data from FTIR system. !=1 for any other data
%     file_dir -- directory where the files to be aggregated are located    
%     
% Examples:
%     desired_output_filename = '2016_10_10_FTIR'
%     FTIR_dpt = 1
%     file_dir = 'C:\Users\stephen\Desktop\2016 fall\Bi for ESW\FTIR_Bi_for_ESW'
%     
% Stephen-made dependencies/functions needed to run this function
% 1. getdata.m
% 2. linecount.m


%% output file parameters
% desired_output_filename = '2016_10_10_FTIR';
outputfile_name = strcat(desired_output_filename,'_aggregate.txt');

if (FTIR_dpt == 1)
    %% Regex parameters
    FTIR_dpt_pattern = '(\d+\.\d+),(-\d+|\d+\.\d+)';
    struct_pattern = '*.dpt';
    regex_pattern = FTIR_dpt_pattern;
    abscissa_label = 'Wavenumber (1/cm)';
end


%% Select the path, expand to take this as an input
%file_dir = 'C:\Users\stephen\Desktop\2016 fall\Bi for ESW\FTIR_Bi_for_ESW';
cd(file_dir); % change to the specified directory with the files to aggregate
files = dir(struct_pattern); % creates struct of the dpt file names present in the current dir


%% Perform aggregation into a single matrix
aggregate_matrix = [];
Header_vector = {};
for i=1:length(files)
    
    % collects data from the i-th file to be aggregated
    cur_file = files(i).name; % gives full file name
    cur_data = getdata(cur_file,regex_pattern);
    [filepath,filename,fileext] = fileparts(cur_file); % strips of parts of file name
    
    % save off abscissa data
    if (i == 1) 
       aggregate_matrix = [aggregate_matrix;cur_data(:,1)];
       header_vector{1,1} = abscissa_label;
    end
    
    % save off the ordinate data
    aggregate_matrix = [aggregate_matrix,cur_data(:,2)];
    
    % save off header data
    header_vector{1,i+1} = filename;
    
end


%% Write the aggregate_matrix data to an output text file
% [rows,columns] = size(aggregate_matrix);
% create csv version of header cell array and save it to outputfile_name
fid=fopen(outputfile_name,'wt');
for i=1:1
      fprintf(fid,'%s,',header_vector{i,1:end-1})
      fprintf(fid,'%s\n',header_vector{i,end})
end

% create csv version of aggregate_matrix and save it in the current dir as temp_numfile.txt
csvwrite('temp_numfile.txt',aggregate_matrix);

% Write each line of temp_numfile to outputfile_name (since it's still open)
f = fopen('temp_numfile.txt','r');
    tline = 'initialization of tline'; % initializes tline for while loop
    while ischar(tline)
        tline = fgetl(f); % get current line
        fprintf(fid,'%s\n',tline)
    end
    
fclose(f);
fclose(fid);

% prints outputfile_name to the command line as a test
type(outputfile_name)

end
