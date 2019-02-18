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

object Main {
  def main(args: Array[String]): Unit = {
    Driver.execute(Array("--target-dir", "Verilog"), () => new LedTest)
  }
}
