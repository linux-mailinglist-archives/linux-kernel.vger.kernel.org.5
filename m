Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3D27705FB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjHDQ25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjHDQ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:28:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8069846B2;
        Fri,  4 Aug 2023 09:28:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D52F2620A7;
        Fri,  4 Aug 2023 16:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C958C433C8;
        Fri,  4 Aug 2023 16:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691166524;
        bh=1SQYRDcXjGoKfMlK7pC2jJ2xp6PZ1JaiWNFXAGtgcCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NjBPpGEQcKTIarY2Z8UoNpSNvgBpJ9lwTtNfMP5KadCJE7NSPdwwT6CVUpi7rT9Rs
         7IS1kyvAMonVpgo2hLUajGihzpPTll831VVhjq+k7A5zILP85TNehzmv1nv9+KpowK
         Kc+AnPAsvO3R7ZgaRS/0UiBSIhackAHmo2aBgYDv5EHq3U3fppvWrBjqXmBoj9CFgl
         2XQ4/aPqTppju44w78cYRpqkRUNC2vduQ8M6O4eM1xlquII4RJLj7r7C8V5aGT/IAb
         b6IHyIEJF8QTX7dl79Cazdy5YaB/1fXlpzPge0bKPvZULAXEdKMwTcGacEtCG/lxk9
         NbR20JujEFBqg==
Date:   Fri, 4 Aug 2023 17:28:39 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Mihai Sain <mihai.sain@microchip.com>
Cc:     claudiu.beznea@tuxon.dev, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, cristian.birsan@microchip.com,
        alexandre.belloni@bootlin.com, andre.przywara@arm.com,
        jerry.ray@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        andrei.simion@microchip.com
Subject: Re: [PATCH] ARM: dts: at91: sama5d29_curiosity: Add device tree for
 sama5d29_curiosity board
Message-ID: <20230804-starlet-facebook-051f59b7eac8@spud>
References: <20230804101043.4063-1-mihai.sain@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3cETkHcmawoyHVtG"
Content-Disposition: inline
In-Reply-To: <20230804101043.4063-1-mihai.sain@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3cETkHcmawoyHVtG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

Firstly, $subject is missing a "v2" inside the []s.

On Fri, Aug 04, 2023 at 01:10:43PM +0300, Mihai Sain wrote:
> Add initial device tree file for sama5d29_curiosity board.
>=20

> Changes in v2:
> * drop dt-bindings patch
> * remove vdd_1v8 regulator
> * fix flx4 node to use 1 spi node and pinctrl
> * add i2s0 node and pinctrl
> * remove macb0 node and pinctrl
> * remove unused pinctrl
> * sort in alphabetical order all nodes and pinctrl
> * replace "_" with "-" in node names

This needs to go under the --- line, not in the commit message.
Perhaps Claudiu would be willing to fix it, but certainly for future
versions this needs fixing.

Thanks,
Conor.

>=20
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> ---

--3cETkHcmawoyHVtG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZM0nNwAKCRB4tDGHoIJi
0qpFAP0dvR3rR5cvo1cZf8PSoYD6jjtkTE83eX9MDV/YBcP/rgD9HX0MuOQvUCoE
7pxqltI/1So3HdQ5Yol2t12Ph4t3Zgk=
=/m9X
-----END PGP SIGNATURE-----

--3cETkHcmawoyHVtG--
