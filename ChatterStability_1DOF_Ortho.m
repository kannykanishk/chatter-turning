clear;
clc;

m = 0.561;
k = 6.48e6;
c = 145;
Kf = 1384;

omega_n = sqrt(k/m);
zy = c/(2*m*omega_n);

omega = 500:10:20000;

G = (omega_n^2 - omega.^2) ./ ( (omega_n^2 - omega.^2).^2 + (2*zy*omega_n*omega).^2 ) ;
H = -(2*zy*omega_n*omega) ./ ( (omega_n^2 - omega.^2).^2 + (2*zy*omega_n*omega).^2 ) ;

psy = PhaseAngle(H,G);

j = find(G<0,1);
negOmega = omega(j:end);
negG = G(j:end);
negPsy = psy(j:end);

N = zeros(25,size(negG,2));
A = zeros(25,size(negG,2));

transferFunction = complex(G,H);

hold on;

for i = 0:24                    %25 lobes
    N(i+1,:) = 60*negOmega ./ (2*i*pi + 3*pi + 2*negPsy);
    A(i+1,:) = -1e-3 ./ (Kf*2*negG);
    plot(N(i+1,:),A(i+1,:));
end

title('Stability Lobe Diagram')
xlabel('N (rpm)')
ylabel('b (mm)')
ylim([0 3]);
xlim([0 15000]);

function angle = PhaseAngle(H,G)

angle = zeros(1,size(G,2));
for i=1:size(G,2)
    if (G(i)>0) && (H(i)<0)
        angle(i) = - atan(abs(H(i)/G(i)));
    elseif (G(i)<0) && (H(i)<0)
        angle(i) = -pi + atan(abs(H(i)/G(i)));
    elseif (G(i)<0) && (H(i)>0)
        angle(i) = -pi - atan(abs(H(i)/G(i)));
    else
        angle(i) = -2*pi + atan(abs(H(i)/G(i)));
    end
end

end