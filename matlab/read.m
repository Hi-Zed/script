clear;
fid = fopen('data/Como/MEP_MOTION_INFO.txt', 'r');
%fid = fopen('data/Lecco/MEP_MOTION_INFO.txt', 'r');
%fid = fopen('data/MEP_1433942973773/MEP_MOTION_INFO.txt', 'r');
%fid = fopen('data/SIMU1/MEP_MOTION_INFO.txt', 'r');

C = textscan(fid, repmat('%s',1,10), 'delimiter',',', 'CollectOutput',true);
C = C{1};
s = size(C, 1);
t0 = str2double(cell2mat(C(1,1)));
t0 = t0/1000;
j = 1;
w = 1;
for k = 1:s
    if(strcmp(cell2mat(C(k,2)), 'TYPE_GYROSCOPE'))
        t = str2double(cell2mat(C(k,1)))/1000 - t0;
        if(j == 1 || (t - gyro(j-1,1)) > 0)
            gyro(j,1) = t;
            gyro(j,2) = str2double(cell2mat(C(k,3)));
            gyro(j,3) = str2double(cell2mat(C(k,4)));
            gyro(j,4) = str2double(cell2mat(C(k,5)));
            j = j+1;
        end
    end
    if(strcmp(cell2mat(C(k,2)), 'TYPE_ACCELEROMETER'))
        t = str2double(cell2mat(C(k,1)))/1000 - t0;
        if(w == 1 || (t - acc(w-1,1)) > 0)
            acc(w,1) = t;
            acc(w,2) = str2double(cell2mat(C(k,3)));
            acc(w,3) = str2double(cell2mat(C(k,4)));
            acc(w,4) = str2double(cell2mat(C(k,5)));
%             if(acc(w,4) > 0)
%                 acc(w,4) = acc(w,4) - 0.5;
%             else
%                 acc(w,4) = acc(w,4) + 0.5;
%             end
%             if(abs(acc(w,4)) < 1.0)
%                 acc(w,4) = 0;
%             end
            w = w+1;
        end
    end
end

Tspan = [acc(1,1) acc(end, 1)];
IC = [0 0 0 0];
[T, Y] = ode45(@(t,y) integrate(t,y,acc(:,1),acc(:,4),gyro(:,1),gyro(:,2)),Tspan,IC);

fclose(fid);