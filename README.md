Учебное приложение для курсов профессиональной разработки на ROR - [Thinknetica](http://ror.thinknetica.com)

Используется:  

* Ruby - 2.2.4  

* Rails - 4.2.6  

* RSpec - 3.5.0  

* PostgreSQL - 9.3.14  

* Тестирование: написаны интеграционные, юнит-тесты, протестирован json, API, background jobs, mailers  
    * Gems: rspec, capybara, json_spec, shoulda-matchers.  
* Авторизация: devise  
* Аутентификация: cancancan  
* Ajax  
* Включены: Nested Forms и полиморфные ассоциации  
* Comet и Pub/Sub: private_pub  
* Авторизация через соц. сети (facebook, twitter): omniauth, omniauth-facebook, omniauth-twitter  
* Реализован REST API для вопросов, ответов, профиля.  
* Background jobs: sidekiq, whenever  
* Полнотекстовый поиск на Sphinx  
* Deploy: capistrano  
* На сервере был настроен: ngnix, passenger, a затем unicorn, monit, backup.