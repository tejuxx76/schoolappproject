<?php
header("Content-Type: application/json");
include_once '../db.php';

// Get JSON input
$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['student_id'])) {
    $student_id = $data['student_id'];

    // First, get user_id linked to this student to delete from users table
    $sqlGetUser = "SELECT user_id FROM students WHERE id = $student_id";
    $result = mysqli_query($conn, $sqlGetUser);

    if ($result && mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
        $user_id = $row['user_id'];

        // Delete from students table
        $sqlDeleteStudent = "DELETE FROM students WHERE id = $student_id";

        // Delete from users table
        $sqlDeleteUser = "DELETE FROM users WHERE id = $user_id";

        if (mysqli_query($conn, $sqlDeleteStudent) && mysqli_query($conn, $sqlDeleteUser)) {
            echo json_encode([
                "success" => true,
                "message" => "Student deleted successfully"
            ]);
        } else {
            echo json_encode([
                "success" => false,
                "message" => "Error deleting student: " . mysqli_error($conn)
            ]);
        }
    } else {
        echo json_encode([
            "success" => false,
            "message" => "Student not found"
        ]);
    }
} else {
    echo json_encode([
        "success" => false,
        "message" => "student_id is required"
    ]);
}
?>
