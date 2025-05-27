<?php
include '../../db.php';
header('Content-Type: application/json');
$data = json_decode(file_get_contents("php://input"));

if (!empty($data->id) && !empty($data->department)) {
    $query = "UPDATE hods SET department = ? WHERE id = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("si", $data->department, $data->id);

    if ($stmt->execute()) {
        echo json_encode(["message" => "HOD updated successfully."]);
    } else {
        echo json_encode(["message" => "Failed to update HOD."]);
    }
} else {
    echo json_encode(["message" => "Incomplete data."]);
}
?>