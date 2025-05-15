<?php
header("Content-Type: application/json");
include_once '../db.php'; // Connect to the database

$data = json_decode(file_get_contents("php://input"), true);

// Validate required input
if (
    isset($data['name']) && isset($data['email']) &&
    isset($data['password']) && isset($data['subject']) &&
    isset($data['department']) && isset($data['qualification'])
) {
    $name = $data['name'];
    $email = $data['email'];
    $password = password_hash($data['password'], PASSWORD_DEFAULT);
    $subject = $data['subject'];
    $department = $data['department'];
    $qualification = $data['qualification'];

    $role_id = 2; // Role ID for 'Teacher'

    // Insert into users table
    $stmt = $conn->prepare("INSERT INTO users (name, email, password, role_id) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("sssi", $name, $email, $password, $role_id);

    if ($stmt->execute()) {
        $user_id = $conn->insert_id;

        // Insert into teachers table
        $stmt2 = $conn->prepare("INSERT INTO teachers (user_id, subject, department, qualification) VALUES (?, ?, ?, ?)");
        $stmt2->bind_param("isss", $user_id, $subject, $department, $qualification);

        if ($stmt2->execute()) {
            echo json_encode(["success" => true, "message" => "Teacher created successfully"]);
        } else {
            echo json_encode(["success" => false, "message" => "Error inserting into teachers table"]);
        }

        $stmt2->close();
    } else {
        echo json_encode(["success" => false, "message" => "Error inserting into users table"]);
    }

    $stmt->close();
} else {
    echo json_encode(["success" => false, "message" => "Missing required fields"]);
}

$conn->close();
?>
