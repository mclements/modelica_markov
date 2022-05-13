/*
BSD-3 licence
Copyright 2022 Mark Clements
*/
function hweibull "y = hweibull(tm,scale,shape)"
  input Real tm;
  input Real shape = 1;
  input Real scale = 1;
  output Real y;
algorithm
  y := if tm>0 then Modelica.Math.Distributions.Weibull.density(tm,shape,scale)/(1-Modelica.Math.Distributions.Weibull.cumulative(tm,shape,scale)) else 1e-16;
end hweibull;

function hweibull_survreg "y = hweibull_survreg(tm,alpha,beta)"
  annotation(derivative=hweibull_survreg_deriv);
  input Real tm;
  input Real alpha = 0;
  input Real beta = 0;
  output Real y;
algorithm
  y := hweibull(tm, exp(alpha), exp(-beta));
end hweibull_survreg;

function hweibull_survreg_grad "y = hweibull_survreg_grad(tm,alpha,beta)"
  input Real tm;
  input Real alpha;
  input Real beta;
  output Real[2] y;
protected
  Real shape, scale;
algorithm
  shape := exp(alpha);
  scale := exp(-beta);
  y[1] := if tm>0 then exp(exp(alpha)*beta+2*alpha)*tm^(exp(alpha)-1)*log(tm)+(exp(alpha)*beta+1)*exp(exp(alpha)*beta+alpha)*tm^(exp(alpha)-1) else 1e-16;
  y[2] := if tm>0 then exp(exp(alpha)*beta+2*alpha)*tm^(exp(alpha)-1) else 1e-16;
end hweibull_survreg_grad;

function hweibull_survreg_deriv "y = hweibull_survreg_deriv(tm,alpha,beta)"
  input Real tm;
  input Real alpha;
  input Real beta;
  input Real der_tm; // = 1
  input Real der_alpha; // = 0
  input Real der_beta; // = 0
  output Real der_y;
algorithm
  der_y := if tm>0 then (exp(alpha)-1)*exp(exp(alpha)*beta+alpha)*tm^(exp(alpha)-2) else 0;
end hweibull_survreg_deriv;

connector RealOutput = output Real;
connector RealInput = input Real;

partial block RateFunction
  parameter Integer n=1;
  parameter Real[n] beta;
  parameter Real[n,n] vcov = zeros(n,n);
  RealOutput h;
  RealOutput[n] gradh; 
  // RealOutput[n,n] hessian;
end RateFunction;

block WeibullRate
  extends RateFunction(n=2);
equation
  h = hweibull_survreg(time,beta[1], beta[2]);
  gradh = hweibull_survreg_grad(time,beta[1], beta[2]);
end WeibullRate;

// Erlang distribution using compartments (this is quite cool:)
model Erlang
  // extends RateFunction; // ?
  // extends State; // ?
  parameter Integer n = 2;
  parameter Real lambda = 1;
  parameter Real p0[n] = zeros(n);
  RealInput lambdaIn;
  RealOutput lambdaOut;
  RealOutput psum;
protected
  Real p[n](start=p0); // internal state
equation
  der(p[1]) = lambdaIn -p[1]*lambda;
  for i in 2:n loop
    der(p[i]) = (p[i-1]-p[i])*lambda;
  end for;
  lambdaOut = p[n]*lambda;
  psum = sum(p);
end Erlang;

// Add a chance node to a rate
model ChanceRate
  parameter Integer n=1;
  parameter Real alpha[n-1] = zeros(n-1);
  parameter Real beta[n-1] = zeros(n-1);
  RealInput rate;
  RealOutput prate[n];
protected
  Real expeta[n-1];
  Real denom;
equation
  for i in 1:(n-1) loop
    expeta[i] = exp(alpha[i]+beta[i]*time);
  end for;
  denom = 1+sum(expeta);
  for i in 1:(n-1) loop
    prate[i+1] = rate*expeta[i]/denom;
  end for;
  prate[1] = rate/denom;
end ChanceRate;

model Test
  Real y(start=1), y2(start=1);
  Real y3[2];
  WeibullRate rate(beta={0.3,0.1});
  Real l;
  Erlang erlang(n=6,lambda=2);
  ChanceRate chance(n=2,alpha={0.1});
equation
  connect(erlang.lambdaOut,chance.rate);
  der(y) = -y*rate.h;
  // der(y) = -y*hweibull(time,0.3,1);
  der(l) = y;
  der(y2) = -y2*1;
  erlang.lambdaIn = y2*1; // time is implicit...
  der(y3) = chance.prate; // vector
end Test;