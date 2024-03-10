// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import ClientRuntime
import AWSS3

// Return an array containing the names of all available buckets.
//
// - Returns: An array of strings listing the buckets.
public func getBucketNames() async throws -> [String] {
    // Get an S3Client with which to access Amazon S3.
    let client = try S3Client(region: "cn-north-1")

    let output = try await client.listBuckets(
        input: ListBucketsInput()
    )
    
    // Get the bucket names.
    var bucketNames: [String] = []

    guard let buckets = output.buckets else {
        return bucketNames
    }
    for bucket in buckets {
        bucketNames.append(bucket.name ?? "<unknown>")
    }

    return bucketNames
}

/// The program's asynchronous entry point.
@main
public struct Main {
    static func main() async {
                     
        do {
            print("Hello, glad to see you coming to change the world!")

            let names = try await getBucketNames()
            print("Found \(names.count) buckets:")
            for name in names {
                print("  \(name)")
            }
        } catch let error as ServiceError {
            print("An Amazon S3 service error occurred: \(error.message ?? "No details available")")
        } catch {
            print("An unknown error occurred: \(dump(error))")
        }
    }
}

