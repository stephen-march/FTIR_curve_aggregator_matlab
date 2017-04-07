function [ n ] = linecount( filename )

f = fopen(filename);

n = 0;
tline = fgetl(f); %initializes tline for loop below

while ischar(tline)
    tline = fgetl(f);
    n = n+1;
end

fclose(f);
end