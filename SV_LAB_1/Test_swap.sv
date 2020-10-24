 module test_config_reg_1(
);

typedef enum{adc0_reg,adc1_reg,temp_sensor0_reg,temp_sensor1_reg,analog_test,digital_test,amp_gain,digital_config} register;

register register_array[] = '{adc0_reg,adc1_reg,temp_sensor0_reg,temp_sensor1_reg,analog_test,digital_test,amp_gain,digital_config,amp_gain,digital_test,analog_test,temp_sensor1_reg,temp_sensor0_reg,adc1_reg,adc0_reg};
logic clk, reset,write;
logic [15:0] data_in,data_out,undefined;
logic [2:0] address;
logic [15:0] reset_val[7:0] = '{'h0001,'h0000,'h0000,'hABCD,'h0000,'h0000,'h0000,'hFFFF};
logic [15:0] data[0:3] = '{'h0001,'hffff,'habcd,'h5eab};
logic write_logic[2:0] = '{0,1,0};

always #10 clk = !clk;
 config_reg configreg(.*);
  initial
  begin
    clk = 0;
    write = 1;
    reset = 0;
   address=register_array[6];
   data_in=4'habcd;
end
   
endmodule
