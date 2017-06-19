--Anime Archtype
function c420.initial_effect(c)
	--1st parameter = card, 2nd parameter = IsFusion
end

-- Alligator
c420.OCGAlligator={
	[39984786]=true; [4611269]=true; [59383041]=true; [66451379]=true;
}
function c420.IsAlligator(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x41e) or c420.OCGAlligator[c:GetFusionCode()]
	else
		return c:IsSetCard(0x41e) or c420.OCGAlligator[c:GetCode()]
	end
end

-- Angel (archetype)
c420.OCGAngel={
	[79575620]=true;[68007326]=true;[39996157]=true;[11398951]=true;[15914410]=true;[32224143]=true;
	[16972957]=true;[16946849]=true;[42216237]=true;[42418084]=true;[59509952]=true;[18378582]=true;
	[81146288]=true;[85399281]=true;[47852924]=true;[74137509]=true;[17653779]=true;[9032529]=true;
	[79571449]=true;[2130625]=true;[21297224]=true;[49674183]=true;[69992868]=true;[96470883]=true;
}
function c420.IsAngel(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x1407) or c420.OCGAngel[c:GetFusionCode()] or c:IsFusionSetCard(0xef)
	else
		return c:IsSetCard(0x1407) or c420.OCGAngel[c:GetCode()] or c:IsSetCard(0xef)
	end
end

-- Anti
c420.OCGAnti={
	[52085072]=true;[59839761]=true;
}
function c420.IsAnti(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x216) or c420.OCGAnti[c:GetFusionCode()]
	else
		return c:IsSetCard(0x216) or c420.OCGAnti[c:GetCode()]
	end
end

-- Assassin
c420.OCGAssassin={
	[48365709]=true;[19357125]=true;[16226786]=true;[2191144]=true;[25262697]=true;[28150174]=true;
	[77558536]=true;
}
function c420.IsAssassin(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x41f) or c420.OCGAssassin[c:GetFusionCode()]
	else
		return c:IsSetCard(0x41f) or c420.OCGAssassin[c:GetCode()]
	end
end

-- Astral
c420.OCGAstral={
	[37053871]=true;[45950291]=true;
}
function c420.IsAstral(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x401) or c420.OCGAstral[c:GetFusionCode()]
	else
		return c:IsSetCard(0x401) or c420.OCGAstral[c:GetCode()]
	end
end

-- Atlandis
function c420.IsAtlandis(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x41c) or c:IsFusionCode(9161357,6387204)
	else
		return c:IsSetCard(0x41c) or c:IsCode(9161357,6387204)
	end
end

-- Barian (archetype) バリアン
function c420.IsBarian(c,fbool)
	if c420.IsBarians(c,fbool) or c420.IsBattleguard(c,fbool) then return true end
	if fbool then
		return c:IsFusionSetCard(0x310) or c:IsFusionCode(67926903)
	else
		return c:IsSetCard(0x310) or c:IsCode(67926903)
	end
end

-- Barian's バリアンズ
c420.OCGBarians={
	-- Rank-Up-Magic Barian's Force, Rank-Up-Magic Limited Barian's Force
	[47660516]=true;[92365601]=true;
}
function c420.IsBarians(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x1310) or c420.OCGBarians[c:GetFusionCode()]
	else
		return c:IsSetCard(0x1310) or c420.OCGBarians[c:GetCode()]
	end
end

-- Battleguard バーバリアン
c420.OCGBattleguard={
	-- Battleguard King, Lava Battleguard, Swamp Battleguard, Battleguard Howling, Battleguard Rage
	[39389320]=true;[20394040]=true;[40453765]=true;[78621186]=true;[42233477]=true;
}
function c420.IsBattleguard(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x2310) or c420.OCGBattleguard[c:GetFusionCode()]
	else
		return c:IsSetCard(0x2310) or c420.OCGBattleguard[c:GetCode()]
	end
end

-- Blackwing Tamer
function c420.IsBlackwingTamer(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x2033) or c:IsFusionCode(81983656)
	else
		return c:IsSetCard(0x2033) or c:IsCode(81983656)
	end
end

