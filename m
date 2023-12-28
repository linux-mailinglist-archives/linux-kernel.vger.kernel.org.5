Return-Path: <linux-kernel+bounces-12766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C3B81F9C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7610C285769
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B527AF502;
	Thu, 28 Dec 2023 15:54:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m12773.qiye.163.com (mail-m12773.qiye.163.com [115.236.127.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FFAF4E3;
	Thu, 28 Dec 2023 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=senarytech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=senarytech.com
Received: from liubo (unknown [61.183.143.78])
	by mail-m12756.qiye.163.com (Hmail) with ESMTPA id B98DCDC035B;
	Thu, 28 Dec 2023 10:57:43 +0800 (CST)
From: =?utf-8?B?5YiY5Y2a?= <bo.liu@senarytech.com>
To: <perex@perex.cz>,
	<tiwai@suse.com>
Cc: <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: =?utf-8?Q?Due_to_returning_the_email_and_r?=
	=?utf-8?Q?esending_it//=E7=AD=94=E5=A4=8D:_=5BPATCH_1/3=5D_Fix?=
	=?utf-8?Q?_headset_auto_detect_fail_in_cx8?=
	=?utf-8?Q?070_and_SN6140?=
Date: Thu, 28 Dec 2023 10:57:43 +0800
Message-ID: <009d01da3939$a1517440$e3f45cc0$@senarytech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Ado5OZT0IQYjxbjwTr6PBszvuPulOQ==
Content-Language: zh-cn
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSx9JVh0ZHhkfH0IZTE0dHlUTARMWGhIXJBQOD1
	lXWRgSC1lBWU1KVUpDSFVKT0hVTENZV1kWGg8SFR0UWUFZT0tIVUpNT0lOSFVKS0tVSkJLS1kG
X-HM-Tid: 0a8cae5b3ba8b223kuuub98dcdc035b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NUk6Vio5Kjw6CQ8SCC4tPxEL
	KAMKCy5VSlVKTEtITEhJSU1PTkpOVTMWGhIXVRkUVRcSDjsIHhUaCQIPHhgTVRgUFkVZV1kSC1lB
	WU1KVUpDSFVKT0hVTENZV1kIAVlBTU5OSjcG

FYI

Best Regards
Bo Liu =EF=BC=88=E5=88=98=E5=8D=9A=EF=BC=89
Cell#: +86-18986160629
=E3=80=80Email: bo.liu@senarytech.com
=E6=B7=B1=E5=9C=B3=E5=89=8D=E6=B5=B7=E6=B7=B1=E8=95=BE=E5=8D=8A=E5=AF=BC=E4=
=BD=93=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8
=E6=B9=96=E5=8C=97=E7=9C=81=E6=AD=A6=E6=B1=89=E5=B8=82=E4=B8=9C=E6=B9=96=E9=
=AB=98=E6=96=B0=E6=8A=80=E6=9C=AF=E5=BC=80=E5=8F=91=E5=8C=BA=E5=85=B3=E5=B1=
=B1=E5=A4=A7=E9=81=93355=E5=8F=B7=E9=93=AD=E4=B8=B0=E5=A4=A7=E5=8E=A6
16=E6=A5=BC1601-1603=E5=AE=A4
=E3=80=80Room 1601-1603=EF=BC=8CmTower, No. 355 Guanshan Avenue,=20
=E3=80=80East Lake High-tech Development Zone, Wuhan, Hubei Province.
=E3=80=80
-----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
=E5=8F=91=E4=BB=B6=E4=BA=BA: bo liu <bo.liu@senarytech.com>=20
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =
2023=E5=B9=B412=E6=9C=8827=E6=97=A5 15:10
=E6=94=B6=E4=BB=B6=E4=BA=BA: perex@perex.cz; tiwai@suse.com
=E6=8A=84=E9=80=81: linux-sound@vger.kernel.org; =
linux-kernel@vger.kernel.org; bo liu <bo.liu@senarytech.com>
=E4=B8=BB=E9=A2=98: [PATCH 1/3] Fix headset auto detect fail in cx8070 =
and SN6140

CX8070 and SN6140 will get wrong headset type when use OMTP headset, =
then the headset mic will not work.

Signed-off-by: bo liu <bo.liu@senarytech.com>
---
 sound/pci/hda/patch_conexant.c | 75 +++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_conexant.c =
b/sound/pci/hda/patch_conexant.c index a889cccdd607..2d58595bfbdd 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -166,6 +166,7 @@ static void cxt_init_gpio_led(struct hda_codec =
*codec)
=20
 static int cx_auto_init(struct hda_codec *codec)  {
+	unsigned int mic_persent;
 	struct conexant_spec *spec =3D codec->spec;
 	snd_hda_gen_init(codec);
 	if (!spec->dynamic_eapd)
@@ -174,6 +175,23 @@ static int cx_auto_init(struct hda_codec *codec)
 	cxt_init_gpio_led(codec);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_INIT);
=20
+	switch (codec->core.vendor_id) {
+	case 0x14f11f86:
+	case 0x14f11f87:
+		/* fix some headset recognize fail issue */
+		snd_hda_codec_write(codec, 0x1c, 0, 0x320, 0x010);
+		snd_hda_codec_write(codec, 0x1c, 0, 0x3b0, 0xe10);
+		snd_hda_codec_write(codec, 0x1c, 0, 0x4f0, 0x0eb);
+		/* fix reboot headset recognize fail issue */
+		mic_persent =3D snd_hda_codec_read(codec, 0x19, 0, 0xf09, 0x0);
+		if (mic_persent&0x80000000) {
+			snd_hda_codec_write(codec, 0x19, 0, 0x707, 0x24);
+		} else {
+			snd_hda_codec_write(codec, 0x19, 0, 0x707, 0x20);
+		}
+		break;
+	}
+
 	return 0;
 }
=20
@@ -191,6 +209,60 @@ static void cx_auto_free(struct hda_codec *codec)
 	cx_auto_shutdown(codec);
 	snd_hda_gen_free(codec);
 }
