require 'fileutils'

class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy, :testCode]

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
      spec_file = File.open(@assignments.spec_path)
      @spec_file_contents = spec_file.read
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
    @labs = Lab.all
  end

  # GET /assignments/1/edit
  def edit
    @labs = Lab.all
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)
    @labs = Lab.all

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to assignments_url, notice: 'Assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def testCode
      editor_text = params[:editor_text]
      # Create tempfile and write the editor text to it
      source_file = Tempfile.new("solution")
      source_filepath = source_file.path
      source_file.write(editor_text)
      source_file.close

      problem_path = File.join(AssignmentsHelper.problems_path, @assignment.test_path)

      xml_result = `ruby #{AssignmentsHelper.test_tool_executable} #{problem_path} #{source_filepath} #{AssignmentsHelper.common_path}`

      FileUtils.remove_entry(source_filepath)

      render text: xml_result
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:description, :test_path, :spec_path)
    end
end
