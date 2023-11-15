Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EB07ED669
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjKOV5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbjKOV5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:57:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C971C1A7;
        Wed, 15 Nov 2023 13:57:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5C7C433C8;
        Wed, 15 Nov 2023 21:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700085452;
        bh=utRWzAUPDR/YGuRAiQgw7t0J+7beCClfBghAq9tfy7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2kFn1/qvdpWpt6Sa7+G3dXsJ4Cbv1CzVhvzu5dwJsUqmu6iyOBj92/iAP71LyWS/
         jq9esZ/hPoY3l1tjHBR/OvQhykIHE7aPhN8YdTgP/PLj7wd7RxkMagETuErzXWWPln
         sa1S95Bv9wII2Fsh/2Wi+eJnpjbRHmmeFS26QcFkIkEYQcu7EJjvrZ2HqcvSCTniH3
         oC3eucpdS3xJAee2huLROhIBCdXn2OHG8glRQyL2JJ/IiOTFY6HJzKeDoXRJXupYmH
         rbxs/qEmZjYlSOGYJN3S2Ug+XIXce5G39JyWXQ2DXihOW7acP8ane0RmDfs5oWrNwi
         mPDpGauwFHNZw==
Date:   Wed, 15 Nov 2023 21:57:28 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: net: renesas,etheravb: Document RZ/Five SoC
Message-ID: <20231115-marry-lagoon-d78d6085f7d7@squawk>
References: <20231115210448.31575-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bQAUvGBLU9yZJPAS"
Content-Disposition: inline
In-Reply-To: <20231115210448.31575-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bQAUvGBLU9yZJPAS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 09:04:48PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The Gigabit Ethernet IP block on the RZ/Five SoC is identical to one
> found on the RZ/G2UL SoC. "renesas,r9a07g043-gbeth" compatible string
> will be used on the RZ/Five SoC so to make this clear and to keep this
> file consistent, update the comment to include RZ/Five SoC.
>=20
> No driver changes are required as generic compatible string
> "renesas,rzg2l-gbeth" will be used as a fallback on RZ/Five SoC.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--bQAUvGBLU9yZJPAS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVU+xQAKCRB4tDGHoIJi
0ksWAQCrH2BGWrEy+3mGVr9EmqX6AEJBK8pFi/wB9kpSOcLm+AD9FhX7YgTDDIxI
1mt+waCdmjiuk7XHFmrMnYATmhKa2AA=
=f8sj
-----END PGP SIGNATURE-----

--bQAUvGBLU9yZJPAS--
