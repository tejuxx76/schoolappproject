<?php
//include '../../db.php';
include '../../db.php';
header('Content-Type: application/json');
$data = json_decode(file_get_contents("php://input"));

if (!empty($data->user_id) && !empty($data->department)) {
    $query = "INSERT INTO hods (user_id, department) VALUES (?, ?)";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("is", $data->user_id, $data->department);

    if ($stmt->execute()) {
        echo json_encode(["message" => "HOD created successfully."]);
    } else {
        echo json_encode(["message" => "Failed to create HOD."]);
    }
} else {
    echo json_encode(["message" => "Incomplete data."]);
}
?>