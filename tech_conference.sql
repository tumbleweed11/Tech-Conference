--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: attendee
CREATE TABLE IF NOT EXISTS attendee (
    attendee_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    phone INTEGER,
    email VARCHAR(30),
    vip BOOLEAN DEFAULT (0)
);

--- Populated some Sample Data
INSERT INTO attendee (attendee_id, first_name, last_name, phone, email, vip) VALUES (2, 'Jon', 'Skeeter', 4802185842, 'john.skeeter@rex.net', 1);
INSERT INTO attendee (attendee_id, first_name, last_name, phone, email, vip) VALUES (3, 'Sam', 'Scala', 2156783401, 'sam.scala@gmail.com', 0);
INSERT INTO attendee (attendee_id, first_name, last_name, phone, email, vip) VALUES (4, 'Brittany', 'Fisher', 5932857296, 'brittany.fisher@outlook.com', 0);

-- Table: company
CREATE TABLE IF NOT EXISTS company (
    company_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR (30) NOT NULL,
    description VARCHAR (60),
    primary_contact_attendee_id INTEGER NOT NULL REFERENCES attendee (attendee_id));

-- Populated some sample Data
INSERT INTO company (company_id, name, description, primary_contact_attendee_id) VALUES (1, 'RexApp Solutions', 'A mobile app delivery service', 3);

-- Table: presentation
CREATE TABLE IF NOT EXISTS presentation (
    presentation_id INTEGER PRIMARY KEY AUTOINCREMENT,
    booked_company_id INTEGER NOT NULL REFERENCES company (company_id),
    booked_room_id INTEGER NOT NULL REFERENCES room (room_id),
    start_time TIME,
    end_time TIME);

-- Table: presentation_attendance
CREATE TABLE IF NOT EXISTS presentation_attendance (
    ticket_id INTEGER PRIMARY KEY AUTOINCREMENT,
    presentation_id INTEGER REFERENCES presentation (presentation_id),
    attendee_id INTEGER REFERENCES attendee (attendee_id));

-- Table: room
CREATE TABLE IF NOT EXISTS room (
    room_id INTEGER PRIMARY KEY AUTOINCREMENT,
    floor_number INTEGER NOT NULL,
    seat_capacity INTEGER NOT NULL
);



-- View: presentation_vw
CREATE VIEW IF NOT EXISTS presentation_vw AS SELECT
company.name as booked_company,
room.room_id as room_number,
room.floor_number as floor,
room.seat_capacity as seats,
start_time,
end_time

FROM presentation

INNER JOIN company
ON presentation.booked_company_id = company.company_id

INNER JOIN room
ON presentation.booked_room_id = room.room_id;

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
