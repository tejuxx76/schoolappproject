<?php
header("Content-Type: application/json");
include_once '../db.php';

$sql = "SELECT 
            students.id,
            users.name,
            users.email,
            students.roll_no,
            students.class,
            students.parent_id
        FROM students
        JOIN users ON students.user_id = users.id";

$result = $conn->query($sql);

$students = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $students[] = $row;
    }
    echo json_encode([
        "success" => true,
        "data" => $students
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "No students found"
    ]);
}

$conn->close();
?>
