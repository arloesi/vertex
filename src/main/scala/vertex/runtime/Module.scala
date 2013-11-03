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
import kernel.service._

class Module extends AbstractModule {
    override def configure() {
    }

    @Provides @Singleton
    def provideServices():List[Service] = {
        val list:List[Service] = newArrayList()
        list.map(i => new Service(i))
    }
}
