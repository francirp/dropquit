module PagesHelper

  def group_options
    { "Smoker" => Quit::Groups::SMOKER, "Dipper" => Quit::Groups::DIPPER }
  end

  def lead_header
    hash =
      { Quit::Groups::SMOKER => "So You're Ready To Stop Smoking. Let's Do This.",
        Quit::Groups::DIPPER => "Let's Get That Dip Out Of Your Lip." }
    hash[@lead.group]
  end

  def lead_present?(lead)
    if lead.present?
      lead.instance_variables.each do |l|
        return false unless lead.instance_variable_get(l).present?
      end
    end
  end

end
