-- Blade snippets for LuaSnip
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local snippets = {
  -- Blade control structures
  s("@if", {
    t("@if ("), i(1, "condition"), t(")"),
    t({"", "    "}), i(0),
    t({"", "@endif"}),
  }),
  
  s("@foreach", {
    t("@foreach ("), i(1, "$items"), t(" as "), i(2, "$item"), t(")"),
    t({"", "    "}), i(0),
    t({"", "@endforeach"}),
  }),
  
  s("@forelse", {
    t("@forelse ("), i(1, "$items"), t(" as "), i(2, "$item"), t(")"),
    t({"", "    "}), i(3),
    t({"", "@empty"}),
    t({"", "    "}), i(0),
    t({"", "@endforelse"}),
  }),
  
  s("@for", {
    t("@for ("), i(1, "$i = 0"), t("; "), i(2, "$i < 10"), t("; "), i(3, "$i++"), t(")"),
    t({"", "    "}), i(0),
    t({"", "@endfor"}),
  }),
  
  s("@while", {
    t("@while ("), i(1, "condition"), t(")"),
    t({"", "    "}), i(0),
    t({"", "@endwhile"}),
  }),
  
  -- Blade templates
  s("@extends", {
    t("@extends('"), i(1, "layouts.app"), t("')"),
  }),
  
  s("@section", {
    t("@section('"), i(1, "content"), t("')"),
    t({"", "    "}), i(0),
    t({"", "@endsection"}),
  }),
  
  s("@include", {
    t("@include('"), i(1, "partials.header"), t("')"),
  }),
  
  s("@component", {
    t("@component('"), i(1, "components.alert"), t("')"),
    t({"", "    "}), i(0),
    t({"", "@endcomponent"}),
  }),
  
  -- Authentication
  s("@auth", {
    t("@auth"),
    t({"", "    "}), i(0),
    t({"", "@endauth"}),
  }),
  
  s("@guest", {
    t("@guest"),
    t({"", "    "}), i(0),
    t({"", "@endguest"}),
  }),
  
  -- Laravel output
  s("{{", {
    t("{{ "), i(1, "$variable"), t(" }}"),
  }),
  
  s("{!!", {
    t("{!! "), i(1, "$html"), t(" !!}"),
  }),
  
  -- Common Laravel helpers
  s("route", {
    t("{{ route('"), i(1, "route.name"), t("') }}"),
  }),
  
  s("asset", {
    t("{{ asset('"), i(1, "path/to/asset"), t("') }}"),
  }),
  
  s("url", {
    t("{{ url('"), i(1, "path"), t("') }}"),
  }),
  
  s("old", {
    t("{{ old('"), i(1, "field_name"), t("') }}"),
  }),
  
  s("@error", {
    t("@error('"), i(1, "field"), t("')"),
    t({"", "    "}), i(0),
    t({"", "@enderror"}),
  }),
  
  -- Forms
  s("@csrf", {
    t("@csrf"),
  }),
  
  s("@method", {
    t("@method('"), i(1, "PUT"), t("')"),
  }),
  
  -- Slots
  s("@slot", {
    t("@slot('"), i(1, "name"), t("')"),
    t({"", "    "}), i(0),
    t({"", "@endslot"}),
  }),
  
  -- Props
  s("@props", {
    t("@props(['"), i(1, "title"), t("'])"),
  }),
}

return snippets
