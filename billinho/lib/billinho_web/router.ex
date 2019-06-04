defmodule BillinhoWeb.Router do
  use BillinhoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BillinhoWeb do
    pipe_through :api

    get "/", PageController, :index

    resources "/students", StudentController, only: [:index]
    resources "/invoices", InvoiceController, only: [:index]
    resources "/enrollments", EnrollmentController, only: [:index]
  end
end
