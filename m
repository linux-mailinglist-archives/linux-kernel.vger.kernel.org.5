Return-Path: <linux-kernel+bounces-19321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 009D4826B61
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16F91F222BE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E8D13AE3;
	Mon,  8 Jan 2024 10:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JVFNm2x9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0598134BD;
	Mon,  8 Jan 2024 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 408ACbrZ042470;
	Mon, 8 Jan 2024 04:12:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704708757;
	bh=BqarN9f9s3CEZnaMfiAYm6cRmf3CFhY31csF2gEo2nM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=JVFNm2x9j2qF/PfCzRnqgdfxuXVQSzcxvvrXjWi6Z7LANwvhRY4E+ctGg9sqYo5qZ
	 j44qjwv488XlqKZWW83XSGuB7xVB7sPXU5oPOOHAwrX/yL4vp1hEfWmqdja0WE5A8d
	 M10+vBSGqaAC7ouig5BPGX3mX6+EvKdXK/29rf+A=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 408ACb60100643
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Jan 2024 04:12:37 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jan 2024 04:12:36 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jan 2024 04:12:36 -0600
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.217])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 408ACawd040265;
	Mon, 8 Jan 2024 04:12:36 -0600
Date: Mon, 8 Jan 2024 15:42:29 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
CC: Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Jack Zhu <jack.zhu@starfivetech.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] media: cadence: csi2rx: Add enum_mbus_code pad ops
Message-ID: <ahubawbt5jcef5dajidyfkpwgmdw6wyzv33itu4n6jocheg7c3@et6nax3r7kmp>
References: <20231211094329.9090-1-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r72e3nzso4uzxyaj"
Content-Disposition: inline
In-Reply-To: <20231211094329.9090-1-changhuang.liang@starfivetech.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--r72e3nzso4uzxyaj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the patch.

On Dec 11, 2023 at 01:43:29 -0800, Changhuang Liang wrote:
> Add enum_mbus_code ioctl so that user space can know what
> formats are supported to csi2rx.
>=20
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  drivers/media/platform/cadence/cdns-csi2rx.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media=
/platform/cadence/cdns-csi2rx.c
> index 889f4fbbafb3..7788ce0e3171 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -389,6 +389,18 @@ static int csi2rx_s_stream(struct v4l2_subdev *subde=
v, int enable)
>  	return ret;
>  }
> =20
> +static int csi2rx_enum_mbus_code(struct v4l2_subdev *subdev,
> +				 struct v4l2_subdev_state *state,
> +				 struct v4l2_subdev_mbus_code_enum *code_enum)
> +{
> +	if (code_enum->index >=3D ARRAY_SIZE(formats))
> +		return -EINVAL;
> +
> +	code_enum->code =3D formats[code_enum->index].code;
> +
> +	return 0;
> +}
> +

Tested next-20240108 + this patch, output looks good to me:
root@am62axx-evm:~# v4l2-ctl -d/dev/v4l-subdev0 --list-subdev-mbus-codes
ioctl: VIDIOC_SUBDEV_ENUM_MBUS_CODE (pad=3D0,stream=3D0)
        0x2011: MEDIA_BUS_FMT_YUYV8_1X16
        0x200f: MEDIA_BUS_FMT_UYVY8_1X16
        0x2012: MEDIA_BUS_FMT_YVYU8_1X16
        0x2010: MEDIA_BUS_FMT_VYUY8_1X16
        0x3001: MEDIA_BUS_FMT_SBGGR8_1X8
        0x3013: MEDIA_BUS_FMT_SGBRG8_1X8
        0x3002: MEDIA_BUS_FMT_SGRBG8_1X8
        0x3014: MEDIA_BUS_FMT_SRGGB8_1X8
        0x3007: MEDIA_BUS_FMT_SBGGR10_1X10
        0x300e: MEDIA_BUS_FMT_SGBRG10_1X10
        0x300a: MEDIA_BUS_FMT_SGRBG10_1X10
        0x300f: MEDIA_BUS_FMT_SRGGB10_1X10


Reviewed-by: Jai Luthra <j-luthra@ti.com>
Tested-by: Jai Luthra <j-luthra@ti.com> # [Test on sk-am62a]

>  static int csi2rx_set_fmt(struct v4l2_subdev *subdev,
>  			  struct v4l2_subdev_state *state,
>  			  struct v4l2_subdev_format *format)
> @@ -439,6 +451,7 @@ static int csi2rx_init_cfg(struct v4l2_subdev *subdev,
>  }
> =20
>  static const struct v4l2_subdev_pad_ops csi2rx_pad_ops =3D {
> +	.enum_mbus_code	=3D csi2rx_enum_mbus_code,
>  	.get_fmt	=3D v4l2_subdev_get_fmt,
>  	.set_fmt	=3D csi2rx_set_fmt,
>  	.init_cfg	=3D csi2rx_init_cfg,
> --=20
> 2.25.1
>=20
>=20

--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--r72e3nzso4uzxyaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmWbyoAACgkQQ96R+SSa
cUV5xA/9Es54UmZG4Tshb9ZisEBlRigGb5pw5ALxLfzSXEJCdupuSkpmg0BrtyWJ
HBGn2tRPHqG9O4VzuvZehwQa3YT9RvF7ONEpcus8xR2Tf9v802F+2Q4EJwMvcMRA
57QVZSTnnjZ5DkS+OvQEV2fN7qjt1QAzdKFCj8IZr2fERo8ChIylxSdnbtIb1KFu
uDn/zgY/2c4R+XUOE73g2BBxqKeJAwsT8uriMsTyP6wWjfaHskOjH2fZVlu06RKy
5O6vzCXUQ7s7bqvdZo6Zy+cJpkXLOleotvMPjFkOV+RpyvThbbSEHIAYkKqzEsLJ
5SwcVexAfGEfSOyYFeEndrhGGQo6fv9qn1ojh7gOc6qjGGx01xop8XmB+7zjIFQN
zdtvnPIKZy6XXUrvPHeSvtmX+fNwHVsxpGk2Gg7fuYz21Bx/3fWljaL2BcWWCftE
tJ9A8JofdU6czZo6uBCoB849GNqyVwZ9E7xd/7hYxldkCPPQQ/pvdKY6QpEaCsFb
pEJ1Dc+s8eNX1bV8nK/74sCEcR6wT+VpvsppnIssan0aWfgzfzxL4po9Y2DhsqtW
5+RSVx3+CSfTDKKwHYsNy2VMO+iAWKWuJTPPHQMfye69HIric1+BOWSpPiELpGa4
UM1j+sU5gztKKt4p0xTG6oIZy53FHPShkbFujZezHJuflpeRgXU=
=2G3n
-----END PGP SIGNATURE-----

--r72e3nzso4uzxyaj--

