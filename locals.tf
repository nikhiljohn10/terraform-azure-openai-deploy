locals {
  open_ai_instance_models = flatten([
    for model in var.open_ai_instance.models : {
      model_name    = model.name
      model_version = model.version
      model_type    = model.type
    }
  ])
}