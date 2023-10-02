Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BA47B53DE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbjJBNPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbjJBNPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:15:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF7FB0;
        Mon,  2 Oct 2023 06:15:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E39C433C9;
        Mon,  2 Oct 2023 13:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696252536;
        bh=B6iYHIElwIzFfW1kEOYhbnZcXC5/SesXlHfl5FN/qhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U19DuZT2axXDVYL44w3U/mnQqQeDTkk5uwSov3qWYRqWBeUuZ2PIEBUcxLrCGVPza
         OVMA+5MelERKbT59UYSqHXY7Axomv9vVYasRrUoFKbXtWxtdsObS1lT8Vv2xiXMh3c
         GD6l68zegUpbwTxzJaQgvPkcZJZVkNeSz+jvHQSMq2UhaOqWq8qlD3361hSkBd48TS
         uIAvMuXbqwsL4jkLaBllPkP33HTTmMBwRd5lJ2wl5vsNBJgITEiG7/s8iBZCB6pT02
         9IrstpOVn1W6SowOyCRaRNrgZwydRfX0qZhUGIAntotqul4if5GuLaSB66YLnU/J7X
         HQYTMc5GcTeMA==
Date:   Mon, 2 Oct 2023 14:15:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Heiko Carstens <hca@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Chiu <andy.chiu@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Wu XiangCheng <bobwxc@email.cn>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, workflows@vger.kernel.org
Subject: Re: [PATCH] docs: move riscv under arch
Message-ID: <20231002-panoramic-submersed-7f5bfd8d1e76@spud>
References: <20230928103134.2779459-1-costa.shul@redhat.com>
 <20230930-mauve-jargon-0f7760fd262d@spud>
 <87h6nbka8x.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i+dS31zP9Nq/Ihv5"
Content-Disposition: inline
In-Reply-To: <87h6nbka8x.fsf@meer.lwn.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i+dS31zP9Nq/Ihv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 30, 2023 at 08:26:38AM -0600, Jonathan Corbet wrote:
> Conor Dooley <conor@kernel.org> writes:
>=20
> > On Thu, Sep 28, 2023 at 01:29:42PM +0300, Costa Shulyupin wrote:
> >> and fix all in-tree references.
> >>=20
> >> Architecture-specific documentation is being moved into Documentation/=
arch/
> >> as a way of cleaning up the top-level documentation directory and maki=
ng
> >> the docs hierarchy more closely match the source hierarchy.
> >>=20
> >> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> >
> > This doesn't apply to riscv/for-next or next/master, with git
> > complaining about the sha1 being lacking or useless. What does this
> > actually apply to?
>=20
> docs-next, I would guess (though I haven't had a chance to try it).

I'm far from the world's best git-er, but doesn't the lacking or useless
report from git while trying to apply the patches mean that this patch
depended on commit that is not in next/master (which I assume includes
docs-next).

> If
> you would like to carry this through the riscv tree (which is probably
> the most sensible option), I suspect Costa could be talked into
> respinning it...?

I'm not the maintainer of the riscv tree, so not my call.
I was just going through the things that failed in our patchwork
automation and trying to figure out why :)

--i+dS31zP9Nq/Ihv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRrCcAAKCRB4tDGHoIJi
0gjTAQDVMgVoBfsUh5hwUwlsYqi1M3NgobI07TRun4p/0YUQjwD+O3zHXBw+jdKb
2nIxkjbyGVV4hPB7LuOvbrDj9IOsGgQ=
=+wV3
-----END PGP SIGNATURE-----

--i+dS31zP9Nq/Ihv5--
