Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC758751043
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjGLSIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGLSIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:08:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A364919BC;
        Wed, 12 Jul 2023 11:08:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 355DE618B6;
        Wed, 12 Jul 2023 18:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAF7C433C7;
        Wed, 12 Jul 2023 18:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689185316;
        bh=pR0fZMsUXaaQwQtdPc6o/bATsnwQZMLuxq0kNgltOR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J/8iPVdWzjarFmWJQDRHOGQ2jSofjOO4U9B1bfKkjJgqOBeQ6pIH0qxvlj1LUHJjv
         BrTwzXGiXvJmzajZfMc8xYChtwCo6w/754tI65VItlM0Qe4y3aftdv3l3kPGqXRGC1
         lk1yKrzwHTXPal0kZWl/nwoVSuOkjofaNJ0KxqA57Fvlf7J6ligMcwc0NMADa+2djD
         DXm8sRpbD80jSuNwO/aMT6AoDKTOT8aeVsUmrOBuMOrP/oeB+/2yZLXKMSzD4XRIFo
         RAlWt8WbnDj0Xi7Et76YpOYOxeKbZ+l96OdK6pa1s9yVEsNVmwK19GfbSJ8k/cgpXg
         x2n+6uaaBhQVg==
Date:   Wed, 12 Jul 2023 19:08:29 +0100
From:   Conor Dooley <conor@kernel.org>
To:     p.paillet@foss.st.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Etienne Carriere <etienne.carriere@foss.st.com>
Subject: Re: [PATCH 1/4] dt-bindings: rcc: stm32: add STM32MP13 SCMI
 regulators IDs
Message-ID: <20230712-wildland-molar-4a2db800081c@spud>
References: <20230712142432.1885162-1-p.paillet@foss.st.com>
 <20230712142432.1885162-2-p.paillet@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YlMgpd51Pn6qvNdn"
Content-Disposition: inline
In-Reply-To: <20230712142432.1885162-2-p.paillet@foss.st.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YlMgpd51Pn6qvNdn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 04:24:29PM +0200, p.paillet@foss.st.com wrote:
> From: Etienne Carriere <etienne.carriere@foss.st.com>
>=20
> Adds SCMI regulator identifiers for STM32MP13x family.
>=20
> Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--YlMgpd51Pn6qvNdn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK7sHQAKCRB4tDGHoIJi
0llQAP9xn2pVsWdTdAbjpYJXAlxcGu2Qjk/asa8a9TIPucf+twD/SfC1UfPatxI1
oH/laRbiR+7EC7XoISHvDnhfNZEKyQc=
=g/Ko
-----END PGP SIGNATURE-----

--YlMgpd51Pn6qvNdn--
