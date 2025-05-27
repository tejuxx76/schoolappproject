<?php
include '../../db.php';
header('Content-Type: application/json');
$data = json_decode(file_get_contents("php://input"));

if (!empty($data->id)) {
    $query = "DELETE FROM hods WHERE id = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $data->id);

    if ($stmt->execute()) {
        echo json_encode(["message" => "HOD deleted successfully."]);
    } else {
        echo json_encode(["message" => "Failed to delete HOD."]);
    }
} else {
    echo json_encode(["message" => "ID is required."]);
}
?>