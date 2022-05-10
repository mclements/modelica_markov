function hweibull "y = hweibull(time,scale,shape)"
  input Real tm;
  input Real shape = 1;
  input Real scale = 1;
  output Real y;
algorithm
  y := if tm>=0 then Modelica.Math.Distributions.Weibull.density(tm,shape,scale)/(1-Modelica.Math.Distributions.Weibull.cumulative(tm,shape,scale)) else 0;
end hweibull;

function hweibull_survreg "y = hweibull_survreg(time,alpha,beta)"
  input Real tm;
  input Real alpha = 0;
  input Real beta = 0;
  output Real y;
algorithm
  y := hweibull(tm, exp(alpha), exp(-beta));
end hweibull_survreg;

function hweibull_survreg_deriv "y = hweibull_survreg_deriv(time,alpha,beta)"
  input Real tm;
  input Real alpha;
  input Real beta;
  Real shape, scale;
  output Real[2] y;
algorithm
  scale := exp(alpha);
  shape := exp(-beta);
  y[1] := if tm>=0 then exp(exp(alpha)*beta+2*alpha)*t^(exp(alpha)-1)*log(t)+(exp(alpha)*beta+1)*exp(exp(alpha)*beta+alpha)*t^(exp(alpha)-1) else 0;
  y[2] := if tm>=0 then exp(exp(alpha)*beta+2*alpha)*t^(exp(alpha)-1) else 0;
end hweibull_survreg_deriv;

model Test
  Real y(start=1);
equation
  der(y) = -y*hweibull(time,0.3,1);
end Test;