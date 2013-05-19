package schema

import kernel.schema._
import kernel.runtime.User

object Views {
  trait SIMPLE
  trait DETAIL

  @View(target=classOf[SIMPLE])
  trait MEMBER extends DETAIL

  trait GLOBAL extends SIMPLE with DETAIL
}