use tour;
CREATE TABLE Users (
    ID INT(10) PRIMARY KEY AUTO_INCREMENT,
    users_name VARCHAR(200) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL ,
    email VARCHAR(40) UNIQUE,
    tel VARCHAR(20),
    fullname VARCHAR(40) NOT NULL,
    position VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Customer Table
CREATE TABLE Customer (
    ID INT(10) PRIMARY KEY AUTO_INCREMENT,
    fullname VARCHAR(200) NOT NULL,
    tel VARCHAR(11) NOT NULL,
    address VARCHAR(200),
    email VARCHAR(60) UNIQUE,
    idCardnumber VARCHAR(12) UNIQUE,
    dob DATE,
    note VARCHAR(2000),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 3. Tour Table
CREATE TABLE Tour (
    ID INT(10) PRIMARY KEY AUTO_INCREMENT,
    nameTour VARCHAR(200) NOT NULL,
    describes TEXT,
    price DECIMAL(20,2) NOT NULL,
    departurePoint VARCHAR(100) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    numberOfDays INT(10) NOT NULL,
    departureDate DATE NOT NULL,
    note TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 4. Service Table
CREATE TABLE Service (
    ID INT(10) PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL,
    unit INT(20) NOT NULL ,
    price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 5. Booking Table
CREATE TABLE Booking (
    ID INT(10) PRIMARY KEY AUTO_INCREMENT,
    bookingDate DATE NOT NULL,
    discount DECIMAL(20,2) ,
    note TEXT,
    UsersID INT(10) NOT NULL,
    CustomerID INT(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UsersID) REFERENCES Users(ID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(ID)
) ENGINE=InnoDB;

-- 6. BookedTour Table
CREATE TABLE BookedTour (
    ID INT(10) PRIMARY KEY AUTO_INCREMENT,
    number INT(10) NOT NULL ,
    price DECIMAL(20,2) NOT NULL,
    note TEXT,
    TourID INT(10) NOT NULL,
    BookingID INT(10) NOT NULL,
    FOREIGN KEY (TourID) REFERENCES Tour(ID),
    FOREIGN KEY (BookingID) REFERENCES Booking(ID)
) ENGINE=InnoDB;

-- 7. UserService Table
CREATE TABLE UserService (
    ID INT(10) PRIMARY KEY AUTO_INCREMENT,
    quantity INT(10) NOT NULL ,
    discount DECIMAL(20,2) DEFAULT 0.00,
    BookedTourID INT(10) NOT NULL,
    ServiceID INT(10) NOT NULL,
    FOREIGN KEY (BookedTourID) REFERENCES BookedTour(ID),
    FOREIGN KEY (ServiceID) REFERENCES Service(ID)
) ENGINE=InnoDB;

-- 8. Bill Table
CREATE TABLE Bill (
    ID INT(10) PRIMARY KEY AUTO_INCREMENT,
    paymentMethod VARCHAR(40) NOT NULL,
    paymentAmount DECIMAL(20,2) NOT NULL,
    paymentDate DATE NOT NULL,
    note TEXT,
    BookingID INT(10) NOT NULL,
    UsersID INT(10) NOT NULL,
    FOREIGN KEY (BookingID) REFERENCES Booking(ID),
    FOREIGN KEY (UsersID) REFERENCES Users(ID)
) ENGINE=InnoDB;

-- 9. Evaluate Table (corrected from Evolutate)
CREATE TABLE Evaluate (
    ID INT(10) PRIMARY KEY AUTO_INCREMENT,
    evaluate INT(2) NOT NULL CHECK (evaluate BETWEEN 1 AND 10),
    comment VARCHAR(200),
    assessmentDate DATE NOT NULL,
    TourID INT(10) NOT NULL,
    UsersID INT(10) NOT NULL,
    FOREIGN KEY (TourID) REFERENCES Tour(ID),
    FOREIGN KEY (UsersID) REFERENCES Users(ID)
) ENGINE=InnoDB;

-- 10. TourSchedules Table
CREATE TABLE TourSchedules (
    ID INT(5) PRIMARY KEY AUTO_INCREMENT,
    day INT(2) NOT NULL,
    startTime TIME NOT NULL,
    endTime TIME NOT NULL,
    tourProgram TEXT NOT NULL,
    address TEXT NOT NULL,
    note TEXT,
    TourID INT(10) NOT NULL,
    FOREIGN KEY (TourID) REFERENCES Tour(ID)
) ENGINE=InnoDB;