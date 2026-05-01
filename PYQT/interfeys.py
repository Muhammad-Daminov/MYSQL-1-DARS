import json  # JSON bilan ishlash uchun
from PyQt5.QtWidgets import *
from PyQt5.QtCore import Qt

class RegistrationApp(QWidget):
    def __init__(self):
        super().__init__()
        self.joylar = {
            "Toshkent shahri": ["Chilonzor", "Yunusobod", "Mirzo Ulug'bek", "Yashnobod", "Shayxontohur", "Olmazor", "Sergeli", "Yakkasaroy", "Bektemir", "Mirobod", "Uchtepa"],
            "Toshkent viloyati": ["Chirchiq", "Angren", "Olmaliq", "Bekobod", "Piskent", "O'rtachirchiq", "Qibray", "Zangiota", "Bo'stonliq", "Parkent", "Chinoz"],
            "Andijon": ["Andijon sh.", "Asaka", "Shahrixon", "Xonobod", "Marhamat", "Oltinko'l", "Baliqchi", "Bo'ston", "Buloqboshi", "Izboskan", "Paxtaobod"],
            "Farg'ona": ["Farg'ona sh.", "Marg'ilon", "Qo'qon", "Quva", "Rishton", "Oltiariq", "Bog'dod", "Beshariq", "Uchko'prik", "Toshloq", "Yozyovon"],
            "Namangan": ["Namangan sh.", "Chust", "Pop", "Uychi", "Yangiqo'rg'on", "Kosonsoy", "Mingbuloq", "Norin", "To'raqo'rg'on", "Uchqo'rg'on"],
            "Samarqand": ["Samarqand sh.", "Pastdarg'om", "Bulung'ur", "Narpay", "Ishtixon", "Jomboy", "Kattaqo'rg'on", "Oqdaryo", "Payariq", "Urgut", "Toyloq"],
            "Buxoro": ["Buxoro sh.", "Gijduvon", "Kogon", "Qorako'l", "Olot", "Peshku", "Romitan", "Shofirkon", "Vobkent", "Jondor", "Qorovulbozor"],
            "Xorazm": ["Urganch sh.", "Xiva", "Gurlan", "Bog'ot", "Hazorasp", "Qo'shko'pir", "Shovot", "Yangiariq", "Yangibozor", "Tuproqqal'a"],
            "Surxondaryo": ["Termiz sh.", "Denov", "Sariosiyo", "Sherobod", "Jarqo'rg'on", "Boysun", "Qumqo'rg'on", "Sho'rchi", "Uzun", "Muzrabot"],
            "Qashqadaryo": ["Qarshi sh.", "Shahrisabz", "Kitob", "Chiroqchi", "G'uzor", "Dehqonobod", "Koson", "Muborak", "Nishon", "Qamashi", "Yakkabog'"],
            "Navoiy": ["Navoiy sh.", "Zarafshon", "Uchkuduk", "Karmana", "Qiziltepa", "Konimex", "Navbahor", "Nurota", "Tomdi", "Xatirchi"],
            "Jizzax": ["Jizzax sh.", "G'allaorol", "Zomin", "Do'stlik", "Arnasoy", "Baxmal", "Zafarobod", "Zarbdor", "Mirzachul", "Paxtakor", "Forish"],
            "Sirdaryo": ["Guliston sh.", "Shirin", "Yangiyer", "Boyovut", "Oqoltin", "Sardoba", "Sayxunobod", "Sirdaryo tum.", "Mirzaobod", "Xovos"],
            "Qoraqalpog'iston": ["Nukus sh.", "Mo'ynoq", "Xo'jayli", "Qo'ng'irot", "Beruniy", "To'rtko'l", "Amudaryo", "Ellikqal'a", "Kegeyli", "Chimboy", "Taxtako'pir"]
        }

        self.setStyleSheet("""
            QWidget {
                background-color: black ; 
                color: white; 
            }
            QLabel {
                color: white; 
                font-weight: bold;
                font-size: 13px;
                margin-top: 10px;
            }
            QLineEdit, QComboBox {
                background-color: #333 ;
                border: 2px solid #00FF00; /* Ramka yashil bo'lib qoladi */
                border-radius: 8px;
                padding: 10px;
                font-size: 15px;
                color: white;
            }
            QLineEdit:focus {
                border: 2px solid #333; 
            }
            QPushButton {
                background-color: #00AA00 ;
                color: white;
                border-radius: 10px;
                padding: 12px;
                font-weight: bold;
                font-size: 16px;
            }
            QPushButton:hover {
                background-color: #00CC00;
            }
            QPushButton#exitBtn {
                background-color: #FF4D4D;
            }
        """)

        layout = QVBoxLayout()
        layout.setContentsMargins(30, 20, 30, 20)

        layout.addWidget(QLabel("SHAXSIY MA'LUMOTLAR"))
        
        self.name_edit = QLineEdit()
        self.name_edit.setPlaceholderText("Ism")
        layout.addWidget(self.name_edit)

        self.surname_edit = QLineEdit()
        self.surname_edit.setPlaceholderText("Familiya")
        layout.addWidget(self.surname_edit)

        layout.addWidget(QLabel("YASHASH MANZILI MA'LUMOTLARI"))
        
        self.city_combo = QComboBox()
        self.city_combo.addItem(" Viloyatni tanlang ")
        self.city_combo.addItems(sorted(self.joylar.keys()))
        layout.addWidget(self.city_combo)

        self.district_combo = QComboBox()
        self.district_combo.setEnabled(False)
        layout.addWidget(self.district_combo)

        self.address_edit = QLineEdit()
        self.address_edit.setPlaceholderText("Ko'cha va uy raqami")
        layout.addWidget(self.address_edit)

        layout.addStretch()

        # Tugmalar
        btn_layout = QHBoxLayout()
        self.btn_submit = QPushButton("SUBMIT")
        self.btn_exit = QPushButton("EXIT")
        self.btn_exit.setObjectName("exitBtn")
        
        btn_layout.addWidget(self.btn_submit)
        btn_layout.addWidget(self.btn_exit)
        layout.addLayout(btn_layout)

        self.city_combo.currentIndexChanged.connect(self.update_districts)
        self.btn_exit.clicked.connect(self.close)
        # Submit tugmasini funksiyaga bog'ladik
        self.btn_submit.clicked.connect(self.submit_to_json)

        self.setLayout(layout)
        self.setWindowTitle("Royxatdan otish")
        self.setFixedSize(400, 600)

    def update_districts(self):
        shahar = self.city_combo.currentText()
        if shahar in self.joylar:
            self.district_combo.clear()
            self.district_combo.addItems(self.joylar[shahar])
            self.district_combo.setEnabled(True)
        else:
            self.district_combo.clear()
            self.district_combo.setEnabled(False)

    # Yangi qo'shilgan funksiya
    def submit_to_json(self):
        user_data = {
            "name": self.name_edit.text(),
            "surname": self.surname_edit.text(),
            "city": self.city_combo.currentText(),
            "district": self.district_combo.currentText(),
            "address": self.address_edit.text()
        }

        # Faylni ochish va saqlash mantiqi
        try:
            with open("users.json", "r", encoding="utf-8") as file:
                data = json.load(file)
        except:
            data = []

        data.append(user_data)

        with open("users.json", "w", encoding="utf-8") as file:
            json.dump(data, file, indent=4, ensure_ascii=False)
        
        QMessageBox.information(self, "Muvaffaqiyat", "Royhatdan muvaffaqiyatli otdingiz!")



        self.name_edit.clear()          
        self.surname_edit.clear()        
        self.address_edit.clear()        
        self.city_combo.setCurrentIndex(0) 
        self.district_combo.clear()      
        self.district_combo.setEnabled(False)

app = QApplication([])
win = RegistrationApp()
win.show()
app.exec_()