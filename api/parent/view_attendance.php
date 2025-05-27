<?php
include '../config/db.php';

$student_id = $_GET['student_id'] ?? '';

if ($student_id == '') {
    echo json_encode(["status" => false, "message" => "Student ID is required"]);
    exit;
}

$query = "SELECT date, period, subject, status FROM attendance WHERE student_id = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param("i", $student_id);
$stmt->execute();
$result = $stmt->get_result();

$data = [];

while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode(["status" => true, "attendance" => $data]);
?>
