package schema

import kernel.schema._
import kernel.runtime.User

object Views {
  final val K = kernel.runtime.Views

  trait SIMPLE extends K.SIMPLE
  trait DETAIL extends K.DETAIL

  @View(target=classOf[SIMPLE])
  trait MEMBER extends DETAIL

  trait GLOBAL extends K.GLOBAL with SIMPLE with DETAIL
}