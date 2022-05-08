connector Cut
  flow Real p_flow;
  Real p;
  Real l;
end Cut;

model State
  Cut cut; 
  parameter Real p0 = 0; // initial probability
  Real p(start=p0); // transition probability
  Real l;  // length of stay
equation
  der(p) = cut.p_flow;
  der(l) = cut.p;
  cut.p = p;
  cut.l = l;
end State;

model Arc
  Cut Start, End;
  Real lambda;     // transition rate
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
  connect(s1.cut,arc1.Start);
  connect(arc1.End,s2.cut);
  // s2 -> s3
  connect(s2.cut,arc2.Start);
  connect(arc2.End,s3.cut);
  // s2 -> s1
  connect(s2.cut,arc3.Start);
  connect(arc3.End,s1.cut);
end Markov1;
