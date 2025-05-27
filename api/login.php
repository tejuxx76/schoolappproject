<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

include_once('db.php'); 

$data = json_decode(file_get_contents("php://input"), true);

// Validate required fields
if (!isset($data['email']) || !isset($data['password']) || !isset($data['role']) || !isset($data['full_name'])) {
    echo json_encode(['status' => false, 'message' => 'Full name, email, password, and role are required']);
    exit;
}

$email = $data['email'];
$password = $data['password'];
$role = $data['role'];
$full_name = $data['full_name'];

$conn = new mysqli("localhost", "root", "", "school_app");
if ($conn->connect_error) {
    echo json_encode(['status' => false, 'message' => 'Database connection failed']);
    exit;
}

// Prepare SQL query to check user with email, role, and full name
$sql = "SELECT users.id, users.full_name, users.password, roles.role_name 
        FROM users 
        LEFT JOIN roles ON users.role_id = roles.id 
        WHERE users.email = ? AND roles.role_name = ? AND users.full_name = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("sss", $email, $role, $full_name);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 1) {
    $user = $result->fetch_assoc();
    // Verify password hash
    if (password_verify($password, $user['password'])) {
        echo json_encode([
            'status' => true,
            'message' => 'Login successful',
            'user_id' => $user['id'],
            'name' => $user['full_name'],
            'role' => $user['role_name']
        ]);
    } else {
        echo json_encode(['status' => false, 'message' => 'Invalid password']);
    }
} else {
    echo json_encode(['status' => false, 'message' => 'User not found or incorrect role/full name']);
}

$conn->close();
?>