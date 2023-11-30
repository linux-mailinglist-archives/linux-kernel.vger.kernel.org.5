Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84B47FE7B4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 04:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344300AbjK3Dib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 22:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjK3Dia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 22:38:30 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3175F94;
        Wed, 29 Nov 2023 19:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701315515;
        bh=QRgPVbZjlAzjGyTmIbQamfq+82d76MA8RZ1agJbrz8A=;
        h=Date:From:To:Cc:Subject:From;
        b=DIvzgS8g0GYmSCtlDsZz/jr94jtzTOii2k+OM0Hga1jph9Wt2LAwOLKDrS43kzXzV
         8IIYUOE1rCHpCNs6NvO+us7eZgiK2h1J+rzL6qMduUxmMBhRXJjeiujt3+zf3cX8+3
         oTvoTWW1nODoLiD0BCZV/A6pAwrTRdJnrJesgNaYtu/jn7san7lodpDSos4Yid13V4
         oBycZwTNrmqLHRxC7uFaos/fb/1tZs4JsMr9xqLsmZjokXRZgEEyyEnPsdWVLcruPV
         gnfdPzTP+dEpsIh5IJX1TDYdRmzQBZmXkh+dhQLzlyeds7e638PNHhzDrr7tdbh58X
         Gvz3jDYdYktbg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sghk25sxJz4xVt;
        Thu, 30 Nov 2023 14:38:34 +1100 (AEDT)
Date:   Thu, 30 Nov 2023 14:38:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the bcachefs tree
Message-ID: <20231130143833.61702152@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0/Q6/4pkVYAR_crqXxmlrQ=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0/Q6/4pkVYAR_crqXxmlrQ=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  2b6b9629ab50 ("bcachefs: copygc should wakeup on shutdown if disabled")
  2d0d2722e283 ("bcachefs: rebalance should wakeup on shutdown if disabled")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/0/Q6/4pkVYAR_crqXxmlrQ=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVoA7kACgkQAVBC80lX
0Gy8oQgAotwnFdTVOHY+y1qlUeIjYBsF1hNqCfM9RigfK31XmmFf3dWJQVXuqOnH
BbwcXffYSobMA/9wD72L44wk1c9YdeQ1+qTBAbtDP3is6a8vUyOUjpRVHS7rTw9w
Zc8xGeBpNWMtYKNMHtqBqRd4lirh3xNDfnqbM5k6fv3i3gtrJTBgU3vusoyuLsZ2
kWav16FviUM5pAnZOH4aq3Q9+iw81SLAa7jReqNLEbwBpgc+j/P1j9IcdwAgIuBV
NR8VXF1ahZ6jybUMWEK5zrn/5JGFj4126Pzsk+L/7426QdP3NDaQYh6oqGTbtl1Q
pxwZ/Gsc8aKKTbX39/ImUpFlgS3OMA==
=AKlC
-----END PGP SIGNATURE-----

--Sig_/0/Q6/4pkVYAR_crqXxmlrQ=--
