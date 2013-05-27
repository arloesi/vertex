package models

import kernel.schema._

object Views {
  final val K = kernel.runtime.Views

  type SIMPLE = K.SIMPLE
  type DETAIL = K.DETAIL
  type MEMBER = K.MEMBER

  trait GLOBAL extends SIMPLE with DETAIL
}