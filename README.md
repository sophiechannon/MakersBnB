# MakersBnB

We would like a web application that allows users to list spaces they have available, and to hire spaces for the night.

**Headline specifications**
- Any signed-up user can list a new space.
- Users can list multiple spaces.
- Users should be able to name their space, provide a short description of the space, and a price per night.
- Users should be able to offer a range of dates where their space is available.
- Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
- Nights for which a space has already been booked should not be available for users to book that space.
- Until a user has confirmed a booking request, that space can still be booked for that night.

**Nice-to-haves**
Users should receive an email whenever one of the following happens:
They sign up
They create a space
They update a space
A user requests to book their space
They confirm a request
They request to book a space
Their request to book a space is confirmed
Their request to book a space is denied
Users should receive a text message to a provided number whenever one of the following happens:
A user requests to book their space
Their request to book a space is confirmed
Their request to book a space is denied
A ‘chat’ functionality once a space has been booked, allowing users whose space-booking request has been confirmed to chat with the user that owns that space
Basic payment implementation though Stripe.

**User Stories**

As a property owner,
So that I can use MakersBnb's services,
I'd like to be able to sign up.

As a signed-up property owner,
So I can allow other people to book my properties,
I'd like to be able to list my properties on MakersBnB

As a signed-in property owner,
So I can customise my listing,
I would like to add a name and short description of the property.

As a signed-in property owner,
So people know if they can afford to stay in my property,
I would like to be able to add a price per night.

As a signed-up property owner,
So I can show when my properties are available,
I'd like an avaialbility calender on the listing.

As a signed-up user,
So I can hire a property,
I'd like to view a list of properties that are available on my selected date.

As a user,
So I don't waste time checking each property,
I'd like properties to be hidden if they aren't available on my selected date.

As a signed-up user,
So I can secure my selected property,
I'd like to be able to request to book one night.

As a signed-up property owner,
To prevent damage to my property,
I'd like to be able to approve or reject requests for bookings.

As a property owner,
So my property doesn't go unbooked,
I'd like to space to remain available until I have accepted a request.

**MVP**
- User registration / authorisation
- Users (propertiy owners) can add properties
- Display properties with name, description and price.
- Property availability is listed in the description.
- properties can be booked (could just be an email address initially)

**Model design**

USER

| responsibility | collaborators |
|----------------|---------------|
| knows first name | |
| knows last name | |
| knows email address | |
| Can request to book | |
| Can accept or reject a booking | |
| Can register | |
| Can log in & out | |

PROPERTY
| responsibility | collaborators |
|----------------|---------------|
| can show all properties | |
| knows name | |
| knows description | |
| knows price | |
| knows availability start date | |
| knows availability end date | |
| knows dates booked | |

**Database design**

USERS
| id | first_name | last_name | email | password |
|----|------------|-----------|-------|----------|
| 1 | Chris | Brown | chris@test.com	| jfkldsjf-=t43-64-gdfg |
| 2	| Michael |	Chan |	michael@tech.com | i990-=ffff:) |

PROPERTIES
| id | name | description | price_per_night | fk owner_id  | avail_start | avail_end |
|----|------------|-----------|-------|----------|----|-----|

BOOKINGS
| id | fk property_id | fk user_id | date | status |
|---|---|---|---|---|