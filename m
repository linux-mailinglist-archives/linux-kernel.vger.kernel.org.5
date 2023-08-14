Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E3D77C3AA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjHNWxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjHNWwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:52:54 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8AB10CE;
        Mon, 14 Aug 2023 15:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692053568;
        bh=JPWSToM21ysXC5alTTZWY3I1+cPeY2d1xGL5H7T8D1Q=;
        h=Date:From:To:Cc:Subject:From;
        b=hBj0rpBDj/n4gxLSoHQgzZ/BjEi62BE/h4m3W+qsgDVSq/5tmNM0mXmxiCtBjmSGt
         HpbNDUg07usTuLFmHySss548wSZsW0oUp1QdvqhSIAUzo04+URxs4Mrr4meJ+p6BLt
         2rWW0OVKO+OUWwImOapcle+lJDiSAIRUZ8CxizJJXuKZmOI5M3PBPwMCjZqknAaMDW
         X0R7TFrhRkepc81bP3N/RkrcPSGOcVF15WukCehSE7npRFQGICtYB6KT7yPWUpTSlM
         2Jw6Gvg5UhDoZNNqHORLFYfPszUjb/d/MT2IgIFnTvZUey/gkjj1qAsPhdoeZw7reO
         ZuZkUVgcMyQ7g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPqRh2XtHz4wb8;
        Tue, 15 Aug 2023 08:52:47 +1000 (AEST)
Date:   Tue, 15 Aug 2023 08:52:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Qu Wenruo <wqu@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the btrfs tree
Message-ID: <20230815085245.59c04585@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=2QGq58=0yd92=0knO9dSRY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=2QGq58=0yd92=0knO9dSRY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  d9e714b5ef0a ("btrfs: scrub: fix grouping of read IO")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/=2QGq58=0yd92=0knO9dSRY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTasD0ACgkQAVBC80lX
0GwEeQgAgEaNHjztSOv/t7LxWSnW+b89ndYfycbX+nOsyGyHfwJGdnH6FHqmrBo4
PBs4DkEpiWRsUSTQavQHlSzU5Cyu+tnK/AzCBOeVOfAcXUZ5f7fd2NsjsPmXl60S
46c4SQm4T0gbtews62B9LK7TL2D4fvDs/3h1i/lCD9E/uMJ1Ns7lBjhONquZ2Fqd
w1E56i4eobVpG0y0x/Yy2llYymhoAmlYqH/eH2rymkh9mK4BUZIl3z4ASawEaIp7
4M/bZ6k+CvCf1YUiYGGxFpW+7TBwEtuWjBTw3F5I+CiUpliP0xe4HGT2ENIiu/Dv
kZ406GDTtXqWdS+QFMVWFutfO8Enpw==
=47kj
-----END PGP SIGNATURE-----

--Sig_/=2QGq58=0yd92=0knO9dSRY--
