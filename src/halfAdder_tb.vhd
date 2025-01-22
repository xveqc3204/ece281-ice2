--+----------------------------------------------------------------------------
--| DESCRIPTION: Testbench for halfAdder.vhd
--|
--| NAMING CONVENSIONS :
--|
--|    i_<port name>            = on-chip input port
--|    o_<port name>            = on-chip output port
--|    w_<signal name>          = top level wiring signal
--+----------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  
-- entity should match what we are testing, with _tb
entity halfAdder_tb is
-- no input/output because it's a self-contained testbench 
end halfAdder_tb;

architecture test_bench of halfAdder_tb is 
	
  -- declare the component of your top-level design unit under test (UUT)
  -- this must exactly match entity declaration of the thing you are testing
  component halfAdder is
	port(
		-- TODO: copy in port map from halfAdder.vhd
        i_A     : in  std_logic; -- 1-bit input port
        i_B     : in  std_logic; 
        o_S     : out std_logic;  -- 1-bit output port (NOTE: NO semicolon on LAST port only!)	    
        o_Cout  : out std_logic
	); -- the semicolon is here instead	
  end component;

  
  -- declare signals needed to stimulate the UUT inputs
  signal w_sw1 : std_logic := '0';
  -- TODO:  sw0 signal
  signal w_sw0 : std_logic := '0';
  -- also need signals for the outputs of the UUT
  signal w_led1 : std_logic := '0';
  -- TODO:  led0 signal
  signal w_led0 : std_logic := '0';
  
begin
	-- PORT MAPS ----------------------------------------

	-- map ports for any component instances (port mapping is like wiring hardware)
	halfAdder_inst : halfAdder port map (
		i_A     => w_sw1, -- notice comma (not a semicolon)
		i_B     => w_sw0,
		o_S     => w_led0, -- no comma on LAST one
		-- TODO:  map Cout 
		o_Cout  => w_led1
	);


	-- PROCESSES ----------------------------------------
	
	-- Test Plan Process --------------------------------
	-- Implement the test plan here.  Body of process is continuously from time = 0  
	test_process : process 
	begin
	
		 w_sw1 <= '0'; w_sw0 <= '0'; wait for 10 ns;
		    -- read as "check that w_lec0 = '0' and if it doesn't then give the message 'bad sum' with an error."
            assert w_led0 = '0' report "bad sum" severity error;
            assert w_led1 = '0' report "bad carry" severity error;
		-- TODO:  rest of test plan
		 w_sw1 <= '0'; w_sw0 <= '1'; wait for 10 ns;
            assert w_led0 = '1' report "bad sum" severity error;
            assert w_led1 = '0' report "bad carry" severity error;
		 w_sw1 <= '1'; w_sw0 <= '0'; wait for 10 ns;
            assert w_led0 = '1' report "bad sum" severity error;
            assert w_led1 = '0' report "bad carry" severity error;
		 w_sw1 <= '1'; w_sw0 <= '1'; wait for 10 ns;
            assert w_led0 = '0' report "bad sum" severity error;
            assert w_led1 = '1' report "bad carry" severity error;
		wait; -- wait forever
	end process;	
	-----------------------------------------------------	
	
end test_bench;
