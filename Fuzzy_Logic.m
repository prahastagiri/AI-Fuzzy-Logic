x = [97 36 63 82 71 79 55 57 40 57 77 68 60 82 40 80 60 50 100 11 58 68 64 57 77 98 91 50 95 27];
y = [74 85 43 90 25 81 62 45 65 45 70 75 70 90 85 68 72 95 18 99 63 70 66 77 55 64 59 95 55 79];

%FUZZYFICATION-----------------------------------------------------------
for i = 1 : length(x) ;
    
    %ELOW
    if (x(1,i)>=0 && x(1,i)<=35)
        a=0;b=0;c=20;d=35;
        if (x(1,i)>=0 && x(1,i)<=20)
            emosi(1,1)=1;emosi(1,2)=0;emosi(1,3)=0;
        elseif (x(1,i)>20 && x(1,i)<=35)
            emosi(1,1) = -(x(1,i)-d)/(d-c);
        end
    end
    %EMED
    if (x(1,i)>=20 && x(1,i)<=85)
        a=20;b=35;c=70;d=85;
        if (x(1,i)>20 && x(1,i)<35)
            emosi(1,2) = (x(1,i)-a)/(b-a);
        elseif (x(1,i)>=35 && x(1,i)<=70)
            emosi(1,1)=0;emosi(1,2)=1;emosi(1,3)=0;
        elseif (x(1,i)>70 && x(1,i)<=85)
            emosi(1,2) = -(x(1,i)-d)/(d-c);
        end
    end
    %EHIGH
    %EMOSI HIGH
    if (x(1,i)>=70 && x(1,i)<=105)
        a=70;b=85;c=100;d=105;
        if (x(1,i)>70 && x(1,i)<85)
            emosi(1,3) = (x(1,i)-a)/(b-a);
        elseif (x(1,i)>=85 && x(1,i)<=100)
            emosi(1,1)=0;emosi(1,2)=0;emosi(1,3)=1;
        end
    end
    
    
    %PLOW
    if (y(1,i)>=0 && y(1,i)<=35)
        a=0;b=0;c=20;d=35;
        if (y(1,i)>=0 && y(1,i)<=20)
            provokasi(1,1)=1;provokasi(1,2)=0;provokasi(1,3)=0;
        elseif (y(1,i)>20 && y(1,i)<=35)
            provokasi(1,1) = -(y(1,i)-d)/(d-c);
        end
    end
    %PMED
    if (y(1,i)>=20 && y(1,i)<=85)
        a=20;b=35;c=70;d=85;
        if (y(1,i)>20 && y(1,i)<35)
            provokasi(1,2) = (y(1,i)-a)/(b-a);
        elseif (y(1,i)>=35 && y(1,i)<=70)
            provokasi(1,1)=0;provokasi(1,2)=1;provokasi(1,3)=0;
        elseif (y(1,i)>70 && y(1,i)<=85)
            provokasi(1,2) = -(y(1,i)-d)/(d-c);
        end
    end
    %PHIGH
    if (y(1,i)>=70 && y(1,i)<=105)
        a=70;b=85;c=100;d=105;
        if (y(1,i)>70 && y(1,i)<85)
            provokasi(1,3) = (y(1,i)-a)/(b-a);
        elseif (y(1,i)>=85 && y(1,i)<=100)
            provokasi(1,1)=0;provokasi(1,2)=0;provokasi(1,3)=1;
        end
    end
    
    
    %INFERENCE---------------------------------------------------------------
    %TIDAK
    m=1;
    for g = 1 : 3
        for h = 1 : 2
            if (g==3 && h==2)
                break;
            end
            tidak(m,1) = min(emosi(g),provokasi(h));
            m=m+1;
        end
    end
    
    %YA
    o=1;
    for q = 3 :-1: 1
        for k = 3 :-1: 2
            if (q==2 && k==2)
                continue;
            end
            if (q==1 && k==2)
                continue;
            end
            ya(o,1) = min(emosi(q),provokasi(k));
            o=o+1;
        end
    end
    tidakmax=max(max(tidak));
    yamax=max(max(ya));
    
    %DEFUZZYFICATION-------------------------------------------------------
    
    %SUGENO
    if yamax ==0 && tidakmax==0
        sugeno = 1;
    end
    sugeno = (yamax*25 + tidakmax*75)/(yamax+tidakmax);
    
    %HOAX
    if sugeno >= 45
        hoax(i,1) = 0;
    else
        hoax(i,1) = 1;
    end
end
%hasil hoax
disp(hoax);