-- Butterfly
function c420.IsButterfly(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x421) or c420.OCGButterfly[c:GetFusionCode()]
	else
		return c:IsSetCard(0x421) or c420.OCGButterfly[c:GetCode()]
	end
end

-- Cat
c420.OCGCat={
	[84224627]=true;[43352213]=true;[88032456]=true;[2729285]=true;[32933942]=true;[5506791]=true;
	[25531465]=true;[96501677]=true;[51777272]=true;[11439455]=true;[14878871]=true;[52346240]=true;
}
function c420.IsCat(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x305) or c420.OCGCat[c:GetFusionCode()]
	else
		return c:IsSetCard(0x305) or c420.OCGCat[c:GetCode()]
	end
end

-- Celestial
c420.OCGCelestial={
	[69865139]=true;[25472513]=true;
}
function c420.IsCelestial(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x2407) or c420.OCGCelestial[c:GetFusionCode()]
	else
		return c:IsSetCard(0x2407) or c420.OCGCelestial[c:GetCode()]
	end
end

-- Champion
c420.OCGChampion={
	[82382815]=true;[27503418]=true;
}
function c420.IsChampion(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x121a) or c420.OCGChampion[c:GetFusionCode()]
	else
		return c:IsSetCard(0x121a) or c420.OCGChampion[c:GetCode()]
	end
end
-- Clear
c420.OCGClear={
	[97811903]=true;[82044279]=true;
}
function c420.IsClear(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x306) or c420.OCGClear[c:GetFusionCode()]
	else
		return c:IsSetCard(0x306) or c420.OCGClear[c:GetCode()]
	end
end

-- Comics Hero
c420.OCGComicsHero={
	[77631175]=true;[13030280]=true;
}
function c420.IsComicsHero(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x422) or c420.OCGComicsHero[c:GetFusionCode()]
	else
		return c:IsSetCard(0x422) or c420.OCGComicsHero[c:GetCode()]
	end
end

-- Dart
function c420.IsDart(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x210) or c420.OCGDart[c:GetFusionCode()] or c:IsFusionCode(43061293)
	else
		return c:IsSetCard(0x210) or c420.OCGDart[c:GetCode()] or c:IsCode(43061293)
	end
end

-- Dice (archetype)
c420.OCGDice={
	[16725505]=true;[27660735]=true;[69893315]=true;[59905358]=true;[3549275]=true;[88482761]=true;
	[83241722]=true;
}
function c420.IsDice(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x41a) or c420.OCGDice[c:GetFusionCode()]
	else
		return c:IsSetCard(0x41a) or c420.OCGDice[c:GetCode()]
	end
end
-- Dog
c420.OCGDog={
	[72714226]=true;[79182538]=true;[42878636]=true;[34379489]=true;[15475415]=true;[57346400]=true;
	[29491334]=true;[86652646]=true;[12076263]=true;[96930127]=true;[11987744]=true;[86889202]=true;
	[39246582]=true;[23297235]=true;[6480253]=true;[47929865]=true;[94667532]=true;
}
function c420.IsDog(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x402) or c420.OCGDog[c:GetFusionCode()]
	else
		return c:IsSetCard(0x402) or c420.OCGDog[c:GetCode()]
	end
end

-- Doll
c420.OCGDoll={
	[72657739]=true;[91939608]=true;[85639257]=true;[92418590]=true;[2903036]=true;[39806198]=true;
	[49563947]=true;[82579942]=true;
}
function c420.IsDoll(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x20b) or c:IsFusionSetCard(0x9d) or c420.OCGDoll[c:GetFusionCode()]
	else
		return c:IsSetCard(0x20b) or c:IsSetCard(0x9d) or c420.OCGDoll[c:GetCode()]
	end
end

-- Druid
c420.OCGDruid={
	[24062258]=true;[97064649]=true;[7183277]=true;
}
function c420.IsDruid(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x8c) or c420.OCGDruid[c:GetFusionCode()]
	else
		return c:IsSetCard(0x8c) or c420.OCGDruid[c:GetCode()]
	end
end

-- Dyson
function c420.IsDyson(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x41b) or c:IsFusionCode(1992816,32559361)
	else
		return c:IsSetCard(0x41b) or c:IsCode(1992816,32559361)
	end
