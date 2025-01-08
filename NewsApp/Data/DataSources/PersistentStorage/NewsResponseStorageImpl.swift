import Foundation
import RealmSwift

import Foundation
import RealmSwift

class NewsResponseStorageImpl: NewsResponseStorage {
    
    let queueName: String = "com.newsapp.database.queue"
    lazy var queue = DispatchQueue(label: queueName)
    
    // Helper function to execute Realm operations
    private func performRealmOperation<T>(
        operation: @escaping (Realm) throws -> T,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        queue.async {
            do {
                let realm = try Realm() // Initialize Realm
                let result = try operation(realm) // Perform the operation
                completion(.success(result)) // Return result on the main thread
            } catch {
                completion(.failure(error)) // Return error on the main thread
            }
        }
    }
    
    // Fetch News from local storage (Realm)
    func fetchNews() async throws -> [ArticleModel] {
        return try await withCheckedThrowingContinuation { continuation in
            performRealmOperation(
                operation: { realm in
                    let realmNews = realm.objects(ArticleRealm.self)
                    return realmNews.map { $0.toDomain() }
                },
                completion: { result in
                    switch result {
                    case .success(let news):
                        continuation.resume(returning: Array(news))
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            )
        }
    }
    
    // Save News to local storage (Realm)
    func saveNews(_ news: ArticleModel) async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            performRealmOperation(
                operation: { realm in
                    try realm.write {
                        //realm.deleteAll() // Clear existing objects
                        let realmNews = news.toRealm()
                        realm.add(realmNews, update: .modified) // Add new objects
                        print("Saved :::: ",realmNews)
                    }
                },
                completion: { result in
                    switch result {
                    case .success:
                        Utilities.debugPrint(log: "Save News success ::::")
                        continuation.resume(returning: true)
                    case .failure(let error):
                        Utilities.debugPrint(log: "Save News failure :::: \(error)")
                        continuation.resume(throwing: error)
                    }
                }
            )
        }
    }
    
    // Save News to local storage (Realm)
    func deleteNews(_ news: ArticleModel) async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            performRealmOperation(
                operation: { realm in
                    let realmNews = news.toRealm()
                    try? realm.write {
                        // If the object already exists in Realm, we should fetch it before deletion
                        if let existingNews = realm.object(ofType: ArticleRealm.self, forPrimaryKey: realmNews.id) {
                            Utilities.debugPrint(log: "Object to be deleted :::::: \(existingNews)")
                            realm.delete(existingNews)  // Delete the object from the Realm
                        }
                    }
                },
                completion: { result in
                    switch result {
                    case .success:
                        Utilities.debugPrint(log: "Delete News success ::::")
                        continuation.resume(returning: true)
                    case .failure(let error):
                        Utilities.debugPrint(log: "Delete News failure :::: \(error)")
                        continuation.resume(throwing: error)
                    }
                }
            )
        }
    }
}
