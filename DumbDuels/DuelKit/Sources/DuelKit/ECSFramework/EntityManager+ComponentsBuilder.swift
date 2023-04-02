//
//  EntityManager+ComponentsBuilder.swift
//  DuelKit
//
//  Created by Bing Sen Lim on 14/3/23.
//

import Foundation

#if swift(<5.4)
@_functionBuilder
public enum ComponentsBuilder {}
#else
@resultBuilder
public enum ComponentsBuilder {}
#endif

extension ComponentsBuilder {
    public static func buildBlock(_ components: Component...) -> [Component] {
        components
    }

    public struct Context {
        public let index: Int
    }
}

extension EntityManager {
    /// Creates an entity and assigning one or multiple components.
    ///
    /// Sample Usage:
    /// ```
    /// let newEntity = entityManager.createEntity {
    ///     Position(x: 1, y: 2)
    ///     Render(image: "test.png")
    /// }
    /// ```
    /// Parameters:
    ///   - builder: The component builder
    /// Returns:
    ///   - The newly created component with provided components assigned.
    @discardableResult
    public func createEntity(@ComponentsBuilder using builder: () -> [Component]) -> Entity {
        self.createEntity(with: builder())
    }

    /// Creates multiple entites and assigning multiple components each.
    /// The index in context can be used to customize the data passed into the components for each entity
    ///
    /// Sample Usage:
    /// ```
    /// let newEntity = entityManager.createEntities(count: 100) { context in
    ///     Position(x: context.index, y: 2 * context.index)
    ///     Render(image: "test\(context.index).png")
    /// }
    /// ```
    /// Parameters:
    ///   - builder: The component builder
    /// Returns:
    ///   - The newly created component with provided components assigned.
    @discardableResult
    public func createEntities(
        count: Int,
        @ComponentsBuilder using builder: (ComponentsBuilder.Context) -> [Component]) -> [Entity] {
        (0..<count).map { self.createEntity(with: builder(ComponentsBuilder.Context(index: $0))) }
    }
}
