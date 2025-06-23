defmodule SeraphoRankWeb.Router do
    use SeraphoRankWeb, :router

    pipeline :api do
        plug :accepts, ["json"]
    end

    scope "/", SeraphoRankWeb do
        pipe_through :api

        get "/rank", UsersController, :rank 
        post "/submit", UsersController, :submit

        get "/*any", UsersController, :error
        post "/*any", UsersController, :error
    end

    # Enable LiveDashboard and Swoosh mailbox preview in development
    if Application.compile_env(:serapho_rank, :dev_routes) do
        # If you want to use the LiveDashboard in production, you should put
        # it behind authentication and allow only admins to access it.
        # If your application does not have an admins-only section yet,
        # you can use Plug.BasicAuth to set up some basic authentication
        # as long as you are also using SSL (which you should anyway).

        scope "/dev" do
            pipe_through [:fetch_session, :protect_from_forgery]
        end
    end
end
