%Analog elektronik - Exempel
%matlab: Fasmarginal, slutna f�rst�rkningen och stegsvaret
%('control toolbox kr�vs')
clear all;
close all;

beta_f=200;
v_t=25.7/1000;
i_c=4/1000;
R1=1000;
R2=10000;
Rs=10000;
RL=100;
c_prim_1=100*10^-9;
c_2=2.2*10^-6;

r_pi_2=(beta_f*v_t)/i_c;
r_pi_1_prim=2*(beta_f*v_t)/(i_c);


%DC slingf�rst�rkning och slingpoler:
AtINF=1+(R2/R1); %Asymptotiska f�rst�rkningen
ABnoll=-(beta_f*beta_f*R1*Rs)/((Rs+r_pi_1_prim)*(R1+R2)+Rs*r_pi_1_prim); % DC slingf�rst�rkningen, AB(0)
p1=-(((Rs+r_pi_1_prim)*(R1+R2)+Rs*r_pi_1_prim)/(Rs*(R1+R2)))*(1/(r_pi_1_prim*c_prim_1)); %slingpol, -1krad/s
p2=-1/(r_pi_2*c_2); %slingpol, -5krad/s

%%Definiera s
s=zpk('s');

ABs=ABnoll/((1-s/p1)*(1-s/p2)); %Slingf�rst�rkningen, AB(s)

At=AtINF*(-1)*ABs/(1-ABs); %Slutna f�rst�rkningen, At(s).

%% med kompensering C
w0=((1-ABnoll)*p1*p2)^(1/2);
n_ph=-(w0^2)/(2*w0+p1+p2);
c_ph=-1/(R2*n_ph);
p3_ph_c=-(R1+R2)/(R1*R2*c_ph);

ABs_ph_c=((1-s/n_ph)*ABnoll)/((1-s/p1)*(1-s/p2)*(1-s/p3_ph_c));

%% med kompensering L
l_ph=-R1/n_ph;
p3_ph_l=-(R1+R2)/(l_ph);

ABs_ph_l=((1-s/n_ph)*ABnoll)/((1-s/p1)*(1-s/p2)*(1-s/p3_ph_l));

%% fasmarginal & bandbredd

R2_c=R2/(s*R2*c_ph+1);
AtINF_c=1+(R2_c/R1); 

R1_l=R1+l_ph;
AtINF_l=1+(R2/R1_l); 

At_c=AtINF_c*(-1)*ABs_ph_c/(1-ABs_ph_c);
At_l=AtINF_l*(-1)*ABs_ph_l/(1-ABs_ph_l);

[gainm, pm_komp] = margin((-1)*ABs_ph_c);
pm_komp

BW = bandwidth(At_c/(2*pi));
BW
%% plot

%Fasmarginal kollas "open loop", dvs frekvensen w0, d�r |AB(w0)|=1=0dB,
%Unders�k (plotta) fasmarginal (PM) genom att plotta slingf�rst�rkningen


figure(1);bode((-1).*ABs, (-1).*ABs_ph_c, (-1).*ABs_ph_l, 'b'); title('Slingf�rst�rkning AB(s)'); legend('utan', 'med kondensator', 'med spole')

figure(2);bode(At, At_c, At_l, 'b'); title('Den slutna f�rst�rkningen, At'); legend('utan', 'med kondensator', 'med spole');

figure(3); step(At, At_c, At_l); title('Systemets stegsvar'); legend('utan', 'med kondensator', 'med spole');

%% rlocus

figure(4)
rlocus( 1 / ( (1-s/p1)*(1-s/p2) ) ); title('Utan kompensering');

figure(5)
rlocus( (1-s/n_ph) / ( (1-s/p1)*(1-s/p2)*(1-s/p3_ph_c) ) ); title('Med kompensering');
