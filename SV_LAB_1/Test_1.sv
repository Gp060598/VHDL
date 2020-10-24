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
    write = 0;
    reset = 0;
    //without resetting the system
    for(int k =0;k<8;k++) begin
      address = register_array[k];
      data_in = data[1];
      for(int i=0;i<$size(write_logic) ;i++) begin
        write = write_logic[i];
        @(negedge clk)
        if (i==0 && (!$isunknown(data_out))) begin   //to check if there is an issue with reading and writting to the reg
          $display("%s has issue in write/read operation",register_array[k]);
        end
        if (i==2 && data_out === undefined) begin
          $display("%s cannot perform read operation",register_array[k]); // to check for read operation.
        end
      end
    end
    reset = 1;
    #20;
    reset = 0;
    foreach(register_array[k]) begin
      address = register_array[k];
      for(int j=0;j<$size(data);j+=1) begin
        data_in = data[j];
        for(int i=0;i<$size(write_logic) ;i++) begin
          write = write_logic[i];
          @(posedge clk)
          if (i==0 && j==0 && data_out != reset_val[k]) begin
            $display("%s default value not proper, default value : %h, read value : %h",register_array[k],reset_val[k],data_out);
          end
          @(negedge clk)
          if (i==2 && data_out != data_in) begin
            $display("%s written value(%h) is not equal to read value(%h)",register_array[k],data_in,data_out);
          end
        end
      end
    end
   end
   
endmodule
