package com.project.myserver.restapi.entity

import jakarta.persistence.*
import java.time.ZonedDateTime

@Entity
@Table(name = "budget")
class Budget(
    @Column(name = "name")
    var name: String,

    @Column(name = "price")
    var price: Long,

    @Column(name = "payer")
    var payer: String,

    @Column(name = "pay_date")
    var payDate: ZonedDateTime? = ZonedDateTime.now(),

    @Column(name = "division")
    var division: Boolean,

    @Column(name = "detail")
    var detail: String,
) {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Long = 0
}