require_relative '../automated_init'

context "Build" do
  entity_class = Controls::Entity::Example

  context "Entity Class And Specifier" do
    specifier = Controls::Specifier.example

    entity_cache = EntityCache.build(entity_class, specifier: specifier)

    subject = entity_cache.subject

    control_subject = Controls::Subject.example(specifier: specifier)

    test "Subject" do
      comment "Control subject: #{control_subject}"
      detail "Compare subject: #{subject}"

      assert(subject == control_subject)
    end

    test "Entity class" do
      assert(entity_cache.entity_class == entity_class)
    end

    test "Specifier" do
      assert(entity_cache.specifier == specifier)
    end
  end

  context "Just Entity Class" do
    entity_cache = EntityCache.build(entity_class)

    subject = entity_cache.subject

    control_subject = Controls::Subject.example(specifier: :none)

    test "Subject" do
      comment "Control subject: #{control_subject}"
      detail "Compare subject: #{subject}"

      assert(subject == control_subject)
    end

    test "Entity class" do
      assert(entity_cache.entity_class == entity_class)
    end

    test "Specifier" do
      assert(entity_cache.specifier.nil?)
    end
  end
end
