/*
 * tt_um_factory_test.v
 *
 * Test user module
 *
 * Author: Kavish Ranwella <bue6zr@virginia.edu>
 * Author: Bhasitha Dharmasena <bp2sq@virginia.edu>
 */

`default_nettype none

module tt_um_spi_serv (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // reg rst_n_i;

  wire     spi_miso;
  wire     spi_sck;
  wire     spi_ss;
  wire     spi_mosi;
  wire 	   q;
  wire 	   uart_txd;

  assign uo_out[0] = spi_sck;
  assign uo_out[1] = spi_ss;
  assign uo_out[2] = spi_mosi;
  assign uo_out[3] = q;
  assign uo_out[4] = uart_txd;
  assign spi_miso = ui_in[0];

  assign uo_out[7:5] = 3'h0;
  assign uio_out = 8'h0;
  assign uio_oe = 8'h0;

   assign uart_txd = q;

   servant_spi_top servant
     (.wb_clk (clk),
      .wb_rst (!rst_n),
      .spi_miso(spi_miso),
      .spi_sck(spi_sck),
      .spi_ss(spi_ss),
      .spi_mosi(spi_mosi),
      .q      (q));


  // always @(posedge clk or negedge rst_n)
  //   if (~rst_n) rst_n_i <= 1'b0;
  //   else rst_n_i <= 1'b1;

  // avoid linter warning about unused pins:
  wire _unused_pins = ena;

endmodule  // tt_um_factory_test