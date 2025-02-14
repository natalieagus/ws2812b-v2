# WS2812B Driver

This driver is written in Lucid V2 for Alchitry Au FPGA (v1). Open this project using Alchitry Labs V2.

### Compiling the project

Open `alchitry_au.luc` and edit `COLUMN_DIMENSION` and `ROW_DIMENSION` values to match your LED matrix. If it is a strip, leave `ROW_DIMENSION` as `1`. Compile the project and then load to your Alchitry Au board.

### How to use

Choose a mode using `io_dip[2][2:0]`:

- `000`: static mode
- `001`: manual mode
- `010`: ROM mode
- `011`: RAM mode

#### Manual mode

Press `io_button[1]` to **toggle** between `OFF` and `ON`.

Set the color encoding using `io_dip[0]` and `io_dip[1]`. The encoding is as follows:

```verilog
    // WHITE (11), BLUE (10), RED (01), GREEN (00)
    const COLOR_ENCODING = {24hFFFFFF, 24hFF0000, 24h00FF00, 24h0000FF}
```

Then press `io_button[0]` to latch the value. You should see the pattern shown on the LED. They are set as:

```verilog
   led_encoding.d = ROW_DIMENSIONx{c{io_dip[1], io_dip[1], io_dip[0], io_dip[0]}}
```

You might need to reverse the index/pixel address of every other row since the matrix is usually made in **snaking** pattern. To do this, flip `io_dip[2][7]` switch. This utilises the module `index_reverser.luc` to reverse the index of every odd rows. For instance, in an 8x8 matrix, the following indexes are reversed:

- 8 to 15 is reversed to 15 to 8
- 24 to 31 is reversed to 31 to 24

Index 0 to 7 remains the same, so is 16 to 23.
