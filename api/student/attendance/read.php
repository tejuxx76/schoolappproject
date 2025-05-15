<?php
header('Content-Type: application/json');
include '../../db.php';  // your DB connection file

$student_id = $_GET['student_id'] ?? null;
if (!$student_id) {
    echo json_encode(['error' => 'Student ID required']);
    exit;
}

$sql = "SELECT * FROM attendance WHERE student_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $student_id);
$stmt->execute();
$result = $stmt->get_result();

$attendance = [];
while ($row = $result->fetch_assoc()) {
    $attendance[] = $row;
}

echo json_encode(['attendance' => $attendance]);
?>
