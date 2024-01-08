Return-Path: <linux-kernel+bounces-19593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7D2826F52
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECDCF1F21C4D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA81C41752;
	Mon,  8 Jan 2024 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuKagrB7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257E641236;
	Mon,  8 Jan 2024 13:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26278C433CA;
	Mon,  8 Jan 2024 13:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704719459;
	bh=V/XZirQgER4ZBJmygiwFU3KMch9yuOqE2KjjCbzeoHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EuKagrB7TeH7lUsAiqXRwEviA4GHy5IK1lEJLQ6162YbMgXFmu8yPo1RXaUhI0zZi
	 4gtt+x27DMJrFYE1TiJNNPV1JvCI6hZmhZhNyK2vanSySi085t9fYuI18L2LsSut77
	 hXYW/OqECYxKXmdJipV4E6RzT2VVRzNlveWMzQH4coC9L+TPW80o6co13zPEz6If5i
	 iA8C5j61+6tpeU5wKa50ikYvD72+2JgC0fJbQAq350g1aCvH4A4zbNjlvWjKhlJbBf
	 7GZy7NsEQmGt2m2pD5vbjqThXrG7sUg+4KXBtIOftrIhzKtQlKyN0+Ie/oWpttTYoS
	 I1KhEOJeTR6LA==
Date: Mon, 8 Jan 2024 13:10:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 2/2] docs: dt: submitting-patches: add commit subject
 prefix in reversed format
Message-ID: <ffc45b81-3b37-4afc-b92c-fe98d3357c89@sirena.org.uk>
References: <20240108083750.16350-1-krzysztof.kozlowski@linaro.org>
 <20240108083750.16350-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rWoBB2uLTiSEIR7r"
Content-Disposition: inline
In-Reply-To: <20240108083750.16350-2-krzysztof.kozlowski@linaro.org>
X-Cookie: Best if used before date on carton.


--rWoBB2uLTiSEIR7r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 08, 2024 at 09:37:50AM +0100, Krzysztof Kozlowski wrote:
> ASoC, media, regulators and SPI subsystems prefer commits starting with
> subsystem name (e.g. "spi: dt-bindings:"), so document this to avoid
> confusing contributors.

Reviewed-by: Mark Brown <broonie@kernel.org>

--rWoBB2uLTiSEIR7r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWb9F4ACgkQJNaLcl1U
h9AbdQf/SGA/IECUB+nRplLn+0csaT/Ke5n232jTMBgUL3kzIQXTJLVk532pRMhG
wKR2FDRJzReBWvLHx/tsK2PY+httsqrgx083/aOQGY/jvcZaN5v2VBRKH94iZ+5O
h46GsTIY4/Fw9Ey4VziwYTTIVNKXKVkvtOKD3jWYgrqIdCDoekH0NjjNJan5gOvK
tRxL7gFGDLJTQrlBulUdjqZP1wWQQEZJ1ltWDc1I88LL7GeyCntQ8SvWhSz5OR+O
dkToPyhmQgmLGlrDpkD7SQUwaUNzD7nIe5pHSOno7jI4/3n/HGCarGYtm0bt9spr
E6GaM3pQfSuUJMjconZVj96WldXv/A==
=oioo
-----END PGP SIGNATURE-----

--rWoBB2uLTiSEIR7r--

