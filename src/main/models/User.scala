package models

import java.util._
import scala.collection.JavaConversions._
import javax.persistence._
import javax.xml.bind.annotation._
import kernel.schema.{Property}
import kernel.runtime.digest._

@Entity
@Table(name="model_user")
class User {
  @Id
  @XmlElement
  @Property(view=classOf[Views.GLOBAL])
  @GeneratedValue(strategy=GenerationType.TABLE)
  var id:Long = _

  @XmlElement
  @Property(view=classOf[Views.GLOBAL])
  var name:String = _

  @XmlElement
  @Property(view=classOf[Views.GLOBAL])
  var mail:String = _

  @Property(view=classOf[Views.DETAIL])
  var pass:String = _

  @XmlElement
  @Property(view=classOf[Views.DETAIL])
  def setDecryptedPassword(pass:String) {
    if(pass != null) {
      this.pass = sha(pass)
    }
  }
}
