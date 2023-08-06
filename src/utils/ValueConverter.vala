namespace Psequel {
    public class ValueConverter {
        public static List<Connection> deserialize_connection (string json_data) {
            var parser = new Json.Parser ();
            var recent_connections = new List<Connection> ();

            try {
                parser.load_from_data (json_data);
                var root = parser.get_root ();
                var conns = root.get_array ();

                conns.foreach_element ((array, index, node) => {
                    var conn = (Connection) Json.gobject_deserialize (typeof (Connection), node);
                    recent_connections.append (conn);
                });
            } catch (Error err) {
                debug (err.message);
            }

            return (owned) recent_connections;
        }

        public static string serialize_connection (List<Connection> conns) {

            var builder = new Json.Builder ();
            builder.begin_array ();

            foreach (var conn in conns) {
                builder.add_value (Json.gobject_serialize (conn));
            }
            builder.end_array ();

            var node = builder.get_root ();
            return Json.to_string (node, true);
        }
    }
}