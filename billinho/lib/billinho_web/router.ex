defmodule BillinhoWeb.Router do
  use BillinhoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BillinhoWeb, as: :api do
    pipe_through :api

    scope "/v1", Api.V1, as: :v1 do
      resources "/institutes", InstituteController, except: [:edit, :new]
      resources "/students", StudentController, except: [:edit, :new]
      resources "/enrollments", EnrollmentController, except: [:edit, :new]

      resources "/invoices", InvoiceController, only: [:index, :show]
    end
  end
end
