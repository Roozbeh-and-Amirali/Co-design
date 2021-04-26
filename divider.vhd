library ieee;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
library work;
use work.std_logic_arithext.all;


--datapath entity
entity divider is
port(
   x:in std_logic_vector(7 downto 0);
   y:in std_logic_vector(7 downto 0);
   start:in std_logic;
   q:out std_logic_vector(9 downto 0);
   r:out std_logic_vector(7 downto 0);
   done:out std_logic;
   RST : in std_logic;
   CLK : in std_logic

);
end divider;


--signal declaration
architecture RTL of divider is
signal q_reg:std_logic_vector(7 downto 0);
signal q_reg_wire:std_logic_vector(7 downto 0);
signal m_reg:std_logic_vector(7 downto 0);
signal m_reg_wire:std_logic_vector(7 downto 0);
signal r_reg:std_logic_vector(7 downto 0);
signal r_reg_wire:std_logic_vector(7 downto 0);
signal shift_temp:std_logic_vector(15 downto 0);
signal shift_temp_wire:std_logic_vector(15 downto 0);
signal r_reg_temp:std_logic_vector(7 downto 0);
signal r_reg_temp_wire:std_logic_vector(7 downto 0);
signal n_reg:std_logic_vector(3 downto 0);
signal n_reg_wire:std_logic_vector(3 downto 0);
signal n_reg_const:std_logic_vector(3 downto 0);
signal n_reg_const_wire:std_logic_vector(3 downto 0);
signal start_reg:std_logic;
signal start_reg_wire:std_logic;
signal sig_0:std_logic;
signal sig_1:std_logic;
signal sig_2:std_logic;
signal sig_3:std_logic;
signal sig_4:std_logic;
signal sig_5:std_logic;
signal sig_6:std_logic;
signal sig_7:std_logic_vector(3 downto 0);
signal sig_8:std_logic_vector(3 downto 0);
signal sig_9:std_logic;
signal sig_10:std_logic;
signal sig_11:std_logic;
signal sig_12:std_logic;
signal sig_13:std_logic;
signal sig_14:std_logic;
signal sig_15:std_logic;
signal sig_16:std_logic_vector(3 downto 0);
signal sig_17:std_logic_vector(3 downto 0);
signal sig_18:std_logic;
signal sig_19:std_logic_vector(7 downto 0);
signal sig_20:std_logic;
signal sig_21:std_logic_vector(7 downto 0);
signal sig_22:std_logic;
signal sig_23:std_logic_vector(7 downto 0);
signal sig_24:std_logic;
signal sig_25:std_logic_vector(7 downto 0);
signal sig_26:std_logic;
signal sig_27:std_logic_vector(7 downto 0);
signal sig_28:std_logic;
signal sig_29:std_logic_vector(7 downto 0);
signal sig_30:std_logic;
signal sig_31:std_logic_vector(7 downto 0);
signal sig_32:std_logic_vector(7 downto 0);
signal sig_33:std_logic_vector(7 downto 0);
signal sig_34:std_logic_vector(7 downto 0);
signal sig_35:std_logic;
signal sig_36:std_logic_vector(8 downto 0);
signal sig_37:std_logic;
signal sig_38:std_logic_vector(8 downto 0);
signal sig_39:std_logic;
signal sig_40:std_logic_vector(8 downto 0);
signal sig_41:std_logic;
signal sig_42:std_logic_vector(8 downto 0);
signal sig_43:std_logic;
signal sig_44:std_logic_vector(8 downto 0);
signal sig_45:std_logic;
signal sig_46:std_logic_vector(8 downto 0);
signal sig_47:std_logic;
signal sig_48:std_logic_vector(8 downto 0);
signal sig_49:std_logic_vector(8 downto 0);
signal sig_50:std_logic_vector(1 downto 0);
signal sig_51:std_logic_vector(2 downto 0);
signal sig_52:std_logic_vector(7 downto 0);
signal sig_53:std_logic_vector(7 downto 0);
signal sig_54:std_logic_vector(7 downto 0);
signal sig_55:std_logic_vector(7 downto 0);
signal sig_56:std_logic_vector(7 downto 0);
signal sig_57:std_logic_vector(8 downto 0);
signal sig_58:std_logic_vector(7 downto 0);
signal sig_59:std_logic_vector(8 downto 0);
signal sig_60:std_logic_vector(8 downto 0);
signal sig_61:std_logic_vector(3 downto 0);
signal q_int:std_logic_vector(9 downto 0);
signal r_int:std_logic_vector(7 downto 0);
signal done_int:std_logic;
signal sig_62:std_logic;
signal sig_63:std_logic;
signal sig_64:std_logic;
signal sig_65:std_logic;
signal sig_66:std_logic;
signal sig_67:std_logic;
signal sig_68:std_logic;
signal sig_69:std_logic;
signal sig_70:std_logic;
signal sig_71:std_logic;
signal sig_72:std_logic;
signal sig_73:std_logic;
signal sig_74:std_logic;
signal sig_75:std_logic;
signal sig_76:std_logic;
signal sig_77:std_logic;
signal sig_78:std_logic;
signal sig_79:std_logic;
signal sig_80:std_logic;
signal sig_81:std_logic;
signal sig_82:std_logic;
signal sig_83:std_logic;
signal sig_84:std_logic;
signal sig_85:std_logic;
signal sig_86:std_logic;
signal sig_87:std_logic;
signal sig_88:std_logic;
signal sig_89:std_logic;
signal sig_90:std_logic;
signal sig_91:std_logic;
signal sig_92:std_logic;
signal sig_93:std_logic;
signal sig_94:std_logic;
signal sig_95:std_logic;
type STATE_TYPE is (s0,s1,s2,s3,s4,s5,s6,s7);
signal STATE:STATE_TYPE;
type CONTROL is (alwaysidle
, alwaysinit
, alwaysdo_nothing
, alwaysshift_1
, alwaysshift_2
, alwayssub_1
, alwayssub_2
, alwaysset_q_lsb_1
, alwaysset_q_lsb_0
, alwaysdec_n
, alwaysfinal
);
signal cmd : CONTROL;


