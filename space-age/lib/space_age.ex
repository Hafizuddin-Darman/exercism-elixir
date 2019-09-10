defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @planet_years_to_earth %{
    :mercury => 0.2408467,
    :venus => 0.61519726,
    :earth => 1.0,
    :mars => 1.8808158,
    :jupiter => 11.862615,
    :saturn => 29.447498,
    :uranus => 84.016846,
    :neptune => 164.79132
  }

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) when planet != :earth do
    {:ok, years_to_earth} = Map.fetch(@planet_years_to_earth, planet)

    Float.round(age_on(:earth, seconds) / years_to_earth, 2)
  end

  def age_on(planet, seconds) when planet == :earth do
    seconds / 60 / 60 / 24 / 365.25
  end
end
