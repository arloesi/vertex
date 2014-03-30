package vertex.runtime

import java.io._
import javax.servlet._
import javax.servlet.http._

class Servlet extends HttpServlet {
  override def doGet(request:HttpServletRequest, response:HttpServletResponse) {
    val writer = response.getWriter()
    writer.println("Fuck Off! I'm busy.")
    writer.close()
  }
}