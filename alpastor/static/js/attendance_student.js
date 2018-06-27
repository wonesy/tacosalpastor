function addFileUploadButton() {
    if (document.getElementById('id_file_upload') === null) {
        let divName = document.getElementById('fileUpload');
        let addInput = document.createElement('INPUT');
        addInput.setAttribute('type', 'file');
        addInput.setAttribute('name', 'file_upload');
        addInput.setAttribute('id', 'id_file_upload');
        divName.appendChild(addInput);
        console.log(divName);
    }
}