Return-Path: <linux-kernel+bounces-4169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E535B8178BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16EAB1C23C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591875BFA2;
	Mon, 18 Dec 2023 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/SqjF/T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE25A853;
	Mon, 18 Dec 2023 17:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC39EC433C8;
	Mon, 18 Dec 2023 17:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702920578;
	bh=fcfjjD/2CnHv1DNQBqv8DhO1CWdn7HChK7DcEpQLsos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q/SqjF/TC9Z3xUcpTFQ2eJvNV1Id3rwck8om8bVmsnjqzyCSW+eqHZj7RFsHgCIMy
	 kRSZWIzG27WZ8jyae3odiZy+/lOe0DKBlWWbPpxBU4bpIrNipIicdUZfWVppZ66dZX
	 WgUW/0D7SVjxktH1vZRWCjQ51QlGm4nOoAcDQBtOM6WQXPIf7D6oIasq8Iekpvke2r
	 P45ClmrLxsCZCEyKisjm8UJNN36RfO7RSnPIG9VFnLqEXe//2izgKs2Ovl8NPw8aT2
	 W7aBOWbMoGzLAW18o0Uo4c9jqykQw6cAK6sUZiV/en6bQxlXZodVvplzAv3BE2yv7Z
	 vnDFG205DXEag==
Date: Mon, 18 Dec 2023 17:29:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/106] 6.1.69-rc1 review
Message-ID: <20231218-payment-childlike-249c6824f1ca@spud>
References: <20231218135055.005497074@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CeZHakRwR6rO9YeJ"
Content-Disposition: inline
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>


--CeZHakRwR6rO9YeJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 02:50:14PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.69 release.
> There are 106 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--CeZHakRwR6rO9YeJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYCBfAAKCRB4tDGHoIJi
0mAuAP4v+GMZg5j0OHMBdtB46oJEw6qSuP3I7OI2TFKCuA+TOQD/QtWbxlTcaBEH
OFLhqBa91OWi9UgA6QbMWZaFlVcgzAs=
=Kx+d
-----END PGP SIGNATURE-----

--CeZHakRwR6rO9YeJ--

