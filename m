Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F242979A414
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjIKHDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjIKHDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:03:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B9210C;
        Mon, 11 Sep 2023 00:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694415809;
        bh=w8pPTQz388WZlp9XxM87c9+hTI+P9MO1kzNMPlzTktE=;
        h=Date:From:To:Cc:Subject:From;
        b=YgL5vr+lZePGURMFzEKkXyE8uLXtvvHAbmGOIJvUbSvU81Ac5c53gnwPpcu8TK2UD
         oFSAsogwwLUq/FV7pFQVVo0KA4aHOZq9P+g6W+cmRTD9Bq3zQU4rUtdJeZ2XCmzyAU
         wjofQqwN67R8Drago76P8CxxOVyw96bvdrJk0cXaT6CXhRBCfn6Z8ei4YnvdhBLwpZ
         jLcvY4uEy0P2mWFbfD06/sEcOcQzeGtrS5aE+d7JvBJUf9eojL06B/RNxSHqfn4wjL
         v5ujb+waw6LthOfT/2ZbuokISdD0RK51BMU6KByvFHA30t7op2HN+EmsN0XK6TMrrm
         02joJbMc7yDiw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rkd3P18Jwz4xF6;
        Mon, 11 Sep 2023 17:03:28 +1000 (AEST)
Date:   Mon, 11 Sep 2023 17:03:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the bcachefs tree
Message-ID: <20230911170326.6c6bc1f8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TDagygaubFpUmFlu/iNNn03";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TDagygaubFpUmFlu/iNNn03
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Thanks for fixing these all up, just one left, but it is just missing
a '-' in Signed-off-by, so probably not worth fixing unless you are
otherwise touching it.

Commit

  bbcb7805227d ("bcachefs: fix a possible bcachefs checksum mapping error o=
pt-checksum enum to type-checksum enum")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/TDagygaubFpUmFlu/iNNn03
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT+u78ACgkQAVBC80lX
0GwmSgf+KIQK7e3uXmzmSXCet/ppOn99DFPW1pO4h+uP7izOoGHDgMy+XycUnKhq
lCscmK0MffEJu0NOpfagA5iiJqZ6oL8RdxXmprFc2w5qFLqMG84Jfbe7RCG8yx3h
Ga/UDkh0tSXewIg7gDmTaHwpZlGKG7CfNuWxT6yomNXKRid7orve3tpYopiZ2GG3
62vzJHluu/HgXtGW7kehBz/C43qKkeaHcId2HICBO628QswjyC/Xid6AbxYS38QO
DHw1s/S5gCTY3fw8sPJP8ghCMW60pU4mWko10iM+Wcl2wXafSA1PKEOass06QE6B
2uiMLdr+NoD0AE6NmHOjftRe/5OwUQ==
=kN2l
-----END PGP SIGNATURE-----

--Sig_/TDagygaubFpUmFlu/iNNn03--
