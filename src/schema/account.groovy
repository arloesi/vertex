package schema

import groovy.transform.*
import javax.persistence.*

@Entity
@CompileStatic
public class Account {
  String name
}