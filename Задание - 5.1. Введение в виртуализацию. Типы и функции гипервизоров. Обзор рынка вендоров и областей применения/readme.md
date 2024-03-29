# Задание - 5.1. Введение в виртуализацию. Типы и функции гипервизоров. Обзор рынка вендоров и областей применения.

##        1. Опишите кратко, как вы поняли: в чем основное отличие полной (аппаратной) виртуализации, паравиртуализации и виртуализации на основе ОС.

### Ответ:

    Основное отличие этих типов виртуализации в "расположении" управляющей системы - это может быть только гипервизор используемый напрямую, либо гипервизор установленный поверх операционной системы либо вообще виртуализация средствами операционной системы.

##        2. Выберите один из вариантов использования организации физических серверов, в зависимости от условий использования.

Организация серверов:

    физические сервера,
    паравиртуализация,
    виртуализация уровня ОС.

Условия использования:

    Высоконагруженная база данных, чувствительная к отказу.
    Различные web-приложения.
    Windows системы для использования бухгалтерским отделом.
    Системы, выполняющие высокопроизводительные расчеты на GPU.
        Выберите один из вариантов использования организации физических серверов, в зависимости от условий использования. Опишите, почему вы выбрали к каждому целевому использованию такую организацию.

### Ответ:

  Высоконагруженная база данных, чувствительная к отказу.
    физические сервера, так как для высоконагруженной обработки требуется максимальная производительность аппаратных ресурсов, а отказоустойчивость можно обеспечить резервным копированием
	
	Различные web-приложения.
	  виртуализация уровня ОС, так как легко можно распределять ресурсы самой ос в случае добавления каких либо новых функциональных приложений
    
	Windows системы для использования бухгалтерским отделом.
    паравиртуализация, так как ее возможностей и ресурсов будет достаточно для работы средненагруженной системы
	
	Системы, выполняющие высокопроизводительные расчеты на GPU.
	  физические сервера, так как требуется полное взаимодействие с аппаратной частью


##       3. Выберите подходящую систему управления виртуализацией для предложенного сценария. Детально опишите ваш выбор.

Сценарии:

    100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий.
    Требуется наиболее производительное бесплатное open source решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.
    Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows инфраструктуры.
    Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.

### Ответ:

100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий.
	Hyper V позволяет обеспечить высокую доступность и отказоустойчивость виртуальных машин, также можно резервное копирование через windows server backup и скриптов на его основе. Linux среды также можно запускать на основе этого гипервизора, но возможно не будут доступны самые свежие ядра.
    
	Требуется наиболее производительное бесплатное open source решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.
    KVM является подходящим средством способным обеспечить производительность и связан жесткими рамками с используемыми операционными системами
	
	Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows инфраструктуры.
    XEN PV так как он хорошо совместим с Windows и позволяет обеспечить стабильность работы
	
	Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.
	  KVM так как является нативным решением большинства ядер Linux

##        4. Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, то создавали бы вы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.

### Ответ: 
       При использовании гетерогенной среды требуется более высокая квалификация персонала для обслуживания сервера - администратор должен иметь достаточный опыт во всех используемых системах. Также могут возникнуть сложности с переносом ресурсов, данных из одной среды виртуализации в другую. Но как показывает практика, в айти нельзя зацикливаться на чем то одном, как минимум в плане обеспечения резерва - поэтому использование гетерогенной среды оправдано и желательно в проектах. Требуется продумать риски использования такого решения и провести своевременное обучение обслуживающего персонала..
