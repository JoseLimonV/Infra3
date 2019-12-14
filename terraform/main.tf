resource "digitalocean_tag" "tecWeb" {
    name = "tecWeb"
}
resource "digitalocean_droplet" "tecWeb"{
    count = 2
    image = "${var.image_id}"
    name = "tecWeb"
    region = "SFO2"
    size = "512mb"
    ssh_keys = [25960099]
    user_data = "${file("user-data.web")}"
    tags = ["${digitalocean_tag.tecWeb.id}"]
}
resource "digitalocean_loadbalancer" "tecWeb" {
    name = "tecgurusWeb"
    region = "sfo2"

        forwarding_rule {
            entry_port = 80
            entry_protocol = "http"

            target_port = 3000
            target_protocol = "http"
        }
        healthcheck {
            port = 3000
            protocol = "http"
            path = "/add/1/1"            
        }
        droplet_tag = "${digitalocean_tag.tecWeb.id}"
}