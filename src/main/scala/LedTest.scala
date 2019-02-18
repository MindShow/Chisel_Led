import chisel3._

class LedTest extends Module {
  val io = IO(new Bundle {
    val key  = Input(UInt(1.W))
    val led  = Output(UInt(1.W))
  })
    val max = "h1ff".U
    val cnt = RegInit(0.U(max.getWidth.W))
    val ledReg = RegInit(false.B)
    cnt := Mux(cnt === max, 0.U, cnt + 1.U)
    ledReg := Mux(cnt === max,~ledReg,ledReg)
    io.led := ledReg.asUInt()
}

class LedTestTop extends Module {
  val io = IO(new Bundle{
    val sw_rst = Input(UInt(1.W))
    val sw_key = Input(UInt(1.W))
    val led_D1 = Output(UInt(1.W))
  })
  
  val c = Module(new LedTest)
  c.reset := ~this.io.sw_rst
  c.io.key := this.io.sw_key
  this.io.led_D1 := c.io.led
}



object Main {
  def main(args: Array[String]): Unit = {
    Driver.execute(Array("--target-dir", "Verilog"), () => new LedTestTop)
  }
}
