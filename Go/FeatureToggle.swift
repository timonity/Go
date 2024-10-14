import Foundation

enum LocalToggleValue: String {
    case on = "1"
    case off = "0"
}

enum RemoteToggleValue: String {
    case on = "On"
    case off = "Off"
    case `default` = "Default"
}

@propertyWrapper
struct DevelopmentLocalToggle {
    var wrappedValue: LocalToggleValue {
        return Storage<LocalToggleValue>(key: key, defaultValue: .off).value
    }

    let key: String
}

@propertyWrapper
struct ProductionLocalToggle {
    var wrappedValue: LocalToggleValue {
        return Storage<LocalToggleValue>(key: key, defaultValue: .on).value
    }

    let key: String
}

@propertyWrapper
struct DevelopmentRemoteToggle {
    var wrappedValue: RemoteToggleValue {
        return Storage<RemoteToggleValue>(
            key: key,
            defaultValue: .off
        ).value
    }

    let key: String
}

@propertyWrapper
struct ProductionRemoteToggle {
    var wrappedValue: RemoteToggleValue {
        return Storage<RemoteToggleValue>(
            key: key,
            defaultValue: .default
        ).value
    }

    let key: String
}

struct Storage<Value: RawRepresentable> where Value.RawValue == String {
    var value: Value {
        #if ADHOC || DEBUG
        guard
            let rawValue = UserDefaults.standard.string(forKey: key),
            let value = Value(rawValue: rawValue)
        else {
            return defaultValue
        }

        return value
        #else
        return defaultValue
        #endif
    }

    let key: String
    let defaultValue: Value
}
