package pl.dmcs.service;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Service;
import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.Rental;

import java.io.IOException;
import java.io.OutputStream;

@Service
public class PdfServiceImpl implements PdfService {

    public void generatePdf(Rental rental, HttpServletResponse response) {
        try {
            OutputStream o = response.getOutputStream();
            response.setCharacterEncoding("UTF-8");
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "inline; filename=" + rental.getClient().getId() + ".pdf");

            Document pdf = new Document();
            PdfWriter.getInstance(pdf, o);
            pdf.open();

            // Add rental confirmation title

            Paragraph title = new Paragraph("Rental Confirmation");
            title.setAlignment(Element.ALIGN_CENTER);
            pdf.add(title);

            pdf.add(Chunk.NEWLINE);

            // Create a table for rental information
            PdfPTable table = new PdfPTable(2);

            // Add rental details to the table
            table.addCell("Car:");
            table.addCell(rental.getCar().getMake() + " " + rental.getCar().getModel());

            table.addCell("Car plate:");
            table.addCell(rental.getCar().getRegistrationNumber());

            table.addCell("Rented by:");
            table.addCell(rental.getClient().getFirstName() + " " + rental.getClient().getLastName());

            table.addCell("Rental Date:");
            table.addCell(rental.getRentalDate().toString());

            table.addCell("Return Date:");
            table.addCell(rental.getReturnDate().toString());


            table.addCell("Card Number:");
            table.addCell(rental.getCardNumber());

            table.addCell("Expiration Date:");
            table.addCell(rental.getExpirationDate());


            pdf.add(table);

            Paragraph last1 = new Paragraph("You can pick your car in our shop! Address: Radwanska 40-42 Lodz");
            pdf.add(last1);
            Paragraph last = new Paragraph("Thank you for renting your car with us!");
            pdf.add(last);
            pdf.close();
            o.close();
        } catch (IOException | DocumentException e) {
            e.printStackTrace();
        }
    }
}

