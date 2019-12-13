# Lumen Base

![][build-img]
![][docker-pulls-img]

[build-img]: https://img.shields.io/github/workflow/status/mathrix-education/lumen-base/Build%20Docker%20Image?style=flat-square
[docker-pulls-img]: https://img.shields.io/docker/pulls/mathrix/lumen-base?style=flat-square

This image aims to be the base of the Mathrix Education SA dockerized,
PHP-based projects.
To reduce the size of the image, we used the Alpine distribution.

Proudly maintained by Mathieu Bour <mathieu@mathrix.fr>, Vice-CTO.

## Stack

- Alpine: 3.10
- PHP-FPM: 7.4
- nginx: 1.16

## Environment variables

| Name | Description              |
|------|--------------------------|
| PORT | The nginx listening port |

## Credits

- [renatomefi/php-fpm-healthcheck][1]: PHP FPM healthcheck

[1]: https://github.com/renatomefi/php-fpm-healthcheck
