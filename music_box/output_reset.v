module output_reset (in ,reset, END, change,reset_out);
input [4:0] in;
input reset, END, change;
output reset_out;
wire all_zero;

assign all_zero = ~(|in);                              //利用NOR判斷in是否全為0
assign reset_out = reset | END | change | all_zero;    //只要reset、END、change或是in全為0，輸出的值就會是1
                                                       //要求輸出停止撥放音樂
endmodule