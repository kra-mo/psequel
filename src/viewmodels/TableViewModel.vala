namespace Psequel {
    public class TableViewModel : BaseViewModel {
        public ObservableList<Table> tables { get; set; default = new ObservableList<Table> (); }
        public Table? current_table { get; set; }

        public TableDataViewModel tabledata_viewmodel { get; set; }

        public ObservableList<Column> columns { get; set; default = new ObservableList<Column> (); }
        public ObservableList<Index> indexes { get; set; default = new ObservableList<Index> (); }
        public ObservableList<ForeignKey> foreign_keys { get; set; default = new ObservableList<ForeignKey> (); }


        public TableViewModel (Schema schema, QueryService query_service) {
            Object ();
            tables.append_all (schema.tables);

            this.notify["current-table"].connect (() => {
                columns.clear ();
                indexes.clear ();
                foreign_keys.clear ();

                columns.append_all (current_table.columns);
                indexes.append_all (current_table.indexes);
                foreign_keys.append_all (current_table.foreign_keys);

                tabledata_viewmodel = new TableDataViewModel (query_service);
                tabledata_viewmodel.selected_table = current_table;

                debug ("HIHI");
            });
        }
    }
}