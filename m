Return-Path: <linux-kernel+bounces-16778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8571782439E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C0F0B25EF9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3812424A02;
	Thu,  4 Jan 2024 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hCyoGD6K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884CF249EA;
	Thu,  4 Jan 2024 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 404EK5h8036185;
	Thu, 4 Jan 2024 08:20:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704378005;
	bh=tiBXpNPskkKNBbAjeQAnlbDwPVQMVr+rHjwzlLfheNc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=hCyoGD6KmHS5py62CxXQt5a2pLUWKa14jEOtCOPWM78GxuwF+JYGJvqkoUNneeAZd
	 4q+F4MZsNUdkwxSzPpEB5YM/JmZjRWe6zfHsqzzHCM/ux2lh64GdMNqxIgSrn21cvo
	 D0rMCBTD0ViBX410t7qyPH8CBN3xDWLf8suLjY3w=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 404EK5HO096180
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jan 2024 08:20:05 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jan 2024 08:20:05 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jan 2024 08:20:05 -0600
Received: from localhost ([10.249.131.210])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 404EK4I4060290;
	Thu, 4 Jan 2024 08:20:04 -0600
Date: Thu, 4 Jan 2024 19:50:03 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Javier Carrasco <javier.carrasco@wolfvision.net>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <d-gole@ti.com>, <nm@ti.com>
Subject: Re: [PATCH v2 0/4] usb: typec: tipd: add patch update support for
 tps6598x
Message-ID: <vmngazj6si7xxss7txenezkcukqje2glhvvs7ipdcx3vjiqvlk@ohmmhhhlryws>
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mdhq65qspjzfahoo"
Content-Disposition: inline
In-Reply-To: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--mdhq65qspjzfahoo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Javier, Greg,

On Dec 14, 2023 at 17:29:08 +0100, Javier Carrasco wrote:
> This series extends the patch update mechanism to support the tps6598x.
>=20
> Currently there is only support for the tps25750 part and some
> conditional clauses are used to make a special case out of it. Now that
> different parts support patch updates, a more general approach is
> proposed.
>=20
> The update mechanism differs from the one required by tps25750 and it is
> explained in the commit message as a summary of the application note in
> that respect.
>=20
> Note that the series makes use of the TPS_SETUP_MS introduced in
> commit 6a4d4a27f986 ("usb: typec: tps6598x: add reset gpio support"),
> which is currently available in usb-next / usb-testing.
>=20
> A TPS65987D has been used to test this functionality with positive
> results.
>=20
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
> Changes in v2:
> - Remove probe defeferring mechanism and expect the firmware to be
>   available (Heikki Krogerus).
> - Link to v1:=20
> https://lore.kernel.org/r/20231207-tps6598x_update-v1-0-dc21b5301d91@wolf=
vision.net
>=20

FYI, this series breaks boot for TI SK-AM62A and SK-AM62 which use=20
TPS6598x as the USB-C PD chip.

The platforms stopped booting since next-20240103 [1], and reverting=20
this series [4] seems to fix the issue [2]

Is there any change needed in the board device-tree [3] and bindings?

We don't specify any firmware in the device-tree node, but seems like=20
that is an assumption in this series. I tried reverting it (below=20
change) but that did *not* help with the stuck boot.

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index a956eb976906..fa3bd7349265 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1139,7 +1139,7 @@ static int tps6598x_apply_patch(struct tps6598x *tps)
        ret =3D device_property_read_string(tps->dev, "firmware-name",
                                          &firmware_name);
        if (ret)
-               return ret;
+               return 0;

        ret =3D tps_request_firmware(tps, &fw);
        if (ret)


[1] https://linux.kernelci.org/soc/ti/job/next/kernel/next-20240103/plan/ba=
seline-nfs/
[2] https://gist.github.com/jailuthra/0c077176585e4df2f8b78f7784087865
[3] https://gitlab.com/linux-kernel/linux-next/-/blob/master/arch/arm64/boo=
t/dts/ti/k3-am62a7-sk.dts#L305
[4] https://github.com/jailuthra/linux/commits/next-20240103-tps6598-fix/

> ---
> Javier Carrasco (4):
>       usb: typec: tipd: add init and reset functions to tipd_data
>       usb: typec: tipd: add function to request firmware
>       usb: typec: tipd: declare in_data in as const in exec_cmd functions
>       usb: typec: tipd: add patch update support for tps6598x
>=20
>  drivers/usb/typec/tipd/core.c     | 150 ++++++++++++++++++++++++++++++++=
------
>  drivers/usb/typec/tipd/tps6598x.h |  18 +++++
>  2 files changed, 147 insertions(+), 21 deletions(-)
> ---
> base-commit: 51920207674e9e3475a91d2091583889792df99a
> change-id: 20231207-tps6598x_update-632eab69d2ed
>=20
> Best regards,
> --=20
> Javier Carrasco <javier.carrasco@wolfvision.net>
>=20
>=20


--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--mdhq65qspjzfahoo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmWWvpIACgkQQ96R+SSa
cUXkqg/9G1sX/4UVAZfES43WlWJYw7FN11EWU+pa6WM1WejIlat2r0p34XIQpQmo
N1LKnp1Mbl5nXOXYpiEkqMorFlMtnhalhyd/2jz/j+l/I0da5P8P7pNGoMxHs3yP
GSKm+jX9TZcXzAKPq2+NaSzar2w+f5Fxm4AXDwcYBpxd1xHgt5YnXf4XZ6Ak9pzT
Eq06rF5PEzjLXO4K5Mj3wBrl+jrAbF12gxzVuq7Z27e9JkeUHpAonjsddqLPj3lw
34DbJIhK/pPTwPWzdOv/W0M7tYPQvAoEdQUPiBgf9yNMgpx96xN3MX9QMonclGoa
f5IVF0NbSM2xNz904DuxtmwXU5PlWromYVD2MwVzCMiCq6RJz6Ar611Pok9Ca0Lk
beyp8XDmP2MAaK8kSAbnH4TR+d635OleIAw28fJxHVXdrB/GDjJSvm774SdVWiX/
vPV8G62N17mWMDMRgaLTsN7FrWtSChRaX71S8/cKM9jPBpCZPdWpbdYq4a0G0Jz4
Md5LkVd5sSmT24gJGCnVesB1ktD7l6aICb27jVhkuS0xc95igRzB3jUQ5vuWNaA1
KJKkAhA9YujNgoqELImspzVPCIOjKtN2jiPdYhkhVwYYSsb+6ZPV0XBqsd4mE/cD
Vv2UwhRBK2N5vHP9eU1UxkBs6tWh6nZnLt2diKUeSCvAdZVBhvg=
=UgQe
-----END PGP SIGNATURE-----

--mdhq65qspjzfahoo--

