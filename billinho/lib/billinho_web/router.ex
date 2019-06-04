defmodule BillinhoWeb.Router do
  use BillinhoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BillinhoWeb, as: :api do
    pipe_through :api

    # get "/", PageController, :index

    scope "/v1", Api.V1, as: :v1 do
      resources "/students", StudentController, only: [:index]
      resources "/invoices", InvoiceController, only: [:index]
      resources "/enrollments", EnrollmentController, only: [:index]
    end
  end
end
