Library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.all;

Entity Accelerator is

Port(
clk:in std_logic;

port1: in std_logic_vector(39 downto 0);
port2: in std_logic_vector(39 downto 0);
port3: in std_logic_vector(39 downto 0);
port4: in std_logic_vector(39 downto 0);
port5: in std_logic_vector(39 downto 0);
port6: in std_logic_vector(39 downto 0);
port7: in std_logic_vector(39 downto 0);
port8: in std_logic_vector(39 downto 0);
port9: in std_logic_vector(39 downto 0);
port10: in std_logic_vector(39 downto 0);

opFinished: out std_logic;


AcceleratorOutput: out std_logic_vector(7 downto 0);

AcceleratorWr    :inout std_logic;

conv:in std_logic;

size: in std_logic;

enableOp: in std_logic

);

end entity;



Architecture AcceleratorArch of Accelerator is

Signal a0, a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24 : std_logic_vector(7 downto 0); --From cache 
Signal b0, b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20,b21,b22,b23,b24 :  std_logic_vector(7 downto 0); --From Multiplier
Signal f0, f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21,f22,f23,f24 : std_logic_vector(7 downto 0);
Signal endn0, endn1,endn2,endn3,endn4,endn5,endn6,endn7,endn8,endn9,endn10,endn11,endn12,endn13,endn14,endn15,endn16,endn17,endn18,endn19,endn20,endn21,endn22,endn23,endn24 : std_logic;
Signal rstC:std_logic;
Signal outC:std_logic_vector(6 downto 0);

SIGNAL adderEN: std_logic;
SIGNAL ENDN: std_logic;

Component multiplierModule IS 
  GENERIC(n:integer :=8);
  PORT (
      --- inputs ---
        M1:IN std_logic_vector(n-1 downto 0);
        M2:IN std_logic_vector(n-1 downto 0);
        conv:IN std_logic;
        enableOp:IN std_logic;
        clk:IN std_logic;
    --- outputs ---
        resultN:OUT std_logic_vector(n-1 downto 0);
        endN:OUT std_logic
  );

END component;


COMPONENT AdderPart IS

PORT(   a0, a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24 : in std_logic_vector(7 downto 0); --taken from dma
        b0, b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20,b21,b22,b23,b24 : in std_logic_vector(7 downto 0); --taken from multiplication    
	s : out std_logic_vector(7 downto 0);
	ack:out std_logic;
        en:in std_logic;
        conv,size:std_logic

-----conv =0  pooling=conv=1
-----size=0  when size =5,size=1 sizee=3

);
END COMPONENT;

COMPONENT counter is
generic(n:integer :=7);
port(
clk: in std_logic;

counterout: out std_logic_vector(n-1 downto 0);

rst:in std_logic;



en: in std_logic

);


end COMPONENT;



begin



f0<=port1(7 downto 0);
f1<=port1(15 downto 8);
f2<=port1(23 downto 16);
f3<=port1(31 downto 24);
f4<=port1(39 downto 32);

f5<=port2(7 downto 0);
f6<=port2(15 downto 8);
f7<=port2(23 downto 16);
f8<=port2(31 downto 24);
f9<=port2(39 downto 32);

f10<=port3(7 downto 0);
f11<=port3(15 downto 8);
f12<=port3(23 downto 16);
f13<=port3(31 downto 24);
f14<=port3(39 downto 32);

f15<=port4(7 downto 0);
f16<=port4(15 downto 8);
f17<=port4(23 downto 16);
f18<=port4(31 downto 24);
f19<=port4(39 downto 32);


f20<=port5(7 downto 0);
f21<=port5(15 downto 8);
f22<=port5(23 downto 16);
f23<=port5(31 downto 24);
f24<=port5(39 downto 32);

a0<=port6(7 downto 0);
a1<=port6(15 downto 8);
a2<=port6(23 downto 16);
a3<=port6(31 downto 24);
a4<=port6(39 downto 32);

a5<=port7(7 downto 0);
a6<=port7(15 downto 8);
a7<=port7(23 downto 16);
a8<=port7(31 downto 24);
a9<=port7(39 downto 32);

a10<=port8(7 downto 0);
a11<=port8(15 downto 8);
a12<=port8(23 downto 16);
a13<=port8(31 downto 24);
a14<=port8(39 downto 32);

a15<=port9(7 downto 0);
a16<=port9(15 downto 8);
a17<=port9(23 downto 16);
a18<=port9(31 downto 24);
a19<=port9(39 downto 32);


