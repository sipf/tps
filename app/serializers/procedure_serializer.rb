class ProcedureSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attribute :libelle, key: :label

  attributes :id,
    :description,
    :organisation,
    :direction,
    :archived_at,
    :total_dossier,
    :link,
    :state

  has_many :types_de_champ, serializer: TypeDeChampSerializer
  has_many :types_de_champ_private, serializer: TypeDeChampSerializer
  has_many :types_de_piece_justificative, serializer: TypeDePieceJustificativeSerializer

  def archived_at
    object.archived_at&.in_time_zone('UTC')
  end

  def link
    if object.path.present?
      if object.brouillon_avec_lien?
        commencer_test_url(path: object.path)
      else
        commencer_url(path: object.path)
      end
    end
  end

  def state
    object.aasm_state
  end
end
