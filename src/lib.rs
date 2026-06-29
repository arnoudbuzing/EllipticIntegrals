use wolfram_library_link::export;

// --- Legendre Complete Integrals ---

#[export]
fn ellipk(m: f64) -> f64 {
    ellip::ellipk(m).unwrap_or(std::f64::NAN)
}

#[export]
fn ellipe(m: f64) -> f64 {
    ellip::ellipe(m).unwrap_or(std::f64::NAN)
}

#[export]
fn ellippi(n: f64, m: f64) -> f64 {
    ellip::ellippi(n, m).unwrap_or(std::f64::NAN)
}

#[export]
fn ellipd(m: f64) -> f64 {
    ellip::ellipd(m).unwrap_or(std::f64::NAN)
}

// --- Legendre Incomplete Integrals ---

#[export]
fn ellipf(phi: f64, m: f64) -> f64 {
    ellip::ellipf(phi, m).unwrap_or(std::f64::NAN)
}

#[export]
fn ellipeinc(phi: f64, m: f64) -> f64 {
    ellip::ellipeinc(phi, m).unwrap_or(std::f64::NAN)
}

#[export]
fn ellippiinc(phi: f64, n: f64, m: f64) -> f64 {
    ellip::ellippiinc(phi, n, m).unwrap_or(std::f64::NAN)
}

#[export]
fn ellippiinc_bulirsch(phi: f64, n: f64, m: f64) -> f64 {
    ellip::ellippiinc_bulirsch(phi, n, m).unwrap_or(std::f64::NAN)
}

#[export]
fn ellipdinc(phi: f64, m: f64) -> f64 {
    ellip::ellipdinc(phi, m).unwrap_or(std::f64::NAN)
}

// --- Bulirsch's Integrals ---

#[export]
fn cel(kc: f64, p: f64, a: f64, b: f64) -> f64 {
    ellip::cel(kc, p, a, b).unwrap_or(std::f64::NAN)
}

#[export]
fn cel1(kc: f64) -> f64 {
    ellip::cel1(kc).unwrap_or(std::f64::NAN)
}

#[export]
fn cel2(kc: f64, a: f64, b: f64) -> f64 {
    ellip::cel2(kc, a, b).unwrap_or(std::f64::NAN)
}

#[export]
fn el1(x: f64, kc: f64) -> f64 {
    ellip::el1(x, kc).unwrap_or(std::f64::NAN)
}

#[export]
fn el2(x: f64, kc: f64, a: f64, b: f64) -> f64 {
    ellip::el2(x, kc, a, b).unwrap_or(std::f64::NAN)
}

#[export]
fn el3(x: f64, kc: f64, p: f64) -> f64 {
    ellip::el3(x, kc, p).unwrap_or(std::f64::NAN)
}

// --- Carlson's Symmetric Integrals ---

#[export]
fn elliprf(x: f64, y: f64, z: f64) -> f64 {
    ellip::elliprf(x, y, z).unwrap_or(std::f64::NAN)
}

#[export]
fn elliprg(x: f64, y: f64, z: f64) -> f64 {
    ellip::elliprg(x, y, z).unwrap_or(std::f64::NAN)
}

#[export]
fn elliprd(x: f64, y: f64, z: f64) -> f64 {
    ellip::elliprd(x, y, z).unwrap_or(std::f64::NAN)
}

#[export]
fn elliprj(x: f64, y: f64, z: f64, p: f64) -> f64 {
    ellip::elliprj(x, y, z, p).unwrap_or(std::f64::NAN)
}

#[export]
fn elliprc(x: f64, y: f64) -> f64 {
    ellip::elliprc(x, y).unwrap_or(std::f64::NAN)
}
