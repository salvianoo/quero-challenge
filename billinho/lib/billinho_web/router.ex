defmodule BillinhoWeb.Router do
  use BillinhoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BillinhoWeb, as: :api do
    pipe_through :api

    # get "/", PageController, :index

    scope "/v1", Api.V1, as: :v1 do
      resources "/institutes", InstituteController, except: [:new, :edit]
      resources "/students", StudentController, except: [:new, :edit]
      resources "/enrollments", EnrollmentController, except: [:new, :edit]
      resources "/invoices", InvoiceController, except: [:new, :edit]
    end
  end
end
