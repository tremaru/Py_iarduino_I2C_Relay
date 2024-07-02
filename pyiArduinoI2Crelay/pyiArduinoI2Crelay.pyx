# distutils: language = c++
# cython: language_level = 3
#encoding = utf-8
DEF_CHIP_ID =   0x3C
DEF_MODEL_2RM = 0x0A
DEF_MODEL_4RT = 0x0B
DEF_MODEL_4NC = 0x0C
DEF_MODEL_4PC = 0x0D
DEF_MODEL_4NP = 0x0E
DEF_MODEL_4PP = 0x0F
#   Адреса регистров модулей
REG_FLAGS_0 =0x00
REG_BITS_0 = 0x01
REG_FLAGS_1 = 0x02
REG_BITS_1 = 0x03
REG_MODEL = 0x04
REG_VERSION = 0x05
REG_ADDRESS = 0x06
REG_CHIP_ID = 0x07
REG_FREQUENCY_L = 0x08
REG_FREQUENCY_H = 0x09
REG_AVERAGING   = 0x0A
REG_SHUNT = 0x0B
REG_FLG = 0x10
REG_BIT = 0x11
REG_DIGITAL_ALL = 0x12
REG_DIGITAL_ONE = 0x13
REG_PWM = 0x14
REG_ADC = 0x1C
REG_CURRENT = 0x24
REG_LIMIT = 0x2C
FLG_A_OFF = 0
FLG_A_MAX = 4
BIT_A_OFF = 0
BIT_A_MAX = 4
BIT_WRITE_L = 0
BIT_WRITE_H = 4
ALL_CHANNEL = 0xFF
CURRENT_LIMIT = 0xFF
CURRENT_DISABLE = 0x00
HIGH = 0x01
LOW = 0x00

from iarduino_I2C_Relay cimport iarduino_I2C_Relay

cdef class pyiArduinoI2Crelay:
    cdef iarduino_I2C_Relay c_module

    def __cinit__(self, address=None, auto=None, bus=None):

        if address is not None:

            self.c_module = iarduino_I2C_Relay(address)

            if bus is not None:
                self.changeBus(bus)

            if auto is None:
                #sleep(.5)
                if not self.c_module.begin():

                    print("ошибка инициализации модуля.\n"
                          "Проверьте подключение и адрес модуля,"
                          " возможно не включен интерфейс I2C.\n"
                          " Запустите raspi-config и включите интерфейс"
                          ", инструкция по включению:"
                          " https://wiki.iarduino.ru/page/raspberry-i2c-spi/")

        else:

            self.c_module = iarduino_I2C_Relay()

            if bus is not None:
                self.changeBus(bus)

            if auto is None:
                #sleep(.5)
                if not self.c_module.begin():

                    print("ошибка инициализации модуля.\n"
                          "Проверьте подключение и адрес модуля, "
                          " возможно не включен интерфейс I2C.\n"
                          " Запустите raspi-config и включите интерфейс"
                          ", инструкция по включению:"
                          " https://wiki.iarduino.ru/page/raspberry-i2c-spi/")

    def begin(self):
        return self.c_module.begin()

    def changeAddress(self, unsigned char newAddr):
        return self.c_module.changeAddress(newAddr)

    def reset(self):
        return self.c_module.reset()

    def getAddress(self):
        return self.c_module.getAddress()

    def getVersion(self):
        return self.c_module.getVersion()

    def getModel(self):
        return self.c_module.getModel()

    def digitalWrite(self, unsigned char channel, unsigned char level):
        self.c_module.digitalWrite(channel, level)

    def digitalRead(self, unsigned char channel):
        return self.c_module.digitalRead(channel)
    
    def analogWrite(self, unsigned char channel, unsigned short level):
        self.c_module.analogWrite(channel, level)

    def analogRead(self, unsigned char channel):
        return self.c_module.analogRead(channel)

    def analogAveraging(self, unsigned char coefficient):
        self.c_module.analogAveraging(coefficient)

    def freqPWM(self, unsigned short frequency):
        self.c_module.freqPWM(frequency)

    def currentWrite(self, unsigned char channel, float current, Rsh=None):
        if Rsh is not None:
            self.c_module.currentWrite(channel, current, Rsh)
        else:
            self.c_module.currentWrite(channel, current)

    def currentRead(self,unsigned char channel):
        return self.c_module.currentRead(channel)

    def setCurrentProtection(self, unsigned char channel, float current, unsigned char rtype):
        self.c_module.setCurrentProtection(channel, current, rtype)

    def getCurrentProtection(self, unsigned char channel):
        return self.c_module.getCurrentProtection(channel)

    def delCurrentProtection(self, unsigned char channel):
        self.c_module.delCurrentProtection(channel)

    def resCurrentProtection(self, unsigned char channel):
        self.c_module.resCurrentProtection(channel)

    def enableWDT(self, unsigned char time):
        return self.c_module.enableWDT(time)

    def disableWDT(self):
        return self.c_module.disableWDT()

    def resetWDT(self):
        return self.c_module.resetWDT()

    def getStateWDT(self):
        return self.c_module.getStateWDT()

    def changeBus(self, bus):
        return self.c_module.changeBus(bytes(bus, 'utf-8'))
