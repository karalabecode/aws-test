output "url" {
  value = "http://${aws_lb.this.dns_name}/WeatherForecast"
}
