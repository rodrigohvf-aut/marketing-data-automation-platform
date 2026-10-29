# Test conventions

Public test placeholders are organized into restore and smoke-test areas.

Private implementations should add tests for API availability, workflow retries, pagination, source normalization, database policies, backup integrity, restore validation, and secret rotation. Test fixtures must be synthetic and must not contain customer exports or credentials.