end

-- Earth (archetype)
c420.earth_collection={
	[42685062]=true;[76052811]=true;[71564150]=true;[77827521]=true;
	[75375465]=true;[70595331]=true;[94773007]=true;[45042329]=true;
}
function c420.IsEarth(c,fbool)
	if c420.IsEarthbound(c,fbool) then return true end
	if fbool then
		return c:IsFusionSetCard(0x21f) or c420.OCGEarth[c:GetFusionCode()]
	else
		return c:IsSetCard(0x21f) or c420.OCGEarth[c:GetCode()]
	end
end

-- Earthbound
c420.OCGEarthbound={
	[67105242]=true;[67987302]=true;
 }
function c420.IsEarthbound(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x121f) or c420.OCGEarthbound[c:GetFusionCode()] or c:IsFusionSetCard(0x21)
	else
		return c:IsSetCard(0x121f) or c420.OCGEarthbound[c:GetCode()] or c:IsSetCard(0x21)
	end
end

-- Elf
c420.OCGElf={
	[44663232]=true;[98582704]=true;[39897277]=true;[93221206]=true;[97170107]=true;[85239662]=true;
	[68625727]=true;[59983499]=true;[21417692]=true;[69140098]=true;[42386471]=true;[61807040]=true;
	[11613567]=true;[15025844]=true;[98299011]=true;
}
function c420.IsElf(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x405) or c420.OCGElf[c:GetFusionCode()] 
	else
		return c:IsSetCard(0x405) or c420.OCGElf[c:GetCode()] 
	end
end

-- Emissary of Darkness
function c420.IsEmissaryOfDarkness(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x423) or c:IsFusionCode(44330098)
	else
		return c:IsSetCard(0x423) or c:IsCode(44330098)
	end
end

-- Fairy (archetype)
--OCG Fairy collection
c420.OCGFairy={
	[51960178]=true;[25862681]=true;[23454876]=true;[90925163]=true;[48742406]=true;[51960178]=true;
	[45939611]=true;[20315854]=true;[1761063]=true;[6979239]=true;[55623480]=true;[42921475]=true; 	
}
function c420.IsFairy(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x412) or c420.OCGFairy[c:GetFusionCode()]
	else
		return c:IsSetCard(0x412) or c420.OCGFairy[c:GetCode()]
	end
end

-- Forest (archetype)
function c420.IsForest(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x308) or c420.OCGForest[c:GetFusionCode()]
	else
		return c:IsSetCard(0x308) or c420.OCGForest[c:GetCode()]
	end
end

-- Fossil (not finished)
function c420.IsFossil(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x1304) or c420.OCGFossil[c:GetFusionCode()]
	else
		return c:IsSetCard(0x1304) or c420.OCGFossil[c:GetCode()]
	end
end

-- Gem-Knight Lady
function c420.IsGemKnightLady(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x3047) or c:IsFusionCode(47611119,19355597)
	else
		return c:IsSetCard(0x3047) or c:IsCode(47611119,19355597)
	end
end

-- Goyo
c420.OCGGoyo={
	[7391448]=true;[63364266]=true;[98637386]=true;[84305651]=true;[58901502]=true;[59255742]=true;
}
function c420.IsGoyo(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x204) or c420.OCGGoyo[c:GetFusionCode()]
	else
		return c:IsSetCard(0x204) or c420.OCGGoyo[c:GetCode()]
	end
end

-- Hand (archetype)
c420.OCGHand={
	[28003512]=true;[52800428]=true;[62793020]=true;[68535320]=true;[95929069]=true;
	[22530212]=true;[21414674]=true;[63746411]=true;[55888045]=true;
}
function c420.IsHand(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x425) or c420.OCGHand[c:GetFusionCode()]
	else
		return c:IsSetCard(0x425) or c420.OCGHand[c:GetCode()]
	end
end

-- Heavy Industry
c420.OCGHeavyIndustry={
	[42851643]=true;[29515122]=true;[13647631]=true;
}
function c420.IsHeavyIndustry(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x426) or c420.OCGHeavyIndustry[c:GetFusionCode()]
	else
		return c:IsSetCard(0x426) or c420.OCGHeavyIndustry[c:GetCode()]
	end
