provider "google"{
    credentials=file("~/keys/terra.json")
    project = var.project
    region = var.region
    zone = var.zone
}
