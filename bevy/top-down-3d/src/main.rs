use bevy::prelude::*;
use heron::prelude::*;

const CELL_SIZE: f32 = 1.0;

#[derive(Component)]
struct Hero;

#[derive(Component)]
struct World;

#[derive(PhysicsLayer)]
enum Layer {
    Hero,
    World,
}

// #[derive(Debug, Clone, PartialEq, Eq, Hash)]
// enum AppState {
//     Setup,
//     Finished
// }

fn main() {
    App::new()
        .add_plugins(DefaultPlugins)
        .add_plugin(PhysicsPlugin::default())
        .insert_resource(Gravity::from(Vec3::new(0.0, -9.81, 0.0)))
        .insert_resource(Msaa { samples: 4 })
        .insert_resource(WindowDescriptor {
            title: "Top Down in 3D!".to_string(),
            width: 1600.,
            height: 1600.,
            ..Default::default()
        })
        // .add_state(AppState::Setup)
        // .add_system_set(SystemSet::on_enter(AppState::Setup).with_system(load_assets))
        // .add_system_set(SystemSet::on_enter(AppState::Finished).with_system(setup))
        .add_system(setup)
        .add_system(input)
        .run();
}

// fn load_assets(
//     mut state: ResMut<State<AppState>>,
//     mut commands: Commands,
//     mut texture_atlases: ResMut<Assets<TextureAtlas>>,
//     asset_server: Res<AssetServer>)
// {
//     let texture_handle = asset_server.load("dungeon.png");
//     let texture_atlas = TextureAtlas::from_grid(texture_handle, Vec2::new(32.0, 32.0), 4, 28);
//     let texture_atlas_handle = texture_atlases.add(texture_atlas);
//
//     commands.spawn_bundle(SpriteSheetBundle {
//         texture_atlas: texture_atlas_handle,
//         ..Default::default()
//     });
//
//     state.set(AppState::Finished).unwrap();
// }

fn input(keyboard_input: Res<Input<KeyCode>>, mut hero: Query<&mut Transform, With<Hero>>) {
    for mut transform in hero.iter_mut().next() {
        if keyboard_input.pressed(KeyCode::Up) {
            transform.translation.x -= 2.;
        }
        if keyboard_input.pressed(KeyCode::Down) {
            transform.translation.x += 2.;
        }
        if keyboard_input.pressed(KeyCode::Left) {
            transform.translation.z -= 2.;
        }
        if keyboard_input.pressed(KeyCode::Right) {
            transform.translation.z += 2.;
        }
    }
}

fn setup(
    mut commands: Commands,
    mut meshes: ResMut<Assets<Mesh>>,
    mut materials: ResMut<Assets<StandardMaterial>>,
    asset_server: Res<AssetServer>)
{
    let texture = asset_server.load("tile-0.png");

    let material_handler = materials.add(StandardMaterial{
        base_color: Color::rgb(0.0, 0.0, 1.0),
        base_color_texture: Some(texture),
        alpha_mode: AlphaMode::Blend,
        unlit: true,
        ..Default::default()
    });

    // plane
    commands
        .spawn_bundle(PbrBundle {
            mesh: meshes.add(Mesh::from(shape::Box::new(CELL_SIZE * 10., 0., CELL_SIZE * 3.0)
            )),
            material: material_handler,
            // material: materials.add(Color::rgb(0.3, 0.5, 0.3).into()),
            ..Default::default()
        })
        .insert(World)
        .insert(RigidBody::Dynamic)
        .insert(CollisionShape::Cuboid {
            half_extends: Vec3::new(1., 1., 1.), border_radius: Some(0.)
        });

    // Hero
    commands
        .spawn_bundle(PbrBundle {
            mesh: meshes.add(Mesh::from(shape::Cube { size: CELL_SIZE })),
            material: materials.add(Color::rgb(0.8, 0.7, 0.6).into()),
            transform: Transform::from_xyz(0.0, CELL_SIZE / 2., 0.0),
            ..Default::default()
        })
        .insert(Hero)
        .insert(RigidBody::Dynamic)
        .insert(CollisionShape::Cuboid {
            half_extends: Vec3::new(1., 1., 1.), border_radius: Some(0.)
        });

    // light
    commands.spawn_bundle(PointLightBundle {
        point_light: PointLight {
            intensity: 1500.0,
            shadows_enabled: true,
            ..Default::default()
        },
        transform: Transform::from_xyz(4.0, 8.0, 4.0),
        ..Default::default()
    });

    // camera
    commands.spawn_bundle(PerspectiveCameraBundle {
        transform: Transform::from_xyz(-10.0, 20.0, 0.0).looking_at(Vec3::ZERO, Vec3::Y),
        ..Default::default()
    });
}
