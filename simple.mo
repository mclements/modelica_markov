/*
BSD-3 licence
Copyright 2022 Felix Felgner
Copyright 2022 Mark Clements
*/
connector Cut
  flow Real p_flow;
  Real p;
end Cut;

model State
  Cut cut; 
  parameter Real p0 = 0 "initial probability";
  Real p(start=p0)      "transition probability";
  Real l                "length of stay";
equation
  der(p) = cut.p_flow;
  der(l) = p;
  cut.p = p;
end State;

model Arc
  Cut Start, End;
  parameter Real lambda = 1 "transition rate";
  Real p_flow;
equation
  Start.p_flow + End.p_flow = 0;
  Start.p_flow = p_flow;
  p_flow = Start.p*lambda;
end Arc;

model Markov1
  State s1(p0=1), s2, s3;
  Arc arc1(lambda=0.1);
  Arc arc2(lambda=0.1);
  Arc arc3(lambda=0.05);
equation
  // s1 -> s2
  connect(arc1.Start,s1.cut);
  connect(arc1.End,  s2.cut);
  // s2 -> s3
  connect(arc2.Start,s2.cut);
  connect(arc2.End,  s3.cut);
  // s2 -> s1
  connect(arc3.Start,s2.cut);
  connect(arc3.End,  s1.cut);
end Markov1;
