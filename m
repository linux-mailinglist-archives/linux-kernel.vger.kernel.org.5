Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3008A7CB4F9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjJPU7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPU7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:59:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F9DA7;
        Mon, 16 Oct 2023 13:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697489948;
        bh=EUUfQmbPuoJ6VpjZzB45ptApbzJjAxXVBjL4y2UG2sw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nI3SetMCOfOQGtg0b0JhtAdTokxCMXuW69W6WSrjYbF4ODEOMNxfTVTYy0HnXEPAz
         KFC4khFlUNFELdSRqEUa0SX2Q/A5HOpDExC3izFzO4U+U9qESDQ6R+xeV7PGYlN6Yr
         SELUckCnLpFeCar7/gDR+9c4kty+A+3hVBClLJDnRLeJO7S6lsXvCvU94DYU/tk0DJ
         wp+NEUN+iN7WExtX72lTcbCDWcd8cjhO0tD7R0mMPJkNS3O7kxTm58zTxJulGFmeBr
         /CPDOuDLfI5mk8a3zq+ZbFM0tGp9m4qH93btjTQLQS75mbIznbEu8q2ZWIn/rD5y+Y
         jqctUeaKaa5Og==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S8TxS20PYz4wcM;
        Tue, 17 Oct 2023 07:59:08 +1100 (AEDT)
Date:   Tue, 17 Oct 2023 07:59:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Lei, Jun" <jun.lei@amd.com>,
        "Dhere, Chaitanya" <Chaitanya.Dhere@amd.com>,
        "Zhuo, Qingqing" <qingqing.zhuo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Roman Li <roman.li@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20231017075906.3906b823@canb.auug.org.au>
In-Reply-To: <111ce50e-f445-4018-8d10-c1f7908b3198@amd.com>
References: <20231010124357.5251e100@canb.auug.org.au>
        <cc75c480-5359-465e-adab-46b418ec5d97@amd.com>
        <20231016113946.698ac2da@canb.auug.org.au>
        <111ce50e-f445-4018-8d10-c1f7908b3198@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/c..NT1IpAS8APIXEeh_d=qJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/c..NT1IpAS8APIXEeh_d=qJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rodrigo,

On Mon, 16 Oct 2023 08:53:05 -0600 Rodrigo Siqueira Jordao <Rodrigo.Siqueir=
a@amd.com> wrote:
>
> Could you try this patchset?
>=20
> https://lore.kernel.org/amd-gfx/20231016142031.241912-1-Rodrigo.Siqueira@=
amd.com/T/#t

I will apply that to the merge of the amdgpu tree today.

--=20
Cheers,
Stephen Rothwell

--Sig_/c..NT1IpAS8APIXEeh_d=qJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUtpBoACgkQAVBC80lX
0Gz3qgf5AcXHlqzMLrzLoo5rrfH5XcRzNam5MAZQf3xUUhDUuHMZlYbMAqAPFXI2
rKTU2mXURXUFIt2cJ0JU0f6cFBUQDVhywhB659XnLLxgMcwfxGGfSk9IPQvfHDuM
m+iKna7TP8xfTbXNFQsiyQx4/9Ilc1U7z14O/noSulQlyzyYXQFOtopApEaKoD7S
bnP1uVKPtYv2amPcvllFHSoLpro8M02efxTh9T+f2+fz4ItLo5ARzu3Bckhq5+ww
Re7PfhBj9WTqHJsQVmw0NB9G2fPUnXFm8+O2H0CPFhWuNPsgfX2E4xd+KueyP14G
Jea1ymXtx8XPEQJ+JUoSPlIVmVJ4Hw==
=FCiR
-----END PGP SIGNATURE-----

--Sig_/c..NT1IpAS8APIXEeh_d=qJ--