end

-- Hell
c420.OCGHell={
	[36029076]=true;
}
function c420.IsHell(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x21b) or c420.OCGHell[c:GetFusionCode()]
	else
		return c:IsSetCard(0x21b) or c420.OCGHell[c:GetCode()]
	end
end

-- Heraldic (not finished)
function c420.IsHeraldic(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x427) or c420.OCGHeraldic[c:GetFusionCode()]
	else
		return c:IsSetCard(0x427) or c420.OCGHeraldic[c:GetCode()]
	end
end

-- Hunder
c420.OCGHeraldic={
	[23649496]=true;[47387961]=true;
}
function c420.IsHeraldic(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x428) or c420.OCGHeraldic[c:GetFusionCode()] or c:IsFusionSetCard(0x76)
	else
		return c:IsSetCard(0x428) or c420.OCGHeraldic[c:GetCode()] or c:IsSetCard(0x76)
	end
end

-- Inu (not finished)

-- Ivy
c420.OCGIvy={
	[30069398]=true;
}
function c420.IsIvy(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x429) or c420.OCGIvy[c:GetFusionCode()]
	else
		return c:IsSetCard(0x429) or c420.OCGIvy[c:GetCode()]
	end
end

-- Jester
c420.OCGJester={
	[72992744]=true;[8487449]=true;[88722973]=true;
}
function c420.IsJester(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x411) or c420.OCGJester[c:GetFusionCode()]
	else
		return c:IsSetCard(0x411) or c420.OCGJester[c:GetCode()]
	end
end

-- Jutte
function c420.IsJutte(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x416) or c:IsFusionCode(60410769)
	else
		return c:IsSetCard(0x416) or c:IsCode(60410769)
	end
end

-- King (not finished)
function c420.IsKing(c,fbool)
	if c420.IsChampion(c,fbool) then return true end
	if fbool then
		return c:IsFusionSetCard(0x21a) or c420.OCGKing[c:GetFusionCode()]
	else
		return c:IsSetCard(0x21a) or c420.OCGKing[c:GetCode()]
	end
end

-- Knight (not finished)
function c420.IsKnight(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x416) 
	else
		return c:IsSetCard(0x416) 
	end
end

-- Koala
c420.OCGKoala={
	-- Big Koala, Des Koala, Vampire Koala, Sea Koala, Koalo-Koala, Tree Otter
	[42129512]=true;[69579761]=true;[1371589]=true;[87685879]=true;[7243511]=true;[71759912]=true;
}
function c420.IsKoala(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x42a) or c420.OCGKoala[c:GetFusionCode()]
	else
		return c:IsSetCard(0x42a) or c420.OCGKoala[c:GetCode()]
	end
end

-- Lamp
c420.OCGLamp={
	[54912977]=true;[97590747]=true;[98049915]=true;[99510761]=true;[91584698]=true;[42002073]=true;
	[63545455]=true;
}
function c420.IsLamp(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x400) or c420.OCGLamp[c:GetFusionCode()]
	else
		return c:IsSetCard(0x400) or c420.OCGLamp[c:GetCode()]
	end
end

-- Landstar
c420.OCGLandstar={
	[3573512]=true;[83602069]=true;
}
function c420.IsLandstar(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x42b) or c420.OCGLandstar[c:GetFusionCode()]
	else
		return c:IsSetCard(0x42b) or c420.OCGLandstar[c:GetCode()]
	end
end

-- Line Monster
c420.OCGLineMonster={
	[32476434]=true;[41493640]=true;[75253697]=true;
}
function c420.IsLineMonster(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x432) or c420.OCGLineMonster[c:GetFusionCode()]
	else
		return c:IsSetCard(0x432) or c420.OCGLineMonster[c:GetCode()]
	end
end

-- Magnet
function c420.IsMagnet(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x800) or c:IsFusionSetCard(0x2066)
	else
		return c:IsSetCard(0x800) or c:IsSetCard(0x2066)
	end
end

