import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static final String routeName = '/filters';
  final _currentFilters;
  final _setFilters;

  FiltersScreen(this._currentFilters, this._setFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var isGlutenFree = false;
  var isVegan = false;
  var isVegetarian = false;
  var isLactoseFree = false;

  @override
  initState() {
    isGlutenFree = widget._currentFilters['glutten'];
    isLactoseFree = widget._currentFilters['lactose'];
    isVegetarian = widget._currentFilters['vegetarian'];
    isVegan = widget._currentFilters['vegan'];
    super.initState();
  }

  Widget _buildSwitchTile(
      String title, String subtitle, bool val, Function onChange) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: val,
      onChanged: onChange,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              widget._setFilters({
                "glutten": isGlutenFree,
                "lactose": isLactoseFree,
                "vegetarian": isVegetarian,
                "vegan": isVegan,
              });
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            child: Text(
              'Adjust your meal selection!',
              style: Theme.of(context).textTheme.title,
            ),
            padding: EdgeInsets.all(20),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchTile(
                  'Glutten-free',
                  'Only include gluten-free meals',
                  isGlutenFree,
                  (newVal) {
                    setState(() {
                      isGlutenFree = newVal;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Lactose-free',
                  'Only include Lactose-free meals',
                  isLactoseFree,
                  (newVal) {
                    setState(() {
                      isLactoseFree = newVal;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Vegetarian',
                  'Only include vegetarian meals',
                  isVegetarian,
                  (newVal) {
                    setState(() {
                      isVegetarian = newVal;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Vegan',
                  'Only include vegan meals',
                  isVegan,
                  (newVal) {
                    setState(() {
                      isVegan = newVal;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
