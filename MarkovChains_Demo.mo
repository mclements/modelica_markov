package MarkovChains
  package Examples
    model Two_States
    parameter Real T_I(unit="h") = 8760 "Inspection interval";

      Components.State OK(P_0=1) annotation (                         Placement(
            transformation(extent={{-34,-10},{-14,10}},rotation=0)));
      Components.State D annotation (                       Placement(
            transformation(extent={{16,-10},{36,10}},rotation=0)));
      Components.Arc arc(lambda=3600*1e-9) annotation (
          Placement(transformation(extent={{-12,2},{14,12}},  rotation=0)));
      Components.Arc arc1(lambda=2/T_I) annotation (
          Placement(transformation(extent={{14,-12},{-14,-2}},rotation=0)));
    equation
      connect(arc.Start, OK.cut) annotation (
        Line(
          points={{-10.31,7},{-19.4,7},{-19.4,0},{-24.05,0}},
          color={209,0,0},
          pattern=LinePattern.None,
          thickness=0.5));
      connect(arc.End, D.cut) annotation (
        Line(
          points={{12.31,7},{22,7},{22,0},{25.95,0}},
          color={209,0,0},
          pattern=LinePattern.None,
          thickness=0.5));
      connect(arc1.Start, D.cut) annotation (
        Line(
          points={{12.18,-7},{19.16,-7},{19.16,0},{25.95,0}},
          color={209,0,0},
          pattern=LinePattern.None,
          thickness=0.5));
      connect(arc1.End, OK.cut) annotation (
        Line(
          points={{-12.18,-7},{-16.16,-7},{-16.16,0},{-24.05,0}},
          color={209,0,0},
          pattern=LinePattern.None,
          thickness=0.5));
      annotation (Diagram(graphics), experiment(StopTime=50000,
            __Dymola_Algorithm="Dassl"));
    end Two_States;

    model Boercsoek_Fig_13_4 "Markov model according to figure 13.4 from book: Josef Börcsök, Functional Safety"

    parameter Real lambda_S(unit="1/h") = 20.9E-9;
    parameter Real lambda_D(unit="1/h") = 20.9E-9;
    parameter Real lambda_DD(unit="1/h") = 10.45E-9;
    parameter Real lambda_DU(unit="1/h") = 10.45E-9;

    parameter Real beta = 0.03;
    parameter Real beta_D = 0.03;

    parameter Real mu_R(unit="1/h") = 0.125;
    parameter Real mu_0(unit="1/h") = 0.0416;
    parameter Real mu_LT(unit="1/h") = 0;

    Real MTTF "Mean time to failure is asymptotic value reached for time --> inifinity";

      Components.State OK_OK_0(P_0=100) annotation (
          Placement(transformation(extent={{-88,-4},{-68,16}}, rotation=0)));
      Components.State State_S_1 annotation (                         Placement(
            transformation(extent={{-45,55},{-25,75}}, rotation=0)));
      Components.State OK_DD_2 annotation (                      Placement(
            transformation(extent={{5,25},{25,45}}, rotation=0)));
      Components.State OK_DU_3 annotation (                        Placement(
            transformation(extent={{5,-36},{25,-16}}, rotation=0)));
      Components.State DD_DD_4 annotation (                       Placement(
            transformation(extent={{61,25},{81,45}}, rotation=0)));
      Components.State DD_DU_5 annotation (                         Placement(
            transformation(extent={{61,-36},{81,-16}}, rotation=0)));
      Components.State DU_DU_6 annotation (                           Placement(
            transformation(extent={{-47,-75},{-27,-55}}, rotation=0)));
      Components.Arc_diag arc_diag(lambda=2*lambda_S)
        annotation (                         Placement(transformation(extent={{-68,33},
                {-50,44}},         rotation=0)));
      Components.Arc_diag arc_diag1(lambda=mu_R)
        annotation (                         Placement(transformation(extent={{-43,39},
                {-61,28}},         rotation=0)));
      Components.Arc_diag arc_diag2(lambda=mu_LT)
        annotation (                           Placement(transformation(extent={{-50,-31},
                {-64,-20}},            rotation=0)));
      Components.Arc_diag arc_diag3(lambda=beta*lambda_DU)
        annotation (                           Placement(transformation(extent={{-71,-24},
                {-56,-35}},            rotation=0)));
      Components.Arc_bend arc_bend(lambda=lambda_DU)
        annotation (                         Placement(transformation(extent={{19,-43},
                {-7,-67}},         rotation=0)));
      Components.Arc_diag arc_diag4(lambda=2*lambda_DU)
        annotation (                         Placement(transformation(extent={{-49,-2},
                {-12,-9}},         rotation=0)));
      Components.Arc_diag arc_diag5(lambda=mu_LT)
        annotation (                           Placement(transformation(extent={{-19,-19},
                {-54,-12}},            rotation=0)));
      Components.Arc arc(lambda=lambda_DD) annotation (
          Placement(transformation(extent={{31,-32},{52,-21}}, rotation=0)));
      Components.Arc_diag arc_diag6(lambda=2*lambda_DD)
        annotation (                       Placement(transformation(extent={{-29,26},
                {8,32}},         rotation=0)));
      Components.Arc_bend2 arc_diag7(lambda=beta_D*lambda_DD)
        annotation (                       Placement(transformation(extent={{19,48},
                {50,64}},     rotation=0)));
      Components.Arc_bend arc_bend1(lambda=mu_0) annotation (
                 Placement(transformation(extent={{18,47},{-4,68}}, rotation=0)));
      Components.Arc_bend arc_bend2(lambda=mu_0) annotation (
                 Placement(transformation(extent={{74,50},{52,71}}, rotation=0)));
      Components.Arc_bend arc_bend3(lambda=mu_0) annotation (
                 Placement(transformation(extent={{89,53},{67,74}}, rotation=0)));
      Components.Arc arc1(lambda=lambda_DD) annotation (
          Placement(transformation(extent={{30,30},{50,40}}, rotation=0)));
      Components.Arc_diag arc_diag8(lambda=lambda_DU)
        annotation (                      Placement(transformation(extent={{27,18},{
                49,8}},      rotation=0)));
    equation
      connect(arc_diag.End, State_S_1.cut) annotation (
        Line(points={{-53.78,44.99},{-42,61},{-41,60},{-35.05,60},{-35.05,65}},
            color={198,0,0}));
      connect(arc_diag.Start, OK_OK_0.cut) annotation (
        Line(points={{-63.95,32.23},{-79,13},{-76,12},{-78.05,12},{-78.05,6}},
            color={198,0,0}));
      connect(arc_diag1.Start, State_S_1.cut) annotation (
        Line(points={{-47.05,39.77},{-35,56},{-35.05,56},{-35.05,65}}, color={198,0,0}));
      connect(arc_diag1.End, OK_OK_0.cut) annotation (
        Line(points={{-57.22,27.01},{-72,9},{-73,11},{-74,11},{-80,8},{-78.05,6}},
            color={198,0,0}));
      connect(arc_diag2.Start, DU_DU_6.cut) annotation (
        Line(points={{-53.15,-31.77},{-37,-58},{-38,-57},{-39,-57},{-39,-65},{-37.05,
              -65}},        color={198,0,0}));
      connect(arc_diag2.End, OK_OK_0.cut) annotation (
        Line(points={{-61.06,-19.01},{-75,3},{-74,0},{-79,0},{-79,6},{-78.05,6}},
            color={198,0,0}));
      connect(arc_diag3.End, DU_DU_6.cut) annotation (
        Line(points={{-59.15,-35.99},{-43,-62},{-42,-60},{-39,-60},{-36,-63},{-37.05,
              -65}},        color={198,0,0}));
      connect(arc_diag3.Start, OK_OK_0.cut) annotation (
        Line(points={{-67.625,-23.23},{-80,-3},{-79,-3},{-78,1},{-78.05,6}},
            color={198,0,0}));
      connect(arc_bend.End, DU_DU_6.cut) annotation (
        Line(points={{-4.16364,-65.2545},{-28.0818,-65.2545},{-28.0818,-65},{
              -37.05,-65}}, color={198,0,0}));
      connect(arc_bend.Start, OK_DU_3.cut) annotation (
        Line(points={{15.3364,-44.9636},{15.3364,-23.4818},{14.95,-23.4818},{
              14.95,-26}}, color={198,0,0}));
      connect(arc_diag4.Start, OK_OK_0.cut) annotation (
        Line(points={{-40.675,-1.51},{-70,9},{-69,6},{-78.05,6}}, color={198,0,0}));
      connect(arc_diag4.End, OK_DU_3.cut) annotation (
        Line(points={{-19.77,-9.63},{9,-21},{14.95,-26}}, color={198,0,0}));
      connect(arc_diag5.Start, OK_DU_3.cut) annotation (
        Line(points={{-26.875,-19.49},{12,-34},{14.95,-26}}, color={198,0,0}));
      connect(arc_diag5.End, OK_OK_0.cut) annotation (
        Line(points={{-46.65,-11.37},{-74,0},{-73,0},{-73,6},{-78.05,6}}, color={198,0,0}));
      connect(arc.Start, OK_DU_3.cut) annotation (
        Line(points={{32.365,-26.5},{24,-26.5},{24,-26},{14.95,-26}}, color={198,0,0}));
      connect(arc.End, DD_DU_5.cut) annotation (
        Line(points={{50.635,-26.5},{63,-26.5},{63,-26},{70.95,-26}}, color={198,0,0}));
      connect(arc_diag6.End, OK_DD_2.cut) annotation (
        Line(points={{0.23,32.54},{8,35},{14.95,35}}, color={198,0,0}));
      connect(arc_diag6.Start, OK_OK_0.cut) annotation (
        Line(points={{-20.675,25.58},{-70,9},{-78.05,9},{-78.05,6}}, color={198,0,0}));
      connect(arc_diag7.Start, OK_OK_0.cut) annotation (
        Line(points={{19.8455,56},{-70,56},{-70,6},{-78.05,6}}, color={198,0,0}));
      connect(arc_diag7.End, DD_DD_4.cut) annotation (
        Line(points={{49.2955,56},{71,56},{71,35},{79,35},{70.95,35}}, color={198,0,0}));
      connect(arc_bend1.Start, OK_DD_2.cut) annotation (
        Line(points={{14.9,48.7182},{14.95,41},{14.95,35}}, color={198,0,0}));
      connect(arc_bend1.End, State_S_1.cut) annotation (
        Line(points={{-1.6,66.4727},{-26.3,66.4727},{-26.3,65},{-35.05,65}},
            color={198,0,0}));
      connect(arc_bend2.Start, DD_DD_4.cut) annotation (
        Line(points={{70.9,51.7182},{70.9,35},{70.95,35}}, color={198,0,0}));
      connect(arc_bend2.End, State_S_1.cut) annotation (
        Line(points={{54.4,69.4727},{-28,69.4727},{-28,65},{-35.05,65}}, color={198,0,0}));
      connect(arc_bend3.End, State_S_1.cut) annotation (
        Line(points={{69.4,72.4727},{-32,72.4727},{-32,70},{-31,70},{-31,65},{
              -35.05,65}}, color={198,0,0}));
      connect(DD_DU_5.cut, arc_bend3.Start) annotation (
        Line(points={{70.95,-26},{85.9,-26},{85.9,54.7182}}, color={198,0,0}));
      connect(arc1.Start, OK_DD_2.cut) annotation (
        Line(points={{31.3,35},{14.95,35}}, color={198,0,0}));
      connect(arc1.End, DD_DD_4.cut) annotation (
        Line(points={{48.7,35},{70.95,35}}, color={198,0,0}));
      connect(arc_diag8.Start, OK_DD_2.cut) annotation (
        Line(points={{31.95,18.7},{20,30},{19,29},{19,35},{14.95,35}}, color={198,0,0}));
      connect(arc_diag8.End, DD_DU_5.cut) annotation (
        Line(points={{44.38,7.1},{70,-18},{69,-19},{68,-19},{68,-26},{70.95,-26}},
            color={198,0,0}));
    der(MTTF) = OK_OK_0.P/100 + OK_DD_2.P/100 + OK_DU_3.P/100;

      annotation (                      Diagram(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-90,-80},{90,80}},
            grid={1,1},
            initialScale=0.1),
          graphics={
            Text(
              extent={{65,-58},{65,-63}},
              lineColor={175,175,175},
              textString=
                   "For MTTF calculation, set"),
            Text(
              extent={{61,-64},{61,-69}},
              lineColor={175,175,175},
              textString=
                   "arc_diag1.mu_R = 0,"),
            Text(
              extent={{62,-69},{62,-74}},
              lineColor={175,175,175},
              textString=
                   "arc_diag2.mu_LT = 0,"),
            Text(
              extent={{62,-74},{62,-79}},
              lineColor={175,175,175},
              textString=
                   "arc_diag5.mu_LT = 0.")}),
        experiment(StopTime=1e+009),
        experimentSetupOutput);
    end Boercsoek_Fig_13_4;

  end Examples;

  package Components
    package Connectors
      connector Cut
      flow Real P_flow(unit="% / time unit") "Probability flow";
      Real P(unit="") "Probability of connected state";

        annotation (Icon(graphics={Ellipse(extent={{-80,80},{80,-80}},
                  lineColor={255,0,0})}));

      end Cut;

    end Connectors;

    package Base
      model State_base
      parameter Real P_0(unit="%")=0 "Initial probability";
      Real P(unit="%", start=P_0) "Probabilty";

      Connectors.Cut cut annotation (
          Placement(transformation(extent={{-104,-101},{103,101}}, rotation=0)));

      equation
      der(P) = cut.P_flow;
      cut.P = P;

        annotation (
          Diagram(coordinateSystem(
              preserveAspectRatio=false,
              preserveOrientation=false,
              extent={{-100,-100},{100,100}},
              grid={1,1},
              initialScale=0), graphics),
          Icon(coordinateSystem(
              preserveAspectRatio=false,
              preserveOrientation=false,
              extent={{-100,-100},{100,100}},
              grid={1,1},
              initialScale=0), graphics));
      end State_base;

      class State_base_G
        "State used in generic Markov models with deliberate number of states"
      Real P(unit="%") "Probabilty";
      //Boolean reinitTrigger "Trigger for reinitialization of state";
      //Real reinitValue "Value after reinit";

      Connectors.Cut cut annotation (                             Placement(
              transformation(extent={{-111,-112},{112,112}}, rotation=0)));
      initial equation
      //P = P_0;
      equation

      der(P) = cut.P_flow;
      cut.P = P;

      //when reinitTrigger then
      //  reinit(P, reinitValue);

      //end when;

        annotation (
          Diagram(coordinateSystem(
              preserveAspectRatio=false,
              preserveOrientation=false,
              extent={{-100,-100},{100,100}},
              grid={1,1},
              initialScale=0), graphics),
          Icon(coordinateSystem(
              preserveAspectRatio=false,
              preserveOrientation=false,
              extent={{-100,-100},{100,100}},
              grid={1,1},
              initialScale=0), graphics));
      end State_base_G;
    end Base;

    class StateG
    extends Components.Base.State_base_G;

      annotation (
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-100,-100},{100,100}},
            grid={1,1},
            initialScale=0), graphics),
        Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-100,-100},{100,100}},
            grid={1,1},
            initialScale=0),
          graphics={Ellipse(
              extent={{-90,92},{92,-91}},
              lineColor={28,108,200},
              pattern=LinePattern.None,
              lineThickness=0.5,
              fillColor={199,0,0},
              fillPattern=FillPattern.Solid), Text(
              extent={{-80,45},{80,-40}},
              lineColor={215,215,215},
              pattern=LinePattern.None,
              lineThickness=0.5,
              fillColor={231,231,231},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name")}));

    end StateG;

    model State
    extends Components.Base.State_base;

      annotation (
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-100,-100},{100,100}},
            grid={1,1},
            initialScale=0), graphics),
        Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-100,-100},{100,100}},
            grid={1,1},
            initialScale=0),
          graphics={Ellipse(
              extent={{-90,89},{90,-89}},
              lineColor={28,108,200},
              pattern=LinePattern.None,
              lineThickness=0.5,
              fillColor={199,0,0},
              fillPattern=FillPattern.Solid), Text(
              extent={{-80,45},{80,-40}},
              lineColor={215,215,215},
              pattern=LinePattern.None,
              lineThickness=0.5,
              fillColor={231,231,231},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name")}));

    end State;

    model State_green
    extends Components.Base.State_base;

      annotation (
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-100,-100},{100,100}},
            grid={1,1},
            initialScale=0), graphics),
        Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-100,-100},{100,100}},
            grid={1,1},
            initialScale=0),
          graphics={Ellipse(
              extent={{-89,90},{90,-90}},
              lineColor={28,108,200},
              pattern=LinePattern.None,
              lineThickness=0.5,
              fillColor={108,170,1},
              fillPattern=FillPattern.Solid), Text(
              extent={{-80,45},{80,-40}},
              lineColor={215,215,215},
              pattern=LinePattern.None,
              lineThickness=0.5,
              fillColor={231,231,231},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name")}));

    end State_green;

    model State_grey
    extends Components.Base.State_base;

      annotation (
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-100,-100},{100,100}},
            grid={1,1},
            initialScale=0), graphics),
        Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-100,-100},{100,100}},
            grid={1,1},
            initialScale=0),
          graphics={Ellipse(
              extent={{-89,90},{90,-90}},
              lineColor={28,108,200},
              pattern=LinePattern.None,
              lineThickness=0.5,
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid), Text(
              extent={{-80,45},{80,-40}},
              lineColor={215,215,215},
              pattern=LinePattern.None,
              lineThickness=0.5,
              fillColor={231,231,231},
              fillPattern=FillPattern.Solid,
              textString=
                   "%name")}));

    end State_grey;

    class Arc
    parameter String Mode="rates"
      annotation(choices(choice="rates" "Rates", choice="percentages"
            "Percentages", radioButtons=true), dialog(group="Define mode of transition between states"));
    Real lambda "Rate"             annotation(dialog(group="Define transition rate", joinNext=true, enable=(Mode=="rates")));
    parameter String Unit="1/h"
      annotation(choices(choice="1/h" "1/h", choice="1/d" "1/d", choice="1/y" "1/y"),
                  dialog(group="Define transition rate", enable=(Mode=="rates")));

    Real P_flow(unit="% / time unit") "Probability flow";

      Connectors.Cut End annotation (                      Placement(
            transformation(extent={{80,-7},{94,7}}, rotation=0)));
      Connectors.Cut Start annotation (                        Placement(
            transformation(extent={{-94,-7},{-80,7}}, rotation=0)));
    equation

    Start.P_flow + End.P_flow = 0;
    //when sample(0, 0.05) then
    Start.P_flow = P_flow;
    P_flow = Start.P*lambda;
    //end when;
      annotation (Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-100,-50},{100,50}},
            grid={1,1},
            initialScale=0.1),
          graphics={Text(
              extent={{0,54},{0,17}},
              lineColor={198,0,0},
              pattern=LinePattern.None,
              lineThickness=0.5,
              fillColor={231,231,231},
              fillPattern=FillPattern.Solid,
              textString=
                   "%lambda"), Line(
              points={{-79,0},{78,0},{40,15},{78,0},{40,-15}},
              color={193,0,0},
              thickness=0.5)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-100,-50},{100,50}},
            grid={1,1},
            initialScale=0.1), graphics));
    end Arc;

    class Arc_diag
    parameter String Mode="rates"
      annotation(choices(choice="rates" "Rates", choice="percentages"
            "Percentages", radioButtons=true), dialog(group="Define mode of transition between states"));
    Real lambda "Rate"   annotation(dialog(group="Define transition rate", joinNext=true, enable=(Mode=="rates")));
    parameter String Unit="1/h"
      annotation(choices(choice="1/h" "1/h", choice="1/d" "1/d", choice="1/y" "1/y"),
                  dialog(group="Define transition rate", enable=(Mode=="rates")));

    Real P_flow(unit="% / time unit") "Probability flow";

      Connectors.Cut End annotation (                       Placement(
            transformation(extent={{51,52},{65,66}}, rotation=0)));
      Connectors.Cut Start annotation (                           Placement(
            transformation(extent={{-62,-64},{-48,-50}}, rotation=0)));
    equation
    Start.P_flow + End.P_flow = 0;
    Start.P_flow = P_flow;
    P_flow = Start.P*lambda;
      annotation (Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-100,-50},{100,50}},
            grid={1,1},
            initialScale=0.1),
          graphics={Text(
              extent={{-49,34},{-49,-3}},
              lineColor={198,0,0},
              pattern=LinePattern.None,
              lineThickness=0.5,
              fillColor={231,231,231},
              fillPattern=FillPattern.Solid,
              textString=
                   "%lambda"), Line(
              points={{-50,-53},{53,54},{18,41},{53,54},{42,21}},
              color={193,0,0},
              thickness=0.5)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-100,-50},{100,50}},
            grid={1,1},
            initialScale=0.1), graphics));
    end Arc_diag;

    class Arc_bend
    parameter String Mode="rates"
      annotation(choices(choice="rates" "Rates", choice="percentages"
            "Percentages", radioButtons=true), dialog(group="Define mode of transition between states"));
    Real lambda "Rate"   annotation(dialog(group="Define transition rate", joinNext=true, enable=(Mode=="rates")));
    parameter String Unit="1/h"
      annotation(choices(choice="1/h" "1/h", choice="1/d" "1/d", choice="1/y" "1/y"),
                  dialog(group="Define transition rate", enable=(Mode=="rates")));

    Real P_flow(unit="% / time unit") "Probability flow";

      Connectors.Cut End annotation (                        Placement(
            transformation(extent={{79,87},{93,101}}, rotation=0)));
      Connectors.Cut Start annotation (                           Placement(
            transformation(extent={{-86,-99},{-72,-85}}, rotation=0)));
    equation
    Start.P_flow + End.P_flow = 0;
    Start.P_flow = P_flow;
    P_flow = Start.P*lambda;
      annotation (Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-110,-110},{110,110}},
            grid={1,1},
            initialScale=0.1),
          graphics={
            Text(
              extent={{-2,18},{-2,-19}},
              lineColor={198,0,0},
              pattern=LinePattern.None,
              lineThickness=0.5,
              fillColor={231,231,231},
              fillPattern=FillPattern.Solid,
              textString=
                   "%lambda"),
            Line(
              points={{-78,-85},{-78,-71},{-78,-49},{-77,-22},{-73,7},{-64,39},
                  {-50,63},{-23,81},{7,91},{46,94},{80,94}},
              color={203,0,0},
              thickness=0.5),
            Line(
              points={{44,108},{80,94},{45,79}},
              color={203,0,0},
              thickness=0.5)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-110,-110},{110,110}},
            grid={1,1},
            initialScale=0.1), graphics));
    end Arc_bend;

    class Arc_bend2
    parameter String Mode="rates"
      annotation(choices(choice="rates" "Rates", choice="percentages"
            "Percentages", radioButtons=true), dialog(group="Define mode of transition between states"));
    Real lambda "Rate"   annotation(dialog(group="Define transition rate", joinNext=true, enable=(Mode=="rates")));
    parameter String Unit="1/h"
      annotation(choices(choice="1/h" "1/h", choice="1/d" "1/d", choice="1/y" "1/y"),
                  dialog(group="Define transition rate", enable=(Mode=="rates")));

    Real P_flow(unit="% / time unit") "Probability flow";

      Connectors.Cut End annotation (                       Placement(
            transformation(extent={{98,-7},{112,7}}, rotation=0)));
      Connectors.Cut Start annotation (                         Placement(
            transformation(extent={{-111,-7},{-97,7}}, rotation=0)));
    equation
    Start.P_flow + End.P_flow = 0;
    Start.P_flow = P_flow;
    P_flow = Start.P*lambda;
      annotation (Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-110,-110},{110,110}},
            grid={1,1},
            initialScale=0.1),
          graphics={
            Text(
              extent={{-2,18},{-2,-19}},
              lineColor={198,0,0},
              pattern=LinePattern.None,
              lineThickness=0.5,
              fillColor={231,231,231},
              fillPattern=FillPattern.Solid,
              textString=
                   "%lambda"),
            Line(
              points={{-101,6},{-81,31},{-59,52},{-35,69},{-17,79},{3,83},{22,
                  79},{41,69},{61,52},{82,30},{101,7}},
              color={203,0,0},
              thickness=0.5),
            Line(
              points={{94,41},{102,6},{66,21}},
              color={203,0,0},
              thickness=0.5)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-110,-110},{110,110}},
            grid={1,1},
            initialScale=0.1), graphics));
    end Arc_bend2;

    class Arc_hbend
    parameter String Mode="rates"
      annotation(choices(choice="rates" "Rates", choice="percentages"
            "Percentages", radioButtons=true), dialog(group="Define mode of transition between states"));
    Real lambda "Rate"   annotation(dialog(group="Define transition rate", joinNext=true, enable=(Mode=="rates")));
    parameter String Unit="1/h"
      annotation(choices(choice="1/h" "1/h", choice="1/d" "1/d", choice="1/y" "1/y"),
                  dialog(group="Define transition rate", enable=(Mode=="rates")));

    Real P_flow(unit="% / time unit") "Probability flow";

      Connectors.Cut End annotation (                         Placement(
            transformation(extent={{-24,79},{-10,93}}, rotation=0)));
      Connectors.Cut Start annotation (                            Placement(
            transformation(extent={{-87,-100},{-73,-86}}, rotation=0)));
    equation
    Start.P_flow + End.P_flow = 0;
    Start.P_flow = P_flow;
    P_flow = Start.P*lambda;
      annotation (Icon(
          coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-110,-110},{110,110}},
            grid={1,1},
            initialScale=0.1),
          graphics={
            Text(
              extent={{11,18},{11,-19}},
              lineColor={198,0,0},
              pattern=LinePattern.None,
              lineThickness=0.5,
              fillColor={231,231,231},
              fillPattern=FillPattern.Solid,
              textString=
                   "%lambda"),
            Line(
              points={{-80,-88},{-80,-74},{-80,-61},{-79,-35},{-76,-13},{-71,8},
                  {-64,26},{-54,44},{-43,59},{-33,70},{-23,80}},
              color={203,0,0},
              thickness=0.5),
            Line(
              points={{-53,71},{-22,81},{-28,53}},
              color={203,0,0},
              thickness=0.5)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            preserveOrientation=false,
            extent={{-110,-110},{110,110}},
            grid={1,1},
            initialScale=0.1), graphics));
    end Arc_hbend;
  end Components;

  annotation (uses(Modelica(version="3.2.3")),
    version="1",
    conversion(noneFromVersion=""));
end MarkovChains;
