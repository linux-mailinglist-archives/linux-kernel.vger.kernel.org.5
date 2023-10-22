Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5B67D24F9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjJVRfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjJVRf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:35:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDF0E6;
        Sun, 22 Oct 2023 10:35:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EADC433C7;
        Sun, 22 Oct 2023 17:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697996127;
        bh=+RDNXfr09gHQffArCIyEozXJfIbsRgoaUkMmT9nAQcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eLkBckyNDlVImV6OmWVubPL8xno7BMuzseCqIL3vonmAX2lr7NWo32iXbn7x329lq
         WBmBv5FKUlX0Zen72FOVJfSeggC712Wl6JuCOuCd9IR55st2uLprrpMjZ9fUZZ+eVl
         XbTqr7uvU8iA3/c+NKe+NkPGnZFOGzZ4WB7QjxBE8NFvv1q7DFvKk0fRHfpUTM/Yy3
         ELu7ofnQHMlVeT+01DnzQFIlZWEv+NgxtPfcVXY+AHciEFXx5Y7Cc9hRDUCY33aW9Q
         FQ7k1H0JkowwcDWor3eSXTsmSLuFfhcKBt1LnWIYRYBvkfhBCXSVXyDBTlJHKx1pyD
         2tcWgJrfdaG6A==
Date:   Sun, 22 Oct 2023 18:35:22 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: nuvoton,npcm845: Add missing
 additionalProperties on gpio child nodes
Message-ID: <20231022-imprison-gruffly-7a54a48918a6@spud>
References: <20231020170017.3610978-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zjBK80u1y4Q2cFRB"
Content-Disposition: inline
In-Reply-To: <20231020170017.3610978-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zjBK80u1y4Q2cFRB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 12:00:16PM -0500, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present for any node. Add the missing addtionalProperties to the 'gpio'
> child nodes.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.yaml     | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pi=
nctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinc=
trl.yaml
> index e4b9f3da2cf0..3e8472898800 100644
> --- a/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.y=
aml
> +++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,npcm845-pinctrl.y=
aml
> @@ -35,6 +35,7 @@ properties:
>  patternProperties:
>    '^gpio@':
>      type: object
> +    additionalProperties: false
> =20
>      description:
>        Eight GPIO banks that each contain 32 GPIOs.
> --=20
> 2.42.0
>=20

--zjBK80u1y4Q2cFRB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTVdWgAKCRB4tDGHoIJi
0nCNAQC4n/8blQKppMM0k1acuJdQK7No/wYvFuR+achfFZtDgQEA42l10lATlk8v
JinAMIUTJAq/UBAw9oma3JH5StDPDwo=
=sxmL
-----END PGP SIGNATURE-----

--zjBK80u1y4Q2cFRB--
