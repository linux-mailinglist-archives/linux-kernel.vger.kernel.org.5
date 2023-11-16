Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3DC7EE637
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345361AbjKPRz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKPRz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:55:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A94189
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:55:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CB0C433C8;
        Thu, 16 Nov 2023 17:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700157353;
        bh=JTOSSzmkti/CwkIFzl38dTbWRkcFa2xCEPwQSmwX8aA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EFyoDzEMgrhUh2OxSpogBRBdx/kxk2p6NXUbDjjjl4EwgWbPltzgZixN/p8bEtMi7
         hKGIPprRoW/tOD8Qi79NE84j5zepPPPfDTZ4nGeBlQ/kfEvXdSTu504rIhA0hRfivw
         otOlkcUPnhOfuI3QGcCn7TyQWtn2zoL4S1oS43gRY3NxT1gobz1QaTr1DCgXPKxuT6
         iETnqxuNlPQ+vxs2F2//BHVqDgh9I14q059z8Lx1OZVi2DuLkrZvhkcXnD8TvBMG8/
         ZbCvJ1T99RoNUpsb7o/vOmb0CiVd4cgH494by8++yRUaYyitC8OskXl2dJ+ztFQ4Gj
         NSvbNuQH7f1SQ==
Date:   Thu, 16 Nov 2023 17:55:48 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Samin Guo <samin.guo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        geert@linux-m68k.org
Subject: Re: [PATCH v2 12/12] [UNTESTED] riscv: dts: starfive:
 beaglev-starlight: Enable gmac
Message-ID: <20231116-stellar-anguished-7cf06eb5634a@squawk>
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-13-cristian.ciocaltea@collabora.com>
 <f253b50a-a0ac-40c6-b13d-013de7bac407@lunn.ch>
 <233a45e1-15ac-40da-badf-dee2d3d60777@collabora.com>
 <cb6597be-2185-45ad-aa47-c6804ff68c85@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uAMF7mMjCIyQbaxj"
Content-Disposition: inline
In-Reply-To: <cb6597be-2185-45ad-aa47-c6804ff68c85@collabora.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAMF7mMjCIyQbaxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 03:15:46PM +0200, Cristian Ciocaltea wrote:
> On 10/30/23 00:53, Cristian Ciocaltea wrote:
> > On 10/29/23 20:46, Andrew Lunn wrote:
> >> On Sun, Oct 29, 2023 at 06:27:12AM +0200, Cristian Ciocaltea wrote:
> >>> The BeagleV Starlight SBC uses a Microchip KSZ9031RNXCA PHY supporting
> >>> RGMII-ID.
> >>>
> >>> TODO: Verify if manual adjustment of the RX internal delay is needed.=
 If
> >>> yes, add the mdio & phy sub-nodes.
> >>
> >> Please could you try to get this tested. It might shed some light on
> >> what is going on here, since it is a different PHY.
> >=20
> > Actually, this is the main reason I added the patch. I don't have access
> > to this board, so it would be great if we could get some help with test=
ing.
>=20
> @Emil, @Conor: Any idea who might help us with a quick test on the
> BeagleV Starlight board?

I don't have one & I am not sure if Emil does. Geert (CCed) should have
one though. Is there a specific test you need to have done?

--uAMF7mMjCIyQbaxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVZXoQAKCRB4tDGHoIJi
0tu2AP9drj6GsHST1GuwVshDCPfcDCHRO+vR+I1UqBAWPOMUXwEAqSxcPaC1TyWe
GMY51dqgFxkhTDyvFRD6foJdL4VC4w8=
=kvIZ
-----END PGP SIGNATURE-----

--uAMF7mMjCIyQbaxj--
