require 'fileutils'
require 'assignment_grader'

class AssignmentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_assignment, only: [:show, :edit, :update, :destroy, :testCode, :saveCode, :restartCode, :uploadCode, :downloadCode, :submitCode]

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    if (!current_user.hasSolutionFileForAssignment?(@assignment))
      to_write_solution = ""
      if @assignment.hasSpecFile?
        to_write_solution = @assignment.getSpecFileContents()
      end

      current_user.writeToSolutionFileForAssignment(@assignment, to_write_solution)
    end

    @editor_file_contents = current_user.getSolutionFileContentsForAssignment(@assignment)
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

  def grades
    set_assignment
  end

  def testCode
    # Runs the unit test tool with the users code (what is in the editor right now, not what is saved)

    assignment_grader = AssignmentGrader.new(@assignment, params[:editor_text])
    assignment_grader.runTests()

    render json: {:progress_bar_html => assignment_grader.getProgressBarHTML()}
  end

  def submitCode
    assignment_grader = AssignmentGrader.new(@assignment, params[:editor_text])
    assignment_grader.runTests()

    # dummy score until actual score can be found
    score = assignment_grader.getGrade()
    # find or create a grade for the assignment/user combination
    new_grade = Grade.where(:user => current_user, :assignment => @assignment).first_or_create

    # only update score if it's higher than the existing one
    if (score > new_grade.score)
      new_grade.score = score
      new_grade.save
    end

    render json: {:progress_bar_html => assignment_grader.getProgressBarHTML()}
  end

  def saveCode
    # Saves the user's code to their solution file
    editor_text = params[:editor_text]

    current_user.writeToSolutionFileForAssignment(@assignment, editor_text)

    render nothing: true
  end

  def restartCode
    # Restarts the code to the default spec, does not save it to the user's solution file
    render json: {:new_editor_content => @assignment.getSpecFileContents()}
  end

  def uploadCode
    # Uploads the file received and replaces the user's solution file with it.
    uploaded_file = params[:assignment_file]
    assignment_file_path = current_user.getSolutionFilepathForAssignment(@assignment)

    upload_success = false
    if uploaded_file
      uploaded_file_contents = uploaded_file.read
      uploaded_file_contents = uploaded_file_contents.force_encoding('utf-8')

      if (uploaded_file_contents.valid_encoding?)
        begin
          current_user.writeToSolutionFileForAssignment(@assignment, uploaded_file_contents)
          upload_success = true
        rescue
          upload_success = false
        end
      else
        upload_success = false
      end
    end

    respond_to do |format|
      if upload_success
        format.html {
          redirect_to @assignment,
          :flash => {
            :success => 'Assignment file was successfully uploaded.'
          }
        }
      else
        format.html {
          redirect_to @assignment,
          :flash => {
            :error => 'There was a problem uploading your assignment file.'
          }
        }
      end
    end
  end

  def downloadCode
    # Downloads the code that the user has saved, if any.

    # If the user wants to save their code
    if (params["commit"] == "Yes")
      editor_text = params["editor-text-hidden"]
      current_user.writeToSolutionFileForAssignment(@assignment, editor_text)
    end

    puts params

    if current_user.hasSolutionFileForAssignment?(@assignment)
      send_file(current_user.getSolutionFilepathForAssignment(@assignment))
    else
      respond_to do |format|
        format.html {
          redirect_to @assignment,
          :flash => {
            :error => 'No assignment file to download. Please save your code and try again.'
          }
        }
      end
    end
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
