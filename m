Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893DF7A9912
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjIUSKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjIUSKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:10:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045F185D17
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484CEC4DE17;
        Thu, 21 Sep 2023 12:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695297986;
        bh=ZKBejLxpxLiP18j3xN/sgh8MY7/Ts1j/7fzM5Nb1mY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pY3IDSRXGoG3UnWuDSwjo5IIoIuQv3Dp8HhxtdSqoNg06dpPB6csEpUbUaTr4W5Xn
         iUHEvjjr35PPoC4yqvuWT1HzE7GBE0v70iDXacaXv0mO5fJPw6eNNSsanqKuoCTQuR
         9cN18zojqgdLlsFFejBcMGSEdjM7+vfmzPkQ3pIskBVlIS8K+/PoIRpSAYA/d92Wvs
         u2ITLuagYQWGH93mfQ118NaARWZRfPRbxxaPvUdJaQB6l392Az9TUNpG6RDeGiyF54
         MOJc+igrStR2WnEyB9BnAHsSw9oicyCcXIVGl+oJlrItLAmpMQ+W2XKvUpiD1aqFu1
         TAsZe7IIZbguw==
Date:   Thu, 21 Sep 2023 13:06:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Chen Wang <unicornxw@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, devicetree@vger.kernel.org,
        emil.renner.berthing@canonical.com, guoren@kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>,
        Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [PATCH v2 09/11] riscv: dts: add initial SOPHGO SG2042 SoC
 device tree
Message-ID: <20230921-fdc47972b1d3caa685f2a164@fedora>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
 <ffe6a61a8879232aea7b86ff8aee5d681c6bd287.1695189879.git.wangchen20@iscas.ac.cn>
 <20230920-financial-declared-7b4b4baae517@wendy>
 <CAHAQgRBmUtyz-U+1Fu9qdvyhMuSzg+o4MMbTV9duUXsoSoPqUQ@mail.gmail.com>
 <20230921-d2db829b289c937081dc8a72@fedora>
 <CAHAQgRDLmKJQ1sp76q4s7P4E_=nYuw199ceGCR0LYeq3331tLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3kYZRnlz9oHCd92h"
Content-Disposition: inline
In-Reply-To: <CAHAQgRDLmKJQ1sp76q4s7P4E_=nYuw199ceGCR0LYeq3331tLQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3kYZRnlz9oHCd92h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 06:27:09PM +0800, Chen Wang wrote:
> Conor Dooley <conor@kernel.org> =E4=BA=8E2023=E5=B9=B49=E6=9C=8821=E6=97=
=A5=E5=91=A8=E5=9B=9B 18:15=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Sep 21, 2023 at 05:56:28PM +0800, Chen Wang wrote:

> > > > > +
> > > > > +/ {
> > > > > +     compatible =3D "sophgo,sg2042";
> > > > > +     #address-cells =3D <2>;
> > > > > +     #size-cells =3D <2>;
> > > > > +     dma-noncoherent;
> > > > > +
> > > > > +     aliases {
> > > > > +             serial0 =3D &uart0;
> > > > > +     };
> > > > > +
> > > > > +     /* the mem node will be updated by ZSBL. */
> > > >
> > > > huh? So these are random numbers below? Either put something useful=
 here
> > > > or delete it please.
> > >
> > > The memory for SG2042 is not fixed, the bootloader will detect memory
> > > installed on board during booting and fill the actual address and size
> > > in the memory node. The comment " /* the mem node will be updated by
> > > ZSBL. */" is telling this.
> >
> > Yes, I read the comment!
> >
> > > We write memory nodes like this to make them act just as placeholders
> > > and the value is by default written as zero.
> >
> > Why knowingly add something that is wrong, rather than omitting them
> > entirely?
>=20
> We learn this from arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts,
> it writes DTS as following:
>=20
> ```
>         memory@0 {
>                 device_type =3D "memory";
>                 /* rewrite this at bootloader */
>                 reg =3D <0x0 0x0 0x0 0x0>;
>         };
> ```
> So you mean we can totally remove the memory nodes in DTS and make
> bootloader add it by itself? That sounds a good idea, I will have a
> try. I used to think memory nodes are must-have in DTS.

AFAIR, the ones for the d1 based systems (like the nezha I have) don't
have a memory node at all.

--3kYZRnlz9oHCd92h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQwxuAAKCRB4tDGHoIJi
0vvKAQCrC0C9bXbaFXJHj7tbnfJboS8Mfb3B4Jj75CM/Q4JbpgD+L0gLJUvWQidi
1Jm9pI5/wQNC7eDOP6U2fe3VvEgK5Ao=
=QS3Z
-----END PGP SIGNATURE-----

--3kYZRnlz9oHCd92h--
