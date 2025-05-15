<?php
header("Content-Type: application/json");
include_once '../db.php';

// Get raw JSON input
$data = json_decode(file_get_contents("php://input"), true);

// Check for required fields
if (
    isset($data['teacher_id']) &&
    isset($data['name']) &&
    isset($data['email']) &&
    isset($data['subject']) &&
    isset($data['department']) &&
    isset($data['qualification'])
) {
    $teacher_id = $data['teacher_id'];
    $name = $data['name'];
    $email = $data['email'];
    $subject = $data['subject'];
    $department = $data['department'];
    $qualification = $data['qualification'];

    // Update users table
    $sql1 = "UPDATE users 
             SET name = '$name', email = '$email' 
             WHERE id = (SELECT user_id FROM teachers WHERE id = $teacher_id)";

    // Update teachers table
    $sql2 = "UPDATE teachers 
             SET subject = '$subject', department = '$department', qualification = '$qualification' 
             WHERE id = $teacher_id";

    if (mysqli_query($conn, $sql1) && mysqli_query($conn, $sql2)) {
        echo json_encode([
            "success" => true,
            "message" => "Teacher updated successfully"
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
