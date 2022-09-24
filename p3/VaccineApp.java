import java.sql.*;
import java.util.Scanner;
import java.text.SimpleDateFormat;

class VaccineApp {
    public static void main (String [] args) throws SQLException {
        Connection con = connectToDb();

        // For add person
        PreparedStatement queryPersonStmt = con.prepareStatement(
            "SELECT hinsurnum FROM People WHERE hinsurnum = ?"
        );
        PreparedStatement insertPersonStmt = con.prepareStatement(
            "INSERT INTO People VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        );
        PreparedStatement updatePersonStmt = con.prepareStatement(
            "UPDATE People\n" +
            "SET name = ?,\n" +
            "    phone = ?,\n" +
            "    city = ?,\n" +
            "    streetaddr = ?,\n" +
            "    postalcode = ?,\n" +
            "    dateofbirth = ?,\n" +
            "    gender = ?,\n" +
            "    regdate = ?,\n" +
            "    cname = ?\n" +
            "WHERE hinsurnum = ?\n"
        );

        // For assign slot
        PreparedStatement personNumSlotsStmt = con.prepareStatement(
            "SELECT count(*) AS numAllocSlots\n" +
            "FROM Slots, People\n" +
            "WHERE Slots.hinsurnum = People.hinsurnum\n" +
            "  AND Slots.hinsurnum = ?"
        );
        PreparedStatement personVaccineDosesStmt = con.prepareStatement(
            "SELECT DISTINCT numdoses\n" +
            "FROM Slots, People, Vials, Vaccines\n" +
            "WHERE Slots.hinsurnum = People.hinsurnum\n" +
            "  AND Slots.vname = Vials.name\n" +
            "  AND Slots.batchnum = Vials.batchnum\n" +
            "  AND Slots.num = Vials.num\n" +
            "  AND Vials.name = Vaccines.name\n" +
            "  AND Slots.hinsurnum = ?"
        );
        PreparedStatement freeSlotStmt = con.prepareStatement(
            "SELECT *\n" +
            "FROM Slots\n" +
            "WHERE Slots.date >= CURRENT_DATE\n" +
            "  AND Slots.hinsurnum is null\n" +
            "  AND Slots.locname = ?\n" +
            "  AND Slots.date = ?\n" +
            "  AND Slots.time = ?\n" +
            "  AND Slots.tentnum = ?"
        );
        PreparedStatement allocateSlotStmt = con.prepareStatement(
            "UPDATE Slots SET\n" +
            "(hinsurnum, allocdate) = (?, ?)\n" +
            "WHERE Slots.locname = ? AND Slots.date = ? AND Slots.time = ? AND Slots.tentnum = ?"
        );

        // Enter Vaccine Info
        PreparedStatement personVaccineStmt = con.prepareStatement(
            "SELECT vname\n" +
            "FROM People, Slots\n" +
            "WHERE People.hinsurnum = Slots.hinsurnum\n" +
            "  AND People.hinsurnum = (\n" +
            "    SELECT hinsurnum\n" +
            "    FROM Slots\n" +
            "    WHERE Slots.locname = ?\n" +
            "      AND Slots.date = ?\n" +
            "      AND Slots.time = ?\n" +
            "      AND Slots.tentnum = ?\n" +
            ")"
        );
        PreparedStatement nurseVialToSlotStmt = con.prepareStatement(
            "UPDATE Slots SET\n" +
            "(licenseno, vname, batchnum, num) = (?, ?, ?, ?)\n" +
            "WHERE Slots.locname = ? AND Slots.date = ? AND Slots.time = ? AND Slots.tentnum = ?"
        );

        Scanner sc = new Scanner(System.in);
        while (true) {
            System.out.print(
                "Vaccine Main Menu: \n"
                + "\t1. Add a Person\n"
                + "\t2. Assign a slot to a Person\n"
                + "\t3. Enter Vaccination Information\n"
                + "\t4. Exit Application\n"
                + "Please Enter Your Option: "
            );

            String option = sc.nextLine();
            if (option.equals("1")) {
                String hinsurnum = prompt(sc, "Health insurance number: ");
                String name = prompt(sc, "Name: ");
                String phone = prompt(sc, "Phone (leave empty for null): ");
                String city = prompt(sc, "City (leave empty for null): ");
                String streetaddr = prompt(sc, "Street Address (leave empty for null): ");
                String postalcode = prompt(sc, "Postal Code (leave empty for null): ");
                String dateofbirth = prompt(sc, "Date of Birth (month/day/year): ");
                String gender = prompt(sc, "Gender (i.e. male, female, other): ");
                String regdate = prompt(sc, "Registration date (month/day/year): ");
                String cname = prompt(sc, "Category name: ");

                if (phone.equals("")) {
                    phone = null;
                }
                if (city.equals("")) {
                    city = null;
                }
                if (streetaddr.equals("")) {
                    streetaddr = null;
                }
                if (postalcode.equals("")) {
                    postalcode = null;
                }

                addPerson(
                    sc,
                    queryPersonStmt,
                    insertPersonStmt,
                    updatePersonStmt,
                    hinsurnum,
                    name,
                    phone,
                    city,
                    streetaddr,
                    postalcode,
                    dateofbirth,
                    gender,
                    regdate,
                    cname
                );
            } else if (option.equals("2")) {
                String hinsurnum = prompt(sc, "Health insurance number: ");
                SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
                String allocdate = formatter.format(new java.util.Date());
                String locname = prompt(sc, "Vaccine location name: ");
                String date = prompt(sc, "Slot date: ");
                String time = prompt(sc, "Slot time: ");
                String tentnum = prompt(sc, "Tent number: ");

                assignSlot(
                    personNumSlotsStmt,
                    personVaccineDosesStmt,
                    freeSlotStmt,
                    allocateSlotStmt,
                    hinsurnum,
                    allocdate,
                    locname,
                    date,
                    time,
                    tentnum
                );
            } else if (option.equals("3")) {
                String locname = prompt(sc, "Vaccination location name: ");
                String date = prompt(sc, "Slot date: ");
                String time = prompt(sc, "Slot time: ");
                String tentnum = prompt(sc, "Tent number: ");
                String licenseno = prompt(sc, "Nurse license number: ");
                String vname = prompt(sc, "Vaccine name: ");
                String batchnum = prompt(sc, "Batch number: ");
                String num = prompt(sc, "Vial number: ");

                enterVaccineInfo(
                    personVaccineStmt,
                    nurseVialToSlotStmt,
                    locname,
                    date,
                    time,
                    tentnum,
                    licenseno,
                    vname,
                    batchnum,
                    num
                );
            } else if (option.equals("4")) {
                insertPersonStmt.close();
                con.close();
                System.out.println("Disconnected from database.");
                System.out.println("Exited.");
                System.exit(0);
            } else {
                System.out.println("Invalid command, please try again.");
                System.out.println(option);
            }
        }
    }

    public static void addPerson(
        Scanner sc,
        PreparedStatement queryPersonStmt,
        PreparedStatement insertPersonStmt,
        PreparedStatement updatePersonStmt,
        String hinsurnum,
        String name,
        String phone,
        String city,
        String streetaddr,
        String postalcode,
        String dateofbirth,
        String gender,
        String regdate,
        String cname
    ) throws SQLException {
        try {
            queryPersonStmt.setString(1, hinsurnum);
            ResultSet rs = queryPersonStmt.executeQuery();
            if (rs.next()) { // if hinsurnum exists
                System.out.println(
                    "A person already exists with this hinsurnum. Do you want to update this person's info?"
                    + "\nType anything before pressing enter for yes (just press enter for no):"
                );
                String yes = sc.nextLine();
                if (yes.length() > 0) {
                    updatePersonStmt.setString(1, name);
                    updatePersonStmt.setString(2, phone);
                    updatePersonStmt.setString(3, city);
                    updatePersonStmt.setString(4, streetaddr);
                    updatePersonStmt.setString(5, postalcode);
                    updatePersonStmt.setString(6, dateofbirth);
                    updatePersonStmt.setString(7, gender);
                    updatePersonStmt.setString(8, regdate);
                    updatePersonStmt.setString(9, cname);
                    updatePersonStmt.setString(10, hinsurnum);
                    updatePersonStmt.executeUpdate();
                    System.out.println("Update person DONE");
                } else {
                    System.out.println("Didn't update.");
                }
            } else {
                insertPersonStmt.setString(1, hinsurnum);
                insertPersonStmt.setString(2, name);
                insertPersonStmt.setString(3, phone);
                insertPersonStmt.setString(4, city);
                insertPersonStmt.setString(5, streetaddr);
                insertPersonStmt.setString(6, postalcode);
                insertPersonStmt.setString(7, dateofbirth);
                insertPersonStmt.setString(8, gender);
                insertPersonStmt.setString(9, regdate);
                insertPersonStmt.setString(10, cname);
                insertPersonStmt.executeUpdate();
                System.out.println("Add person DONE");
            }
        } catch (SQLException e) {
            System.out.println("Code: " + e.getErrorCode() + "  sqlState: " + e.getSQLState());
            System.out.println(e);
        }
    }

    public static void assignSlot(
        PreparedStatement personNumSlotsStmt,
        PreparedStatement personVaccineDosesStmt,
        PreparedStatement freeSlotStmt,
        PreparedStatement allocateSlotStmt,
        String hinsurnum,
        String allocdate,
        String locname,
        String date,
        String time,
        String tentnum
    ) throws SQLException { // to a person
        try {
            // 1st error check
            personNumSlotsStmt.setString(1, hinsurnum);
            ResultSet rs = personNumSlotsStmt.executeQuery();
            rs.next();
            int numAllocSlots = rs.getInt("numAllocSlots");

            personVaccineDosesStmt.setString(1, hinsurnum);
            rs = personVaccineDosesStmt.executeQuery();
            if (rs.next()) {
                int maxDoses = rs.getInt("numDoses");

                if (numAllocSlots >= maxDoses) {
                    System.out.println("This person has been given/reserved the required number of shots.");
                    return;
                }
            }

            // 2nd error check
            freeSlotStmt.setString(1, locname);
            freeSlotStmt.setString(2, date);
            freeSlotStmt.setString(3, time);
            freeSlotStmt.setString(4, tentnum);
            if (!freeSlotStmt.executeQuery().next()) {
                System.out.println("This slot does not exist, is not free, or has expired.");
                return;
            }

            // Actual assigning slot
            allocateSlotStmt.setString(1, hinsurnum);
            allocateSlotStmt.setString(2, allocdate);
            allocateSlotStmt.setString(3, locname);
            allocateSlotStmt.setString(4, date);
            allocateSlotStmt.setString(5, time);
            allocateSlotStmt.setString(6, tentnum);
            allocateSlotStmt.executeUpdate();
            System.out.println("Assign person to slot DONE");
        } catch (SQLException e) {
            System.out.println("Code: " + e.getErrorCode() + "  sqlState: " + e.getSQLState());
            System.out.println(e);
        }
    }

    public static void enterVaccineInfo(
        PreparedStatement personVaccineStmt,
        PreparedStatement nurseVialToSlotStmt,
        String locname,
        String date,
        String time,
        String tentnum,
        String licenseno,
        String vname,
        String batchnum,
        String num
    ) throws SQLException {
        try {
            personVaccineStmt.setString(1, locname);
            personVaccineStmt.setString(2, date);
            personVaccineStmt.setString(3, time);
            personVaccineStmt.setString(4, tentnum);
            ResultSet rs = personVaccineStmt.executeQuery();

            String personVaccine = null;
            while (personVaccine == null && rs.next()) {
                personVaccine = rs.getString("vname");
            }

            if (personVaccine == null || vname.equals(personVaccine)) {
                nurseVialToSlotStmt.setString(1, licenseno);
                nurseVialToSlotStmt.setString(2, vname);
                nurseVialToSlotStmt.setString(3, batchnum);
                nurseVialToSlotStmt.setString(4, num);
                nurseVialToSlotStmt.setString(5, locname);
                nurseVialToSlotStmt.setString(6, date);
                nurseVialToSlotStmt.setString(7, time);
                nurseVialToSlotStmt.setString(8, tentnum);
                nurseVialToSlotStmt.executeUpdate();
                System.out.println("Assign nurse and vial to slot DONE");
            } else {
                System.out.println("This person has used/reserved a different vaccine already.");
            }
        } catch (SQLException e) {
            System.out.println("Code: " + e.getErrorCode() + "  sqlState: " + e.getSQLState());
            System.out.println(e);
        }
    }

    public static String prompt(Scanner sc, String msg) {
        System.out.print(msg);
        return sc.nextLine().trim();
    }

    public static Connection connectToDb() throws SQLException {
        System.out.print("Connecting to database... ");

        try {
            DriverManager.registerDriver(new com.ibm.db2.jcc.DB2Driver());
        }
        catch (Exception e){
            System.out.println("Class not found");
        }

        // This is the url you must use for DB2.
        String url = System.getenv("SOCSURL"); // jdbc:db2://localhost:6666/cs421
        // "jdbc:db2://winter2021-comp421.cs.mcgill.ca:50000/cs421";

        // REMEMBER to remove your user id and password before submitting your code!!
        String your_userid = null;
        String your_password = null;
        // AS AN ALTERNATIVE, you can just set your password in the shell environment in the Unix (as shown below) and read it from there.
        // $  export SOCSPASSWD=yoursocspasswd
        if (your_userid == null && (your_userid = System.getenv("SOCSUSER")) == null) {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }
        if (your_password == null && (your_password = System.getenv("SOCSPASSWD")) == null) {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }
        Connection con = DriverManager.getConnection(url, your_userid, your_password);

        System.out.println("Connected.");
        return con;
    }
}