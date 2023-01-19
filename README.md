# Kid Actions Digital Education Platform docker file

This set of scripts contain the instructions and the code to install the Kid Actions Digital Education Platform on any machine.
It is part of the European project [Kid Actions](https://www.kidactions.eu/), which aims at addressing cyberbullying among children and adolescents through interactive education and gamification in formal and informal settings.

The platform includes three technological components: the chat application Rocket.Chat, the Creender tool for image annotation, and the High School Superhero videogame. The tools are all available together and can be administered through a single interface called Kaum (Kid Actions User Management), allowing a centralised management of users and tasks.

The following sections contain the instructions to create a multi-container Docker application that includes the whole Kid Actions platform.

## Requirements

Only a working instance of Docker is needed to install and use the Kid Actions platform.

## Installing containers

Before the installation, two files must be created:
  * `admin_secret.txt` containing a single line with the desired admin interface password (Kaum and Rocket.Chat)
  * `mysql_secret.txt` containing a single line with the desired MySQL server (MariaDB) password for the root user

The platform can be installed by simply run the command `docker-compose up [-d]` (where `-d` is used to run in background).

Once finished, the platform can be accessed through its web interface on port 8001.

List of available tools:
  * `http://localhost:8001/kaum` - Kid Actions User Management
  * `http://localhost:8001/pma` - phpMyAdmin (useful to manage the data stored into MySQL database)
  * `http://localhost:8001/creender` - Creender
  * `http://localhost:8001/chat` - Rocket.Chat
  * `http://localhost:8001/hssh` - High School Superhero

Once logged in Kaum as admin, one can follow the instructions included in Kid Actions D3.3.
