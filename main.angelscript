/*
 Hello world!
*/

#include "eth_util.angelscript"
#include "Collide.angelscript"
#include "force.angelscript"
float speed;

void main()
{
	LoadScene("scenes/open.esc", "openCreate", "openUpdate");
	//LoadScene("scenes/testing.esc", "testCreate", "testUpdate");

	// Prefer setting window properties in the app.enml file
	SetWindowProperties("FRACTURE", 1024, 768, true, true, PF32BIT);
}
///Opening Scene///
void openCreate()
{
	SetCameraPos(vector2(0,0));
	HideCursor(true);
	//DrawText(vector2(100,200), "Text drawing test!", "Verdana64_shadow.fnt", ARGB(250,255,255,255));
}
void openUpdate()
{
	ETHInput @input = GetInputHandle();
	if (input.GetKeyState(K_ENTER) == KS_HIT)
	{
		LoadScene("scenes/testing.esc", "testCreate", "testUpdate");
	}
	DrawText(vector2(335,500), "Press Enter", "Verdana64_shadow.fnt", ARGB(250,10,255,100));
}

///test field///
void testCreate()
{
	ETHEntity @ship = SeekEntity("ship.ent");
	ship.SetPositionXY(vector2(0,0));
}

void ETHCallback_ship(ETHEntity@ thisEntity)
{
	ETHInput @input = GetInputHandle();
	ETHPhysicsController @body = thisEntity.GetPhysicsController();
	SetCameraPos(thisEntity.GetPositionXY() - (GetScreenSize() / 2.0f));
	speed = UnitsPerSecond(500.0f);
	vector2 move = KeyboardInput();
	if (input.GetKeyState(K_A) == KS_DOWN)
	{
		speed = UnitsPerSecond(50000.0f);
	}
	vector2 pos = thisEntity.GetPositionXY();
	print(vector2ToString(pos));
	//thisEntity.AddToPositionXY(KeyboardInput() * speed);
	body.SetLinearVelocity(normalize(move) * speed);
	//thisEntity.SetPositionXY(0,0);




	//thisEntity.AddToPositionXY(normalize(move) * speed);
	print(vector2ToString(move));

	if (input.GetKeyState(K_ESC) == KS_HIT)
			Exit();

}

vector2 KeyboardInput()
{
	ETHInput @input = GetInputHandle();
	vector2 keydir(0, 0);

	if (input.KeyDown(K_LEFT))
		keydir.x +=-1;

	if (input.KeyDown(K_RIGHT))
		keydir.x += 1;

	if (input.KeyDown(K_UP))
		keydir.y +=-1;
		
	if (input.KeyDown(K_DOWN))
		keydir.y += 1;

	return keydir;
}