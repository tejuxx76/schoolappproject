<?php
header('Content-Type: application/json');
include '../../db.php';

$student_id = $_GET['student_id'] ?? null;
if (!$student_id) {
    echo json_encode(['error' => 'Student ID required']);
    exit;
}

$sql = "SELECT * FROM marks WHERE student_id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $student_id);
$stmt->execute();
$result = $stmt->get_result();

$marks = [];
while ($row = $result->fetch_assoc()) {
    $marks[] = $row;
}

echo json_encode(['marks' => $marks]);
?>
