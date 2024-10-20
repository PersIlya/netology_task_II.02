## <p style="text-align: center;">ОТЧЕТ</p> <p style="text-align: center;">по домашним заданиям к занятию «Основы Terraform. Yandex Cloud»</p>
## <p style="text-align: right;">Выполнил: студент Порсев И.С.</p>


## Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Исходный код для выполнения задания расположен в директории 02/src.


![localImage](./Yes.png)

## Задание 1

1. Изучить проект. В файле variables.tf объявлены переменные для Yandex provider.
2. Создать сервисный аккаунт и ключ. service_account_key_file.
3. Сгенерировать новый или использовать свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную vms_ssh_public_root_key.
4. Инициализировать проект, выполнить код. Исправить намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
5. Подключится к консоли ВМ через ssh и выполните команду  curl ifconfig.me. Примечание: К OS ubuntu "out of a box, те из коробки" необходимо подключаться под пользователем ubuntu: "ssh ubuntu@vm_ip_address". Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: eval $(ssh-agent) && ssh-add Вы познакомитесь с тем как при создании ВМ создать своего пользователя в блоке metadata в следующей лекции.;
6. Ответить, как в процессе обучения могут пригодиться параметры preemptible = true и core_fraction=5 в параметрах ВМ.

В качестве решения приложите:             
- скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес;    
- скриншот консоли, curl должен отобразить тот же внешний ip-адрес;    
- ответы на вопросы.

### <div style="text-align: center;">Решение</div>
>по пунктам 1-5
![localImage](./screen_II.01.1-5.png)    

>по пункту 6    
Использование параметров preemptible и core_fraction уменьшают стоимость использования ВМ в облаке, а именно:     
параметр `preemptible=true` указывает на создание прерываемой виртуальной машины, которая может быть принудительно остановлена в случаях работы ВМ более 24 часов или нехватки ресурсов для запуска обычной виртуальной машины в той же зоне доступности     
параметр `core_fraction=5` - определяющий базовую производительность vCPU в % при создании виртуальной машины.
   

![localImage](./Yes.png)

## Задание 2

1. Заменить все хардкод-значения для ресурсов yandex_compute_image и yandex_compute_instance на отдельные переменные. К названиям переменных ВМ добавьте в начало префикс vm_web_ . Пример: vm_web_name.
2. Объявить нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их default прежними значениями из main.tf.
3. Проверить terraform plan. Изменений быть не должно.

### <div style="text-align: center;">Решение</div>
![localImage](./screen_II.02.1-3.png)  
![localImage](./Yes.png)


## Задание 3

1. Создать в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
2. Скопироваь блок ресурса и создать с его помощью вторую ВМ в файле main.tf: "netology-develop-platform-db" , cores  = 2, memory = 2, core_fraction = 20. Объявите её переменные с префиксом vm_db_ в том же файле ('vms_platform.tf'). ВМ должна работать в зоне "ru-central1-b"
3. Применить изменения.

### <div style="text-align: center;">Решение</div>
![localImage](./screen_II.03.1-3.png)  
### Ссылка на файл: 
>[vms_platform.tf](./vms_platform.tf);          
 
![localImage](./Yes.png)

## Задание 4

1. Объявить в файле outputs.tf один output , содержащий: instance_name, external_ip, fqdn для каждой из ВМ в удобном лично для вас формате.(без хардкода!!!)
2. Применить изменения.    

В качестве решения приложите вывод значений ip-адресов команды terraform output.

### <div style="text-align: center;">Решение</div>
![localImage](./screen_II.04.1-2.png)  
![localImage](./Yes.png)

## Задание 5

1. В файле locals.tf описать в одном local-блоке имя каждой ВМ, используя интерполяцию ${..} с НЕСКОЛЬКИМИ переменными по примеру из лекции.
2. Заменить переменные внутри ресурса ВМ на созданные вами local-переменные.
3. Применить изменения.

### <div style="text-align: center;">Решение</div>
![localImage](./screen_II.05.1-3.png)  
![localImage](./Yes.png)

## Задание 6

1. Вместо использования трёх переменных ".._cores",".._memory",".._core_fraction" в блоке resources {...}, объединить их в единую map-переменную vms_resources и внутри неё конфиги обеих ВМ в виде вложенного map(object).

``` terraform
пример из terraform.tfvars:
vms_resources = {
  web={
    cores=2
    memory=2
    core_fraction=5
    hdd_size=10
    hdd_type="network-hdd"
    ...
  },
  db= {
    cores=2
    memory=4
    core_fraction=20
    hdd_size=10
    hdd_type="network-ssd"
    ...
  }
}
```

2. Создать и использовать отдельную map(object) переменную для блока metadata, она должна быть общая для всех ваших ВМ.
``` terraform
пример из terraform.tfvars:
metadata = {
  serial-port-enable = 1
  ssh-keys           = "ubuntu:ssh-ed25519 AAAAC..."
}
```
3. Найти и закоментировать все, более не используемые переменные проекта.
4. Проверить terraform plan. Изменений быть не должно.

### <div style="text-align: center;">Решение</div>
>по пунктам 1-3
![localImage](./screen_II.06.1-3.png) 
>по пункту 4
![localImage](./screen_II.06.4.png)      

### Отмечу что изменения присутствуют т.к. задание выполнялось с перерывом в 1 день.
![localImage](./Yes.png)

## Дополнительное задание (со звёздочкой*)
Настоятельно рекомендуем выполнять все задания со звёздочкой.
Они помогут глубже разобраться в материале. Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию.

## Задание 7*
Изучите содержимое файла console.tf. Откройте terraform console, выполните следующие задания:

1. Напишите, какой командой можно отобразить второй элемент списка test_list.
2. Найдите длину списка test_list с помощью функции length(<имя переменной>).
3. Напишите, какой командой можно отобразить значение ключа admin из map test_map.
4. Напишите interpolation-выражение, результатом которого будет: "John is admin for production server based on OS ubuntu-20-04 with X vcpu, Y ram and Z virtual disks", используйте данные из переменных test_list, test_map, servers и функцию length() для подстановки значений.

Примечание: если не догадаетесь как вычленить слово "admin", погуглите: "terraform get keys of map"

В качестве решения предоставьте необходимые команды и их вывод.

![localImage](./NotMain.png)

## Задание 8*
1. Напишите и проверьте переменную test и полное описание ее type в соответствии со значением из terraform.tfvars:

``` terraform
test = [
  {
    "dev1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117",
      "10.0.1.7",
    ]
  },
  {
    "dev2" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88",
      "10.0.2.29",
    ]
  },
  {
    "prod1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101",
      "10.0.1.30",
    ]
  },
]
```
2. Напишите выражение в terraform console, которое позволит вычленить строку "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117" из этой переменной.

![localImage](./NotMain.png)

## Задание 9*
Используя инструкцию https://cloud.yandex.ru/ru/docs/vpc/operations/create-nat-gateway#tf_1, настройте для ваших ВМ nat_gateway. Для проверки уберите внешний IP адрес (nat=false) у ваших ВМ и проверьте доступ в интернет с ВМ, подключившись к ней через serial console. Для подключения предварительно через ssh измените пароль пользователя: sudo passwd ubuntu

![localImage](./NotMain.png)