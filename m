Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40421781E73
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 17:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjHTPKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 11:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjHTPKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 11:10:09 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A483A80
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 08:06:47 -0700 (PDT)
Received: from spock.localnet (unknown [94.142.239.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 4B59014B8CA0;
        Sun, 20 Aug 2023 17:06:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1692544004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JdxGo36Lh1p31hCmZS5SPtvfYf2e8rDFIdsQuqmDjKY=;
        b=gPSD0mQStIBkmJXQSqJWfNkA2Xj79E5RdVl1nnE8ccG4eRHdvUlJe8EmamIxzz7ScHihKX
        j+X2Uzcr0JTlElhwTSCEsuogyQ/YmgGCHoQV9K3aO7N3mBY4WU2s40G4SqyGOIEejec4IH
        bzrG/lZwmCYRukZcMvBHuntgvjHBotI=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 6.5-rc7
Date:   Sun, 20 Aug 2023 17:06:32 +0200
Message-ID: <2695589.mvXUDI8C0e@natalenko.name>
In-Reply-To: <CAHk-=whD0w46GUTwp_tyzjZRg8Nk-U2e3ucM7EntKPfn+iOSAw@mail.gmail.com>
References: <CAHk-=whD0w46GUTwp_tyzjZRg8Nk-U2e3ucM7EntKPfn+iOSAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12269552.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12269552.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: Linux 6.5-rc7
Date: Sun, 20 Aug 2023 17:06:32 +0200
Message-ID: <2695589.mvXUDI8C0e@natalenko.name>
MIME-Version: 1.0

Hello.

On ned=C4=9Ble 20. srpna 2023 15:09:38 CEST Linus Torvalds wrote:
> So it's Sunday afternoon, just not in the usual timezone where I do
> these releases, since I've been traveling.
>=20
> But apart from the timezone difference, everything looks entirely
> normal. Drivers (GPU, networking and sound dominate - the usual
> suspects, in other words) and architecture fixes. The latter are
> mostly arm devicetree fixlets, but also some x86 cleanups and fallout
> from the embargo last week.
>=20
> Not a huge amount of patches, and I really get the feeling that a lot
> of maintainers are on vacation. But I will be optimistic and also
> blame it all being quiet on things working fairly well.
>=20
> So I think this will be the last rc unless something nasty comes up.
> Do keep testing,
>=20
>              Linus
>=20
> =E2=80=A6

v6.5-rc7 tag is missing in the git repo.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart12269552.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmTiK/gACgkQil/iNcg8
M0s3dRAA2A6xQD/9ptVn9Jg+brnGb+omQ/gKKj15/3g4Xl1yr7+sGjZjiDyllcos
2iF6P1lSknQeRqbZOkKDc/WeKGXDClk/P4LIpv6m3mAqqQLz12FgS6oWK2nUfaK+
8IvD1gsvQHxOErHgf3YJkmoe2AHJKo2t2GZYlpMI+pbOrbGLaeZvj3DIRAq3IOio
ECdwUs3BCWN1ADtnDgLe8i9VPaH3Ntpao4Rgct8zZ0neF/G5acKdP2EVFGq+RHvD
4E/8sFZWnErtLLgtdoczsRYvfM/Tp5n2t/hk2pwNIaxx0ObqPYAPq0bntMsqc5CB
YrVqwoI788lE4ENy00wOkt4wDiHCAQQ8FuXvoepKRiikmQ1BdtMIzQQl8CU0lvxp
n8NP8Dgw2c+7P730XABsZx2jsT4ffKFDPOHKMpWLpQL/y4iXizgy4wGl/YI9R/cH
ob23Sex6rJDoz/oGYcNK9fMjRsYgI7xRAT2qUbeMRc7+NGs9wYFBkBcft9E4bTR7
z5yy56FzkBXsy3EewlmuoSsz8zSh16tnjcpfn2/9clmgKzjSHW6PTiJKpDH1lJJg
CIDl0pgRv7XuvLJDBRn+PkH076kptLg1rJgkO7w+HVMUzDxXj38fJC3r3J6dTmIy
tvn0e9bcVR+Y+vawrqbblDtPfn2DNdQsGLhiISXlKWNMZ6AgaAg=
=vvtb
-----END PGP SIGNATURE-----

--nextPart12269552.O9o76ZdvQC--



