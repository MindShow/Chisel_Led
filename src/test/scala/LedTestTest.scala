import chisel3.iotesters.{PeekPokeTester, Driver, ChiselFlatSpec}

class LedTestTest(c: LedTest) extends PeekPokeTester(c) {
  var i = 0
  var o:Boolean = true
  var cnt = 0
  val cir = 512
  for (i <- 0 until 8) {
    for(cnt <- 0 until cir) {
      if(0 == cnt) {
          o = !o
      }
      expect(c.io.led, o)
      step(1)
    }
  }
}

object LedTestTester {
  def main(args:Array[String]): Unit = {
      Driver(() => new LedTest)(c => new LedTestTest(c))
  }
}