a20<=port10(7 downto 0);
a21<=port10(15 downto 8);
a22<=port10(23 downto 16);
a23<=port10(31 downto 24);
a24<=port10(39 downto 32);

--------------------------------------------------------------------------------------------------------------------------------------------------------

Mul0: multiplierModule   PORT map (
      --- inputs ---
        a0,
        f0,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b0,
        endn0
  );


Mul1: multiplierModule   PORT map (
      --- inputs ---
        a1,
        f1,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b1,
        endn1
  );
  
  Mul2: multiplierModule   PORT map (
      --- inputs ---
        a2,
        f2,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b2,
        endn2
  );
  
  Mul3: multiplierModule   PORT map (
      --- inputs ---
        a3,
        f3,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b3,
        endn3
  );
  
  Mul4: multiplierModule   PORT map (
      --- inputs ---
        a4,
        f4,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b4,
        endn4
  );
  
  Mul5: multiplierModule   PORT map (
      --- inputs ---
        a5,
        f5,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b5,
        endn5
  );
  
  Mul6: multiplierModule   PORT map (
      --- inputs ---
        a6,
        f6,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b6,
        endn6
  );
  
  Mul7: multiplierModule   PORT map (
      --- inputs ---
        a7,
        f7,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b7,
        endn7
  );




Mul8: multiplierModule   PORT map (
      --- inputs ---
        a8,
        f8,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b8,
        endn8
  );

  Mul9: multiplierModule   PORT map (
      --- inputs ---
        a9,
        f9,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b9,
        endn9
  );

  Mul10: multiplierModule   PORT map (
      --- inputs ---
        a10,
        f10,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b10,
        endn10
  );
  
  Mul11: multiplierModule   PORT map (
      --- inputs ---
        a11,
        f11,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b11,
        endn11
  );
  
  Mul12: multiplierModule   PORT map (
      --- inputs ---
        a12,
        f12,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b12,
        endn12
  );
  
  Mul13: multiplierModule   PORT map (
      --- inputs ---
        a13,
        f13,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b13,
        endn13
  );
  
  Mul14: multiplierModule   PORT map (
      --- inputs ---
        a14,
        f14,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b14,
        endn14
  );
  
  
  Mul15: multiplierModule   PORT map (
      --- inputs ---
        a15,
        f15,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b15,
        endn15
  );
  
  Mul16: multiplierModule   PORT map (
      --- inputs ---
        a16,
        f16,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b16,
        endn16
  );
  
  Mul17: multiplierModule   PORT map (
      --- inputs ---
        a17,
        f17,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b17,
        endn17
  );

Mul18: multiplierModule   PORT map (
      --- inputs ---
        a18,
        f18,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b18,
        endn18
  );


Mul19: multiplierModule   PORT map (
      --- inputs ---
        a19,
        f19,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b19,
        endn19
  );


Mul20: multiplierModule   PORT map (
      --- inputs ---
        a20,
        f20,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b20,
        endn20
  );
  

  
  Mul21: multiplierModule   PORT map (
      --- inputs ---
        a21,
        f21,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b21,
        endn21
  );
  
  Mul22: multiplierModule   PORT map (
      --- inputs ---
        a22,
        f22,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b22,
        endn22
  );
  
  Mul23: multiplierModule   PORT map (
      --- inputs ---
        a23,
        f23,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b23,
        endn23
  );
  
  Mul24: multiplierModule   PORT map (
      --- inputs ---
        a24,
        f24,
        conv,
        enableOp,
        clk,
    --- outputs ---
        b24,
        endn24
  );


myAdder: AdderPart PORT MAP(   a0, a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24 ,
        b0, b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20,b21,b22,b23,b24 ,
	AcceleratorOutput,
	AcceleratorWR,
        ENDN,
        conv,size

);

ENDN<= '1' when endn0='1'  and endn1='1'  and endn2='1'  and endn3='1'  and endn4='1'  and endn5='1'  and 
                endn6='1'  and endn7='1'  and endn8='1'  and endn9='1'  and endn10='1' and endn11='1' and 
                endn12='1' and endn13='1' and endn14='1' and endn15='1' and endn16='1' and endn17='1' and 
                endn18='1' and endn19='1' and endn20='1' and endn21='1' and endn22='1' and endn23='1' and 
                endn24='1' 
  else '0';
    

adderEN <= '1' when (ENDN='1' and conv='0')  or (conv='1' and enableOp='1')
else '0';


ramCounter : counter port map(clk,outC,rstC,AcceleratorWR);

rstC<='1' when outC="0000001"
else '0';

opFinished<='1' when outC="0000001"
else '0';

end AcceleratorArch;
