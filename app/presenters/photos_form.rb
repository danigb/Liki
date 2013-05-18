class PhotosForm < BasicForm
  model :node, on: :node

  property :tilte, on: :node
end
