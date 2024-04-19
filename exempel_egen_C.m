%Analog elektronik - Exempel
%matlab: Fasmarginal, slutna f�rst�rkningen och stegsvaret
%('control toolbox kr�vs')
clear all;
close all;

%DC slingf�rst�rkning och slingpoler:
AtINF=11; %Asymptotiska f�rst�rkningen
ABnoll=-2462; % DC slingf�rst�rkningen, AB(0)
p1=-5*1e3; %slingpol, -1krad/s
p2=-367; %slingpol, -5krad/s
p3=-385132000;
n1=-35012;

%%Definiera s
s=zpk('s');

ABs=((1-s/n1)*ABnoll)/((1-s/p1)*(1-s/p2)*(1-s/p3)); %Slingf�rst�rkningen, AB(s)

At=AtINF*(-1)*ABs/(1-ABs); %Slutna f�rst�rkningen, At(s).

%Fasmarginal kollas "open loop", dvs frekvensen w0, d�r |AB(w0)|=1=0dB,
%Unders�k (plotta) fasmarginal (PM) genom att plotta slingf�rst�rkningen
figure(1);bode((-1).*ABs,'b'); title('Slingf�rst�rkning'); legend('AB(s)','Location','Best')
figure(2);bode(At,'b'); title('Den slutna f�rst�rkningen, At'); legend('A_t','Location','Best')
figure(3); step(At); title('Systemets stegsvar');