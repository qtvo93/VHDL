library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity factorial is
    generic (n: natural:= 32);
    port(ck, reset: in std_logic;
    z: out std_logic_vector(n-1 downto 0)
    );
end factorial;

architecture Behavioral of factorial is
    signal temp: std_logic_vector(2*n-1 downto 0);
    signal count: std_logic_vector(n-1 downto 0);
begin
    process(ck)
    begin
     if ck='1' and ck'event then
        if reset ='1' then
            temp <= (0 =>'1', others=>'0');
            count <= (0=>'1' , others =>'0');
        else
            temp <= temp(n-1 downto 0)*count;
            count <= count + 1;
         end if;
      end if;
     end process;
     
 z <= temp(n-1 downto 0);

end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity factorial_tb is
    port(ck, reset, btn0, btn1: in std_logic;
    z: out std_logic_vector(15 downto 0)
    );
end factorial_tb;

architecture struc of factorial_tb is
 component factorial
    generic (n: natural:= 2);
    port(ck, reset: in std_logic;
    z: out std_logic_vector(n-1 downto 0)
    );
  end component;
  signal en: std_logic;
  begin
  dut: factorial generic map(16)
                port map(en,reset,z);
  process(ck)
  type db_state is (not_rdy,rdy,pulse);
  variable db_ns:db_state;
  begin
  if ck='1' and ck'event then
    case db_ns is 
    when not_rdy=>en <='0';
        if btn1='1' then
            db_ns := rdy;
          end if;
     when rdy => en <= '0';
        if btn0 = '1' then
            db_ns:= pulse;
         end if;
      when pulse => en <= '1';
            db_ns:= not_rdy;
       when others => null;
       end case;
    end if;
    end process;
  end struc;