<?php
header("Content-Type: application/json");
include_once '../db.php';

// Get JSON input
$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['teacher_id'])) {
    $teacher_id = $data['teacher_id'];

    // Get user_id linked to this teacher
    $sqlGetUser = "SELECT user_id FROM teachers WHERE id = $teacher_id";
    $result = mysqli_query($conn, $sqlGetUser);

    if ($result && mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
        $user_id = $row['user_id'];

        // Delete from teachers table
        $sqlDeleteTeacher = "DELETE FROM teachers WHERE id = $teacher_id";

        // Delete from users table
        $sqlDeleteUser = "DELETE FROM users WHERE id = $user_id";

        if (mysqli_query($conn, $sqlDeleteTeacher) && mysqli_query($conn, $sqlDeleteUser)) {
            echo json_encode([
                "success" => true,
                "message" => "Teacher deleted successfully"
            ]);
        } else {
            echo json_encode([
                "success" => false,
                "message" => "Error deleting teacher: " . mysqli_error($conn)
            ]);
        }
    } else {
        echo json_encode([
            "success" => false,
            "message" => "Teacher not found"
        ]);
    }
} else {
    echo json_encode([
        "success" => false,
        "message" => "teacher_id is required"
    ]);
}
?>
