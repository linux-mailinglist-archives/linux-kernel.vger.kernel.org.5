Return-Path: <linux-kernel+bounces-27615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A365782F2F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BD8288CB4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80E41CAA4;
	Tue, 16 Jan 2024 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqREW0F8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1148E1CA87;
	Tue, 16 Jan 2024 17:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF34C433C7;
	Tue, 16 Jan 2024 17:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705425215;
	bh=SuJRku70FFjuPFDYTnqO6MNWPjTMigxU8tBt5tIlgok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqREW0F8UbaqeNQLcbT67iMdyDxfPX6v6paL1UjmuTw5X6bxVdwe0ccgoi4SXUvNy
	 hRFqqe1taQB+32HhAqfMGbFE0EZNAUFKcN0D6V42Yn/6MZyDaVtaNr9IDpbDyY0i9w
	 ZdGZN8TeGBtiQHR28Gp1HBkcx5LmlRF4Kw3gfpNT4ateIaBPuLvR7hw97P6O1My4DZ
	 VfHe/eXNSBl1D8edDW1EtKTl2WeE80yO6tdbLN21LTQZCipzS8f1hJHESZlIrt8yV+
	 oDeA+iHaZiUqHzJ/5m2yf/M+73jUW8PFzoGXCBTmuONQEmxDKeAP1VuTuzb72ybL/A
	 p1GGJOC1DYLyA==
Date: Tue, 16 Jan 2024 17:13:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Frieder Schrempf <frieder@fris.de>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Yang Xiwen <forbidden405@foxmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Sielaff
Message-ID: <20240116-treat-amperage-d292d9e573f9@spud>
References: <20240116105317.267525-1-frieder@fris.de>
 <20240116105317.267525-2-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/pDMlpA8KyAT6rUA"
Content-Disposition: inline
In-Reply-To: <20240116105317.267525-2-frieder@fris.de>


--/pDMlpA8KyAT6rUA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 11:51:55AM +0100, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>=20
> Add "Sielaff GmbH & Co. KG Automatenbau Herrieden" (https://sielaff.de).
>=20
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 309b94c328c84..8825a9f60ac5a 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1233,6 +1233,8 @@ patternProperties:
>      description: Si-En Technology Ltd.
>    "^si-linux,.*":
>      description: Silicon Linux Corporation
> +  "^sielaff,.*":
> +    description: Sielaff GmbH & Co. KG Automatenbau Herrieden
>    "^siemens,.*":
>      description: Siemens AG
>    "^sifive,.*":
> --=20
> 2.43.0
>=20

--/pDMlpA8KyAT6rUA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaa5OgAKCRB4tDGHoIJi
0gwrAP9wUzzoaxZr4KgANTEw68LtS7mefqLYGzUyrunbFe23hgEAnSMGPE+wNf51
pGSOd8FTva8IPvnJ2eN4SEff5PqMCA8=
=eHId
-----END PGP SIGNATURE-----

--/pDMlpA8KyAT6rUA--

