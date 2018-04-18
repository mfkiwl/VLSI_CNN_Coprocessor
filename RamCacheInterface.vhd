Library ieee;
use ieee.std_logic_1164.all;

Entity RamCacheInterface is


Port(

clk: in std_logic;
rst: in std_logic;

Start: in std_logic;
conv: in std_logic;
size: in std_logic;
stride: in std_logic;

opFinished: in std_logic; --Signal from accelerator to indicate that the operation
--has finished

AcceleratorOutput: in std_logic_vector(7 downto 0);

AcceleratorWr    :in std_logic;

--ports to be connected to the accelerator
------------------------------------------
port1: out std_logic_vector(39 downto 0);
port2: out std_logic_vector(39 downto 0);
port3: out std_logic_vector(39 downto 0);
port4: out std_logic_vector(39 downto 0);
port5: out std_logic_vector(39 downto 0);
port6: out std_logic_vector(39 downto 0);
port7: out std_logic_vector(39 downto 0);
port8: out std_logic_vector(39 downto 0);
port9: out std_logic_vector(39 downto 0);
port10: out std_logic_vector(39 downto 0)
);

end entity;



Architecture RamCacheInterfaceArch of RamCacheInterface is

Signal ramdataoutput: std_logic_vector(39 downto 0);
Signal cacheDataInput: std_logic_vector(39 downto 0);
Signal ramDataInput: std_logic_vector(7 downto 0);
Signal cacheDataOut: std_logic_vector(7 downto 0);
Signal ramAddress: std_logic_vector(17 downto 0);
Signal cacheAddress: std_logic_vector(3 downto 0);
Signal wrRam: std_logic;
Signal wrCache: std_logic;
Signal rdRam: std_logic;
Signal rdCache: std_logic;
Signal DMAWRcache:std_logic;



begin

wrCache<= DMAWRcache or AcceleratorWr;
DMA: entity work.DMA port map(
start,
Conv,
Size,
ramdataoutput,
cacheDatainput,
cacheDataOut,
ramDataInput,
ramAddress,
CacheAddress,
wrRam,
DMAwrCache,
rdRam,
rdCache,
opfinished,
stride,
clk,
rst
);

--Ram: entity work.Ram port map(clk,wrRam,ramAddress,ramDataInput,ramDataOutput);

Ram: entity work.Ram port map(clk,wrRam,ramAddress,ramDataInput,ramDataOutput);
Cache: entity work.cache2 port map(cacheDatainput,AcceleratorOutput,cacheDataOut,
port1,
port2,
port3,
port4,
port5,
port6,
port7,
port8,
port9,
port10,
cacheAddress,
rdCache,
WrCache,
rst,
clk
);


end RamCacheInterfaceArch; 

