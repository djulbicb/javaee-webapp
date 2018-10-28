
package model;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

@Entity
@Table(name = "manufactors")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Manufactor.findAll", query = "SELECT m FROM Manufactor m")
    , @NamedQuery(name = "Manufactor.findById", query = "SELECT m FROM Manufactor m WHERE m.id = :id")
    , @NamedQuery(name = "Manufactor.findByName", query = "SELECT m FROM Manufactor m WHERE m.name = :name")
    , @NamedQuery(name = "Manufactor.findByDescription", query = "SELECT m FROM Manufactor m WHERE m.description = :description")})
public class Manufactor implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    private Integer id;
    @Size(max = 256)
    private String name;
    @Size(max = 512)
    private String description;
    @OneToMany(mappedBy = "manufactorId", fetch = FetchType.EAGER)
    private Collection<Product> productCollection;

    public Manufactor() {
    }

    public Manufactor(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @XmlTransient
    public Collection<Product> getProductCollection() {
        return productCollection;
    }

    public void setProductCollection(Collection<Product> productCollection) {
        this.productCollection = productCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Manufactor)) {
            return false;
        }
        Manufactor other = (Manufactor) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Manufactor[ id=" + id + " ]";
    }

}
