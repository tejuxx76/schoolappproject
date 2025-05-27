<?php
include '../config/db.php';

$data = json_decode(file_get_contents("php://input"));

$from_id = $data->from_id ?? '';
$to_id = $data->to_id ?? '';
$message = $data->message ?? '';

if (!$from_id || !$to_id || !$message) {
    echo json_encode(["status" => false, "message" => "Missing fields"]);
    exit;
}

$query = "INSERT INTO chat (from_id, to_id, message, sender_role) VALUES (?, ?, ?, 'parent')";
$stmt = $conn->prepare($query);
$stmt->bind_param("iis", $from_id, $to_id, $message);

if ($stmt->execute()) {
    echo json_encode(["status" => true, "message" => "Message sent"]);
} else {
    echo json_encode(["status" => false, "message" => "Failed to send"]);
}
?>

