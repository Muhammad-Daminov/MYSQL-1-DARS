
from PyQt5.QtWidgets import QApplication, QWidget, QVBoxLayout, QLineEdit, QPushButton, QGridLayout
from PyQt5.QtCore import Qt

app = QApplication([])

win = QWidget()
win.setWindowTitle("Smart Calculator")
win.resize(300, 400)

layout = QVBoxLayout()


display = QLineEdit()
display.setAlignment(Qt.AlignRight)
display.setPlaceholderText("0")

layout.addWidget(display)


grid = QGridLayout()

buttons = [
    "7", "8", "9", "/",
    "4", "5", "6", "*",
    "1", "2", "3", "-",
    "0", "C", "=", "+"
]

def click(btn):
    text = display.text()

    if btn == "C":
        display.clear()

    elif btn == "=":
        try:
            result = eval(text)
            display.setText(str(result))
        except ZeroDivisionError:
            display.setText("Error: /0")
        except:
            display.setText("Error")

    else:
        display.setText(text + btn)

for i, b in enumerate(buttons):
    button = QPushButton(b)
    button.clicked.connect(lambda _, x=b: click(x))
    grid.addWidget(button, i // 4, i % 4)

layout.addLayout(grid)
win.setLayout(layout)

win.show()
app.exec_()
