Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2497F1782
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbjKTPkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbjKTPkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:40:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3158A7;
        Mon, 20 Nov 2023 07:39:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161FBC433C9;
        Mon, 20 Nov 2023 15:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700494797;
        bh=JgmVlAD0SVlJwutybmB0QZ20Wz0K+sINDxYtLsbPzX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oCgpEN1YXbuhuRySf7/jaCTIIj+j7Wj8bejNx/SYNsjABBuzqqSdM0NgPT05UNIWa
         Nvsx8gG6Ky9D8CNCBGuarzZ4hFb81oa9J8Kg4ehL4qcB6vck3OjH9LJOa1tZ72L0iA
         csiBwFfp31jDIAE2EbzI8KB2OdD0YXNLMFrHMMsSw/ZcxmeB8oBempmRHAWwapwObs
         GGzWEMdvXDducbBRvFYQE7cyngvjnPVbqOoAx4p11NBLrVw84zBZtphM2i7hItc8Xv
         XJzqlyXDQmpOfqhlnH6PH0/U3FVWaIXfg/0X9LTuBnDJdjpzVRL9CIP3VyTzKgYA51
         5+zB6irvoN7Xw==
Date:   Mon, 20 Nov 2023 15:39:48 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@armlinux.org.uk, geert+renesas@glider.be,
        magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, p.zabel@pengutronix.de, arnd@arndb.de,
        m.szyprowski@samsung.com, alexandre.torgue@foss.st.com, afd@ti.com,
        broonie@kernel.org, alexander.stein@ew.tq-group.com,
        eugen.hristev@collabora.com, sergei.shtylyov@gmail.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 09/14] dt-bindings: net: renesas,etheravb: Document
 RZ/G3S support
Message-ID: <20231120-colonize-stagnant-014b8c3e088a@spud>
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120070024.4079344-10-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EsTjh6DiHZ+G5q0D"
Content-Disposition: inline
In-Reply-To: <20231120070024.4079344-10-claudiu.beznea.uj@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EsTjh6DiHZ+G5q0D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 09:00:19AM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Document Ethernet RZ/G3S support. Ethernet IP is similar to the one
> available on RZ/G2L devices.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--EsTjh6DiHZ+G5q0D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVt9xAAKCRB4tDGHoIJi
0pyUAP4uVNs4gjXhcdJ2Mkl6p+n4LaYxSVRlvGqfTmIxUltbsQD8CiHoPxqOlRnY
S3CJKejSMjx7ZsCqXgD0ENkvFY5Pww8=
=dkRN
-----END PGP SIGNATURE-----

--EsTjh6DiHZ+G5q0D--
