import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/models/category_model.dart';
import '../details_screens/category_details_screen.dart';


class BrowseTab extends StatelessWidget {
   BrowseTab({super.key});
  var category =CategoryModel.getCategories();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50,left: 20,right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text("Browse Category",
          style: GoogleFonts.inter(
              fontSize: 27,
              color: Colors.white,
              fontWeight: FontWeight.w400
          ),),
        Expanded(
          child: GridView.builder(
          
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 30,
              mainAxisSpacing: 0
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, CategoryDetailsScreen.routeName,
                  arguments: category[index]);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 27),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(category[index].imagePath,
                        fit: BoxFit.fill,
                          height: double.infinity,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(130, 128, 128, 128),
                        ),
                        height: double.infinity,
                      ),
                      Center(
                        child: Text(category[index].label,style:
                          GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,


                          ),),
                      )
                    ],
                  ),

                ),
              );
            },
            itemCount: category.length,
          ),
        )

      ],),
    )
;
  }
}
