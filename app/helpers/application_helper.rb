# helper used in code.
module ApplicationHelper
  # Counts incoming emails based on their status.
  def count_incoming_emails(status)
    {
      'all' => IncomingEmail.count,
      'pending' => IncomingEmail.where(status: 'pending').count,
      'processing' => IncomingEmail.where(status: 'processing').count,
      'failed' => IncomingEmail.where(status: 'failed').count,
      'success' => IncomingEmail.where(status: 'success').count
    }.fetch(status, 0)
  end

  # Returns the color badge for a given status.
  def color_badge(status)
    {
      'pending' => 'black',
      'processing' => 'warning',
      'failed' => 'danger',
      'success' => 'success'
    }.fetch(status, 'secondary')
  end

  # Returns the color alert for a given status.
  def bootstrap_class_for(type)
    type = type.to_s

    return 'success' if %w[success notice].include?(type)
    return 'danger'  if %w[error alert danger].include?(type)
    return 'warning' if type == 'warning'
    return 'info'    if type == 'info'

    'secondary'
  end
end
