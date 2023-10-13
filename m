Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDF77C7CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 06:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjJMEhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 00:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJMEhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 00:37:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75B9B8;
        Thu, 12 Oct 2023 21:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697171852;
        bh=QZLGmzuhg4vl5V/4lq5u2AQp+rcENqy2UqWSoHPk3RY=;
        h=Date:From:To:Cc:Subject:From;
        b=WDaKXTNSNv/im9CEYDIc/7/07IjSrK72QvjANT/rj7jlTSInK9uJPgQxG0LPG1lYB
         BlDR9A0tff7YYH3ms+Xo9Tum0l8XA9PTeMch0GcdL77EsMzy/vn3LvbAjUstO7NCDR
         wBAYkS7RxTb5tchn3dp364jDQqaitOwgTJ2K5xVqXQHRSx5kpMPh9/r10aKpPX/bQN
         ZlqnNzVLCgQojP2gkSCJwFWCyxtMrElIRAgxFqgbYRBkP+cvZ+vCxNXxyUhKGgWfSe
         sVxpT6ubO/s8xl3kLoOFK2DbGXsuJGyT64/BGl8hnjG2rmilWv9YvgtiXIP4UDCOYO
         g0a8+Ns2trJ1Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S6DJC3tnPz4xYP;
        Fri, 13 Oct 2023 15:37:31 +1100 (AEDT)
Date:   Fri, 13 Oct 2023 15:37:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the rcu tree
Message-ID: <20231013153730.2adf28b9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Nv6YQHiph7f742BW6.YDjjx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Nv6YQHiph7f742BW6.YDjjx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the tip tree as a different commit
(but the same patch):

  8bf4aa582b16 ("x86/nmi: Fix out-of-order nesting checks")

This is commit

  f44075ecafb7 ("x86/nmi: Fix out-of-order NMI nesting checks & false posit=
ive warning")

in the tip tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Nv6YQHiph7f742BW6.YDjjx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUoyYoACgkQAVBC80lX
0GzkTgf+PspjuRRS8NB/QQRaZCY6rBo+4T2N0Ny9nOkP+YQKMUoRO9mYZDefcfoG
FCgApHBtoYRzu2BmiGu2n9+kzdiF2TdAhfxHSlLYfmW+8UsZTdqS7PchijX/X9He
dEBDePVAWQ0or+UJRaW7c8naoBMJi9n7w3lGa96Ro2q6XPDCDi7pLk/EcJmALhhE
ElySX12dCuAyOLxwFSsX2V165zmae/o7ZBI1uo3DKCpj7zzzrTemDtP9F16dIio4
vYs0TTE0t0o75DwSGtlhkC0jASkqZvVilS9Su7shtJpCVMPrjhcPKn/gA15dBbyW
9CDu3UW9eN04jwDJpTkNrtnB9UIZhw==
=XK74
-----END PGP SIGNATURE-----

--Sig_/Nv6YQHiph7f742BW6.YDjjx--
