%Rootlocus exempel ('control toolbox krävs')
clear all;
close all;
s=zpk('s'); %Definiera 's', se help zpk

%Antag några värden
P1=-5000;
P2=-367;
P3=-385132000;
n=-35012;

figure(1)
%två slingpoler och ett slingnollställe
rlocus( (1-s/n) / ( (1-s/P1)*(1-s/P2)*(1-s/P3) ) )


