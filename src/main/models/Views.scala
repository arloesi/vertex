package models

import kernel.schema._

object Views {
  final val K = kernel.runtime.Views

  trait SIMPLE extends K.SIMPLE
  trait DETAIL extends K.DETAIL

  @View(target=classOf[SIMPLE])
  trait MEMBER

  trait GLOBAL extends SIMPLE with DETAIL
}