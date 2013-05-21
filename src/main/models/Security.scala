package models

import java.util._
import scala.collection.JavaConversions._
import javax.persistence._
import javax.xml.bind.annotation._

import kernel.schema.{Property}
import kernel.runtime.{Variable}

@Entity
@DiscriminatorValue("model_authentication")
class Authentication extends Variable {
  @OneToOne
  var user:User = _
}