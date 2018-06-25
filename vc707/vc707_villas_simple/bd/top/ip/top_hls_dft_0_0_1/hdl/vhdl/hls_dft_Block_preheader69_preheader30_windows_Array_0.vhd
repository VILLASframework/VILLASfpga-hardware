-- ==============================================================
-- File generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2016.1
-- Copyright (C) 1986-2016 Xilinx, Inc. All Rights Reserved.
-- 
-- ==============================================================


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity hls_dft_Block_preheader69_preheader30_windows_Array_0_core is
    generic (
        DATA_WIDTH : integer := 32;
        ADDR_WIDTH : integer := 9;
        DEPTH : integer := 400);
    port (
        clk : in std_logic;
        ce : in std_logic;
        reset : in std_logic;
        din : in std_logic_vector(DATA_WIDTH-1 downto 0);
        addr : in std_logic_vector(ADDR_WIDTH-1 downto 0);
        dout : out std_logic_vector(DATA_WIDTH-1 downto 0));
end entity;

architecture rtl of hls_dft_Block_preheader69_preheader30_windows_Array_0_core is
type SRL_ARRAY is array (0 to DEPTH-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
signal ShiftRegMem : SRL_ARRAY := (others=>(others=>'0'));

signal counter : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');

begin
p_shift: process (clk)
    variable i: integer;
begin
    if (clk'event and clk = '1') then
        if (ce = '1') then
            for i in 0 to DEPTH - 2 loop
                ShiftRegMem(i+1) <= ShiftRegMem(i);
            end loop;
            ShiftRegMem(0) <= din;
        end if;
    end if;
end process;

p_counter: process (clk)
begin
    if (clk'event and clk = '1') then
        if (reset = '1') then
            counter <= (others => '0');
        elsif (ce = '1' and (unsigned(counter) < DEPTH - 1)) then
            counter <= unsigned(counter) + 1;
        else
            counter <= counter;
        end if;
    end if;
end process;

p_dout: process (counter, addr)
begin
    if ((unsigned(counter)) < (unsigned(addr))) then
        dout <= (others => '0');
    else
        dout <= ShiftRegMem(CONV_INTEGER(addr));
    end if;
end process;

end rtl;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity hls_dft_Block_preheader69_preheader30_windows_Array_0 is
    generic (
        DataWidth : integer := 32;
        AddressWidth : integer := 9;
        AddressRange : integer := 400);
    port (
        clk : in std_logic;
        reset : in std_logic;
        address0 : in std_logic_vector(AddressWidth-1 downto 0);
        ce0 : in std_logic;
        we0 : in std_logic;
        d0 : in std_logic_vector(DataWidth-1 downto 0);
        q0 : out std_logic_vector(DataWidth-1 downto 0));
end;

architecture behav of hls_dft_Block_preheader69_preheader30_windows_Array_0 is

    component hls_dft_Block_preheader69_preheader30_windows_Array_0_core is
        generic (
            DATA_WIDTH : integer;
            ADDR_WIDTH : integer;
            DEPTH : integer);
        port (
            clk : in std_logic;
            ce : in std_logic;
            reset : in std_logic;
            din : in std_logic_vector(DATA_WIDTH-1 downto 0);
            addr : in std_logic_vector(ADDR_WIDTH-1 downto 0);
            dout : out std_logic_vector(DATA_WIDTH-1 downto 0));
    end component;

begin
    hls_dft_Block_preheader69_preheader30_windows_Array_0_core_U : component hls_dft_Block_preheader69_preheader30_windows_Array_0_core
    generic map (
        DATA_WIDTH => DataWidth,
        ADDR_WIDTH => AddressWidth,
        DEPTH => AddressRange)
    port map (
        clk => clk,
        ce => we0,
        reset => reset,
        din => d0,
        addr => address0,
        dout => q0);

end behav;
