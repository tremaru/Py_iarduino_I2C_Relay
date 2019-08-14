# Данный пример постоянно меняет сигнал ШИМ на 3 канале модуля.    
                                     # * Строки со звёздочкой являются необязательными.
import numpy as np
import math as m
from time import sleep               #   Подключаем метод sleep их модуля time
from pyiArduinoI2Crelay import *     #   Подключаем модуль для работы с ключём
pwrkey = pyiArduinoI2Crelay(0x09)    #   Объявляем объект pwrkey
                                     #   Если объявить объект без указания адреса (iarduino_I2C_Relay pwrkey ), то адрес будет найден автоматически.
val = [0, 0, 0, 0]                   #   Определяем начальное аналоговое значение.
channels = [1, 2, 3, 4]
flag = True                          #   Определяем флаг приращения аналогового значения (0-убывает, 1-растёт).
                                     #
pwrkey.analogWrite(ALL_CHANNEL, 0)   # * Отключаем все каналы.
print("Меняем сигнал ШИМ"            #
      " на на всех каналах."         #
      " Нажмите ctrl+c для"          #
      " остановки")                  #
                                     #
try:
    while True:                      #
        for x in range(1, 360):      #
            sleep(0.001)             #   Чем выше задержка, тем плавнее меняется аналоговый уровень.
            val[0] = abs(m.cos(
                         x*np.pi
                         / 180))
            val[0] = 1 - val[0]
            val[1] = 1 - abs(m.cos(x*np.pi/180
                         + np.pi/4))
            val[2] = 1 - abs(m.sin(x*np.pi/180))
            val[3] = 1 - abs(m.sin(x*np.pi/180
                         + np.pi/4))
            for i, j in zip(channels, val):                                   #
                pwrkey.analogWrite(i, int(j*511))
                                             #   Допустимые значения ШИМ - от 0 до 4095.
except KeyboardInterrupt:
    pwrkey.analogWrite(ALL_CHANNEL, LOW)
    print()
    print("программа остановлена,"
          " все каналы отключены")
