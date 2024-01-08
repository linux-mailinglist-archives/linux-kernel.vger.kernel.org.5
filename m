Return-Path: <linux-kernel+bounces-19907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A44C82767D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8EA28452E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FA154BCC;
	Mon,  8 Jan 2024 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3NXbRr8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A518454BD3;
	Mon,  8 Jan 2024 17:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E1BC433C8;
	Mon,  8 Jan 2024 17:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704735517;
	bh=sRdhFFjG4vYoS4PB2ORGCKITVh+f7hbNwK17Xzu9HJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3NXbRr83nXImKXCFXpxAZNBKresHQ1IBQEA4iIqvkN/7DsAGO52Q9E+MkL9bi8JD
	 h5SN5GDou4STdrkNYGJH/Q6xw8SVp75+Y3Z6LFM4maYoVACCVAh6RyXkJcRpCVnPcv
	 d9+ASxByUJSsf2oHgM4spoCsPswbnuzI/Sk0xzfQGHkgPLWktfgAUjORhFyjZVdfa+
	 aUTNnVruF1CvZA+uO/F+eLKMg6bq5ioXqVmk86Vrb0gGCXiLKM2NuggzKDFZHoWN4E
	 2nXJhwwrllFqP5LgXkYUZijdkE3u201HQdk8IupVy/1YlDjfH73U9uRaKeTGqHew7U
	 AGBG/3W0Vw8Qg==
Date: Mon, 8 Jan 2024 17:38:31 +0000
From: Conor Dooley <conor@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	=?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado <nfraprado@collabora.com>,
	jason-ch chen <Jason-ch.Chen@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>,
	Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] dt-bindings: arm64: mediatek: Add MT7988A and BPI-R4
Message-ID: <20240108-helium-retriever-043ed3e1dbe0@spud>
References: <20240102205941.29654-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fpLxZoPgQvXVZ2oX"
Content-Disposition: inline
In-Reply-To: <20240102205941.29654-1-zajec5@gmail.com>


--fpLxZoPgQvXVZ2oX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2024 at 09:59:40PM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> MT7988A is another MediaTek's SoC with just 1 device available right
> now: Banana Pi BPI-R4.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--fpLxZoPgQvXVZ2oX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZwzFwAKCRB4tDGHoIJi
0tmdAP0UWGqGDdPKC8piDlk05QfJDU0tLttpkPbYrD3AcUrQwgEA2oJx1AaHQUav
Xvqol9sSOmbiJkBSjQLQHDWheer2CgI=
=J4xX
-----END PGP SIGNATURE-----

--fpLxZoPgQvXVZ2oX--

