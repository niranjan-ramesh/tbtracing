<%@ Page Title="Error" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ErrorPage.aspx.vb" Inherits="TBTracing.ErrorPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <section class="content-header">
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-home"></i> Home</a></li>
        </ol>
    </section>

    <section class="content">
        
        <div class="row header-row">
            <div class="col-xs-12">
                <div class="page-header">
                    <div class="pull-left">
                        <h1 class="page-title"><i class="fa fa-exclamation-triangle"></i> Error</h1>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6 col-lg-offset-3">
                <div class="well well-lg well-danger margin-top-50">
                    <div class="text-center">
                        <i class="fa fa-exclamation-triangle fa-5x text-danger"></i><br />
                        <h2>We're Sorry, something went wrong!</h2>
                        <hr />
                        <h3><asp:Label ID="lblErrorMessage" runat="server" Text="Application Error"></asp:Label></h3>
                        <div class="margin-top-50">
                            <asp:LinkButton ID="homeButton" runat="server" CssClass="btn btn-primary" PostBackUrl="~/Default.aspx"><i class="fa fa-tachometer"></i> Go to Dashboard</asp:LinkButton>
                        </div>
                    </div>
                    
                </div>
            </div>
        </div>
    </section>
</asp:Content>
