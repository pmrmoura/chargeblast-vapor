import Vapor
import Fluent
import FluentPostgresDriver

public func configure(_ app: Application) async throws {
    try app.databases.use(.postgres(url: Environment.get("DB_CONNECTION_STRING") ?? ""), as: .psql)
    
    app.migrations.add(CreateOrder())

    // register routes
    try routes(app)
}
