package pl.dmcs.service;


import jakarta.servlet.http.HttpServletResponse;
import pl.dmcs.domain.AppUser;
import pl.dmcs.domain.Rental;


public interface PdfService {
    public void generatePdf(Rental rental, HttpServletResponse response);
}