+=20
+static int headset_present_flag;
+static void cx_jack_unsol_event(struct hda_codec *codec, unsigned int=20
+res) {
+	unsigned int val,phone_present,mic_persent,phone_tag,mic_tag;
+	unsigned int count=3D0;
+=09
+	switch (codec->core.vendor_id) {
+	case 0x14f11f86:
+	case 0x14f11f87:
+		/* check hp&mic tag to process headset pulgin&plugout */
+		phone_tag =3D snd_hda_codec_read(codec, 0x16, 0, 0xf08, 0x0);
+		mic_tag =3D snd_hda_codec_read(codec, 0x19, 0, 0xf08, 0x0);
+		if((phone_tag&(res>>26)) || (mic_tag&(res>>26))) {
+			//msleep(600);
+			phone_present =3D snd_hda_codec_read(codec, 0x16, 0, 0xf09, 0x0);
+			if(!(phone_present&0x80000000)) {/* headphone plugout */
+				headset_present_flag =3D 0;
+				snd_hda_codec_write(codec, 0x19, 0, 0x707, 0x20);
+				break;
+			}
+			if (headset_present_flag =3D=3D 0) {
+				headset_present_flag =3D 1;
+			} else if(headset_present_flag =3D=3D 1) {
+				mic_persent =3D snd_hda_codec_read(codec, 0x19, 0, 0xf09, 0x0);
+				if ((phone_present&0x80000000)&&(mic_persent&0x80000000)) {/* =
headset is present */
+					/* wait headset detect done */
+					do {
+						val =3D snd_hda_codec_read(codec, 0x1c, 0, 0xca0, 0x0);
+						if(val&0x080) {
+							break;
+						}
+						msleep(10);
+						count +=3D 1;
+					} while(count > 5);
+					val =3D snd_hda_codec_read(codec, 0x1c, 0, 0xcb0, 0x0);
+					if(val&0x800) {
+						codec_dbg(codec, "headset plugin, type is CTIA\n");
+						snd_hda_codec_write(codec, 0x19, 0, 0x707, 0x24);
+					} else if(val&0x400) {
+						codec_dbg(codec, "headset plugin, type is OMTP\n");
+						snd_hda_codec_write(codec, 0x19, 0, 0x707, 0x24);
+					} else {
+						codec_dbg(codec, "headphone plugin\n");
+					}
+					headset_present_flag =3D 2;
+				}
+			}
+		}
+		break;
+	}
+
+	snd_hda_jack_unsol_event(codec, res);
+}
=20
 #ifdef CONFIG_PM
 static int cx_auto_suspend(struct hda_codec *codec) @@ -205,7 +277,7 @@ =
static const struct hda_codec_ops cx_auto_patch_ops =3D {
 	.build_pcms =3D snd_hda_gen_build_pcms,
 	.init =3D cx_auto_init,
 	.free =3D cx_auto_free,
-	.unsol_event =3D snd_hda_jack_unsol_event,
+	.unsol_event =3D cx_jack_unsol_event,
 #ifdef CONFIG_PM
 	.suspend =3D cx_auto_suspend,
 	.check_power_status =3D snd_hda_gen_check_power_status, @@ -1042,6 =
+1114,7 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	codec->spec =3D spec;
 	codec->patch_ops =3D cx_auto_patch_ops;
=20
+	headset_present_flag =3D 0;
 	cx_auto_parse_eapd(codec);
 	spec->gen.own_eapd_ctl =3D 1;
=20
--
2.34.1


