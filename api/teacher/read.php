<?php
header("Content-Type: application/json");
include_once '../db.php';

$sql = "SELECT 
            teachers.id, 
            users.name, 
            users.email, 
            teachers.subject, 
            teachers.department, 
            teachers.qualification 
        FROM teachers 
        JOIN users ON teachers.user_id = users.id";

$result = mysqli_query($conn, $sql);

if ($result) {
    $teachers = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $teachers[] = $row;
    }

    echo json_encode([
        "success" => true,
        "data" => $teachers
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Failed to fetch teachers"
    ]);
}
?>
