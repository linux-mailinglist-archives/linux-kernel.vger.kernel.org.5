Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5E48130ED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573206AbjLNNGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573177AbjLNNGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:06:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7352118
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:06:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829CFC433C9;
        Thu, 14 Dec 2023 13:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702559218;
        bh=4DmhfcKP5a7QiKawraF+mw/pvVqMPyK0S58+roaapOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oiul8EewigOeqOx6Mi9PQ6UZF0YQOATTHlzqVv7wkqi4OqclyCpebjS1KjirRDmEJ
         SvN6nIAF5QFu3Rcpr05GHKOL9eWgDgCzQnhmYlLvXsoBM5YepIaVkkk87flH4foOMk
         HaEEHOk0t2MkerO7erR4Tg+mK9QVlxsBk7Li9xJ41U0gwmHV/F1W6wdcrgGytQYVC6
         l+8sai6EDx5PdMp0sZGLrrvruoCIlp5nUBPWXV5vXuL6jbYuhR4pxOxmDPiJk4Tuig
         EUYn8D2ZMCCIcBnTMtuI4S6P9Gk70pgl1fWKnsQog7jGOaMaIc+kHPMXoL5wrB9y7/
         vLwEC5YUsRGug==
Date:   Thu, 14 Dec 2023 14:06:54 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     peter.griffin@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, arnd@arndb.de, semen.protsenko@linaro.org,
        andre.draszik@linaro.org, saravanak@google.com,
        willmcvicker@google.com, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 03/13] dt-bindings: i2c: exynos5: add google,gs101-hsi2c
 compatible
Message-ID: <ZXr97owdnLq3viNc@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>, peter.griffin@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
        andi.shyti@kernel.org, alim.akhtar@samsung.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, s.nawrocki@samsung.com,
        tomasz.figa@gmail.com, cw00.choi@samsung.com, arnd@arndb.de,
        semen.protsenko@linaro.org, andre.draszik@linaro.org,
        saravanak@google.com, willmcvicker@google.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
 <20231214105243.3707730-4-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HQnYG9fD4BDlpmSL"
Content-Disposition: inline
In-Reply-To: <20231214105243.3707730-4-tudor.ambarus@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HQnYG9fD4BDlpmSL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 10:52:33AM +0000, Tudor Ambarus wrote:
> Add google,gs101-hsi2c dedicated compatible for representing
> I2C of Google GS101 SoC.
>=20
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Acked-by: Wolfram Sang <wsa@kernel.org>


--HQnYG9fD4BDlpmSL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmV6/ekACgkQFA3kzBSg
Kbac1hAAtEeMMhA9NKxHiemKCgdvzxVb71vVFzKZTa0rM9HstusgWrnxcXTU4XWd
tQMUwAVVs6G5Lxho0WuFLuJXRVmc/XOFSyDLeo75vHop/khJpREg5/4x5S953V7j
SDY4ThYVJuYdXFhZKFsiH04nV3O4zrxm3leDvT0q9C9P09Xh7DYeMu2PnHPV/Gu1
JFGknNxP4nAb86hKMMsZIkhWZ9Wk+XZAluArjyu17rKeSQHcbE6QJoR95AEydEUy
PolkM4ZOh/SHRffnMO+FG1+IX2lIEMM9dOX2eLpjZzMRI4iW0I39iQaoPz7WSqQs
fWa8LdXndWGIZvQmYN4lRjQFhzDKDEOheg/SglzLuGa+48tkqrrcRKGRM+Kx/cGo
yHbtA6qimdxi/o8+YmUWl+X57X8JIbgmSHsucm/+lNCG6JFtfMyOskeS1hsIgWws
PV3BPNAY32hJLbEnTf2royzKnJbWMt75RZJTsu/8j54DPydhhLO9IqdHDqngnHpp
d5WPhOebKuYdqH5YHqVG6C7hOYTR903tWy0annEcAKm64bboWZ9EWYs5Z0IP2/af
i/i9y1Nou+YYvlSmkp0asWHhpHySkIR3rkThW9eIHVBEWkSS2si6WJSfWQBvDGro
hEYeczzfDuUcb3v6vuIinWdDcVoHWyrlRbJS5GLIT8LoVAc8ohs=
=msdb
-----END PGP SIGNATURE-----

--HQnYG9fD4BDlpmSL--
