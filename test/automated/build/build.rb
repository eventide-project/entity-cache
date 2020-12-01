require_relative '../automated_init'

context "Build" do
  entity_class = Controls::Entity::Example

  specifier = Controls::Specifier.example

  entity_cache = EntityCache.build(entity_class, specifier)

  subject = entity_cache.subject

  control_subject = Controls::Subject.example(specifier: specifier)

  test "Subject" do
    detail subject
    comment control_subject

    assert(subject == control_subject)
  end

  test "Entity class" do
    assert(entity_cache.entity_class == entity_class)
  end

  test "Specifier" do
    assert(entity_cache.specifier == specifier)
  end
end
