Return-Path: <linux-kernel+bounces-26261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2484882DDA5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37DEF1C21D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F4717BC9;
	Mon, 15 Jan 2024 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPX6xHOJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B80F17BAD;
	Mon, 15 Jan 2024 16:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF92C433F1;
	Mon, 15 Jan 2024 16:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705336338;
	bh=jIHd7RWYoQH0ICLh5gm4rBIQX41V/WBDu5Lo3jqSrkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RPX6xHOJogGdH3G2C+jlERKp4dvJJRR3bRIJhm0HpriyqkWtucYEIPQosA6GXjeM9
	 EHAP+QXGFNxBzgT90WVDALLYDfOAXa5laLPDt6uSZLy4ikSa4KrbDT9HQglytJ3ywI
	 Kdor+c7keaMy7fct1NZzyrAF/gy/scPASOpq9pGLzlp/MOzB6lAtayR1xzyYhJZWqg
	 F150GRNOuUv4JAuVvq/FxKMmrc+yBBN+QC2gzh+gA6dID2dNxHri1WdMWB6h1HrqKv
	 KYJs83fBjB+N7a2Na8NqVrDSBbEe38Lcd7FrsUd9HNyIPgBhWTsPg4N6yFidyqWIrN
	 Mndnv2EyCjVjQ==
Date: Mon, 15 Jan 2024 16:32:14 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Elad Nachman <enachman@marvell.com>, gregkh@linuxfoundation.org,
	rowland.harvard.edu@mx0a-0016f401.pphosted.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add Marvell ac5
Message-ID: <20240115-angelfish-droplet-2e1f300397f2@spud>
References: <20240114172154.2622275-1-enachman@marvell.com>
 <20240114172154.2622275-2-enachman@marvell.com>
 <de079fa2-bba2-4e50-b738-465ed959633a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="myXpCa/y9/oa7o6h"
Content-Disposition: inline
In-Reply-To: <de079fa2-bba2-4e50-b738-465ed959633a@linaro.org>


--myXpCa/y9/oa7o6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 08:25:08AM +0100, Krzysztof Kozlowski wrote:
> On 14/01/2024 18:21, Elad Nachman wrote:
> > From: Elad Nachman <enachman@marvell.com>
> >=20
> > Add Marvell ac5 device tree bindings to generic EHCI.
> > This compatible enables the Marvell Orion platform code
> > to properly configure the DMA mask for the Marvell AC5 SOC.
> >=20
> > Signed-off-by: Elad Nachman <enachman@marvell.com>
>=20
> This is a friendly reminder during the review process.
>=20
> It looks like you received a tag and forgot to add it.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
>=20
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/su=
bmitting-patches.rst#L577
>=20
> If a tag was not added on purpose, please state why and what changed.
>=20
> Best regards,
> Krzysztof
>=20

--myXpCa/y9/oa7o6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaVeDgAKCRB4tDGHoIJi
0u+hAQDNSp4qA2zR+OLCrexT01BskxalE5VSWlr+JoAUW4Tn1gEAl7pCg05locJn
rLpNsU+tATBqiRfVnlBJGPIv3dDb0gE=
=5xKb
-----END PGP SIGNATURE-----

--myXpCa/y9/oa7o6h--

