class AddCountryOfManufactureToSpreeVariants < SolidusSupport::Migration[6.1]
  def change
    add_column :spree_variants, :country_of_manufacture, :string
  end
end