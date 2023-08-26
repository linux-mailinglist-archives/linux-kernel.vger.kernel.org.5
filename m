Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DD5789607
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 12:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjHZKjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 06:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjHZKjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 06:39:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2FA1FEC;
        Sat, 26 Aug 2023 03:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E376606DC;
        Sat, 26 Aug 2023 10:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C34BC433C8;
        Sat, 26 Aug 2023 10:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693046341;
        bh=RitoIFSZhjW5UlBYkipkGZOhMn5wsY+KxH7kfSkDkH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CVlRu76SpcLwJW2Xx3+H65Q6/71FC6ThyRmb25EmtkpLFcMmTmPx1Aq+dhyCx2g72
         EfNbA5QawXnZYviGDB9fh21pmHIn0WcXJ7lOhlXsjJnMNm0WfKBKT0NdXqLQmNtrHm
         FuqyH4giU4NrkRZ/jAwWQ8/dQOivnAix4lv+nWaC2bGDuKWZ089GFy/KHCYFIDolXF
         dbsmu4JpD5fby9bazqObbsFrTgZMUwQ8vbtnmHBedkh24tVPHpLjRGsyk0FcUSffrQ
         kniY8tHOkNlZDrKq1i2eG+6WAWacqNOVBoX0LcW9Pmr+P3AnZooUOcmE4M6KuvHQcb
         eGBi8DQjln03g==
Date:   Sat, 26 Aug 2023 11:38:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.10 000/135] 5.10.192-rc1 review
Message-ID: <20230826-huddle-designed-952a01db6e88@spud>
References: <20230824170617.074557800@linuxfoundation.org>
 <fb1c3952-1d72-4f9d-bc93-2988bcde462e@roeck-us.net>
 <2023082636-postnasal-cobalt-5ab5@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rghNHbswWVpEDuGH"
Content-Disposition: inline
In-Reply-To: <2023082636-postnasal-cobalt-5ab5@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rghNHbswWVpEDuGH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 26, 2023 at 12:08:20PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Aug 25, 2023 at 07:24:29AM -0700, Guenter Roeck wrote:
> > On Thu, Aug 24, 2023 at 07:07:52PM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.10.192 release.
> > > There are 135 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >=20
> > > Responses should be made by Sat, 26 Aug 2023 17:05:50 +0000.
> > > Anything received after that time might be too late.
> > >=20
> >=20
> > Testing is not complete, but early feedback: All riscv32 boot tests
> > crash badly with errors such as
> >=20
> > Starting syslogd: OK
> > Starting klogd: OK
> > /etc/init.d/S02sysctl: line 68: syntax error: EOF in backquote substitu=
tion
> > /etc/init.d/S20seedrng: line 33: syntax error: unexpected end of file (=
expecting ";;")
> > Starting network: /bin/sh: syntax error: unterminated quoted string
> > sed: unmatched '/'
> > /bin/sh: syntax error: unterminated quoted string
> > FAIL
> > /etc/init.d/S55runtest: line 48: syntax error: EOF in backquote substit=
ution
> >=20
> > This is no longer seen after reverting the following patches.
> >=20
> > 92609bb3a1f8 riscv: uaccess: Return the number of bytes effectively not=
 copied
> > e06648704417 riscv: lib: uaccess: fix CSR_STATUS SR_SUM bit
> > 20704d763646 riscv: lib: uaccess: fold fixups into body
> > 4f503bad920e riscv: __asm_copy_to-from_user: Optimize unaligned memory =
access and pipeline stall
>=20
> Thanks for the review, I'll go drop all of the riscv patches here.
> Really, we shouldn't be adding any of them to any kernels older than
> 5.15 these days as I do not think anyone using that cpu is using those
> older kernels (or at least I sure hope not...)

I know one of the main cpu IP vendors does run a 5.10 based tree, but
that thing is both an abomination of out-of-tree patches to core arch
code & about 100 releases out of date, therefore not really worth
factoring. Anyone in their right mind should be running something
significantly more recent than 5.10 for riscv.

--rghNHbswWVpEDuGH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOnWQAAKCRB4tDGHoIJi
0kUfAP4xb16YY0T200gX/E1eNIUB6qJFsOkRpKFiBXmHgVR2SQEA21dQYFqO1WY5
d6spP/yOL5Q39bkLnWSMl0Tafpw3dws=
=/L3h
-----END PGP SIGNATURE-----

--rghNHbswWVpEDuGH--
