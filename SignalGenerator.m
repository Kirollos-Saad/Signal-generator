fs=input("Please enter the sampling frequency ");
while(fs<=0)
    fs=input("wrong input\nPlease enter the sampling frequency again ");
end
tstart=input('enter the starting time\n');
tend=input('enter the ending time\n');
if(tstart>tend)
    temp=tend;tend=tstart;tstart=temp;
end

t=linspace(tstart,tend,(tstart-tend)*fs);
x=input('enter number of break points\n');
while(x<0)
    x=input('enter number of break points not a negative number\n');
end
a=zeros(1,x);
if x>0
    for i=1:x
        
       % disp('point');
        %disp(i);
        fprintf('enter the %d th point',i);
        a(1,i)=input(''); 
        if a(1,i)>tend || a(1,i)<tstart
            i=i-1;
            fprintf('enter break points between %d and %d',tstart,tend);
        end
    end
end

b=zeros(1,length(a));
c=[tstart a tend];
for i=1:length(a)+1
    disp(['enter the type of signal' ...
        ' for DC press 1 ' ...
        ' for ramp press 2 ' ...
        ' for genral order polynomial press 3 ' ...
        ' for exponential press 4 ' ...
        ' for Sinosoidal signal press 5  ']);
    fprintf('enter the type of the signal stating at %d and ending %d \n',c(1,i),c(1,i+1));
    b(1,i)=input(''); 
end


for i=1:length(b)
    if i==1 &&~isempty(a)==0
         t=linspace(tstart,tend,(tend-tstart)*fs);
    elseif i==1 && ~isempty(a)
        t=linspace(tstart,a(1,i),(a(1,i)-tstart)*fs);
   
    elseif i==length(b)
        t=linspace(a(1,i-1),tend,(tend-a(1,i-1))*fs);
        
    else
         t=linspace(a(1,i-1),a(1,i),(a(1,i)-a(1,i-1))*fs);
    end
    
    
       if b(1,i)==1
           fprintf('for DC signal stating at %d and ending %d \n',c(1,i),c(1,i+1));
          amp=input('enter amplitude\n'); 
           x1=amp*ones(size(t));
           figure;plot(t,x1);
       elseif b(1,i)==2
           fprintf('for Ramp signal stating at %d and ending %d \n',c(1,i),c(1,i+1));
            sl=input('enter slope of the ramp\n');
            inter=input('enter intercept of the ramp\n'); 
            x1=sl*t+inter;
            figure;plot(t,x1);
       elseif b(1,i)==3
           fprintf('for General polynomial signal stating at %d and ending %d \n',c(1,i),c(1,i+1));
           pow=input('enter power of the function\n');
            inter=input('enter intercept of the function\n');
             A=input('enter amplitude\n');
             x1 = (A*((t).^pow))+inter;
             figure;plot(t,x1);
             
        elseif b(1,i)==4
            fprintf('for Exponential signal stating at %d and ending %d \n',c(1,i),c(1,i+1));
            k=input('enter amplitude\n');
            ex2=input('enter exponent\n');
            x1=k.*(2.71828182846).^(ex2.*t);
            figure;plot(t,x1);
        elseif b(1,i)==5
            fprintf('for Sinsoidal signal stating at %d and ending %d \n',c(1,i),c(1,i+1));
               am=input('enter amplitude\n');
               f=input('enter frequency in hz\n');
               ph=input('enter phase\n');
            x1=am.*cos(2*pi*f*t + ph*pi/180);
            figure;plot(t,x1);
                
            
       end
            if i==1
             x=x1;
            else
                x=[x x1];
            end
    
end

t=linspace(tstart,tend,(tend-tstart)*fs);
figure;plot(t,x);
n=1;
k=tstart;p=tend;
while n==1||n==2
    disp(['1-amplitude scale     ' ...
        '2-time reversal    ' ...
        '  3-time shift']);
    disp(['4-expanding  ' ...
        '         5-compressing  ' ...
        '      6-none']);
    num=input('enter the number of the wanted operation');
    if num==1
      sc=input('enter the scale value');
      %t=linspace(tstart/sc,tend/sc,(tend-tstart)*fs);
      x=sc.*x;
      figure;plot(t,x);
    elseif num==2
        if n==1
        k=-tstart;p=-tend;
        else
        k=-k;p=-p;
        end
        t=linspace(k,p,(tend-tstart)*fs);
        figure;plot(t,x);n=2;
    elseif num==3
      sh=input('enter the shift value'); 
      if n==1
        k=tstart+sh;p=sh+tend;
      else
          k=k+sh;p=p+sh;
      end
      t=linspace(k,p,(tend-tstart)*fs);
      figure;plot(t,x);
      n=2;
    elseif num==4
        u=input('enter the expand value');
        while u<0 ||u>1
            u=input('enter the expand value');
        end
        if n==1
        k=tstart/u;p=tend/u;
        else
            k=k/u;p=p/u;
        end
      t=linspace(k,p,(tend-tstart)*fs);
      figure;plot(t,x);
      n=2;
    elseif num==5
        u=input('enter the compress value');
        while u<1
            u=input('enter the compress value');
        end
        if n==1
        k=tstart/u;p=tend/u;
        else
            k=k/u;p=p/u;
        end
      t=linspace(k,p,(tend-tstart)*fs);
      figure;plot(t,x);
      n=2;
    elseif(num==6)
        n=0;
        figure;plot(t,x);
    end
end