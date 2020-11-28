require_relative '../automated_init'

context "External Store" do
  context "Entity Class" do
    control_entity_class = Controls::Entity::Example

    external_store = Controls::Store::External.example(entity_class: control_entity_class)

    entity_class = external_store.entity_class

    test do
      comment entity_class.inspect
      detail "Control Entity Class: #{control_entity_class.inspect}"

      assert(entity_class == control_entity_class)
    end
  end
end
