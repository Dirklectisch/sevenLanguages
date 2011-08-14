import scala.io._
import scala.actors._
import Actor._

object PageLoader {
    
    // Pattern taken from: http://daringfireball.net/2010/07/improved_regex_for_matching_urls
    val urlPattern = """(?i)\b((?:https?://|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?«»“”‘’]))""".r
    
    def getPage(url : String) = Source.fromURL(url).mkString
    def pageSize(page : String) = page.length
    def findLinks(page : String) = urlPattern.findAllIn(page).toList.map { url => 
        if("""https?://""".r.findFirstIn(url) != None) url else "http://" + url }
    def countLinks(links : List[String]) = links.length
    
}

def timeMethod(method: () => Unit) = {
 val start = System.nanoTime
 method()
 val end = System.nanoTime
 println("Method took " + (end - start)/1000000000.0 + " seconds.")
}

def getPageInfoConcurrently(urls: List[String], followLinks: Boolean): Any = {
    val caller = self

    for(url <- urls) {
      actor { 
          val page = PageLoader.getPage(url)
          val links = PageLoader.findLinks(page)
          caller ! (url, PageLoader.pageSize(page), PageLoader.countLinks(links))
          if(followLinks == true){ 
                getPageInfoConcurrently(links, false)
                caller ! (url, true) 
          }
      }
    }
    
    val x = (if(followLinks) 2 else 1)
    
    for(i <- 1 to (urls.size * x)) {
      receive {
        case (url, size, linkCount) =>
          println("Size for " + url + ": " + size + ", " + linkCount + " links found.")
        case (url, true) =>
          println("Done crawling " + url)  
      }
    }
}

def crawlPages() = {
      
    val urls = List("http://pragprog.com/book/btlang/seven-languages-in-seven-weeks",
                    "http://www.ibm.com/developerworks/java/library/j-scala02049/index.html")
                   
    getPageInfoConcurrently(urls, true)
    
}


println("Concurrent run")
timeMethod { crawlPages }