-- Mantis (not finished)
function c420.IsMantis(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x2048) or c420.OCGMantis[c:GetFusionCode()] or c:IsFusionCode(58818411)
	else
		return c:IsSetCard(0x2048) or c420.OCGMantis[c:GetCode()] or c:IsCode(58818411)
	end
end

-- Melodious Songstress
c420.OCGMelodiousSongstress={
	[14763299]=true;[62895219]=true;
}
function c420.IsMelodiousSongtress(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x209b) or c420.OCGMelodiousSongstress[c:GetFusionCode()]
	else
		return c:IsSetCard(0x209b) or c420.OCGMelodiousSongstress[c:GetCode()]
	end
end

-- Mosquito
c420.OCGMosquito={
	[33695750]=true;[50074522]=true;[17285476]=true;
}
function c420.IsMosquito(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x21d) or c420.OCGMosquito[c:GetFusionCode()]
	else
		return c:IsSetCard(0x21d) or c420.OCGMosquito[c:GetCode()]
	end
end

-- Motor (not finished)
function c420.IsMotor(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x219) or c420.OCGMotor[c:GetFusionCode()] or c:IsFusionCode(82556058)
	else
		return c:IsSetCard(0x219) or c420.OCGMotor[c:GetCode()] or c:IsCode(82556058)
	end
end

-- Neko (not finished)

-- Number 39: Utopia (archetype) (not finished)

-- Number C39: Utopia Ray (archetype) (not finished)

-- Number S
c420.OCGNumberS={
	[52653092]=true;[56832966]=true;[86532744]=true;
}
function c420.IsNumberS(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x2048) or c420.OCGNumberS[c:GetFusionCode()]
	else
		return c:IsSetCard(0x2048) or c420.OCGNumberS[c:GetCode()]
	end
end

-- Numeron ヌメロン 
c420.OCGNumeron={
	[57314798]=true;[48333324]=true;[71345905]=true;
}
function c420.IsNumeron(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x1ff) or c420.OCGNumeron[c:GetFusionCode()]
	else
		return c:IsSetCard(0x1ff) or c420.OCGNumeron[c:GetCode()]
	end
end

-- Paleozoic (anime)
function c420.IsPaleozoic(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x8304) or c420.OCGPaleozoic[c:GetFusionCode()]
	else
		return c:IsSetCard(0x8304) or c420.OCGPaleozoic[c:GetCode()]
	end
end

-- Papillon (not finished)
function c420.IsPapillon(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x312) or c420.OCGPapillon[c:GetFusionCode()]
	else
		return c:IsSetCard(0x312) or c420.OCGPapillon[c:GetCode()]
	end
end

-- Parasite
c420.OCGParasite={
	[49966595]=true;[6205579]=true;
}
function c420.IsParasite(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x410) or c420.OCGParasite[c:GetFusionCode()]
	else
		return c:IsSetCard(0x410) or c420.OCGParasite[c:GetCode()]
	end
end

-- Pixie (not finished)
function c420.IsPixie(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x413) or c420.OCGPixie[c:GetFusionCode()]
	else
		return c:IsSetCard(0x413) or c420.OCGPixie[c:GetCode()]
	end
end

-- Priestess (not finished)
function c420.IsPriestess(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x404) or c420.OCGPriestess[c:GetFusionCode()]
	else
		return c:IsSetCard(0x404) or c420.OCGPriestess[c:GetCode()]
	end
end

-- Puppet (not finished)
function c420.IsPuppet(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x42d) or c:IsFusionSetCard(0x83) or c420.OCGPuppet[c:GetFusionCode()]
	else
		return c:IsSetCard(0x42d) or c:IsSetCard(0x83) or c420.OCGPuppet[c:GetCode()]
	end
end

-- Raccoon (not finished)
function c420.IsRaccoon(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x42e) or c420.OCGRaccoon[c:GetFusionCode()]
	else
		return c:IsSetCard(0x42e) or c420.OCGRaccoon[c:GetCode()]
	end
end

