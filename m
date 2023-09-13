Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C05579ED8B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjIMPo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjIMPo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:44:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C7DCE;
        Wed, 13 Sep 2023 08:44:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A5EC433C7;
        Wed, 13 Sep 2023 15:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694619863;
        bh=1/CkrulF6+KqbTuzKb1q/qLsYFk1Z2Rg5kemiCj/HOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iz4vXsVlWKFeoRTHSTR6jo+EiFbQhqudRDByNMPV3K4LzK7obYnpdIte0MwAk909i
         hGhMyBHcJz49tdTsQtDZ5NJLDzr9CZf8C00vmehN5tV0rFnD270rmbDU8vCEfbLBDg
         UQnDhfIb55+LtsMLOM5gQeTTxV9+IUjqPb425N0JB6YZkoMLKUw+Yc//poexsVDZG1
         BSecK2bR4kY0TAefqTYoyDb5mGB4opp1R+AkSHWsP2ycu2Cig1P2Dm2faNkM8IALwL
         lup/MCsokIWlva1znMfKu9Av4dSm2nG5DcLyYdydJXv1VlX1l9Ni2MWR1fYDjaoDNL
         sWfBJGEAR5AAw==
Date:   Wed, 13 Sep 2023 16:44:18 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
Subject: Re: [PATCH v2] riscv: dts: thead: set dma-noncoherent to soc bus
Message-ID: <20230913-faster-spotted-9df41a0d7787@spud>
References: <20230912072232.2455-1-jszhang@kernel.org>
 <20230912-trailing-pampered-52738ec6f009@spud>
 <ZQHSLdPufI6CXApg@xhacker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9jVo0hczGyclwPro"
Content-Disposition: inline
In-Reply-To: <ZQHSLdPufI6CXApg@xhacker>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9jVo0hczGyclwPro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 11:15:57PM +0800, Jisheng Zhang wrote:
> On Tue, Sep 12, 2023 at 05:27:31PM +0100, Conor Dooley wrote:
> > On Tue, Sep 12, 2023 at 03:22:32PM +0800, Jisheng Zhang wrote:
> > > riscv select ARCH_DMA_DEFAULT_COHERENT by default, and th1520 isn't
> > > dma coherent, so set dma-noncoherent to reflect this fact.
> > >=20
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > Tested-by: Drew Fustini <dfustini@baylibre.com>
> > > ---
> > >=20
> > > Since v1:
> > >  - rebase on v6.6-rc1
> > >  - collect Tested-by tag
> >=20
> > Does this mean you're expecting me to take this?
>=20
> Hi Conor,
>=20
> I think I will take this and send PR to soc people. The reason
> I send v2 is the rebasing on new rc1 and v1 wasn't in linux-riscv
> mailist due to typo;

Great, thanks. Please ask SFR to add your tree to linux-next.

Cheers,
Conor.

--9jVo0hczGyclwPro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQHY0gAKCRB4tDGHoIJi
0gecAP0auetLpNJ7XpG2j+SH1o/AGeaMeSgE2Z7Ig27iynDf5wEA6Jjs8EUIxn97
J9fX6wqhmw1fgEb2f8gLCYktVPx9qAM=
=Zlau
-----END PGP SIGNATURE-----

--9jVo0hczGyclwPro--
