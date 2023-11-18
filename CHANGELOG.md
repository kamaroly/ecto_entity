# Changelog for v0.1.x

## v1.0.0

* Introduced `phoenix_pubsub` for events.
* Added `created`, `updated` and `deleted` events.
* Automatically set events to schema name for example: Schema Person will have `person_created`, `person_updated`, `person_deleted`
* Other module can subscribe to the schema events using `SchemaName.subscribe`. E.g: `Person.subscribe`

## v0.1.4

### Enhancements

* Removed warnings for previous matching functions.
* Added `truncate_without_key_checks/0` to truncate a table in a MySql database.
* Added `disable_foreign_key_checks/0` to disable foreign key checks in MySql.
* Added `enable_foreign_key_checks/0` to enable foreign key checks in MySql.
* Added `delete/0` to delete all **schema** entries.
* Added `raw/3` for raw query functions.

## v0.1.3

* [Ecto.Entity.Create] Added `create_many/1`
* [Ecto.Entity.Update] added `update_many/2`
