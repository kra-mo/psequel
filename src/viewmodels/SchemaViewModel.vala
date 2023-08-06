namespace Psequel {
    public class SchemaViewModel : BaseViewModel {

        const string DEFAULT = "public";

        public ObservableList<Schema> schemas { get; set; default = new ObservableList<Schema> (); }
        public Schema? current_schema { get; set; }

        // Child viewmodel
        public TableViewModel table_viewmodel { get; set; }
        public ViewViewModel view_viewmodel { get; set; }

        public SchemaRepository repository;

        // Services
        public QueryService query_service { get; construct; }
        public SchemaService schema_service { get; private set; }

        public SchemaViewModel (QueryService service) {
            Object (query_service: service);

            this.notify["current-schema"].connect (() => {
                table_viewmodel = new TableViewModel (current_schema, query_service);
                view_viewmodel = new ViewViewModel (current_schema);

                table_viewmodel.current_table = (Table) table_viewmodel.tables.get_item (0);
                view_viewmodel.current_view = view_viewmodel.views[0];
            });
        }

        public async void connect_db (Connection conn) throws PsequelError {
            yield query_service.connect_db (conn);

            // auto load schema
            yield list_schemas ();
        }

        public async void load_schema (Schema schema) throws PsequelError {
            yield schema_service.load_schema (schema);

            current_schema = schema;
        }

        public async void list_schemas () throws PsequelError {

            schema_service = new SchemaService (query_service);

            var unload_schemas = yield schema_service.get_schemas ();

            schemas.append_all (unload_schemas);
        }
    }
}