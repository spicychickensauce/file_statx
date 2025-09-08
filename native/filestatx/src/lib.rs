use rustler::{NifStruct, NifTaggedEnum};
use std::{
    fs::{self, Metadata},
    os::unix::fs::{MetadataExt, PermissionsExt},
    time::SystemTime,
};

#[derive(Debug, NifTaggedEnum)]
enum FileType {
    Regular,
    Directory,
    Symlink,
}

#[derive(Debug, NifStruct)]
#[module = "FileStatx"]
struct FileStatx {
    r#type: FileType,
    atime: Option<u128>,
    ctime: Option<u128>,
    mtime: Option<u128>,
    size: u64,
    mode: u32,
}

#[rustler::nif]
fn stat(path: String) -> Result<FileStatx, String> {
    let metadata = fs::metadata(path).map_err(|err| err.to_string())?;
    println!("{metadata:?}");
    Ok(FileStatx {
        r#type: get_file_type(&metadata),
        ctime: metadata.created().ok().and_then(to_unix),
        mtime: metadata.modified().ok().and_then(to_unix),
        atime: metadata.accessed().ok().and_then(to_unix),
        size: metadata.size(),
        mode: metadata.permissions().mode(),
    })
}

fn to_unix(t: SystemTime) -> Option<u128> {
    let d = t.duration_since(SystemTime::UNIX_EPOCH).ok()?;
    Some(d.as_nanos())
}

fn get_file_type(m: &Metadata) -> FileType {
    if m.is_dir() {
        FileType::Directory
    } else if m.is_file() {
        FileType::Regular
    } else {
        FileType::Symlink
    }
}

rustler::init!("Elixir.FileStatx");
