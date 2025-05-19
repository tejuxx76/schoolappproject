<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
include_once("../db.php");

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['email']) || !isset($data['password'])) {
    echo json_encode(['status' => false, 'message' => 'Email and password required']);
    exit;
}

$email = $data['email'];
$password = $data['password'];

$conn = new mysqli("localhost", "root", "", "school_app");

if ($conn->connect_error) {
    echo json_encode(['status' => false, 'message' => 'Database connection failed']);
    exit;
}

$sql = "SELECT users.*, roles.role_name FROM users 
        LEFT JOIN roles ON users.role_id = roles.id 
        WHERE email = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 1) {
    $user = $result->fetch_assoc();
    if (password_verify($password, $user['password'])) {
        echo json_encode([
            'status' => true,
            'message' => 'Login successful',
            'role' => $user['role_name']
        ]);
    } else {
        echo json_encode(['status' => false, 'message' => 'Invalid password']);
    }
} else {
    echo json_encode(['status' => false, 'message' => 'User not found']);
}

$conn->close();
?>
