<?php
include '../../db.php';
header('Content-Type: application/json');

$query = "SELECT hods.*, users.name, users.email FROM hods JOIN users ON hods.user_id = users.id";
$result = $conn->query($query);
$hods = [];

while ($row = $result->fetch_assoc()) {
    $hods[] = $row;
}

echo json_encode($hods);
?>