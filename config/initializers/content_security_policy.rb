# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

Rails.application.configure do
    config.content_security_policy do |policy|
      policy.default_src :self, :https
      policy.font_src    :self, :https, :data
      policy.img_src     :self, :https, :data
      policy.object_src  :none
      policy.script_src  :self, :https # Add :unsafe_inline if absolutely necessary
      policy.style_src   :self, :https
      # Specify URI for violation reports
      # policy.report_uri "/csp-violation-report-endpoint"
    end
  
    # Generate session nonces for permitted scripts
    config.content_security_policy_nonce_generator = ->(request) { SecureRandom.base64(16) }
    config.content_security_policy_nonce_directives = %w(script-src)
    
    # If you want to test without enforcing the policy
    # config.content_security_policy_report_only = true
  end
  
#   # Report violations without enforcing the policy.
#   # config.content_security_policy_report_only = true
# end
