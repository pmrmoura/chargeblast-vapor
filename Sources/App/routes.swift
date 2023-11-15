import Vapor
import Fluent
import FluentPostgresDriver

func routes(_ app: Application) throws {
    app.get("api", "orders") { req async throws in
        try await Order.query(on: req.db).all()
    }
    
    app.post("api", "orders") { req -> EventLoopFuture<Order> in
        let orderResult = try req.content.decode(OrderResult.self)
        let order = orderResult.order
        return order.create(on: req.db)
            .map { order }
    }
    
    app.post("api", "find", "orders") { req -> [Order] in
        let productToFind = try req.content.decode([String: String].self)
        return try await Order.query(on: req.db)
            .filter(\.$product == productToFind["name"] ?? "")
            .all()
    }
}
