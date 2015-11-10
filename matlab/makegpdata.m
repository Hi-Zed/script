clear;

ftrj = fopen('mep-trj.gpdata', 'w');
fgps = fopen('mep-gps.gpdata', 'w');

strj = load('/tmp/roamfree/PoseSE3(W).log');
sgps = load('/tmp/roamfree/GPS.log');

fprintf(fgps, '%f %f\n', [sgps(3:end,23) sgps(3:end,24)]');
fprintf(ftrj, '%f %f\n', [strj(15:end,3) strj(15:end,4)]');

plot(sgps(3:end,23), sgps(3:end,24), 'o');
hold on;
plot(strj(15:end,3), strj(15:end,4));
axis equal;