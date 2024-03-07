###  use this command first in new command line .  это даст key id , secret key , token . каждый раз разные .

1. aws sts assume-role --role-arn arn:aws:iam::657126973073:role/mini_project --role-session-name NameYouChoose

####copy this to here 

"Credentials": 
        "AccessKeyId": "ASIAZR76R32I2PKNX2NZ",
        "SecretAccessKey": "uxJDrKEQojCic5c+gM/D2v58dwSM4UAcDL76eQa4",
        "SessionToken": "IQoJb3JpZ2luX2VjEOT//////////wEaCXVzLWVhc3QtMSJIMEYCIQDv5kKROq5B1vt9rLkGyR2LL5EKCpNuGF2socUqyGVhrgIhAJHWGovUiIjT0pAYH1mwx2O2LPx/jRwfBpHLDObGYzgyKqMCCMz//////////wEQABoMNjU3MTI2OTczMDczIgz7k0pkMLm4g+qoFPQq9wE4t8Jdg5pRotVXkC3p+OuWUePdDI15PffQ98TmjN5VNfJ2D6Ecd+2Xzn0riUSukIGqire5QCAY1Wn+0z0XmEvJx4KqG7bX0sicSJgoUX+FNPCXwYX00UL21fg040RdDL2Rvu/vtMR60m0yC22aa/ZXrqmB+WsY7uSPlYeQMvm2+hq9Q6+FBc/MygyGIMMYPBBf9GFn36SKIoeS1cbiCEbqXZmBmCczYOrYXEqC6VZaV0k0KKHZS203VEN6xMw7r5LOJXtrT2dyGWrdu5ZcPgc1KJxPLVjE9PPSZMiVLLuwIoQN7KM7oZnlZv7WxG8OvzhMZrkgJuEJMMSm9a4GOpwBNkla00ciyX4jYzRrTruTvwdT93u8QChXueZa6qxaex1teC9MuMl5jXpUBAeDGEg51weFeko0Qs1zaLz1N3RlVFdj4ambRINMAdjfgItopPeqDJJCh73x1XBLcu6uHhU06bmMKHAnpUY21ScTQUhy9Xp2to3OIBP1mvPUM5V+QU9joc0szKU5WKOev9oocxqh4sos8e6x2WgzWnv6"


########################


2. export AWS_ACCESS_KEY_ID=ASIAZR76R32I463KKQ7N
3. export AWS_SECRET_ACCESS_KEY=oDKenPfkdHTV2ztW4sSgPsuS1ic8kWlOjmy3mcTJ
4. export AWS_SESSION_TOKEN=IQoJb3JpZ2luX2VjEOT//////////wEaCXVzLWVhc3QtMSJHMEUCIHHjBcxw2dh9Xpy2VT0HtfO3ntke1j4oAB2A7tHE7GmuAiEA8caCm2k7qCm74du7fJzfqKhoTHO/2UWV5l5DhFGAsHwqowIIzf//////////ARAAGgw2NTcxMjY5NzMwNzMiDI8JancQq0CzaAjutyr3AaGoTkZUXVouKS5kc8yP1CSutvjFx813LuFruXS6fU+9QWOEyPSulSBFff4wbRxGpAFIYpRHZmKhyyRKsF2nBJvRzv7/YZjZ+9MzVEpBzxziz3ekM2zWWW/Xp10w+ZiKH0x7pxJfmA1KXVm09hBBuF2qeJ6LrCNuIF1Bzf5TQXena3T332G9VDPvheZFXFAzM/HO8FBDOfAFeXweeUUZ1u2k0WAOFY8Hu+jvb/KlkTIRJ/TQg5sYnYp+oJZkGAB/X9k7A9W1zMlYc2wGtzabza2GAb9e6utBxtzND4030fXoBpdnLyuBQaXL5Yc1E3HZOBna8dbNuIUwnrX1rgY6nQHwW4Lso6YimHLz23v476LOrgwUaJgkUQ9CpibJVz49QXNXT7qXhGgp1YuSA7UYDYm5ZEhd7fKEtgv7JQu6qNwUbocLEtzgov4Gq4uUH4psbO4faHGcoibAgW7z211UIAL/zW0GHubgwhA2mGETs0t4mDXUgzuv5y/fSsoBvJMCI//egVUFIjordNo1TyrG8Ss2z/tLPiHuivPCwWeh



