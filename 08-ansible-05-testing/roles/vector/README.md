Role Name
=========

This is role install Vector.

Requirements
------------

- Ansible 2.10 or higher
- Debian-based system (tested on Debian 12)

Role Variables
--------------

### Defaults Variables

- `vector_version`: The version of Vector to install. Default is `"0.44.0"`.

### Vars Variables

- `vector_config_path`: The path to the Vector configuration file. Default is `"/etc/vector/vector.yaml"`.
- `clickhouse_host`: The hostname or IP address of the ClickHouse server. Default is `"192.168.3.158"`.
- `clickhouse_user`: The username for the ClickHouse server. Default is `"clickhouse"`.
- `clickhouse_password`: The password for the ClickHouse server (encrypted with Ansible Vault).
- `lighthouse_port`: The port for Lighthouse. Default is `3000`.
- `lighthouse_host`: The hostname or IP address of the Lighthouse server. Default is `"192.168.3.192"`.

Dependencies
------------

- No external dependencies.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: vector }

### Шаблоны:

- **vector.yaml.j2**: Основная конфигурация Vector.

### Задачи:

- Загрузка дистрибутива
- Обновление кэша пакетов.
- Установка и запуск Vector.
- Развертывание конфигураци Vector.

### Хендлеры:

- Перезапуск Vector при изменении конфигурации.         

License
-------

MIT

Author Information
------------------

Ruslan Arestov
