import sys
from PyQt5.QtCore import QObject, pyqtSlot, pyqtProperty, QVariant, Qt, QPointF, pyqtSignal
from PyQt5.QtGui import QColor
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine

class Element(QObject):
    def __init__(self, element_type, x=0, y=0, rotation=0, color=QColor("black"), parent=None):
        super().__init__(parent)
        self._type = element_type
        self._x = x
        self._y = y
        self._rotation = rotation
        self._color = color

    @pyqtProperty(str)
    def type(self):
        return self._type

    @pyqtProperty(float)
    def x(self):
        return self._x

    @pyqtProperty(float)
    def y(self):
        return self._y

    @pyqtProperty(float)
    def rotation(self):
        return self._rotation

    @pyqtProperty(QColor)
    def color(self):
        return self._color

class MechanismDesigner(QObject):
    elementsChanged = pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self._elements = []

    @pyqtProperty(QVariant)
    def elements(self):
        return self._elements

    @pyqtSlot(str)
    def addElement(self, element_type):
        if element_type == "Link":
            qml_file = "qml/Link/Link.qml"
        elif element_type == "Joint":
            qml_file = "qml/Joint/Joint.qml"
        elif element_type == "Motor":
            qml_file = "qml/Motor/Motor.qml"
        else:
            return

        self._elements.append({
            'type': element_type,
            'qml_file': qml_file,
            'x': 100,
            'y': 100,
            'rotation': 0,
            'color': "blue" if element_type == "Link" else "red" if element_type == "Joint" else "green"
        })
        self.elementsChanged.emit()

    @pyqtSlot(QPointF)
    def selectElement(self, pos):
        # Логика выбора элемента
        pass

    @pyqtSlot()
    def simulate(self):
        print("Simulating Mechanism...")

    @pyqtSlot()
    def design(self):
        print("Designing Mechanism...")

if __name__ == '__main__':
    app = QApplication(sys.argv)

    engine = QQmlApplicationEngine()
    designer = MechanismDesigner()
    engine.rootContext().setContextProperty("designer", designer)
    engine.load('qml/main.qml')

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())