# KEYCLOAK

Autentizace k aplikacím a zabezpečeným službám. Není třeba se zabývat 
ukládáním nebo ověřováním uživatelů. 
Vše je k dispozici hned po nasazení.

Obsahuje pokročilé funkce, jako je User Federation, Identity Brokering a Social Login.
Viz [webová stránka produktu](https://www.keycloak.org/). [Kontejnery](https://github.com/keycloak/keycloak-containers)

## Docker

    docker run jboss/keycloak
    
nebo

    docker-compose up -d


## Systémové proměnné

- __DB_VENDOR__: databázový stroj. (POSTGRES)
- __DB_ADDR__: hostitel databázového stroje (postgres)
- __DB_DATABASE__: databáze pro uložená dat (keylock)
- __DB_USER__: uživatel databázového stroje (keylock)
- __DB_SCHEMA__: databázové schéma (public)
- __DB_PASSWORD__: heslo uživatele databázového stroje 
- __KEYCLOAK_USER__: administrátor keycloak
- __KEYCLOAK_PASSWORD__: heslo administrátora keycloak

