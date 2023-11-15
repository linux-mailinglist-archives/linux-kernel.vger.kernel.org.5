Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299A07ED655
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343667AbjKOVys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjKOVyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:54:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67C1130;
        Wed, 15 Nov 2023 13:54:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CAFC433C8;
        Wed, 15 Nov 2023 21:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700085284;
        bh=3cBd6zL0s3h4kc7XKXxRxiqowOHUr5irsv4JVBuw1nY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oOphkJaT+WdFxmy0sEobuHa8sWkWajxR3hcgekEZ5VqhwSUInN3NLHh3WnpEgVZgQ
         bmmfqnZgKipYPucr9Ol3YgXaxNeMVMUZ0QpioCjMj7QIJSHugSGiWuEunA3raGD0HR
         UD21lbtWuZYjc+pDmH2dUO+k8gLFbPUZS7QjQYWbk2JYmYXN/rSA1QYxYvRXBMgej1
         urP9+TzGCDldfsE725L8hrTlO6FznJMs4c74MfJ/zRnnTeuOQPFQ21fsjc7+dJGLIB
         nuRxf2ulQz8/WymkTw9UAzttlgTp3PmqyRvAZu7foJRasQuw/bnLMCnPKoYdORuVxr
         ODZJcG1dLc5ug==
Date:   Wed, 15 Nov 2023 21:54:40 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: timer: renesas: ostm: Document RZ/Five SoC
Message-ID: <20231115-hertz-buffoon-aeb2c8d9e7ee@squawk>
References: <20231115212908.33131-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C2xlhivywdgGtokx"
Content-Disposition: inline
In-Reply-To: <20231115212908.33131-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C2xlhivywdgGtokx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 09:29:08PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The OSTM block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,r9a07g043-ostm" compatible string will be used on the RZ/Fi=
ve
> SoC so to make this clear and to keep this file consistent, update the
> comment to include RZ/Five SoC.
>=20
> No driver changes are required as generic compatible string "renesas,ostm"
> will be used as a fallback on RZ/Five SoC.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor,

> ---
>  Documentation/devicetree/bindings/timer/renesas,ostm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml b/=
Documentation/devicetree/bindings/timer/renesas,ostm.yaml
> index 7207929e5cd6..8b06a681764e 100644
> --- a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
> +++ b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
> @@ -23,7 +23,7 @@ properties:
>        - enum:
>            - renesas,r7s72100-ostm  # RZ/A1H
>            - renesas,r7s9210-ostm   # RZ/A2M
> -          - renesas,r9a07g043-ostm # RZ/G2UL
> +          - renesas,r9a07g043-ostm # RZ/G2UL and RZ/Five
>            - renesas,r9a07g044-ostm # RZ/G2{L,LC}
>            - renesas,r9a07g054-ostm # RZ/V2L
>        - const: renesas,ostm        # Generic
> --=20
> 2.34.1
>=20

--C2xlhivywdgGtokx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVU+HAAKCRB4tDGHoIJi
0pq/AP4o7Kn1vZAS5Npud5TKjsoeBea2Y+96WybgzEbbT6yq/QD/Y54HBIxOvFDl
nup41Y2l91Jks1pCXbP1AfdRkAvqJw0=
=CfMI
-----END PGP SIGNATURE-----

--C2xlhivywdgGtokx--
