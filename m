Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA61777FE7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbjHJSDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbjHJSDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:03:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117B02724;
        Thu, 10 Aug 2023 11:02:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3A5C6659D;
        Thu, 10 Aug 2023 18:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EE7C433C7;
        Thu, 10 Aug 2023 18:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691690577;
        bh=Y5NbfTzNtvATG9GxZM1Qw0F5nvZfv1HtLDJ4xkBt2hQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A/YtgsbUK1wEI/m3j+lbTimnm7LKRJA1RywxB47qQiteMKMuxx3i5Hxz5wtM7hmBq
         gQWNrwf4B/Z3ZTRm6ZdGvpAAHWJuaXjOCXa7N55mL0wtFPvP/ylhqrvMtkqUIMM/JV
         zgJ30nRuhI4FS9CyjrmqcotVV6h78rgZPOlvHBAGXY41sG42h1oPf7apyqzwbd/rW2
         2DxJ/u6e3Yu352ECVCo6etxNwrv9NevlS4G0Vl+in1lmuYoXwsSn104EnGHeM4NYM/
         qrrmX/A1z0Ldu57/+cFQMKtZrQcnYCql4+G+6tmwkWM9V/LrtDLM93ewblFGf3R6NI
         eb/pN+7Q+2OGQ==
Date:   Thu, 10 Aug 2023 19:02:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        kernel@puri.sm, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        David Heidelberg <david@ixit.cz>,
        Sherry Sun <sherry.sun@nxp.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: sound: gtm601: Add description
Message-ID: <582be994-d3c8-4edf-9028-99b18505e378@sirena.org.uk>
References: <cover.1691684726.git.agx@sigxcpu.org>
 <6904cc6d877d28d92e9f9fa9f1bdc404614d9734.1691684726.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GODGWzgiFfPQfLkj"
Content-Disposition: inline
In-Reply-To: <6904cc6d877d28d92e9f9fa9f1bdc404614d9734.1691684726.git.agx@sigxcpu.org>
X-Cookie: Reunite Gondwondaland!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GODGWzgiFfPQfLkj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 07:59:49PM +0200, Guido G=FCnther wrote:
> This allows to us to document the channel and sampling
> rate requirements.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--GODGWzgiFfPQfLkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTVJkcACgkQJNaLcl1U
h9CWgQf9E1fK+h8U4tglO2QBYdincfV5U+VibIuT+X3R6d04Ld31bt4zcsOebMv6
fsAbpoGJOrIqB63vKIGaOO3UvhUzmzR3IjzgzHf6J9a2oQm8G59+qayWuwpx8VZ3
ttWsCsjjJU7ZILOFmfZf2zIBnipw8Ze+dlyT9qzm7W9B0CPW1FEnD6jiklT/o6YP
ekdGU7vZA2Yap/nLhfDlLFQN5dh1UC0kuSOx/uScsanGSMtYN/WqsQHdCNsPCX0s
v4BwnIIX+KJcOwFIJ7Ye3YaOUBWanxVI2iWXZCZ0xX1bFOeUVyZRKtKDNGyUSb4p
jPICdMQVJ1M1b/QOehMvuvGkkbGTJg==
=ie9k
-----END PGP SIGNATURE-----

--GODGWzgiFfPQfLkj--
