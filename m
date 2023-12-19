Return-Path: <linux-kernel+bounces-5573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B41818C78
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBED628777F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAC120DE3;
	Tue, 19 Dec 2023 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+JztzBj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EDF20327;
	Tue, 19 Dec 2023 16:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E19FC433CA;
	Tue, 19 Dec 2023 16:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703004020;
	bh=UrJeoHAbToGIFVIb+Xcf13zbgC5RX/uC16n/ATc0Wpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+JztzBj6Q+lWk209Lf5Rz9LMGwgNxsCPAxj1RKiE9Hai/Ygi1rRSArt3TEMQ+AKl
	 yTcDQuZuIk3rWI/HTWhLKOs2A7SPpUU4gmGxFAIUlQg587cS/Evr5B7FiWRt/J3WQP
	 o0Lr4H4Hn8j/zXdLx0DKCeZpn0rO7RsfEHe7GjVptHE13v4j72hdFcsh6sOdjUY+ox
	 SoLBIbED0cAo7D8lPdSmf0Pq+wmBznH1rfubAuFlP3wCl7IJEeKucxEGv5BCDYlbsY
	 fWe1hzHZ3SzD+QvLj18dr4aUrZgKgvQXHMk4XLO0aH+2wcIiu7k0/DrI9b/V5a3lYX
	 ROaEaTwSlzSEQ==
Date: Tue, 19 Dec 2023 16:40:15 +0000
From: Conor Dooley <conor@kernel.org>
To: Elad Nachman <enachman@marvell.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, pali@kernel.org,
	mrkiko.rs@gmail.com, chris.packham@alliedtelesis.co.nz,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, cyuval@marvell.com
Subject: Re: [PATCH 1/2] dt-bindings: arm64: add Marvell 7k COMe boards
Message-ID: <20231219-briskness-proving-374376a874c3@spud>
References: <20231218154431.3789032-1-enachman@marvell.com>
 <20231218154431.3789032-2-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bgIjMIk+f7m35qjd"
Content-Disposition: inline
In-Reply-To: <20231218154431.3789032-2-enachman@marvell.com>


--bgIjMIk+f7m35qjd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 05:44:30PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
>=20
> Add dt bindings for:
> Armada 7020 COM Express CPU module
> Falcon DB-98CX85x0 COM Express type 7 Carrier board
> Falcon DB-98CX85x0 COM Express type 7 Carrier board
> with an Armada 7020 COM Express CPU module
>=20
> Signed-off-by: Elad Nachman <enachman@marvell.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../devicetree/bindings/arm/marvell/armada-7k-8k.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.y=
aml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
> index 52d78521e412..24d8031a533d 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
> @@ -21,6 +21,17 @@ properties:
>            - const: marvell,armada-ap806-dual
>            - const: marvell,armada-ap806
> =20
> +      - description:
> +          Falcon (DB-98CX85x0) Development board COM Express Carrier plus
> +          Armada 7020 SoC COM Express CPU module
> +        items:
> +          - const: marvell,armada7020-falcon-carrier
> +          - const: marvell,db-falcon-carrier
> +          - const: marvell,armada7020-cpu-module
> +          - const: marvell,armada7020
> +          - const: marvell,armada-ap806-dual
> +          - const: marvell,armada-ap806
> +
>        - description: Armada 7040 SoC
>          items:
>            - const: marvell,armada7040
> --=20
> 2.25.1
>=20

--bgIjMIk+f7m35qjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYHHbwAKCRB4tDGHoIJi
0r52AQCVptlobL+rozOxXgvJoDTVfNuy1jh+4NgtosowA1P02gD/fNkY3+irVsq8
vzFW78WV3R+9oycwXBcSZR1oW08qdQ0=
=PiDp
-----END PGP SIGNATURE-----

--bgIjMIk+f7m35qjd--

