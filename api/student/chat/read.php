<?php
header('Content-Type: application/json');
include '../../db.php';

$student_id = $_GET['student_id'] ?? null;
$teacher_id = $_GET['teacher_id'] ?? null;

if (!$student_id || !$teacher_id) {
    echo json_encode(['error' => 'Student ID and Teacher ID required']);
    exit;
}

$sql = "SELECT * FROM chat WHERE (sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?) ORDER BY timestamp ASC";
$stmt = $conn->prepare($sql);
$stmt->bind_param("iiii", $student_id, $teacher_id, $teacher_id, $student_id);
$stmt->execute();
$result = $stmt->get_result();

$messages = [];
while ($row = $result->fetch_assoc()) {
    $messages[] = $row;
}

echo json_encode(['messages' => $messages]);
?>