-- Red (archetype)
c420.OCGRed={
	[58831685]=true;[10202894]=true;[65570596]=true;[511001464]=true;[511001094]=true;
	[68722455]=true;[58165765]=true;[45462639]=true;[511001095]=true;[511000365]=true;
	[14886469]=true;[30494314]=true;[81354330]=true;[86445415]=true;[100000562]=true;
	[34475451]=true;[40975574]=true;[37132349]=true;[61019812]=true;[19025379]=true;
	[76547525]=true;[55888045]=true;[97489701]=true;[67030233]=true;[65338781]=true;
	[45313993]=true;[8706701]=true;[21142671]=true;[72318602]=true;[66141736]=true;
	[511018006]=true;
}
function c420.IsRed(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x42f) or c:IsFusionSetCard(0x3b) or c:IsFusionSetCard(0x1045) or c420.OCGRed[c:GetFusionCode()]
	else
		return c:IsSetCard(0x42f) or c:IsSetCard(0x3b) or c:IsSetCard(0x1045) or c420.OCGRed[c:GetCode()]
	end
end

-- Rose 
c420.OCGRose={
	[49674183]=true;[96470883]=true;[31986288]=true;[41160533]=true;[51085303]=true;
	[41201555]=true;[75252099]=true;[58569561]=true;[96385345]=true;[17720747]=true;
	[98884569]=true;[23087070]=true;[1557341]=true;[12469386]=true;[2986553]=true;
	[51852507]=true;[44125452]=true;[61049315]=true;[79531196]=true;[89252157]=true;
	[32485271]=true;[33698022]=true;[73580471]=true;[4290468]=true;[25090294]=true;
	[45247637]=true;[71645243]=true;[73580471]=true;[4290468]=true;[25090294]=true;
}
function c420.IsRose(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x218) or c420.OCGRose[c:GetFusionCode()]
	else
		return c:IsSetCard(0x218) or c420.OCGRose[c:GetCode()]
	end
end

-- Seal 
c420.OCGSeal={
	[63102017]=true;[29549364]=true;[25880422]=true;[58921041]=true;
}
function c420.IsSeal(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x430) or c420.OCGSeal[c:GetFusionCode()] 
	else
		return c:IsSetCard(0x430) or c420.OCGSeal[c:GetCode()] 
	end
end

-- Shaman (not finished)
function c420.IsShaman(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x309) or c420.OCGShaman[c:GetFusionCode()]
	else
		return c:IsSetCard(0x309) or c420.OCGShaman[c:GetCode()]
	end
end

-- Shark (archetype)(not finished)
function c420.IsShark(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x321) or c420.OCGShark[c:GetFusionCode()]
	else
		return c:IsSetCard(0x321) or c420.OCGShark[c:GetCode()]
	end
end

-- Shining (not finished)
function c420.IsShining(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x311) or c420.OCGShining[c:GetFusionCode()]
	else
		return c:IsSetCard(0x311) or c420.OCGShining[c:GetCode()]
	end
end

-- Sky (not finished)
function c420.IsSky(c,fbool)
	if c420.IsAngel(c,fbool) or c420.IsCelestial(c,fbool) then return true end
	if fbool then
		return c:IsFusionSetCard(0x407) or c420.OCGSky[c:GetFusionCode()] or c:IsFusionSetCard(0xf6) or c:IsFusionSetCard(0x3042)
	else
		return c:IsSetCard(0x407) or c420.OCGSky[c:GetCode()] or c:IsSetCard(0xf6) or c:IsSetCard(0x3042)
	end
end

-- Slime (list to recheck)
c420.OCGSlime={
	[31709826]=true;[46821314]=true;[3918345]=true;[26905245]=true;[5600127]=true;[45206713]=true;
	[72291412]=true;[21770261]=true;
}
function c420.IsSlime(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x207) or c420.OCGSlime[c:GetFusionCode()]
	else
		return c:IsSetCard(0x207) or c420.OCGSlime[c:GetCode()]
	end
end

-- Sphere
c420.OCGSphere={
	[60202749]=true;[75886890]=true;[32559361]=true;[14466224]=true;[82693042]=true;[26302522]=true;
	[29552709]=true;[60417395]=true;[72144675]=true;[66094973]=true;[1992816]=true;[51043053]=true;
	[70780151]=true;[10000080]=true;
}
function c420.IsSphere(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x417) or c420.OCGSphere[c:GetFusionCode()]
	else
		return c:IsSetCard(0x417) or c420.OCGSphere[c:GetCode()]
	end
