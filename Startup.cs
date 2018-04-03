using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;


namespace MetricsCore
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
           // System.Text.Encoding.RegisterProvider(System.Text.CodePagesEncodingProvider.Instance);
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
           // System.Text.Encoding.RegisterProvider(System.Text.CodePagesEncodingProvider.Instance);
            services.AddMvc();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            System.Text.Encoding.RegisterProvider(System.Text.CodePagesEncodingProvider.Instance);
       
            if (true)
            {
                app.UseDeveloperExceptionPage();
            }
           
            app.UseStaticFiles();

            app.UseMvc(routes =>
            {
                routes.MapRoute(
                    name: "default",
                    template: "{controller=Metrics}/{action=UploadToServer}/{id?}");
            });
        }
    }
}
