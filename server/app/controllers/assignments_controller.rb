require 'fileutils'

class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy, :testCode, :saveCode, :restartCode]

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    current_user = UsersHelper.getCurrentUser
    @editor_file_contents = AssignmentsHelper.getEditorText(current_user, @assignment)
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
    source_file_prefix = "solution"
    source_file = Tempfile.new(source_file_prefix)
    source_filepath = source_file.path
    source_file.write(editor_text)
    source_file.close

    test_file_path = @assignment.getTestFilePath()

    json_test_report = `ruby #{AssignmentsHelper.testing_tool_script} #{test_file_path} #{source_filepath} #{AssignmentsHelper.common_path}`

    test_report = JSON.parse(json_test_report)


    source_file.unlink

    progress_bar_html = AssignmentsHelper.generateProgressBarHTMLFromTestReport(test_report)

    render json: {:progress_bar_html => progress_bar_html};
  end

  def saveCode
    editor_text = params[:editor_text]

    current_user = UsersHelper.getCurrentUser

    # Get the assignment folder path and create it if it doesn't exist
    assignment_folder_path = current_user.getDirectoryForAssignment(@assignment)
    FileUtils.mkdir_p(assignment_folder_path)

    # Get the assignment file name
    assignment_file_path = current_user.getFilepathForAssignment(@assignment)
    # Write the assignment file using the editor source
    assignment_file = File.open(assignment_file_path, "w")
    assignment_file.write(editor_text)
    assignment_file.close

    render nothing: true
  end

  def restartCode
    current_user = UsersHelper.getCurrentUser
    editor_file_contents = AssignmentsHelper.getSpecFileContents(@assignment)

    render json: {:new_editor_content => editor_file_contents}
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def assignment_params
    params.require(:assignment).permit(:description, :name)
  end
end