end

-- Spirit (archetype) (not finished)
function c420.IsSpirit(c,fbool)
	if fbool then
		return (c:IsFusionSetCard(0x414) or c420.OCGSpirit[c:GetFusionCode()])
	else
		return (c:IsSetCard(0x414) or c420.OCGSpirit[c:GetCode()])
	end
end

-- Starship (not finished)
function c420.IsStarship(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x431) or c420.OCGStarship[c:GetFusionCode()]
	else
		return c:IsSetCard(0x431) or c420.OCGStarship[c:GetCode()]
	end
end

-- Statue (not finished)
function c420.IsStatue(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x21e) or c420.OCGStatue[c:GetFusionCode()]
	else
		return c:IsSetCard(0x21e) or c420.OCGStatue[c:GetCode()]
	end
end

-- Tachyon
c420.OCGTachyon={
	-- Tachyon Transmigrassion, Tachyon Chaos Hole
	[8038143]=true;[59650656]=true;
}
c420.OCGTachyonDragon={
	-- N107, CN107
	[88177324]=true;[68396121]=true;
}
function c420.IsTachyon(c,fbool)
	if c420.IsTachyonDragon(c,fbool) then return true end
	if fbool then
		return c:IsFusionSetCard(0x418) or c420.OCGTachyon[c:GetFusionCode()]
	else
		return c:IsSetCard(0x418) or c420.OCGTachyon[c:GetCode()]
	end
end

-- Tachyon Dragon
function c420.IsTachyonDragon(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x1418) or c420.OCGTachyonDragon[c:GetFusionCode()]
	else
		return c:IsSetCard(0x1418) or c420.OCGTachyonDragon[c:GetCode()]
	end
end

-- Toy
function c420.IsToy(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x434) or c420.OCGToy[c:GetFusionCode()]
	else
		return c:IsSetCard(0x434) or c420.OCGToy[c:GetCode()]
	end
end

-- Toy (ARC-V archetype)
function c420.IsToyArcV(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x435) or c:IsFusionSetCard(0xad) or c420.OCGToyArcV[c:GetFusionCode()]
	else
		return c:IsSetCard(0x435) or c:IsSetCard(0xad) or c420.OCGToyArcV[c:GetCode()]
	end
end

-- White
c420.OCGWhite={
	[1571945]=true;[3557275]=true;[9433350]=true;[13429800]=true;[15150365]=true;[20193924]=true;
	[24644634]=true;[32269855]=true;[38517737]=true;[73398797]=true;[73891874]=true;[79473793]=true;
	[79814787]=true;[89631139]=true;[92409659]=true;[98024118]=true;[22804410]=true;[71039903]=true;
	[84812868]=true;
}
function c420.IsWhite(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x202) or c420.OCGWhite[c:GetFusionCode()]
	else
		return c:IsSetCard(0x202) or c420.OCGWhite[c:GetCode()]
	end
end

-- Yomi (not finished)
function c420.IsYomi(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x437) or c420.OCGYomi[c:GetFusionCode()]
	else
		return c:IsSetCard(0x437) or c420.OCGYomi[c:GetCode()]
	end
end

-- Yubel (archetype)
c420.OCGYubel={
	-- Yubel, Yubel terror, Yubel nighmare
	[78371393]=true;[4779091]=true;[78371393]=true;
}
function c420.IsYubel(c,fbool)
	if fbool then
		return c:IsFusionSetCard(0x433) or c420.OCGYubel[c:GetFusionCode()]
	else
		return c:IsSetCard(0x433) or c420.OCGYubel[c:GetCode()]
	end
end

c420.Mask={13676474,28933734,49064413,48948935,94377247,82432018,
		20765952,22610082,29549364,57882509,56948373,511001317,511002943
}		
function c420.IsMask(c,fbool)
	if fbool then
		return c:IsFusionCode(table.unpack(c420.Mask))
	else
		return c:IsCode(table.unpack(c420.Mask))
	end
end
