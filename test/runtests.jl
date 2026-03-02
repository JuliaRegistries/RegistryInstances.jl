import RegistryInstances
using Test: Test, @testset, @test

using Base: UUID

@testset "RegistryInstances.jl" begin
    general_registry = only(
        filter!(
            x -> x.name == "General",
            RegistryInstances.reachable_registries(),
        )
    )
    @test general_registry isa RegistryInstances.RegistryInstance
    @test general_registry.name == "General"
    @test general_registry.uuid == UUID("23338594-aafe-5451-b93e-139f81909106")
    @test !isempty(general_registry.pkgs)
    example_entry = general_registry.pkgs[UUID("7876af07-990d-54b4-ab0e-23690620f79a")]
    @test example_entry isa RegistryInstances.PkgEntry
    @test example_entry.name == "Example"
    @test example_entry.uuid == UUID("7876af07-990d-54b4-ab0e-23690620f79a")
    example_info = RegistryInstances.registry_info(example_entry)
    @test example_info isa RegistryInstances.PkgInfo
    @test lowercase(strip(example_info.repo)) == lowercase("https://github.com/JuliaLang/Example.jl.git")
end
