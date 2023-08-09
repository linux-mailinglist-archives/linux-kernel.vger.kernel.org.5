Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A008776687
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjHIRip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjHIRio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:38:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8F7E71;
        Wed,  9 Aug 2023 10:38:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43DF264311;
        Wed,  9 Aug 2023 17:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF67C433C7;
        Wed,  9 Aug 2023 17:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691602721;
        bh=JEJkyDA9mNcPNMW2BuJGF6PgKkgkGalfSfXFkQWZKhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tq1eoIkfdHy3ArOqTDn4u16YGaskMie+zV/Px2pdMO+p7mwSk2jIcXc84UbQ3naLy
         AZL/dX+Xl1TrhwZLNDXZbzjQgkouCcptFeZQlqWaIYf+4HY0hgy0PqKYxONzT3JbvU
         1YRJbD1aqnZZ/1vN97f7npFMQjU8q4HCvZfeLB38+JHNub2soLcZ+cnTuS0muSkMSA
         U5zu5gNFUdIx+ghF0n8KC7XLYXAT4xHnKhyFqB8gxeWJl9S/yD8YBTVzj6KGq8p1Xn
         TXJtNajuj2YmQ2342YfUNUZ/8RFSooDTJImjgBtyd0Z1MVGJEXXHdlZtriKkmMZPDx
         0j0mY4L9sRysQ==
Date:   Wed, 9 Aug 2023 18:38:36 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 09/10] dt-bindings: net: snps,dwmac: add per
 channel irq support
Message-ID: <20230809-scabby-cobweb-bb825dffb309@spud>
References: <20230809165007.1439-1-jszhang@kernel.org>
 <20230809165007.1439-10-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xjvlQWsUfSJ189eD"
Content-Disposition: inline
In-Reply-To: <20230809165007.1439-10-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xjvlQWsUfSJ189eD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 12:50:06AM +0800, Jisheng Zhang wrote:
> The IP supports per channel interrupt, add support for this usage case.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

I do not see a response to
<https://lore.kernel.org/all/20230808-clapper-corncob-0af7afa65752@spud/>
in my mailbox or on lore, nor is there any changes in v3 on this front.

Thanks,
Conor.

> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docu=
mentation/devicetree/bindings/net/snps,dwmac.yaml
> index 5d81042f5634..5a63302ad200 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -109,6 +109,7 @@ properties:
>        - description: The interrupt that occurs when Rx exits the LPI sta=
te
>        - description: The interrupt that occurs when Safety Feature Corre=
ctible Errors happen
>        - description: The interrupt that occurs when Safety Feature Uncor=
rectible Errors happen
> +      - description: All of the rx/tx per-channel interrupts
> =20
>    interrupt-names:
>      minItems: 1
> @@ -118,6 +119,38 @@ properties:
>        - const: eth_lpi
>        - const: sfty_ce
>        - const: sfty_ue
> +      - const: rx0
> +      - const: rx1
> +      - const: rx2
> +      - const: rx3
> +      - const: rx4
> +      - const: rx5
> +      - const: rx6
> +      - const: rx7
> +      - const: rx8
> +      - const: rx9
> +      - const: rx10
> +      - const: rx11
> +      - const: rx12
> +      - const: rx13
> +      - const: rx14
> +      - const: rx15
> +      - const: tx0
> +      - const: tx1
> +      - const: tx2
> +      - const: tx3
> +      - const: tx4
> +      - const: tx5
> +      - const: tx6
> +      - const: tx7
> +      - const: tx8
> +      - const: tx9
> +      - const: tx10
> +      - const: tx11
> +      - const: tx12
> +      - const: tx13
> +      - const: tx14
> +      - const: tx15
> =20
>    clocks:
>      minItems: 1
> --=20
> 2.40.1
>=20

--xjvlQWsUfSJ189eD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNPPHAAKCRB4tDGHoIJi
0uDFAP4qH8Xnk1lWdOwlIW0fWCJyaXgG1F8zPUQ2Gsb4MgpJXAD/aFtaJoIkYfZ/
21lPuNeab/ZdCafUEILwlmTgvCUFsw0=
=r6X8
-----END PGP SIGNATURE-----

--xjvlQWsUfSJ189eD--
