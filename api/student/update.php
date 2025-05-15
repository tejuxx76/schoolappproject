<?php
header("Content-Type: application/json");
include_once '../db.php';

// Get raw POST JSON data
$data = json_decode(file_get_contents("php://input"), true);

if (
    isset($data['student_id']) &&
    isset($data['name']) &&
    isset($data['email']) &&
    isset($data['roll_no']) &&
    isset($data['class']) &&
    isset($data['parent_id'])
) {
    $student_id = $data['student_id'];
    $name = $data['name'];
    $email = $data['email'];
    $roll_no = $data['roll_no'];
    $class = $data['class'];
    $parent_id = $data['parent_id'];

    // Update users table
    $sql1 = "UPDATE users
             SET name = '$name', email = '$email'
             WHERE id = (SELECT user_id FROM students WHERE id = $student_id)";

    // Update students table
    $sql2 = "UPDATE students
             SET roll_no = '$roll_no', class = '$class', parent_id = $parent_id
             WHERE id = $student_id";

    if (mysqli_query($conn, $sql1) && mysqli_query($conn, $sql2)) {
        echo json_encode([
            "success" => true,
            "message" => "Student updated successfully"
        ]);
    } else {
        echo json_encode([
            "success" => false,
            "message" => "Update failed: " . mysqli_error($conn)
        ]);
    }
} else {
    echo json_encode([
        "success" => false,
        "message" => "Missing required fields"
    ]);
}
?>
