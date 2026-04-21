from PyQt5.QtWidgets import QApplication, QWidget, QLabel, QLineEdit, QPushButton

class MyWindow(QWidget):
    def __init__(self):
        super().__init__()
        self.setStyleSheet("font-size:20px")

        self.red_btn = QPushButton("RED",self)
        self.red_btn.move(50,50)
        # self.red_btn.clicked.connect(self.Red)
        self.red_btn.clicked.connect(lambda: self.Rang(self.red_btn))

        self.yellow_btn = QPushButton("YELLOW",self)
        self.yellow_btn.move(50, 150)
        # self.yellow_btn.clicked.connect(self.Yellow)
        self.red_btn.clicked.connect(lambda: self.Rang(self.yellow_btn))

        self.green_btn = QPushButton("GREEN",self)
        self.green_btn.move(50, 250)
        # self.green_btn.clicked.connect(self.Green)
        self.red_btn.clicked.connect(lambda: self.Rang(self.green_btn))


    # def Red(self):
    #     self.setStyleSheet("background:red")
    
    # def Yellow(self):
    #     self.setStyleSheet("background:yellow")
    
    # def Green(self):
    #     self.setStyleSheet("background:green")

    def Rang(self, obj):
        if obj == self.red_btn:
            print(obj.text())
        elif obj == self.yellow_btn:
            pass
        else:
            pass


app = QApplication([])
win = MyWindow()
win.show()
app.exec_()
