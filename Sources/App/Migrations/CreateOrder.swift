//
//  CreateOrder.swift
//  
//
//  Created by Pedro Moura on 15/11/23.
//

import Fluent
import FluentPostgresDriver

struct CreateOrder: AsyncMigration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) async throws {
        try await database.schema("orders")
            .id()
            .field("price", .double)
            .field("currency", .string)
            .field("product", .string)
            .field("customer_email", .string)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("orders").delete()
    }
}
