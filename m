Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBC67A8DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjITUlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjITUlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:41:21 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC755CA;
        Wed, 20 Sep 2023 13:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695242471;
        bh=oDZTNwi3EKTaGi/ctu22k1ffl1AdMyNlQmP8lC+uJ6s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yk4MQp4nPr56vbVom9f0OSWQ/NAJlKz2QOQL1uyZG7QY11g0IOyW0UyduK6x2OVif
         TJdY6K7iliAznNZeixRkiWd0zZux1R5JKhNaj1QN+SnCz8uqYewjdCtrhPrUVfrx6N
         6OObG7Z5430h62zKCTwbZ5Qome1YsJQL6mKE6GCZB5oqIJWtO2nw+P+qecLi7Iz2+k
         sMPNLXyBweeWMWt9qBdai9jU4kCVmmR0Q3ftm0kX9TcWQY8vf7tBbhXG9JnASL7VtS
         rJE3Cb57aTHdqa2Z5tSKVFQf3NrnNdmmSW7oHYC4LyOfs19FlAHC1e17/uP2XxgXIV
         jVYGp1iQjZ0VA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RrVml5NRLz4xQ0;
        Thu, 21 Sep 2023 06:41:11 +1000 (AEST)
Date:   Thu, 21 Sep 2023 06:41:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the
 v4l-dvb-next tree
Message-ID: <20230921064111.33affd1a@canb.auug.org.au>
In-Reply-To: <20230914080429.31008f8c@canb.auug.org.au>
References: <20230914080429.31008f8c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Rs2I4L7MKYYiYhphCc.rhUM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Rs2I4L7MKYYiYhphCc.rhUM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

On Thu, 14 Sep 2023 08:04:29 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Commits
>=20
>   2c1bae27df78 ("media: qcom: camss: Fix pm_domain_on sequence in probe")
>=20
> are missing a Signed-off-by from their committers.

This is now in the v4l-dvb tree but is still missing its committer SOB :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/Rs2I4L7MKYYiYhphCc.rhUM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmULWOcACgkQAVBC80lX
0GyHRQf+Ic0sH0g+GzKJpGFvEG5ACk/VkbvfjSsPgU9D7oSraIF55o4c0MhyYj1h
YDF0f98p/XHzPn/cV1ue8Cibj1/jqgsptxEk0bHNWHA/QxEOh3rR6ASeGqCYAuI1
j7CUOHQWKc/ApUvxhsxQHsEbIsZGBAGnQbVsMe5KZpw4352r0kNmga4d+EJOTfxB
5MhnAL5KfIgoZOkmK8vOnQ3DGB+rcqkLUFLscy0872lzRifGpHghV/dJfXflGfti
HhYMbLLe0T6P0h8kQS1k1ANHvgHz25BctXwAwDPd6m4g4gsi7efeLd+yKJ2tIv1i
le0C8JvZnJcrPXVZBIFdBZ7xQTmSXg==
=zTtc
-----END PGP SIGNATURE-----

--Sig_/Rs2I4L7MKYYiYhphCc.rhUM--
