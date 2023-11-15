//
//  Order.swift
//  
//
//  Created by Pedro Moura on 15/11/23.
//

import Vapor
import Fluent
import FluentPostgresDriver

struct OrdersResponse: Content {
    var orders: [Order]
}

struct OrderResult: Content {
    var order: Order
}

final class Order: Model, Content {
    static let schema = "orders"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "price")
    var price: Double
    
    @Field(key: "currency")
    var currency: String
    
    @Field(key: "product")
    var product: String
    
    @Field(key: "customer_email")
    var customer_email: String
    
    init() { }
    
    init(id: UUID? = nil, price: Double, currency: String, product: String, customer_email: String) {
        self.id = id
        self.price = price
        self.currency = currency
        self.product = product
        self.customer_email = customer_email
    }
}
