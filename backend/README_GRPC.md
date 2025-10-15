# gRPC Restaurant Service

This directory contains a complete gRPC service implementation for restaurant management, integrated with the Django backend.

## Files

- `restaurant.proto` - Protocol buffer definition for RestaurantService
- `restaurant_pb2.py` - Generated Python protobuf code (auto-generated)
- `restaurant_pb2_grpc.py` - Generated gRPC Python code (auto-generated)
- `grpc_server.py` - gRPC server implementation
- `grpc_client.py` - gRPC client implementation
- `create_sample_restaurant.py` - Script to create sample restaurant data

## Prerequisites

Install the required dependencies:
```bash
pip install grpcio grpcio-tools
```

## Setup

1. **Generate gRPC Code:**
   ```bash
   python -m grpc_tools.protoc --proto_path=. --python_out=. --grpc_python_out=. restaurant.proto
   ```

2. **Run Database Migrations:**
   ```bash
   python manage.py migrate
   ```

3. **Create Sample Data:**
   ```bash
   python create_sample_restaurant.py
   ```
   This creates a sample restaurant for testing.

## Usage

### 1. Start the gRPC Server

```bash
python grpc_server.py
```

The server will start on port 50051. It will:
- Connect to the Django database
- Serve the RestaurantService
- Handle GetRestaurant requests

### 2. Use the gRPC Client

```bash
# Get restaurant details by ID
python grpc_client.py <restaurant_id>

# Example:
python grpc_client.py a04de459-55d2-4819-adc3-6086fdda340b
```

**Example Output:**
```
🔍 Getting restaurant details for ID: a04de459-55d2-4819-adc3-6086fdda340b
🍽️  Restaurant Details
==============================
ID: a04de459-55d2-4819-adc3-6086fdda340b
Name: Sample Pizza Place
Address: 123 Main Street, Sample City, SC 12345
Phone: +1-555-PIZZA
Rating: 4.5/5.0
Active: Yes
Created: 2025-01-14T17:30:00+00:00
Updated: 2025-01-14T17:30:00+00:00
✅ Successfully retrieved restaurant details!
```

## Protocol Buffer Definition

### Restaurant Message
```protobuf
message Restaurant {
  string id = 1;
  string name = 2;
  string address = 3;
  string phone_number = 4;
  double rating = 5;
  string created_at = 6;
  string updated_at = 7;
  bool is_active = 8;
}
```

### RestaurantService
```protobuf
service RestaurantService {
  rpc GetRestaurant(GetRestaurantRequest) returns (GetRestaurantResponse);
}
```

## Implementation Details

### Server (`grpc_server.py`)
- Implements `RestaurantServiceServicer`
- Uses Django ORM to fetch restaurant data
- Handles errors with appropriate gRPC status codes
- Converts Django models to protobuf messages

### Client (`grpc_client.py`)
- Demonstrates how to call the gRPC service
- Handles responses and errors
- Formats output for easy reading

## Error Handling

- **NOT_FOUND**: Restaurant with given ID doesn't exist
- **INTERNAL**: Database or server errors
- **INVALID_ARGUMENT**: Malformed request

## Testing

1. **Start Server:** `python grpc_server.py` (in one terminal)
2. **Run Client:** `python grpc_client.py <id>` (in another terminal)
3. **Verify:** Check that restaurant details are returned correctly

## Integration with Backend

- Uses the existing Django `Restaurant` model
- Compatible with the current database schema
- Can be extended to support more CRUD operations

This gRPC service provides a high-performance, language-agnostic way to access restaurant data from the Django backend!
