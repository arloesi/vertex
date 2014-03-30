package vertex.runtime

import java.util._
import scala.collection.JavaConversions._
import scala.collection.JavaConverters._

import com.google.inject._
import com.google.common.collect.Lists._

import org.vertx.java.core._
import org.vertx.java.core.http._
import org.vertx.java.core.json._
import org.vertx.java.core.VertxFactory.newVertx

import kernel.network._
import kernel.network.Handler._

class Module extends AbstractModule {
    override def configure() {
    }

    @Provides @Singleton
    def provideHtmlHandler():Html = {
      new Html("build/dist/html/")
    }

    @Provides @Singleton
    def provideStaticHandler():Static = {
      new Static("build/dist/static/","/static")
    }

    @Provides @Singleton
    def provideRouteMatcher(html:Html, static:Static):RouteMatcher = {
      val matcher = new RouteMatcher()

      matcher.get("/:page", html)
      matcher.getWithRegEx("/static/.*", static)

      matcher
    }
}
