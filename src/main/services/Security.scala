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

  @Remote val created = new Event[Object]()
  @Remote val authenticated = new Event[{val error:Boolean}]()

  @Remote def create(connection:Connection,params:Map[String,String]) {
    val provider = schema.openSession()
    val user = new User()
    user.name = params.get("name")
    user.mail = params.get("mail")
    user.pass = sha(params.get("pass"))
    provider.getTransaction().begin()
    provider.persist(user)
    provider.getTransaction().commit()
    provider.close()
    created.send(null)
    authenticate(connection,params)
  }

  @Remote def authenticate(connection:Connection,params:Map[String,String]) {
    val provider = schema.openSession()
    val query = new ReadObjectQuery(classOf[User])

    val name = params.get("name")
    val pass = params.get("pass")

    val builder = query.getExpressionBuilder()

    builder.get("name").equal(name)
    builder.get("pass").equal(sha(pass))

    val user = provider.getDatabaseSession().executeQuery(query).asInstanceOf[User]

    var msg:String = null
    var err:Boolean = false

    if(user != null) {
      val authentication = new Authentication()
      authentication.user = user;

      provider.getTransaction().begin()
      provider.persist(authentication)
      connection.session.variables.put("authentication", authentication)
      provider.merge(connection.session)
      provider.getTransaction().commit()

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