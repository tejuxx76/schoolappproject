<?php
header("Content-Type: application/json");
include_once '../../db.php';

$sql = "SELECT 
            a.id,
            s.roll_no,
            s.class,
            a.date,
            a.period,
            a.subject,
            a.status,
            u.name AS marked_by
        FROM attendance a
        JOIN students s ON a.student_id = s.id
        JOIN users u ON a.marked_by = u.id
        ORDER BY a.date DESC";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $attendance = array();
    while ($row = $result->fetch_assoc()) {
        $attendance[] = $row;
    }
    echo json_encode(["success" => true, "data" => $attendance]);
} else {
    echo json_encode(["success" => false, "message" => "No attendance records found."]);
}
?>
