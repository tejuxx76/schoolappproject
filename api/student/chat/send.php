<?php
header('Content-Type: application/json');
include '../../db.php';

$data = json_decode(file_get_contents('php://input'), true);
$sender_id = $data['sender_id'] ?? null;
$receiver_id = $data['receiver_id'] ?? null;
$message = $data['message'] ?? null;

if (!$sender_id || !$receiver_id || !$message) {
    echo json_encode(['error' => 'Sender ID, Receiver ID, and message are required']);
    exit;
}

$sql = "INSERT INTO chat (sender_id, receiver_id, message, timestamp) VALUES (?, ?, ?, NOW())";
$stmt = $conn->prepare($sql);
$stmt->bind_param("iis", $sender_id, $receiver_id, $message);
if ($stmt->execute()) {
    echo json_encode(['success' => 'Message sent']);
} else {
    echo json_encode(['error' => 'Failed to send message']);
}
?>
