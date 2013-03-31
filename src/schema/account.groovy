package schema

import groovy.transform.*
import javax.persistence.*

@Entity
@CompileStatic
public class Account {
  @Id @GeneratedValue(strategy=GenerationType.AUTO)
  Long id
  String name
}