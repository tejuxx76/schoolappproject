<?php
header('Content-Type: application/json');
include '../../db.php';

$student_id = $_GET['student_id'] ?? null;
if (!$student_id) {
    echo json_encode(['error' => 'Student ID required']);
    exit;
}

$sql = "SELECT * FROM fees WHERE student_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $student_id);
$stmt->execute();
$result = $stmt->get_result();

$fees = [];
while ($row = $result->fetch_assoc()) {
    $fees[] = $row;
}

echo json_encode(['fees' => $fees]);
?>
