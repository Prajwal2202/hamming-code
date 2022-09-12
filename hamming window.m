
% FIR HAMMING WINDOW
clc;
clear all;
close all;
f1=500;
f2=600;
fs=2000;
omg1=2*3.14*f1;
omg2=2*3.14*f2;
wp=omg1/fs;
wc=omg2/fs;
 
%to find order opf the filter
N=(2*3.14*4)/(wc-wp);
N=ceil(N);
r=rem(N,2);
 
if (r==2)
    N=N+1;
end
 
wp=wc;
wc=wc/3.14;
k=hamming(N);
h=fir1((N-1),wc,k);
[b,w]=freqz(h,1,128);
m=20*log10(abs(b));
figure(1);
plot(w/3.14,m);
grid;
ylabel('gain in db');
xlabel('normalized frequency');
 
%veriofication of filter
f1=200;
f2=400;
f3=900;
n=0:49;
x1=sin(2*3.14*n*f1/fs);
x2=sin(2*3.14*n*f2/fs);
x3=sin(2*3.14*n*f3/fs);
x=[x1 x2 x3];
lx=length(x);
y=filter(h,1,x);
t=0:149;
figure(2);
subplot(2,1,1);
plot(t,x);
xlabel('t');
ylabel('x');
subplot(2,1,2);
plot(t,y);
axis=([0 149 -1 1]);
xlabel('t');
ylabel('y');
 
%store the coeffcient and input sample to a file
fid=fopen('g_co_inp.c','w');
fprintf(fid,'float h[%d]={',N);
fprintf(fid,'%f\t,',h);
fprintf(fid,'};');
fprintf(fid,'\nfloat x[%d] ={',lx);
fprintf(fid,'%f\t,',x);
fprintf(fid,'};');
fclose(fid);
 

cc studio--------------




