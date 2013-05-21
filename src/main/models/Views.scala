package models

import kernel.schema._

object Views {
  trait SIMPLE
  trait DETAIL

  @View(target=classOf[SIMPLE])
  trait MEMBER

  trait GLOBAL extends SIMPLE with DETAIL
}