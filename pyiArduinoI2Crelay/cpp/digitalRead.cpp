// Данный пример считывает текущее состояние каналов модуля.        // * Строки со звёздочкой являются необязательными.
#include <iostream>                                                 //
#include "../iarduino_I2C_Relay.h"                                  //   Подключаем библиотеку для работы с реле и силовыми ключами.
iarduino_I2C_Relay relay(0x09);                                     //   Объявляем объект relay для работы с функциями и методами библиотеки iarduino_I2C_Relay, указывая адрес модуля на шине I2C.
                                                                    //   Если объявить объект без указания адреса (iarduino_I2C_Relay relay;), то адрес будет найден автоматически.
int main(){  	                                                    //
//  Готовим модуль к работе:                                        //
    relay.begin();                                                  //   Инициируем работу с модулем.
//  Включаем и выключаем каналы модуля:                             //
    relay.digitalWrite(1, LOW);                                     //   Отключаем 1 канал.
    relay.digitalWrite(2,HIGH);                                     //   Включаем  2 канал.
    relay.digitalWrite(3, LOW);                                     //   Отключаем 3 канал.
    relay.digitalWrite(4,HIGH);                                     //   Включаем  4 канал.
//  Проверяем состояние каналов модуля в цикле:                     //
    for(int i=1; i<=4; i++){       std::cout <<  "Канал N ";     	//   Проходим по всем каналам модуля.
                                   std::cout <<  i;              	//   Выводим номер очередного канала.
        if( relay.digitalRead(i) ){std::cout <<  " включен "; }  	//   Если функция digitalRead() вернула HIGH значит канал включён.
        else                      {std::cout <<  " отключен\t"; }  	//   Если функция digitalRead() вернула LOW  значит канал отключён.
    }                              std::cout <<  '\n';              //
}                                                                   //
                                                                    //
//  ПРИМЕЧАНИЕ: состояние всех каналов можно получить одним байтом: //
//  uint8_t j = relay.digitalRead(ALL_CHANNEL);                     //   4 младших бита переменной «j» соответствуют состояниям 4 каналов модуля.
