<?php
header("Content-Type: application/json");
include_once '../../db.php';

$data = json_decode(file_get_contents("php://input"));

if (
    !empty($data->student_id) &&
    !empty($data->date) &&
    isset($data->period) &&
    !empty($data->subject) &&
    !empty($data->status) &&
    !empty($data->marked_by)
) {
    $stmt = $conn->prepare("INSERT INTO attendance (student_id, date, period, subject, status, marked_by) VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("isissi", $data->student_id, $data->date, $data->period, $data->subject, $data->status, $data->marked_by);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Attendance marked successfully."]);
    } else {
        echo json_encode(["success" => false, "message" => "Error: " . $stmt->error]);
    }
} else {
    echo json_encode(["success" => false, "message" => "Missing required fields."]);
}
?>
