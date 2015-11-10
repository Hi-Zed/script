clear;

lau = fopen('LAURA_POS.txt', 'w');

fid = fopen('POS1425309996368.log','r');
C = textscan(fid, repmat('%s',1,10), 'delimiter',',', 'CollectOutput',true);
C = C{1};
fclose(fid);
C(:,1) = num2cell(str2double(C(:,1)));
C(:,3) = num2cell(str2double(C(:,3)));
C(:,4) = num2cell(str2double(C(:,4)));
times = cell2mat(C(1:end-20,1));
X = cell2mat(C(1:end-20,3));
Y = cell2mat(C(1:end-20,4));
Y = -Y;

fprintf(lau, '%f,%f,%f\n', [times X Y]');