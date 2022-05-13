/*
BSD-3 licence
Copyright 2022 Felix Felgner
Copyright 2022 Mark Clements
*/
connector Cut
  flow Real p_flow;
  flow Real var_p_flow;
  Real p;
  flow Real var_l_flow;
  Real l;
end Cut;

model State
  Cut cut; 
  parameter Real p0 = 0 "initial probability";
  Real p(start=p0)      "transition probability";
  Real l                "length of stay";
  Real var_p, lower_p, upper_p;
  Real var_l, lower_l, upper_l;
equation
  der(p) = cut.p_flow;
  der(l) = cut.p;
  cut.p = p;
  cut.l = l;
  cut.var_p_flow = -var_p;
  cut.var_l_flow = -var_l;
  lower_p = p - 1.96*sqrt(var_p);
  upper_p = p + 1.96*sqrt(var_p);
  lower_l = l - 1.96*sqrt(var_l);
  upper_l = l + 1.96*sqrt(var_l);
end State;

partial model ArcBase
  Cut Start, End;
  parameter Integer nbeta = 1;
  parameter Real beta[nbeta] = zeros(nbeta);
  parameter Real var_beta[nbeta,nbeta] = zeros(nbeta,nbeta) "variance for beta parameter";
  Real lambda   "transition rate";
  Real p_flow;
  Real grad_p_flow[nbeta];
  Real grad_l_flow[nbeta];
  Real var_p_flow;
  Real var_l_flow;
equation
  // p
  Start.p_flow + End.p_flow = 0;
  Start.p_flow = p_flow;
  p_flow = Start.p*lambda;
  // grad_p
  var_p_flow = grad_p_flow*var_beta*grad_p_flow;
  Start.var_p_flow = var_p_flow;
  End.var_p_flow = var_p_flow;
  // grad_l
  der(grad_l_flow) = grad_p_flow;
  var_l_flow = grad_l_flow*var_beta*grad_l_flow;
  Start.var_l_flow = var_l_flow;
  End.var_l_flow = var_l_flow;
end ArcBase;

model ArcExponential
  extends ArcBase;
equation
  lambda = beta[1];
  der(grad_p_flow[1]) = grad_p_flow[1]*lambda + Start.p;
end ArcExponential;

model ArcExponentialLogLambda
  extends ArcBase;
equation
  lambda = exp(beta[1]);
  der(grad_p_flow[1]) = grad_p_flow[1]*lambda + Start.p*lambda;
end ArcExponentialLogLambda;

model Markov1
  State s1(p0=1), s2, s3;
  ArcExponential arc1(beta={0.1},var_beta={{1e-4}});
  ArcExponential arc2(beta={0.1},var_beta={{1e-4}});
  ArcExponentialLogLambda arc3(beta={0.05},var_beta={{1}});
equation
  connect(s1.cut,arc1.Start);
  connect(arc1.End,s2.cut);
  connect(s2.cut,arc2.Start);
  connect(arc2.End,s3.cut);
  connect(s2.cut,arc3.Start);
  connect(arc3.End,s1.cut);
end Markov1;
