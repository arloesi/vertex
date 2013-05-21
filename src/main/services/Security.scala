package services

import java.util._
import scala.collection.JavaConversions._

import org.eclipse.persistence.queries.ReadObjectQuery
import org.eclipse.persistence.internal.jpa.{EntityManagerImpl}

import kernel.runtime.{
  Remote,Event,Connection}

import kernel.runtime.digest._

import models._

object Security {
  class Authenticated(val error:Boolean,val message:String) {
    def getError() = {error}
    def getMessage() = {message}
  }
}

class Security(schema:kernel.schema.Schema) {
  import Security._

  @Remote val authenticated = new Event[{val error:Boolean}]()

  @Remote def authenticate(connection:Connection,params:Map[String,String]) {
    val name = params.get("name")
    val pass = params.get("pass")

    val provider = schema.openSession()

    val query = provider.createQuery("from User u where u.name=:name and u.pass=:pass");
    query.setParameter("name", name);
    query.setParameter("pass", sha(pass));
    val users = query.getResultList()

    var msg:String = null
    var err:Boolean = false

    if(users.size() == 1) {
      msg = "Welcome "+name+"."
      err = false
    } else {
      msg = "Incorrect username or password."
      err = true
    }

    provider.close()

    authenticated.send(connection,new Authenticated(err,msg))
  }
}