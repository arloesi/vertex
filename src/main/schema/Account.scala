package schema

import javax.persistence._
import javax.xml.bind.annotation._

import kernel.schema._

@Entity
@Table(name="account")
@XmlRootElement
class Account() {
  @Id
  @XmlElement
  @GeneratedValue(strategy=GenerationType.TABLE)
  @Property(view=classOf[Views.GLOBAL])
  var id:Long = _

  @XmlElement
  @Property(view=classOf[Views.GLOBAL])
  var name:String = _

  @XmlElement
  @Property(view=classOf[Views.GLOBAL])
  var display:String = _
}