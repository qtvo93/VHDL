library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lock is
 Port (x: in std_logic_vector(3 downto 0);
 z: out std_logic;
 ck, reset: in std_logic);
end lock;

architecture Behavioral of lock is
TYPE STATE_TYPE IS (s0, s1, s2,s3,invalid);
SIGNAL state   : STATE_TYPE;
BEGIN
PROCESS (ck, reset)
BEGIN
If ck='1' and ck'event then
      If reset = '1' then
         state <= s0;
      Else
         Case state is
            When s0=>
               IF x = "0011" THEN
                  state <= s1;
               ELSE
                  state <= invalid;
               END IF;
            When s1=>
               IF x = "0101" THEN
                  state <= s2;
               ELSE
                  state <= invalid;
               END IF;
            When s2=>
               IF x = "1000" THEN
                  state <= s3;
               ELSE
                  state <= invalid;
               END IF;
            When s3 => null;
            When invalid => null;
                
         End case;
      End if;
  End if;
END PROCESS;
   
PROCESS (state)
   BEGIN
      CASE state IS
         When s0 =>
            z <='0';
         When s1 =>
            z <='0';
         When s2 =>
            z <='0';
         When s3 =>
            z <='1';
         When invalid =>
            z <='0';
      END CASE;
   END PROCESS;
end Behavioral;
