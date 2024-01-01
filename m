Return-Path: <linux-kernel+bounces-13876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA4C8213E5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 15:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC70282075
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 14:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12404433;
	Mon,  1 Jan 2024 14:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAn69pGU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE744691;
	Mon,  1 Jan 2024 14:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050A9C433C8;
	Mon,  1 Jan 2024 14:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704117885;
	bh=FzuSWwWvpBgAC2NCSRqKQPffhPoMdS2sf1padg0K5bU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAn69pGUv+pGF4zzLDwLCXkfDc6iP8o0G2HVNKYRg6RbrALO1++9Gq52fyGml9R1h
	 m9EGtgOERHhJJ56d9v9WtrcdMj6BEX0cPBTo6IUTP7ICfu4ukMtVVfasKfUgHKH3Cm
	 DiJNihltvI4Ia5/rU1Ef/s5vU9F5avo8qo8g5ytrW31H+tV6+/nV9Vay0jw1O3/sV/
	 8rX0F2Q/0YZc+mX30esK99HeNrLfAG4aq9XGnKDF0SmeCIqSrhKNyVfPRzE/v8BpEu
	 6PFNawN8NyAbANhNLbBPnfksQtGVnPK/Fq5GDsU+9jNmbFXNletNrACYJ/agFQi0T3
	 SVg1PfcWdsEDw==
Date: Mon, 1 Jan 2024 14:04:40 +0000
From: Conor Dooley <conor@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/8] dt-bindings: mfd: stm32f7: Add binding definition
 for DSI
Message-ID: <20240101-devouring-anointer-d6da59bd872b@spud>
References: <20231229135154.675946-1-dario.binacchi@amarulasolutions.com>
 <20231229135154.675946-2-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RloIUIyV6rC2Sjnj"
Content-Disposition: inline
In-Reply-To: <20231229135154.675946-2-dario.binacchi@amarulasolutions.com>


--RloIUIyV6rC2Sjnj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 02:51:16PM +0100, Dario Binacchi wrote:
> Add binding definition for MIPI DSI Host controller.
>=20
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--RloIUIyV6rC2Sjnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZLGeAAKCRB4tDGHoIJi
0k/vAQC1vXTxuphnM+TaXni2YgUQ1I4XsaY5LnyNMwJoGnGxGgEAnwat9dn5e+ne
g1K7ezWGpq/8RjqpyLPfsx47gcHaYgs=
=aG3R
-----END PGP SIGNATURE-----

--RloIUIyV6rC2Sjnj--

