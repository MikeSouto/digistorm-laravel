@extends('layouts.base')

@section('title', 'Gallery')

@section('content')
<div class="row">
    <div class="col-xs-12">
        <h1>Gallery</h1>
    </div>
</div>
<div class="row">
    <form action="./index.php" method="GET" accept-charset="UTF-8">
        <div class="col-xs-9 form-group">
            <label>Image type</label>
            <select name="type" class="form-control" id="type">
                <option value="" {{ $img_type == "" ? 'selected' : '' }}>All</option>
                @if (count($types) > 0)
                @foreach ($types as $type)
                <option value="{{ $type }}" {{ $img_type == $type ? 'selected' : '' }}>{{ $type }}</option>
                @endforeach
                @endif
            </select>
        </div>
        <div class="col-xs-9 form-group text-left">
            <button type="submit" class="btn btn-success">Submit</button>
        </div>
    </form>
</div>
<div class="row">
    @if (count($images) > 0)
    @foreach ($images as $image)
    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-6">
        <a href="{{ $image['fullpath'] }}" data-toggle="lightbox" data-title="{{ $image['name'] }}">
            <img src="{{ $image['fullpath'] }}" class="img-thumbnail">
        </a>
    </div>
    @endforeach
    @endif
</div>
@endsection

@section('javascript')
<script type="text/javascript">
    $(document).on('click', '[data-toggle="lightbox"]', function(event) {
        event.preventDefault();
        $(this).ekkoLightbox();
    });
</script>
@endsection