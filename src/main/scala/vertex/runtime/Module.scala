package vertex.runtime

import java.util._
import scala.collection.JavaConversions._
import scala.collection.JavaConverters._

import javax.inject.{Named}
import com.google.inject._
import com.google.common.collect.Lists._

import org.vertx.java.core._
import org.vertx.java.core.http._
import org.vertx.java.core.json._
import org.vertx.java.core.VertxFactory.newVertx

import kernel.network._

class Module extends AbstractModule {
    override def configure() {
    }

    @Provides @Singleton @Named("html")
    def provideHtmlHandler():Static = {
      new Static("build/dist/html/",".html","/","")
    }

    @Provides @Singleton @Named("static")
    def provideStaticHandler():Static = {
      new Static("build/dist/static/","/static")
    }

    @Provides @Singleton
    def provideRouteMatcher(
      @Named("html") html:Static,
      @Named("static") static:Static):RouteMatcher = {

      val matcher = new RouteMatcher()

      matcher.get("/:page", html)
      matcher.getWithRegEx("/static/.*", static)

      matcher
    }
}
