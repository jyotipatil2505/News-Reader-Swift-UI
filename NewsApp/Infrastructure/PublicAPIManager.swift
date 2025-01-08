//// The Swift Programming Language
//
//import Foundation
//
//public struct PublicAPIManager {
//    
//    public static func initializeService(environment: APIEnvironment) {
//        APIEnvironment.setEnvironment(environment: environment)
//    }
//    
//    public static func fetchAllObjects() async throws -> [ObjectModel] {
//        do {
//            let request = Endpoint.objects
//            let response: [ObjectModel] = try await NetworkService.shared.request(request, type: [ObjectModel].self, decodingType: .useDefaultKeys)
//            print("Success: \(response)")
//            return response
//        } catch let error as NetworkError {
//            print("NetworkError :::::: ",error.errorDescription ?? "")
//            throw error
//        } catch {
//            print("error :::::: ",error)
//            throw error
//        }
//    }
//    
//    public static func fetchAllObjectsByIds(id1: String, id2: String) async throws -> [ObjectModel] {
//        do {
//            let request = Endpoint.objectsBy(id1: id1, id2: id2)
//            let response: [ObjectModel] = try await NetworkService.shared.request(request, type: [ObjectModel].self, decodingType: .useDefaultKeys)
//            print("Success: \(response)")
//            return response
//        } catch let error as NetworkError {
//            print("NetworkError :::::: ",error.errorDescription ?? "")
//            throw error
//        } catch {
//            print("error :::::: ",error)
//            throw error
//        }
//    }
//    
//    public static func fetchObjectById(id: String) async throws -> ObjectModel {
//        do {
//            let request = Endpoint.singleObject(id: id)
//            let response: ObjectModel = try await NetworkService.shared.request(request, type: ObjectModel.self, decodingType: .useDefaultKeys)
//            print("Success: \(response)")
//            return response
//        } catch let error as NetworkError {
//            print("NetworkError :::::: ",error.errorDescription ?? "")
//            throw error
//        } catch {
//            print("error :::::: ",error)
//            throw error
//        }
//    }
//    
//    public static func addObject(object: ObjectModel) async throws -> ObjectModel {
//        do {
//            let request = Endpoint.addObject(details: object)
//            let response: ObjectModel = try await NetworkService.shared.request(request, type: ObjectModel.self, decodingType: .useDefaultKeys)
//            print("Success: \(response)")
//            return response
//        } catch let error as NetworkError {
//            print("NetworkError :::::: ",error.errorDescription ?? "")
//            throw error
//        } catch {
//            print("error :::::: ",error)
//            throw error
//        }
//    }
//    
//    public static func updateObject(id: String, object: ObjectModel) async throws -> ObjectModel {
//        do {
//            let request = Endpoint.updateObjects(id: id, details: object)
//            let response: ObjectModel = try await NetworkService.shared.request(request, type: ObjectModel.self, decodingType: .useDefaultKeys)
//            print("Success: \(response)")
//            return response
//        } catch let error as NetworkError {
//            print("NetworkError :::::: ",error.errorDescription ?? "")
//            throw error
//        } catch {
//            print("error :::::: ",error)
//            throw error
//        }
//    }
//    
//    public static func partiallyUpdateObject(id: String, name: String) async throws -> ObjectModel {
//        do {
//            let request = Endpoint.partialllyUpdateObjects(id: id, name: name)
//            let response: ObjectModel = try await NetworkService.shared.request(request, type: ObjectModel.self, decodingType: .useDefaultKeys)
//            print("Success: \(response)")
//            return response
//        } catch let error as NetworkError {
//            print("NetworkError :::::: ",error.errorDescription ?? "")
//            throw error
//        } catch {
//            print("error :::::: ",error)
//            throw error
//        }
//    }
//    
//    public static func deleteObject(id: String) async throws -> DeleteObjectResponse {
//        do {
//            let request = Endpoint.deleteObjects(id: id)
//            let response: DeleteObjectResponse = try await NetworkService.shared.request(request, type: DeleteObjectResponse.self, decodingType: .useDefaultKeys)
//            print("Success: \(response)")
//            return response
//        } catch let error as NetworkError {
//            print("NetworkError :::::: ",error.errorDescription ?? "")
//            throw error
//        } catch {
//            print("error :::::: ",error)
//            throw error
//        }
//    }
//}
