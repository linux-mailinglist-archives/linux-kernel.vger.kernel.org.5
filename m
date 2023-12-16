Return-Path: <linux-kernel+bounces-2226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628BE8159DE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 15:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1D8281791
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BC62E641;
	Sat, 16 Dec 2023 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1hF7FkC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB232DF84;
	Sat, 16 Dec 2023 14:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A92C433C7;
	Sat, 16 Dec 2023 14:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702736385;
	bh=/ctPJy0azfLfxM5yqOAqAkJqOjuJ469gACrTnVp0hHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t1hF7FkCWb7+6Fft3DsRj+DJ/0DreKqwjbkk1X1RKAL9kv5rhZXkWm9jthfGNuc/o
	 E4q8VcRvbmJgGgRvK620Yub1XIOMgxHzlXyUEj4j7Xn9Y/tQ6X3b88381PqyWcrQDl
	 qlcj4Xa9xaB6yZz9u8T99RwY4nwEsUeTbw1OCGfoceT8jHU13LRiLua5F9MLU4gWRZ
	 87dhqTWW/+Ai+X6SHzvI2nz0X/m8Bpf+57wYcPRqk40udNWUSU3tG1OHSW2i/5w5+/
	 4aJAkGc8vbS8jR8oOfE96mJ+eYS8skxtcEMolUHwkX8Hj7IBp+8I9Z3Rj7Af696d0r
	 tyMJwblZyoGLg==
Date: Sat, 16 Dec 2023 14:19:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: crypto: starfive: Add jh8100 compatible
 string
Message-ID: <20231216-starved-underdog-18c90ba52785@spud>
References: <20231216141234.417498-1-jiajie.ho@starfivetech.com>
 <20231216141234.417498-2-jiajie.ho@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kb1OsIt5E3Qv7jXn"
Content-Disposition: inline
In-Reply-To: <20231216141234.417498-2-jiajie.ho@starfivetech.com>


--Kb1OsIt5E3Qv7jXn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 10:12:30PM +0800, Jia Jie Ho wrote:
> Add compatible string for StarFive JH8100 crypto hardware.
>=20
> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../devicetree/bindings/crypto/starfive,jh7110-crypto.yaml  | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/crypto/starfive,jh7110-cry=
pto.yaml b/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.=
yaml
> index 71a2876bd6e4..3b14320a107f 100644
> --- a/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
> +++ b/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
> @@ -12,7 +12,11 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    const: starfive,jh7110-crypto
> +    oneOf:
> +      - items:
> +          - const: starfive,jh8100-crypto
> +          - const: starfive,jh7110-crypto
> +      - const: starfive,jh7110-crypto
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.34.1
>=20

--Kb1OsIt5E3Qv7jXn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZX2x+wAKCRB4tDGHoIJi
0lRCAQD0AnKUr49Yeum9ET8v9RiptRhyOYvEkDmzlpHQ/0rL7AEAwPLNapIWYXxE
ifddl188biTo1EVQ2fFCcdv3VI1RTA0=
=kISw
-----END PGP SIGNATURE-----

--Kb1OsIt5E3Qv7jXn--

