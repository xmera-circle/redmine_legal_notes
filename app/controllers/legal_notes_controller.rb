# frozen_string_literal: true

##
# Control the LegalNotes page rendering
#
class LegalNotesController < ApplicationController
  self.main_menu = false

  before_action :find_legal_note, only: :index

  def index
    if @legal_note.present?
      pretty_name
      respond_to do |format|
        format.html { render :index }
      end
    else
      redirect_to home_path
    end
  end

  private

  def find_legal_note
    @legal_note = LegalNote.find(name: name)
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def name
    params[:name]
  end

  def pretty_name
    @pretty_name = name.titleize
  end
end
