PetOwners ↔ Pets (1:N): 한 명의 주인이 여러 반려동물을 소유
Pets ↔ Reservations (1:N): 한 마리의 반려동물이 여러 번 예약 가능
Rooms ↔ Reservations (1:N): 한 객실이 여러 예약을 받을 수 있음
Reservations ↔ Services (1:N): 한 예약에 여러 서비스 추가 가능

-- 반려동물 호텔 예약 시스템 데이터베이스 생성
CREATE DATABASE PetHotelDB;
USE PetHotelDB;

-- 1. PetOwners 테이블 생성 (반려동물 주인)
CREATE TABLE PetOwners (
    ownerID INT AUTO_INCREMENT PRIMARY KEY COMMENT '고객 고유 ID (자동 증가, 기본키)',
    name VARCHAR(100) NOT NULL COMMENT '고객 이름',
    contact VARCHAR(50) NOT NULL COMMENT '고객 연락처'
);

-- 2. Rooms 테이블 생성 (객실) - 외래키 참조가 없으므로 먼저 생성
CREATE TABLE Rooms (
    roomID INT AUTO_INCREMENT PRIMARY KEY COMMENT '객실 고유 ID (자동 증가, 기본키)',
    roomNumber VARCHAR(20) NOT NULL UNIQUE COMMENT '객실 번호',
    roomType VARCHAR(50) NOT NULL COMMENT '객실 타입 (스탠다드, 디럭스 등)',
    pricePerNight DECIMAL(10, 2) NOT NULL COMMENT '1박당 가격'
);

-- 3. Pets 테이블 생성 (반려동물)
CREATE TABLE Pets (
    petID INT AUTO_INCREMENT PRIMARY KEY COMMENT '반려동물 고유 ID (자동 증가, 기본키)',
    ownerID INT NOT NULL COMMENT '반려동물의 주인 ID (외래키)',
    name VARCHAR(100) NOT NULL COMMENT '반려동물 이름',
    species VARCHAR(50) NOT NULL COMMENT '종 (개, 고양이 등)',
    breed VARCHAR(100) COMMENT '품종',
    FOREIGN KEY (ownerID) REFERENCES PetOwners(ownerID) ON DELETE CASCADE
);

-- 4. Reservations 테이블 생성 (예약)
CREATE TABLE Reservations (
    reservationID INT AUTO_INCREMENT PRIMARY KEY COMMENT '예약 고유 ID (자동 증가, 기본키)',
    petID INT NOT NULL COMMENT '예약된 반려동물 ID (외래키)',
    roomID INT NOT NULL COMMENT '예약된 객실 ID (외래키)',
    startDate DATE NOT NULL COMMENT '예약 시작 날짜',
    endDate DATE NOT NULL COMMENT '예약 종료 날짜',
    FOREIGN KEY (petID) REFERENCES Pets(petID) ON DELETE CASCADE,
    FOREIGN KEY (roomID) REFERENCES Rooms(roomID) ON DELETE CASCADE,
    CONSTRAINT check_date_range CHECK (endDate >= startDate)
);

-- 5. Services 테이블 생성 (서비스)
CREATE TABLE Services (
    serviceID INT AUTO_INCREMENT PRIMARY KEY COMMENT '서비스 고유 ID (자동 증가, 기본키)',
    reservationID INT NOT NULL COMMENT '예약 ID (외래키)',
    serviceName VARCHAR(100) NOT NULL COMMENT '서비스 이름 (목욕, 산책 등)',
    servicePrice DECIMAL(10, 2) NOT NULL COMMENT '서비스 가격',
    FOREIGN KEY (reservationID) REFERENCES Reservations(reservationID) ON DELETE CASCADE
);

-- 인덱스 생성 (성능 향상을 위한 추가 인덱스)
CREATE INDEX idx_pets_owner ON Pets(ownerID);
CREATE INDEX idx_reservations_pet ON Reservations(petID);
CREATE INDEX idx_reservations_room ON Reservations(roomID);
CREATE INDEX idx_reservations_date ON Reservations(startDate, endDate);
CREATE INDEX idx_services_reservation ON Services(reservationID);

-- 샘플 데이터 삽입
-- 반려동물 주인 데이터
INSERT INTO PetOwners (name, contact) VALUES 
('김철수', '010-1234-5678'),
('이영희', '010-2345-6789'),
('박민수', '010-3456-7890');

-- 객실 데이터
INSERT INTO Rooms (roomNumber, roomType, pricePerNight) VALUES 
('101', '스탠다드', 50000.00),
('102', '스탠다드', 50000.00),
('201', '디럭스', 80000.00),
('202', '디럭스', 80000.00),
('301', '스위트', 120000.00);

-- 반려동물 데이터
INSERT INTO Pets (ownerID, name, species, breed) VALUES 
(1, '바둑이', '개', '진돗개'),
(1, '나비', '고양이', '코숏'),
(2, '멍멍이', '개', '골든리트리버'),
(3, '야옹이', '고양이', '페르시안');

-- 예약 데이터
INSERT INTO Reservations (petID, roomID, startDate, endDate) VALUES 
(1, 1, '2025-07-01', '2025-07-03'),
(2, 2, '2025-07-05', '2025-07-07'),
(3, 3, '2025-07-10', '2025-07-12');

-- 서비스 데이터
INSERT INTO Services (reservationID, serviceName, servicePrice) VALUES 
(1, '목욕 서비스', 30000.00),
(1, '산책 서비스', 20000.00),
(2, '미용 서비스', 50000.00),
(3, '목욕 서비스', 30000.00);

-- 테이블 구조 확인
SHOW TABLES;
DESCRIBE PetOwners;
DESCRIBE Pets;
DESCRIBE Rooms;
DESCRIBE Reservations;
DESCRIBE Services;
