function [X,r,s,X0] = gras(u,v,eps) 
X0 = jvzheng(u,v);
% PURPOSE: estimate a new matrix X with exogenously given row and column 
% totals that is a close as possible to a given original matrix X0 using 
% the Generalized RAS (GRAS) approach
% -------------------------------------------------------------------------
% USAGE: X = gras(X0,u,v) OR [X,r,s] = gras(X0,u,v) with or without eps 
% included as the fourth argument, where
% INPUT:
% -> X0 = benchmark (base) matrix, not necessarily square  
% -> u = column vector of (new) row totals      
% -> v = column vector of (new) column totals   
% -> eps = convergence tolerance level; if empty, the default threshold 
% is 0.1e-5 (=0.000001)
% OUTPUT:
% -> X = estimated/adjusted/updated matrix
% -> r = substitution effects (row multipliers)
% -> s = fabrication effects (column multipliers)
% -------------------------------------------------------------------------
% REFERENCES: 1) Junius T. and J. Oosterhaven (2003), The solution of
% updating or regionalizing a matrix with both positive and negative
% entries, Economic Systems Research, 15, pp. 87-96.
% 2) Lenzen M., R. Wood and B. Gallego (2007), Some comments on the GRAS
% method, Economic Systems Research, 19, pp. 461-465.
% 3) Temurshoev, U., R.E. Miller and M.C. Bouwmeester (2013), A note on the
% GRAS method, Economic Systems Research, 25, pp. 361-367.
% -------------------------------------------------------------------------
% NOTE FROM THE AUTHOR: If you use this program and publish the results in
% the form of working/discussion papers, journal articles etc., you are
% kindly asked to cite the third paper mentioned above (as this code is the
% online Appendix to that paper).
% -------------------------------------------------------------------------


[m,n] = size(X0);
N = zeros(m,n);   
N(X0<0) = -X0(X0<0); 
N = sparse(N);    
P = X0+N;         
P = sparse(P);     
 
r = ones(m,1);      %initial guess for r (suggested by J&O, 2003)
pr = P'*r;
nr = N'*invd(r)*ones(m,1);
s1 = invd(2*pr)*(v+sqrt(v.^2+4*pr.*nr));    %first step s
ss = -invd(v)*nr;
s1(pr==0) = ss(pr==0);      
ps = P*s1;
ns = N*invd(s1)*ones(n,1);
r = invd(2*ps)*(u+sqrt(u.^2+4*ps.*ns));     %first step r
rr = - invd(u)*ns;
r(ps==0) = rr(ps==0);   
pr = P'*r;
nr = N'*invd(r)*ones(m,1);
s2 = invd(2*pr)*(v+sqrt(v.^2+4*pr.*nr));      
ss = -invd(v)*nr;
s2(pr==0) = ss(pr==0);    
dif = s2-s1;             
iter = 1                
if  nargin < 4 || isempty(eps)
    eps = 0.1e-5;      
end        
M = max(abs(dif));
while (M > eps)     
    s1 = s2;
    ps = P*s1;
    ns = N*invd(s1)*ones(n,1);
    r = invd(2*ps)*(u+sqrt(u.^2+4*ps.*ns));   
    rr = -invd(u)*ns;
    r(ps==0) = rr(ps==0);
    pr = P'*r;
    nr = N'*invd(r)*ones(m,1);
    s2 = invd(2*pr)*(v+sqrt(v.^2+4*pr.*nr));  
    ss = -invd(v)*nr;
    s2(pr==0) = ss(pr==0);
    dif = s2-s1;
    iter = iter+1
    M = max(abs(dif));
end
s = s2;                                        
ps = P*s;
ns = N*invd(s)*ones(n,1);
r = invd(2*ps)*(u+sqrt(u.^2+4*ps.*ns));        
rr = -invd(u)*ns;
r(ps==0) = rr(ps==0);
X = diag(r)*P*diag(s)-invd(r)*N*invd(s);  
 
function invd = invd(x) 
invd = 1./x;
invd(x==0) = 1;
invd = diag(invd);


function X0 = jvzheng(u,v) 
m=size(u);
n=size(v);
for i=1:m
    for j=1:n
       X0(i,j)=u(i)*v(j) ;
    end
end
for i=1:m
    X0(i,i)=0;
end



