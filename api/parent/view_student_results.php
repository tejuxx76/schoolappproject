<?php
//include '../config/db.php';
//include_once '../../db.php';
//include('../../config/db.php');
include('../db.php');  // ✅ Correct path now


$student_id = $_GET['student_id'] ?? '';

if ($student_id == '') {
    echo json_encode(["status" => false, "message" => "Student ID is required"]);
    exit;
}

$query = "SELECT subject, marks_obtained, total_marks FROM results WHERE student_id = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param("i", $student_id);
$stmt->execute();
$result = $stmt->get_result();

$data = [];

while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode(["status" => true, "results" => $data]);
?>
