function [ data ] = getdata( inputfile,pattern )
%GETDATA takes in an inputfile and a regular expression (regex) pattern and
%parses the input file for regex. GETDATA's output is a data matrix of the
%input file.
%   INPUTS:
%       inputfile = string that is the inputfile name, e.g. 'test.txt'
%       pattern = string regex pattern, e.g. '(\d+\.\d+)\s+(\d+\.\d+[E]\S\d+)'
%   OUTPUTS:
%       data = output data matrix of the parsed data

filesize = linecount(inputfile);
fid = fopen(inputfile);
data = [];

for row = 1:filesize
    current_line = fgetl(fid);  % get next line from file
    tokens = regexp(current_line,pattern,'tokens');
    if ~isempty(tokens)
        [row_size,col_size] = size(tokens{1});
        cur_data = [];
        for i = 1:col_size
            cur_datum = str2num(cell2mat(tokens{1}(1,i)));
            cur_data = [cur_data,cur_datum];
        end
        data = [data;cur_data];
    end
end

fclose(fid);

end