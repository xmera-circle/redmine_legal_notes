# frozen_string_literal: true

class LegalNotesController < ApplicationController
  self.main_menu = false

  def index
    settings = Setting.send 'plugin_redmine_legal_notes'
    @legal_note = settings[params[:legal_note].to_sym]
    if @legal_note.present?
      respond_to do |format|
        format.html { render :index }
      end
    else
      redirect_to home_path
    end
  end
end
