Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D8C7A5CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjISIsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjISIr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:47:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2750116
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:47:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880ACC433C8;
        Tue, 19 Sep 2023 08:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695113274;
        bh=luFy040TJwhqSwX6q8NyoQWoiTXkeP9Qqccg14Kb0rA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nAIFlH97A7V8Ycm5uK/xK6ieazUEpI6YXPLvhBAsVWWi/V3P5Cl/gf+bo2KM6XzpY
         FiD9pjJGvZgLyEPbAXtwZheJ1vghZLACfrHxcmSvosElzIq2o2lq5R9kKMbsS75SAn
         RYRQVm290QV8qTTKyOZlH4A3dSINv/5Ao7gSizbOLtSmJAzY/44cJRkOcUf0qbsDuH
         +Bu7I7wNfH2s7qGXk9e8jGslCoa0Lfge1lXBwzyrINlsDGeQvHZQEPShb6uScOGxGx
         m1GGzvEU1PkEktT16u02UirNKQUM6SKWCoS06MCHogJlny3+FRkAkhCpfcJ7T7j1hy
         fuRxCsIoi3WoA==
Date:   Tue, 19 Sep 2023 09:47:48 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Kwanghoon Son <k.son@samsung.com>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jszhang@kernel.org, guoren@kernel.org, wefu@redhat.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, inki.dae@samsung.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Document th1520 reset control
Message-ID: <20230919-42333064be342f6ab125dd75@fedora>
References: <20230918045125.4000083-1-k.son@samsung.com>
 <CGME20230918045134epcas1p1b80b338b66512a976c3783cd0e51da50@epcas1p1.samsung.com>
 <20230918045125.4000083-2-k.son@samsung.com>
 <20230918-4ef7f52da269f3a7e4023bb3@fedora>
 <005301d9eab7$5688c920$039a5b60$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1iibWnnp3IIIl0SS"
Content-Disposition: inline
In-Reply-To: <005301d9eab7$5688c920$039a5b60$@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1iibWnnp3IIIl0SS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Guo,

On Tue, Sep 19, 2023 at 02:08:32PM +0900, Kwanghoon Son wrote:
> > > > +      - const: thead,th1520-reset
> > > > +      - const: syscon
> > >
> > > iDumb question perhaps, but why is this a syscon?
> >=20
> > This is good point.
> > In fact, I took it from the vendor kernel, and I tried to keep it as sa=
me as I could.
> > Vendor also followed drivers/reset/reset-imx7.c
> > As Rob said, if don't need it, I'll change it.

> I have investigated vendor kernels, but it is still not sure reset inform=
ation.
> I thought this is about sys_reg, but without datasheet, can't tell.
> Therefore, should be stopped patch for a while until knows better comes o=
ut.

Is there documentation in English you can provide to these people that
are trying to add support for your product?

Thanks,
Conor.

--1iibWnnp3IIIl0SS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQlgMQAKCRB4tDGHoIJi
0vyLAP9HZrpuOPBneDIXfpdgbTVat7I4LUqO20r1ekUdthdEhwD/brQ5aP+rZx8t
p7nYOH/eyRcDKWMoDlVvvHjOP+5T/ww=
=/q0V
-----END PGP SIGNATURE-----

--1iibWnnp3IIIl0SS--
