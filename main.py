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
    def __init__(self, parent=None):
        super().__init__(parent)
        self._elements = []

    @pyqtProperty(QVariant)
    def elements(self):
        return self._elements

    @pyqtSlot(str)
    def addElement(self, element_type):
        element = Element(element_type, 100, 100, 0, QColor("blue"))
        self._elements.append(element)
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

    elementsChanged = pyqtSignal()

if __name__ == '__main__':
    app = QApplication(sys.argv)

    engine = QQmlApplicationEngine()
    designer = MechanismDesigner()
    engine.rootContext().setContextProperty("designer", designer)
    engine.load('main.qml')

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())