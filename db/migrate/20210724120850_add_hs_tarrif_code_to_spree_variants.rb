class AddHsTarrifCodeToSpreeVariants < SolidusSupport::Migration[6.1]
  def change
    add_column :spree_variants, :spree_hs_tarrif_code, :string
  end
end