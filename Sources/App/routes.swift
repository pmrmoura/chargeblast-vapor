import Vapor
import Fluent
import FluentPostgresDriver

func routes(_ app: Application) throws {
    app.get("api", "orders") { req async throws in
        let orders = try await Order.query(on: req.db).all()
        
        return OrdersResponse(orders: orders)
    }
    
    app.post("api", "orders") { req -> EventLoopFuture<OrderResult> in
        let orderResult = try req.content.decode(OrderResult.self)
        let order = orderResult.order
        return order.create(on: req.db)
            .map { OrderResult(order: order) }
    }
    
    app.post("api", "find", "orders") { req async throws in
        let productToFind = try req.content.decode([String: String].self)
        let orders =  try await Order.query(on: req.db)
            .filter(\.$product == productToFind["name"] ?? "")
            .all()
        
        let ordersResponse = OrdersResponse(orders: orders)
        
        return ordersResponse
    }
}
