require_relative '../../../automated_init'

context "Global scoped temporary storage" do
  context "Entity is missing transformer" do
    entity = Controls::Entity::NoTransformer.example
    record = Controls::Record.example(entity: entity)

    subject = Controls::Subject.example

    store = EntityCache::Storage::Temporary::Scope::Global.build(subject)

    context "Error is raised" do
      assert proc { store.put(record) } do
        raises_error?(Transform::Error)
      end
    end
  end
end
