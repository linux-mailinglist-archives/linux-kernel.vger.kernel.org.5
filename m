Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2207ED66E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343696AbjKOV6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbjKOV6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:58:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7947A9;
        Wed, 15 Nov 2023 13:58:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BECAC433C8;
        Wed, 15 Nov 2023 21:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700085485;
        bh=IvBa9pgb6D3ZQqdnKtvi2DQ5k+yybHsYqlcBerz+YPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YfO/N3OqczH0i+5oqUyC9j9eIXuaverTCwnAfUSHN9mV6j4c6DCdrK/OUhS9UZh9n
         EhqplOz6VsGVvTIrGeBp0bZUYoZlCAlSKaNnBEFO6RF9HE6dpYg1YDk+LBYJKiqxc/
         urvlHnngrSNcmVqd/lug1wkj6OSh2s/yM+ibKnN/PyAImOWgXgpo6eQ+tjkLOcQfKx
         gaag8spjtPbrPsacbFFML7YFXQ+Td0L+PpRZFTQ+1gAnzESXlv2DI9nYVKz4dLlKOO
         ox+IvwheB6J0haPCTutxGZUjoqc6/dbSzrue67yybycg1NQPYW8O/8y75tgTzRVXi1
         ZAXYtWxTuFjfg==
Date:   Wed, 15 Nov 2023 21:58:02 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] spi: dt-bindings: renesas,rspi: Document RZ/Five SoC
Message-ID: <20231115-snowdrift-rocking-d1ae345accb3@squawk>
References: <20231115205333.31076-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PsdkWD17Co/CTnDy"
Content-Disposition: inline
In-Reply-To: <20231115205333.31076-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PsdkWD17Co/CTnDy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 08:53:33PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The RSPI block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,r9a07g043-rspi" compatible string will be used on the
> RZ/Five SoC so to make this clear and to keep this file consistent, update
> the comment to include RZ/Five SoC.
>=20
> No driver changes are required as generic compatible string
> "renesas,rspi-rz" will be used as a fallback on RZ/Five SoC.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--PsdkWD17Co/CTnDy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVU+5gAKCRB4tDGHoIJi
0lAwAPkByZRmhg5HpjC0VDdfKiuQ03Hg+gIYsHn90xgHn4SpuAD+JXI3CCYlsMcu
4IQ760DGzo9e1j+KBIvwLLjtPVTDrgA=
=d48B
-----END PGP SIGNATURE-----

--PsdkWD17Co/CTnDy--
