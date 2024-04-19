%Analog elektronik - Exempel
%matlab: Fasmarginal, slutna förstärkningen och stegsvaret
%('control toolbox krävs')
clear all;
close all;

%DC slingförstärkning och slingpoler:
AtINF=11; %Asymptotiska förstärkningen
ABnoll=-2462; % DC slingförstärkningen, AB(0)
p1=-5*1e3; %slingpol, -1krad/s
p2=-367; %slingpol, -5krad/s
p3=-385132000;
n1=-35012;

%%Definiera s
s=zpk('s');

ABs=((1-s/n1)*ABnoll)/((1-s/p1)*(1-s/p2)*(1-s/p3)); %Slingförstärkningen, AB(s)

At=AtINF*(-1)*ABs/(1-ABs); %Slutna förstärkningen, At(s).

%Fasmarginal kollas "open loop", dvs frekvensen w0, dŠr |AB(w0)|=1=0dB,
%Undersök (plotta) fasmarginal (PM) genom att plotta slingförstärkningen
figure(1);bode((-1).*ABs,'b'); title('Slingförstärkning'); legend('AB(s)','Location','Best')
figure(2);bode(At,'b'); title('Den slutna förstärkningen, At'); legend('A_t','Location','Best')
figure(3); step(At); title('Systemets stegsvar');