######################


aws sts get-caller-identity








vss1 command
"AccessKeyId": "ASIAZR76R32IZJALQGVX",
        "SecretAccessKey": "IOZR4l9qHAIFP8wTi5hOGHru0OJAPtGhXOTRbSl6",
        "SessionToken": "IQoJb3JpZ2luX2VjEOL//////////wEaCXVzLWVhc3QtMSJIMEYCIQCUod8zseS5sBXJ6CSdTCOp5BrKR5p/GExCKZ2Bxema9gIhALm3jJGOrtIGR20dIbTdukceA8JI8/aeR9PWpFsy8Y5EKqMCCMv//////////wEQABoMNjU3MTI2OTczMDczIgxIgVWDVsmPson6INEq9wHwh9zslvTJ6C3J4+4AmDIVKtapO6PpYcqVKQKgkJz57HUFHDu1hToPRpdkI8KHx4G8IPgn8tSURFaSMwcMZvo+G+BJDn56h8dB1W7J/DUwW8A2LfAMyjt5gTP1uf6ZnJJUP05+Z6Qp2/vYncaLUcCpTzMlTyL9OiJxkxWvtYc5qK8LpAIdpSYI76yKBswM95a22hEYxR9Ti4Hg8XJdKJGi0wo5JMgyaPfaxEciateIDzYx1Vz46NnxandnuNNYn+T4D2gCkmmKBeb4wS15IkZC2l64tXV3M8Xp6EmPiGUHw7HHBqY/XrXRDvdvjqjQydGoSIsXu9J8MK759K4GOpwBM9EfQWcUtrKotkpfjSGZ0qn3QUviJgYIS0zd7KFq80089z88q0VZ4u8lBMtiBaDE9NVuZjL9Ue1dnJJP9DmzbSgNXj3cxZWo+m9v/CNOXAK5eDG3ruDx1Ah92dC0m9mENOMvJfFWUueth7eYYbsHlWssYlTPfsHA9+ZlTR1+NX+CzU0uB29FFJBwYn+DrkVP2v6eo3uI3L2ofhhy"

vss1 my
 AKIAU6GD3ZZ53KBZTIV2!z
exlJRElRfe9a/GE1l7hTPzZKSOQkZBvkTbdnhOiD!z






Прекратите использование предполагаемой роли . Если вы установили временные учетные данные (идентификатор ключа доступа, секретный ключ доступа, маркер сеанса) в своей среде для предполагаемой роли, вам следует отключить их, чтобы вернуться к использованию профиля по умолчанию, или указать другой профиль, который использует ваши учетные данные пользователя IAM. Вы можете отключить их в своем терминале следующим образом:


unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN



Настройте интерфейс командной строки AWS с использованием своих учетных данных . Убедитесь, что интерфейс командной строки AWS настроен с использованием учетных данных вашего пользователя IAM ( vss1). Вы можете сделать это, запустив:


aws configure   ORRRR ---->>>  aws sts get-caller-identity 


 ### add 2 lines copy - paste


При появлении соответствующего запроса введите идентификатор ключа доступа вашего пользователя IAM и секретный ключ доступа. Вы можете оставить имя региона по умолчанию и формат вывода без изменений или установить их по своему усмотрению.

Подтвердите свою личность . Чтобы убедиться, что вы теперь работаете под своим пользователем IAM, get-caller-identityснова запустите команду:


aws sts get-caller-identity



Это должно вернуть данные вашего пользователя IAM и правильный идентификатор вашей учетной записи 





new 
Эта команда должна автоматически логинить в роль если запустить из терминала   


eval $(aws sts assume-role --role-arn arn:aws:iam::657126973073:role/mini_project --role-session-name test | jq -r '.Credentials | "export AWS_ACCESS_KEY_ID=\(.AccessKeyId)\nexport AWS_SECRET_ACCESS_KEY=\(.SecretAccessKey)\nexport AWS_SESSION_TOKEN=\(.SessionToken)\n"')