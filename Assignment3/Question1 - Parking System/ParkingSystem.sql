CREATE TABLE "ParkingLot" (
  "LotName" varchar PRIMARY KEY,
  "Location" varchar,
  "Capacity" integer,
  "NumLevels" integer
);

CREATE TABLE "ParkingSpace" (
  "SpaceNumber" integer PRIMARY KEY,
  "LotName" varchar,
  "IsOccupied" boolean,
  "ReservedBy" integer
);

CREATE TABLE "Staff" (
  "StaffID" integer PRIMARY KEY,
  "Name" varchar,
  "TelExtension" varchar,
  "VehicleLicense" varchar,
  "ReservedSpaceNum" integer
);

CREATE UNIQUE INDEX ON "ParkingSpace" ("LotName", "SpaceNumber");

ALTER TABLE "ParkingSpace" ADD FOREIGN KEY ("LotName") REFERENCES "ParkingLot" ("LotName");

ALTER TABLE "ParkingSpace" ADD FOREIGN KEY ("ReservedBy") REFERENCES "Staff" ("StaffID");

ALTER TABLE "Staff" ADD FOREIGN KEY ("ReservedSpaceNum") REFERENCES "ParkingSpace" ("SpaceNumber");