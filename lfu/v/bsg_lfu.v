module bsg_lfu
	#(parameter `BSG_INV_PARAM(ways_p=8)
	 ,parameter `BSG_INV_PARAM(lg_ways_lp=3)
	 ,parameter `BSG_INV_PARAM(lg_freq_lp=16)
   ,parameter `BSG_INV_PARAM(lg_sets_lp=6)
	)
	(
	input  logic [lg_freq_lp-1:0] [ways_p-1:0] cache_line_i,
	output logic [lg_ways_lp-1:0] way_o
	);

	logic [ways_p-1:0][lg_ways_lp-1:0] way  = '0;
	logic [ways_p-1:0][lg_freq_lp-1:0] min_f = '0;

	integer index;
	genvar i;

  generate
    for (i = 0; i < ways_p; i++) begin
      always_comb begin
        if (cache_line_i[i] < min_f[i]) begin
          way[i] = i;
          min_f[i] = cache_line_i[i];
        end
      end
    end
  endgenerate

	assign way_o = way[ways_p-1];

endmodule
