import scala.util.parsing.json._

class Hooligan {    
    override def toString():String = {
        return "Shoot, my favourite club lost. I could curse all day, darn it."
    }
}

trait Censor {
    
    val words = loadWords()
    
    def loadWords():Map[String, String] = {
        
        return JSON.parseFull(scala.io.Source.fromFile("bad_words.json").mkString)
            .get.asInstanceOf[Map[String, String]]
        
    }
    
    override def toString():String = {
        return (super.toString() /: words) {(result, word) => 
            result
                .replaceAllLiterally(word._1, word._2)
                .replaceAllLiterally(word._1.capitalize, word._2.capitalize)
        }
    }
}

class CensoredHooligan extends Hooligan with Censor {
    
}

val s = new CensoredHooligan

println(s)