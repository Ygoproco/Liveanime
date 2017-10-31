--Golgoil (DOR)
--scripted by GameMaster (GM)+ Shad3
function c511005703.initial_effect(c)
--Resurect different Mzone
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
e1:SetCode(EVENT_TO_GRAVE)
e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
e1:SetCondition(c511005703.condition5)
e1:SetTarget(c511005703.sptg)
e1:SetOperation(c511005703.spop)
c:RegisterEffect(e1)
end


function c511005703.condition5(e,tp)
local tc=e:GetHandler()
if tc and tc:IsReason(REASON_DESTROY) and tc:IsLocation(LOCATION_GRAVE) and tc:GetPreviousControler()==tp then
e:SetLabel(tc:GetPreviousSequence())
return true
end
return false
end

--block previous zone and special summon
function c511005703.regop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if c:IsReason(REASON_DESTROY) and bit.band(c:GetPreviousLocation(),LOCATION_SZONE)~=0 then
--spsummon
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(511005703,0))
e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e1:SetRange(LOCATION_GRAVE)
e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
e1:SetCost(c511005703.spcost)
e1:SetTarget(c511005703.sptg)
e1:SetOperation(c511005703.spop)
e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
c:RegisterEffect(e1)
end
end

function c511005703.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
local c=e:GetHandler()
if chk==0 then return c:GetFlagEffect(511005703)==0 end
c:RegisterFlagEffect(511005703,nil,0,1)
end

function c511005703.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
local seq=bit.lshift(0x1,e:GetLabel())
local ch=Duel.GetCurrentChain()
e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetRange(LOCATION_GRAVE)
e1:SetCode(EFFECT_DISABLE_FIELD)
e1:SetReset(RESET_CHAIN)
e1:SetOperation(function() if Duel.GetCurrentChain()==ch then return seq else return 0 end end)
Duel.RegisterEffect(e1,tp)
end

function c511005703.spop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local seq=bit.lshift(0x1,e:GetLabel())
if c:IsRelateToEffect(e) then 
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetRange(LOCATION_GRAVE)
e1:SetCode(EFFECT_DISABLE_FIELD)
e1:SetValue(seq)
e:GetHandler():RegisterEffect(e1)
Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
e1:Reset()
end
end