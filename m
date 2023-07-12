Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3144A75104F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjGLSKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjGLSKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:10:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F5F1FEC;
        Wed, 12 Jul 2023 11:10:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA398618BB;
        Wed, 12 Jul 2023 18:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD66C433C8;
        Wed, 12 Jul 2023 18:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689185410;
        bh=Memgf9GzvMAFY5lRq6V3EGilVkjuiQ+UqIuIcVYoRyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nACLBqgy2+0iE6VajuxT2NGv0Fbt6dazbiBuiISdDf2Sj9Q79EpBpd4dIJtPb9Unw
         3l8uk2phOE7OlSsNYg8jraXExFO8jDnIgZAdx1mNneMiBTQgS7P92bz3aG9y4Fosvx
         doeANFH8S2rYeXeNV2TpsvMMMBZuKpP9ByE0ZhuDem4Ac1L1YR+Lh9Vjel5vM7AqdG
         nvPiErKmxdtp9HImBNYFJ3m3xJnByso01/enDqUNWXY3T72s+i/NStZEv07Gd0Z7yD
         PgLLn6TDPsFl5+A+FFB6frvbL4U7QI5OqWBYbARV31cTFvzK7QyHfzvqEttOfvOE2q
         Oe47fn21BDp6w==
Date:   Wed, 12 Jul 2023 19:10:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     l.goehrs@pengutronix.de, a.fatoum@pengutronix.de,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dantuguf14105@gmail.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/9] dt-bindings: arm: stm32: add extra SiP compatible
 for oct,stm32mp157c-osd32-red
Message-ID: <20230712-purge-untangled-b7b333c69c0c@spud>
References: <20230712124248.2400862-1-sean@geanix.com>
 <20230712124248.2400862-8-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DFDDwRwhxkcH4vx8"
Content-Disposition: inline
In-Reply-To: <20230712124248.2400862-8-sean@geanix.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DFDDwRwhxkcH4vx8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 02:42:46PM +0200, Sean Nyekjaer wrote:
> Add binding support for the Octavo OSD32MP1-RED development board.
>=20
> General features:
>  - STM32MP157C
>  - 512MB DDR3
>  - CAN-FD
>  - HDMI
>  - USB-C OTG
>  - UART
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--DFDDwRwhxkcH4vx8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK7sfAAKCRB4tDGHoIJi
0qKLAP4rpJCjMYjqTCHRUmXdQpHseHtotcoK9EOzKAYk8HxXxgD/U+fZlV7lWQqn
K/FMuttJ7rGWrP0k6Ljtzj972RqJBwQ=
=1dgn
-----END PGP SIGNATURE-----

--DFDDwRwhxkcH4vx8--
