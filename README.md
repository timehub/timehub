Important Bugs
==============
1. The hourly rate that is used when an invoice is created should be stored in the invoice! That way when you change the project's rate, it won't change the invoices already created.

Most valuable feedback
======================

Not in this order btw!

1. Ability to log non-commit related times (meetings, server-setup ...) -> Javascript Timer / JPemberthy
2. Hide repos / Maybe make private repos appear first. Most public repos are not invoiced.
3. Have a "contact/client" model. I would love to see how much a client has payed, how much he is due and how much I've invoiced him. This would be a great integration point with Highrise for example.
4. Mark a start commit with an end commit and invoice that time. Ignore commits in the middle!
5. Have a global hourly rate instead of setting it up in every repo.
6. Support multiple branches
7. Allow 0 minutes, sometimes we just need to add a description in the invoice but without charging anything (I use this A LOT).
8. Ability to select multiples context/organizations. Specially Github organizations!
9. Adding a account-related company or companies database so that each time you print out an invoice then it will attach the logo, company name, and any other important details so that they won't have to be typed in per invoice.


Cool to have
============

1. It would be great to have "examples" of how to use the app, like pointing that `git log -n 1 --pretty=format:'%cr' --date=relative` will show the time since the last commit

2. A better invoice layout. Got this from one of the judges:

    You should add the developer name, project name and the time frame to the resulting Invoice.pdf file, so we'd send it via email as is.

3. Option 'send invoice now' directly to the client. This + the contact model would be awesome.

4. Ability to grant access to my clients, it'd be cool if the client goes to the site and monitor his billing.


Other Feedback
=============

1. Add 'default' tasks with pre-defined time.







Next tasks (FROM THE CONTEST DAY)
==========

Para hacer mañana por la mañana:

* Implementar los push de github (Github hook)
* Revisar textos
* Explicar como se usa la app y el parseo del tiempo
* Agregar jQuery quicksand para los proyectos (http://razorjack.net/quicksand/)
* Crear una cuenta dummy de github para que la gente entre a votar
* Mirar el log para ver si hay queries que sean evidentemente optimizables


Hock
=====
* En Invoices#new mostrar un mensaje al lado de total prices si el rate del proyecto es 0.

Andrés
======
* Github Hook
