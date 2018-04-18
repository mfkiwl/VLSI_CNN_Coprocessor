
Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

Entity cache2 is 
port(
DataFromRam: in std_logic_vector(39 downto 0); --input from DMA
DataFromAccelerator: in std_logic_vector(7 downto 0); --input from accelerator

DataOut: out std_logic_vector(7 downto 0); --input TO DMA
port1:out std_logic_vector(39 downto 0);
port2:out std_logic_vector(39 downto 0);
port3:out std_logic_vector(39 downto 0);
port4:out std_logic_vector(39 downto 0);
port5:out std_logic_vector(39 downto 0);
port6:out std_logic_vector(39 downto 0);
port7:out std_logic_vector(39 downto 0);
port8:out std_logic_vector(39 downto 0);
port9:out std_logic_vector(39 downto 0);
port10:out std_logic_vector(39 downto 0);

cacheAddress:in std_logic_vector(3 downto 0);
rd:in std_logic;
wr: in std_logic;

rst:in std_logic;

clk:in std_logic
);

end entity;

Architecture cachearch of cache2 is

Type CacheType is Array(0 to 10) of std_logic_vector(39 downto 0);

Signal CacheData: CacheType; 
Signal Result: std_logic_vector(39 downto 0);
Constant zeros: std_logic_vector(31 downto 0):=(others=>'1');
begin

process(clk,rst)
begin

if rst='1' then
for i in 0 to 10 loop
CacheData(i)<=(others=>'0');
end loop;

elsif rising_edge(clk) then

if  wr='1'  then
if CacheAddress= "0000" then
CacheData(0)<=zeros&DataFromAccelerator;
else
CacheData(to_integer(unsigned(cacheAddress)))<= DataFromRam;
end if;
end if;

end if;
end process;


Port1<=CacheData(1);
Port2<=CacheData(2);
Port3<=CacheData(3);
Port4<=CacheData(4);
Port5<=CacheData(5);
Port6<=CacheData(6);
Port7<=CacheData(7);
Port8<=CacheData(8);
Port9<=CacheData(9);
Port10<=CacheData(10);
Result<=CacheData(0);



DataOut<=Result(7 downto 0);



end cachearch;

