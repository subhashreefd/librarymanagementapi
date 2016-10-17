require 'test_helper'

class BooksOnLoansControllerTest < ActionController::TestCase
  setup do
    @books_on_loan = books_on_loans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:books_on_loans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create books_on_loan" do
    assert_difference('BooksOnLoan.count') do
      post :create, books_on_loan: { book_id: @books_on_loan.book_id, borrower_id: @books_on_loan.borrower_id }
    end

    assert_redirected_to books_on_loan_path(assigns(:books_on_loan))
  end

  test "should show books_on_loan" do
    get :show, id: @books_on_loan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @books_on_loan
    assert_response :success
  end

  test "should update books_on_loan" do
    put :update, id: @books_on_loan, books_on_loan: { book_id: @books_on_loan.book_id, borrower_id: @books_on_loan.borrower_id }
    assert_redirected_to books_on_loan_path(assigns(:books_on_loan))
  end

  test "should destroy books_on_loan" do
    assert_difference('BooksOnLoan.count', -1) do
      delete :destroy, id: @books_on_loan
    end

    assert_redirected_to books_on_loans_path
  end
end
