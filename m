Return-Path: <linux-kernel+bounces-24886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A6482C43A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D551C2174C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D31C1757F;
	Fri, 12 Jan 2024 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3lS3yPQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94E217540;
	Fri, 12 Jan 2024 17:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634CBC433F1;
	Fri, 12 Jan 2024 17:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705079190;
	bh=wZDnbh7n64HZXBziqJnarpVCrDn44XHiaryQeXzT4Jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O3lS3yPQkwbyA3T/nJ4LwyRW+9PissQShMQh5QL5f7Bmho0kWq2fc8EVIb/s7a0Ex
	 f8rQ7wGaVWQVZ429XPgXv2+6eH92Krk3nyrexdA2hE5qUmi3yJBj0vkSX2kAJu3zN5
	 eiRWTF7dz3mfOUIBAfUDNa1FzCy5xD40Y2tBFmKr91My270qB6kIFxv7gcjwsf++bS
	 l83+elWFcsEgiDwapOb4z15ZJDiEzlv4pgq2C4Az4DJ6DMV8EwKTzhjMgKL5M2Q1/m
	 2aon5a9GvA/fcN0f4uPmkNq2Io/7xwbtDpmKFCyIcO4XwZTBMnDBh06KGKyN9tcNt9
	 1pxMwcGs/NSSw==
Date: Fri, 12 Jan 2024 17:06:25 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, wenst@chromium.org, hsinyi@chromium.org,
	nfraprado@collabora.com, macpaul.lin@mediatek.com,
	sean.wang@mediatek.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: Re: [PATCH 01/15] dt-bindings: arm64: mediatek: Add MT8395 Radxa NIO
 12L board compatible
Message-ID: <20240112-scanning-contour-019b286021e6@spud>
References: <20240112094632.66310-1-angelogioacchino.delregno@collabora.com>
 <20240112094632.66310-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="govvU38t0WtaM7t9"
Content-Disposition: inline
In-Reply-To: <20240112094632.66310-2-angelogioacchino.delregno@collabora.com>


--govvU38t0WtaM7t9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 10:46:18AM +0100, AngeloGioacchino Del Regno wrote:
> Add a board compatible for the Radxa NIO 12L, based on the MediaTek
> MT8395 SoC.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index 5d49c7af50e5..cc37c88d8d4a 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -345,6 +345,7 @@ properties:
>        - items:
>            - enum:
>                - mediatek,mt8395-evk
> +              - radxa,nio-12l
>            - const: mediatek,mt8395
>            - const: mediatek,mt8195
>        - items:
> --=20
> 2.43.0
>=20

--govvU38t0WtaM7t9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaFxkQAKCRB4tDGHoIJi
0u2ZAQCrxxq3yuqhnnom8wr4ZvEFVZTjfwbrnntQ/oN+LUXvxQD9EornS9s9da5q
6K6qX/043jYEYDy4qbt94rd6ApvhXgA=
=yQm+
-----END PGP SIGNATURE-----

--govvU38t0WtaM7t9--