begin
--register updates
dpREG: process (CLK,RST)
   begin
      if (RST = '1') then
         q_reg <= (others=>'0');
         m_reg <= (others=>'0');
         r_reg <= (others=>'0');
         shift_temp <= (others=>'0');
         r_reg_temp <= (others=>'0');
         n_reg <= (others=>'0');
         n_reg_const <= (others=>'0');
         start_reg <= '0';
      elsif CLK' event and CLK = '1' then
         q_reg <= q_reg_wire;
         m_reg <= m_reg_wire;
         r_reg <= r_reg_wire;
         shift_temp <= shift_temp_wire;
         r_reg_temp <= r_reg_temp_wire;
         n_reg <= n_reg_wire;
         n_reg_const <= n_reg_const_wire;
         start_reg <= start_reg_wire;

      end if;
   end process dpREG;


--combinational logics
dpCMB: process (q_reg,m_reg,r_reg,shift_temp,r_reg_temp,n_reg,n_reg_const,start_reg,sig_0,sig_1
,sig_2,sig_3,sig_4,sig_5,sig_6,sig_7,sig_8,sig_9,sig_10,sig_11
,sig_12,sig_13,sig_14,sig_15,sig_16,sig_17,sig_18,sig_19,sig_20,sig_21
,sig_22,sig_23,sig_24,sig_25,sig_26,sig_27,sig_28,sig_29,sig_30,sig_31
,sig_32,sig_33,sig_34,sig_35,sig_36,sig_37,sig_38,sig_39,sig_40,sig_41
,sig_42,sig_43,sig_44,sig_45,sig_46,sig_47,sig_48,sig_49,sig_50,sig_51
,sig_52,sig_53,sig_54,sig_55,sig_56,sig_57,sig_58,sig_59,sig_60,sig_61
,q_int,r_int,done_int,x,y,start,cmd,STATE)
   begin
      q_reg_wire <= q_reg;
      m_reg_wire <= m_reg;
      r_reg_wire <= r_reg;
      shift_temp_wire <= shift_temp;
      r_reg_temp_wire <= r_reg_temp;
      n_reg_wire <= n_reg;
      n_reg_const_wire <= n_reg_const;
      start_reg_wire <= start_reg;
      sig_0 <= '0';
      sig_1 <= '0';
      sig_2 <= '0';
      sig_3 <= '0';
      sig_4 <= '0';
      sig_5 <= '0';
      sig_6 <= '0';
      sig_7 <= (others=>'0');
      sig_8 <= (others=>'0');
      sig_9 <= '0';
      sig_10 <= '0';
      sig_11 <= '0';
      sig_12 <= '0';
      sig_13 <= '0';
      sig_14 <= '0';
      sig_15 <= '0';
      sig_16 <= (others=>'0');
      sig_17 <= (others=>'0');
      sig_18 <= '0';
      sig_19 <= (others=>'0');
      sig_20 <= '0';
      sig_21 <= (others=>'0');
      sig_22 <= '0';
      sig_23 <= (others=>'0');
      sig_24 <= '0';
      sig_25 <= (others=>'0');
      sig_26 <= '0';
      sig_27 <= (others=>'0');
      sig_28 <= '0';
      sig_29 <= (others=>'0');
      sig_30 <= '0';
      sig_31 <= (others=>'0');
      sig_32 <= (others=>'0');
      sig_33 <= (others=>'0');
      sig_34 <= (others=>'0');
      sig_35 <= '0';
      sig_36 <= (others=>'0');
      sig_37 <= '0';
      sig_38 <= (others=>'0');
      sig_39 <= '0';
      sig_40 <= (others=>'0');
      sig_41 <= '0';
      sig_42 <= (others=>'0');
      sig_43 <= '0';
      sig_44 <= (others=>'0');
      sig_45 <= '0';
      sig_46 <= (others=>'0');
      sig_47 <= '0';
      sig_48 <= (others=>'0');
      sig_49 <= (others=>'0');
      sig_50 <= (others=>'0');
      sig_51 <= (others=>'0');
      sig_52 <= (others=>'0');
      sig_53 <= (others=>'0');
      sig_54 <= (others=>'0');
      sig_55 <= (others=>'0');
      sig_56 <= (others=>'0');
      sig_57 <= (others=>'0');
      sig_58 <= (others=>'0');
      sig_59 <= (others=>'0');
      sig_60 <= (others=>'0');
      sig_61 <= (others=>'0');
      q_int <= (others=>'0');
      r_int <= (others=>'0');
      done_int <= '0';
      q <= (others=>'0');
      r <= (others=>'0');
      done <= '0';



      case cmd is
         when alwaysidle =>
            q <= q_int;
            r <= r_int;
            q_int <= conv_std_logic_vector(unsigned(q_reg),10);
            r_int <= r_reg;
            done <= done_int;
            done_int <= '0';
            start_reg_wire <= start;
         when alwaysinit =>
            q <= q_int;
            r <= r_int;
            q_int <= conv_std_logic_vector(unsigned(q_reg),10);
            r_int <= r_reg;
            done <= done_int;
            if (unsigned(x) < 2) then
               sig_0 <= '1';
            else
               sig_0 <= '0';
            end if;
            if (unsigned(x) < 4) then
               sig_1 <= '1';
            else
               sig_1 <= '0';
            end if;
            if (unsigned(x) < 8) then
               sig_2 <= '1';
            else
               sig_2 <= '0';
            end if;
            if (unsigned(x) < 16) then
               sig_3 <= '1';
            else
               sig_3 <= '0';
            end if;
            if (unsigned(x) < 32) then
               sig_4 <= '1';
            else
               sig_4 <= '0';
            end if;
            if (unsigned(x) < 64) then
               sig_5 <= '1';
            else
               sig_5 <= '0';
            end if;
            if (unsigned(x) < 128) then
               sig_6 <= '1';
            else
               sig_6 <= '0';
            end if;
            if (sig_6 = '1') then
               sig_7 <= conv_std_logic_vector(7,4);
            else
               sig_7 <= conv_std_logic_vector(8,4);
            end if;
            if (sig_0 = '1') then
               sig_8 <= conv_std_logic_vector(1,4);
            elsif (sig_1 = '1') then
               sig_8 <= conv_std_logic_vector(2,4);
            elsif (sig_2 = '1') then
               sig_8 <= conv_std_logic_vector(3,4);
            elsif (sig_3 = '1') then
               sig_8 <= conv_std_logic_vector(4,4);
            elsif (sig_4 = '1') then
               sig_8 <= conv_std_logic_vector(5,4);
            elsif (sig_5 = '1') then
               sig_8 <= conv_std_logic_vector(6,4);
            else
               sig_8 <= sig_7;
            end if;
            if (unsigned(x) < 2) then
               sig_9 <= '1';
            else
               sig_9 <= '0';
            end if;
            if (unsigned(x) < 4) then
               sig_10 <= '1';
            else
               sig_10 <= '0';
            end if;
            if (unsigned(x) < 8) then
               sig_11 <= '1';
            else
               sig_11 <= '0';
            end if;
            if (unsigned(x) < 16) then
               sig_12 <= '1';
            else
               sig_12 <= '0';
            end if;
            if (unsigned(x) < 32) then
               sig_13 <= '1';
            else
               sig_13 <= '0';
            end if;
            if (unsigned(x) < 64) then
               sig_14 <= '1';
            else
               sig_14 <= '0';
            end if;
            if (unsigned(x) < 128) then
               sig_15 <= '1';
            else
               sig_15 <= '0';
            end if;
            if (sig_15 = '1') then
               sig_16 <= conv_std_logic_vector(7,4);
            else
               sig_16 <= conv_std_logic_vector(8,4);
            end if;
            if (sig_9 = '1') then
               sig_17 <= conv_std_logic_vector(1,4);
            elsif (sig_10 = '1') then
               sig_17 <= conv_std_logic_vector(2,4);
            elsif (sig_11 = '1') then
               sig_17 <= conv_std_logic_vector(3,4);
            elsif (sig_12 = '1') then
               sig_17 <= conv_std_logic_vector(4,4);
            elsif (sig_13 = '1') then
               sig_17 <= conv_std_logic_vector(5,4);
            elsif (sig_14 = '1') then
               sig_17 <= conv_std_logic_vector(6,4);
            else
               sig_17 <= sig_16;
            end if;
            done_int <= '0';
            q_reg_wire <= x;
            m_reg_wire <= y;
            r_reg_wire <= conv_std_logic_vector(0,8);
            n_reg_wire <= sig_8;
            n_reg_const_wire <= sig_17;
         when alwaysdo_nothing =>
            q <= q_int;
            r <= r_int;
            q_int <= conv_std_logic_vector(unsigned(q_reg),10);
            r_int <= r_reg;
            done <= done_int;
            done_int <= '0';
         when alwaysshift_1 =>
            q <= q_int;
            r <= r_int;
            q_int <= conv_std_logic_vector(unsigned(q_reg),10);
            r_int <= r_reg;
            done <= done_int;
            if (unsigned(n_reg_const) = 8) then
               sig_18 <= '1';
            else
               sig_18 <= '0';
            end if;
            sig_19 <= r_reg(6 downto 0) & q_reg(7);
            if (unsigned(n_reg_const) = 7) then
               sig_20 <= '1';
            else
               sig_20 <= '0';
            end if;
            sig_21 <= r_reg(6 downto 0) & q_reg(6);
            if (unsigned(n_reg_const) = 6) then
               sig_22 <= '1';
            else
               sig_22 <= '0';
            end if;
            sig_23 <= r_reg(6 downto 0) & q_reg(5);
            if (unsigned(n_reg_const) = 5) then
               sig_24 <= '1';
            else
               sig_24 <= '0';
            end if;
            sig_25 <= r_reg(6 downto 0) & q_reg(4);
            if (unsigned(n_reg_const) = 4) then
               sig_26 <= '1';
            else
               sig_26 <= '0';
            end if;
            sig_27 <= r_reg(6 downto 0) & q_reg(3);
            if (unsigned(n_reg_const) = 3) then
               sig_28 <= '1';
            else
               sig_28 <= '0';
            end if;
            sig_29 <= r_reg(6 downto 0) & q_reg(2);
            if (unsigned(n_reg_const) = 2) then
               sig_30 <= '1';
            else
               sig_30 <= '0';
            end if;
            sig_31 <= r_reg(6 downto 0) & q_reg(1);
            sig_32 <= r_reg(6 downto 0) & q_reg(0);
            if (sig_30 = '1') then
               sig_33 <= sig_31;
            else
               sig_33 <= sig_32;
            end if;
            if (sig_18 = '1') then
               sig_34 <= sig_19;
            elsif (sig_20 = '1') then
               sig_34 <= sig_21;
            elsif (sig_22 = '1') then
               sig_34 <= sig_23;
            elsif (sig_24 = '1') then
               sig_34 <= sig_25;
            elsif (sig_26 = '1') then
               sig_34 <= sig_27;
            elsif (sig_28 = '1') then
               sig_34 <= sig_29;
            else
               sig_34 <= sig_33;
            end if;
            done_int <= '0';
            r_reg_wire <= sig_34;
         when alwaysshift_2 =>
            q <= q_int;
            r <= r_int;
            q_int <= conv_std_logic_vector(unsigned(q_reg),10);
            r_int <= r_reg;
            done <= done_int;
            if (unsigned(n_reg_const) = 8) then
               sig_35 <= '1';
            else
               sig_35 <= '0';
            end if;
            sig_36 <= conv_std_logic_vector(shl(conv_unsigned(unsigned(q_reg),9),conv_unsigned(1,9)),9);
            if (unsigned(n_reg_const) = 7) then
               sig_37 <= '1';
            else
               sig_37 <= '0';
            end if;
            sig_38 <= conv_std_logic_vector(shl(conv_unsigned(unsigned(q_reg),9),conv_unsigned(1,9)),9);
            if (unsigned(n_reg_const) = 6) then
               sig_39 <= '1';
            else
               sig_39 <= '0';
            end if;
            sig_40 <= conv_std_logic_vector(shl(conv_unsigned(unsigned(q_reg),9),conv_unsigned(1,9)),9);
            if (unsigned(n_reg_const) = 5) then
               sig_41 <= '1';
            else
               sig_41 <= '0';
            end if;
            sig_42 <= conv_std_logic_vector(shl(conv_unsigned(unsigned(q_reg),9),conv_unsigned(1,9)),9);
            if (unsigned(n_reg_const) = 4) then
               sig_43 <= '1';
            else
               sig_43 <= '0';
            end if;
            sig_44 <= conv_std_logic_vector(shl(conv_unsigned(unsigned(q_reg),9),conv_unsigned(1,9)),9);
            if (unsigned(n_reg_const) = 3) then
               sig_45 <= '1';
            else
               sig_45 <= '0';
            end if;
            sig_46 <= conv_std_logic_vector(shl(conv_unsigned(unsigned(q_reg),9),conv_unsigned(1,9)),9);
            if (unsigned(n_reg_const) = 2) then
               sig_47 <= '1';
            else
               sig_47 <= '0';
            end if;
            sig_48 <= conv_std_logic_vector(shl(conv_unsigned(unsigned(q_reg),9),conv_unsigned(1,9)),9);
            sig_49 <= conv_std_logic_vector(shl(conv_unsigned(unsigned(q_reg),9),conv_unsigned(1,9)),9);
            if (sig_47 = '1') then
               sig_50 <= sig_48(1 downto 0);
            else
               sig_50 <= logic_zero_ext(sig_49(0),2);
            end if;
            if (sig_35 = '1') then
               sig_51 <= sig_36(7 downto 0)(2 downto 0);
            elsif (sig_37 = '1') then
               sig_51 <= sig_38(6 downto 0)(2 downto 0);
            elsif (sig_39 = '1') then
               sig_51 <= sig_40(5 downto 0)(2 downto 0);
            elsif (sig_41 = '1') then
               sig_51 <= sig_42(4 downto 0)(2 downto 0);
            elsif (sig_43 = '1') then
               sig_51 <= sig_44(3 downto 0)(2 downto 0);
            elsif (sig_45 = '1') then
               sig_51 <= sig_46(2 downto 0);
            else
               sig_51 <= conv_std_logic_vector(unsigned(sig_50),3);
            end if;
            done_int <= '0';
            q_reg_wire <= conv_std_logic_vector(unsigned(sig_51),8);
         when alwayssub_1 =>
            q <= q_int;
            r <= r_int;
            q_int <= conv_std_logic_vector(unsigned(q_reg),10);
            r_int <= r_reg;
            done <= done_int;
            sig_52 <= unsigned(r_reg) - unsigned(m_reg);
            done_int <= '0';
            r_reg_temp_wire <= r_reg;
            r_reg_wire <= sig_52;
         when alwayssub_2 =>
            q <= q_int;
            r <= r_int;
            q_int <= conv_std_logic_vector(unsigned(q_reg),10);
            r_int <= r_reg;
            done <= done_int;
            sig_53 <= unsigned(m_reg) - unsigned(r_reg);
            sig_54 <=  not sig_53;
            sig_55 <= unsigned(sig_54) + unsigned(conv_std_logic_vector(1,8));
            done_int <= '0';
            r_reg_temp_wire <= r_reg;
            r_reg_wire <= sig_55;
         when alwaysset_q_lsb_1 =>
            q <= q_int;
            r <= r_int;
            q_int <= conv_std_logic_vector(unsigned(q_reg),10);
            r_int <= r_reg;
            done <= done_int;
            sig_58 <= conv_std_logic_vector(shr(unsigned(q_reg),conv_unsigned(1,8)),8);
            sig_59 <= conv_std_logic_vector(shl(conv_unsigned(unsigned(sig_58),9),conv_unsigned(1,9)),9);
            sig_60 <= unsigned(sig_59) + unsigned(conv_std_logic_vector(1,9));
            done_int <= '0';
            q_reg_wire <= sig_60(7 downto 0);
         when alwaysset_q_lsb_0 =>
            q <= q_int;
            r <= r_int;
            q_int <= conv_std_logic_vector(unsigned(q_reg),10);
            r_int <= r_reg;
            done <= done_int;
            sig_56 <= conv_std_logic_vector(shr(unsigned(q_reg),conv_unsigned(1,8)),8);
            sig_57 <= conv_std_logic_vector(shl(conv_unsigned(unsigned(sig_56),9),conv_unsigned(1,9)),9);
            done_int <= '0';
            q_reg_wire <= sig_57(7 downto 0);
            r_reg_wire <= r_reg_temp;
         when alwaysdec_n =>
            q <= q_int;
            r <= r_int;
            q_int <= conv_std_logic_vector(unsigned(q_reg),10);
            r_int <= r_reg;
            done <= done_int;
            sig_61 <= unsigned(n_reg) - unsigned(conv_std_logic_vector(1,4));
            done_int <= '0';
            n_reg_wire <= sig_61;
         when alwaysfinal =>
            q <= q_int;
            r <= r_int;
            q_int <= conv_std_logic_vector(unsigned(q_reg),10);
            r_int <= r_reg;
            done <= done_int;
            done_int <= '1';
         when others=>
      end case;
   end process dpCMB;


