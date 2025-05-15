<?php
header("Content-Type: application/json");
include_once("../db.php");

// Get input from frontend or Postman
$data = json_decode(file_get_contents("php://input"));

if (
    isset($data->name) &&
    isset($data->email) &&
    isset($data->password) &&
    isset($data->roll_no) &&
    isset($data->class)
) {
    $name = $data->name;
    $email = $data->email;
    $password = password_hash($data->password, PASSWORD_DEFAULT);
    $roll_no = $data->roll_no;
    $class = $data->class;

    // 1. Insert into users table
    $role_id = 1; // Student
    $stmt = $conn->prepare("INSERT INTO users (name, email, password, role_id) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("sssi", $name, $email, $password, $role_id);

    if ($stmt->execute()) {
        $user_id = $stmt->insert_id;

        // 2. Insert into students table
        $stmt2 = $conn->prepare("INSERT INTO students (user_id, roll_no, class) VALUES (?, ?, ?)");
        $stmt2->bind_param("iss", $user_id, $roll_no, $class);

        if ($stmt2->execute()) {
            echo json_encode(["status" => "success", "message" => "Student created"]);
        } else {
            echo json_encode(["status" => "error", "message" => "Student insert failed"]);
        }
    } else {
        echo json_encode(["status" => "error", "message" => "User insert failed"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Missing required fields"]);
}
?>
