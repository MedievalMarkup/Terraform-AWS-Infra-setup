# create scheduled action-1 : Increase capacity during business hours
resource "aws_autoscaling_schedule" "increase_capacity_8am" {
  scheduled_action_name     = "increase-capacity-9am"
  max_size                  = 5
  min_size                  = 2
  desired_capacity          = 0
  start_time                = "2024-12-11T18:00:00Z"
  # end_time                  = "2016-12-12T06:00:00Z"
  # every day 9 am
  recurrence                = "00 09 * * *"
  autoscaling_group_name    = aws_autoscaling_group.first_autoscaling_group.id
}

# create scheduled action-1 : decrease capacity during non-business hours

resource "aws_autoscaling_schedule" "decrease_capacity_8pm" {
  scheduled_action_name     = "decrease_capacity_8pm"
  max_size                  = 5
  min_size                  = 2
  desired_capacity          = 0
  start_time                = "2024-12-12T18:00:00Z"
  # end_time                  = "2016-12-12T06:00:00Z"
  # every day 9 am
  recurrence                = "00 21 * * *"
  autoscaling_group_name    = aws_autoscaling_group.first_autoscaling_group.id
}