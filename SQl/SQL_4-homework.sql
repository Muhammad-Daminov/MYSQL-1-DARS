import pymysql

connection = pymysql.connect(
    host='localhost',
    user='root',
    password='1234',  
    database='test_db',        
    cursorclass=pymysql.cursors.DictCursor
)

try:
    with connection.cursor() as cursor:

        cursor.execute("DROP TABLE IF EXISTS Company;")

        cursor.execute("""
        CREATE TABLE Company (
            id INT PRIMARY KEY AUTO_INCREMENT,
            name VARCHAR(100),
            location VARCHAR(100),
            capital INT,
            employees_count INT,
            establishedAt DATE,
            monthly_expenses INT
        );
        """)

        cursor.execute("""
        INSERT INTO Company (name, location, capital, employees_count, establishedAt, monthly_expenses)
        VALUES
        ('AlphaTech', 'Tashkent', 500000, 120, '2015-06-15', 20000),
        ('BetaSoft', 'Samarkand', 300000, 80, '2018-03-10', 15000),
        ('GammaCorp', 'Tashkent', 800000, 200, '2012-01-20', 30000),
        ('DeltaGroup', 'Bukhara', 250000, 50, '2020-07-05', 10000),
        ('Epsilon LLC', 'Tashkent', 600000, 150, '2016-09-25', 22000);
        """)

        connection.commit()

        # 1
        cursor.execute("""
        SELECT * FROM Company
        ORDER BY name ASC;
        """)
        print("\n1. Alphabetical:")
        for row in cursor.fetchall():
            print(row)

        # 2
        cursor.execute("""
        SELECT * FROM Company
        ORDER BY capital DESC;
        """)
        print("\n2. Capital DESC:")
        for row in cursor.fetchall():
            print(row)

        # 3
        cursor.execute("""
        SELECT * FROM Company
        ORDER BY employees_count ASC
        LIMIT 1;
        """)
        print("\n3. Least employees:")
        for row in cursor.fetchall():
            print(row)

        # 4
        cursor.execute("""
        SELECT * FROM Company
        WHERE location = 'Tashkent';
        """)
        print("\n4. Tashkent companies:")
        for row in cursor.fetchall():
            print(row)

        # 5
        cursor.execute("""
        SELECT location, COUNT(*) AS count
        FROM Company
        GROUP BY location;
        """)
        print("\n5. Companies per location:")
        for row in cursor.fetchall():
            print(row)

        # 6 (oddiy usul bilan)
        cursor.execute("""
        SELECT 
            name,
            (YEAR(CURDATE()) - YEAR(establishedAt)) * 12 * monthly_expenses AS total_expense
        FROM Company;
        """)
        print("\n6. Total expenses:")
        for