--controller reg
fsmREG: process (CLK,RST)
   begin
      if (RST = '1') then
         STATE <= s0;
      elsif CLK' event and CLK = '1' then
         STATE <= STATE;
         case STATE is
            when s0 => 
                    STATE <= s1;
            when s1 => 
               if (sig_62 = '1') then
                       STATE <= s2;
               else
                       STATE <= s0;
               end if;
            when s2 => 
                    STATE <= s3;
            when s3 => 
                    STATE <= s4;
            when s4 => 
               if (sig_63 = '1') then
                       STATE <= s5;
               else
                       STATE <= s5;
               end if;
            when s5 => 
               if (sig_94 = '1') then
                       STATE <= s6;
               else
                       STATE <= s6;
               end if;
            when s6 => 
                    STATE <= s7;
            when s7 => 
               if (sig_95 = '1') then
                       STATE <= s0;
               else
                       STATE <= s2;
               end if;
            when others=>
         end case;
      end if;
   end process fsmREG;


--controller cmb
fsmCMB: process (q_reg,m_reg,r_reg,shift_temp,r_reg_temp,n_reg,n_reg_const,start_reg,sig_0,sig_1
,sig_2,sig_3,sig_4,sig_5,sig_6,sig_7,sig_8,sig_9,sig_10,sig_11
,sig_12,sig_13,sig_14,sig_15,sig_16,sig_17,sig_18,sig_19,sig_20,sig_21
,sig_22,sig_23,sig_24,sig_25,sig_26,sig_27,sig_28,sig_29,sig_30,sig_31
,sig_32,sig_33,sig_34,sig_35,sig_36,sig_37,sig_38,sig_39,sig_40,sig_41
,sig_42,sig_43,sig_44,sig_45,sig_46,sig_47,sig_48,sig_49,sig_50,sig_51
,sig_52,sig_53,sig_54,sig_55,sig_56,sig_57,sig_58,sig_59,sig_60,sig_61
,q_int,r_int,done_int,sig_62,sig_63,sig_64,sig_65,sig_66,sig_67,sig_68
,sig_69,sig_70,sig_71,sig_72,sig_73,sig_74,sig_75,sig_76,sig_77,sig_78
,sig_79,sig_80,sig_81,sig_82,sig_83,sig_84,sig_85,sig_86,sig_87,sig_88
,sig_89,sig_90,sig_91,sig_92,sig_93,sig_94,sig_95,x,y,start
,cmd,STATE)
   begin
   sig_62 <= '0';
   sig_63 <= '0';
   sig_64 <= '0';
   sig_65 <= '0';
   sig_66 <= '0';
   sig_67 <= '0';
   sig_68 <= '0';
   sig_69 <= '0';
   sig_70 <= '0';
   sig_71 <= '0';
   sig_72 <= '0';
   sig_73 <= '0';
   sig_74 <= '0';
   sig_75 <= '0';
   sig_76 <= '0';
   sig_77 <= '0';
   sig_78 <= '0';
   sig_79 <= '0';
   sig_80 <= '0';
   sig_81 <= '0';
   sig_82 <= '0';
   sig_83 <= '0';
   sig_84 <= '0';
   sig_85 <= '0';
   sig_86 <= '0';
   sig_87 <= '0';
   sig_88 <= '0';
   sig_89 <= '0';
   sig_90 <= '0';
   sig_91 <= '0';
   sig_92 <= '0';
   sig_93 <= '0';
   sig_94 <= '0';
   sig_95 <= '0';
   if (start_reg = '1') then
      sig_62 <= '1';
   else
      sig_62 <= '0';
   end if;
   if (unsigned(r_reg) > unsigned(m_reg)) then
      sig_63 <= '1';
   else
      sig_63 <= '0';
   end if;
   if (unsigned(n_reg_const) = 8) then
      sig_64 <= '1';
   else
      sig_64 <= '0';
   end if;
   if (r_reg(7) = '0') then
      sig_65 <= '1';
   else
      sig_65 <= '0';
   end if;
   sig_66 <= sig_64 and sig_65;
   if (unsigned(n_reg_const) = 7) then
      sig_67 <= '1';
   else
      sig_67 <= '0';
   end if;
   if (r_reg(6) = '0') then
      sig_68 <= '1';
   else
      sig_68 <= '0';
   end if;
   sig_69 <= sig_67 and sig_68;
   sig_70 <= sig_66 or sig_69;
   if (unsigned(n_reg_const) = 6) then
      sig_71 <= '1';
   else
      sig_71 <= '0';
   end if;
   if (r_reg(5) = '0') then
      sig_72 <= '1';
   else
      sig_72 <= '0';
   end if;
   sig_73 <= sig_71 and sig_72;
   sig_74 <= sig_70 or sig_73;
   if (unsigned(n_reg_const) = 5) then
      sig_75 <= '1';
   else
      sig_75 <= '0';
   end if;
   if (r_reg(4) = '0') then
      sig_76 <= '1';
   else
      sig_76 <= '0';
   end if;
   sig_77 <= sig_75 and sig_76;
   sig_78 <= sig_74 or sig_77;
   if (unsigned(n_reg_const) = 4) then
      sig_79 <= '1';
   else
      sig_79 <= '0';
   end if;
   if (r_reg(3) = '0') then
      sig_80 <= '1';
   else
      sig_80 <= '0';
   end if;
   sig_81 <= sig_79 and sig_80;
   sig_82 <= sig_78 or sig_81;
   if (unsigned(n_reg_const) = 3) then
      sig_83 <= '1';
   else
      sig_83 <= '0';
   end if;
   if (r_reg(2) = '0') then
      sig_84 <= '1';
   else
      sig_84 <= '0';
   end if;
   sig_85 <= sig_83 and sig_84;
   sig_86 <= sig_82 or sig_85;
   if (unsigned(n_reg_const) = 2) then
      sig_87 <= '1';
   else
      sig_87 <= '0';
   end if;
   if (r_reg(1) = '0') then
      sig_88 <= '1';
   else
      sig_88 <= '0';
   end if;
   sig_89 <= sig_87 and sig_88;
   sig_90 <= sig_86 or sig_89;
   if (unsigned(n_reg_const) = 1) then
      sig_91 <= '1';
   else
      sig_91 <= '0';
   end if;
   if (r_reg(0) = '0') then
      sig_92 <= '1';
   else
      sig_92 <= '0';
   end if;
   sig_93 <= sig_91 and sig_92;
   sig_94 <= sig_90 or sig_93;
   if (unsigned(n_reg) = 0) then
      sig_95 <= '1';
   else
      sig_95 <= '0';
   end if;
   cmd <= alwaysidle;
   case STATE is
      when s0 => 
              cmd <= alwaysidle;
      when s1 => 
         if (sig_62 = '1') then
                 cmd <= alwaysinit;
         else
                 cmd <= alwaysdo_nothing;
         end if;
      when s2 => 
              cmd <= alwaysshift_1;
      when s3 => 
              cmd <= alwaysshift_2;
      when s4 => 
         if (sig_63 = '1') then
                 cmd <= alwayssub_1;
         else
                 cmd <= alwayssub_2;
         end if;
      when s5 => 
         if (sig_94 = '1') then
                 cmd <= alwaysset_q_lsb_1;
         else
                 cmd <= alwaysset_q_lsb_0;
         end if;
      when s6 => 
              cmd <= alwaysdec_n;
      when s7 => 
         if (sig_95 = '1') then
                 cmd <= alwaysfinal;
         else
                 cmd <= alwaysdo_nothing;
         end if;
      when others=>
      end case;
end process fsmCMB;
end RTL;
