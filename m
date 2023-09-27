Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8333B7AF9D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjI0FPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0FOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:14:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8601022884;
        Tue, 26 Sep 2023 20:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695786566;
        bh=p/jWd8jSfb8q3fKVDZ/RL8Z4HDCmtxf/r2YVXBG8hEg=;
        h=Date:From:To:Cc:Subject:From;
        b=g/vUR2558LsxsmsAduyOFPfwJjylsy508ld8XCptslSYFB+4TWcdpn5Vyx9z99y24
         cTsD2DREpmupv7Ja59BdyJTrrx/EfB2jbNKByFoh1F8nl7UUifEK5qKwRoQYJgNKwK
         95mRPvijK+aJio5SDmlwq9D9AfUNIv1jnRwSmDOLih4JnAjTrnPCkgKQ0oiCS5n90t
         XstKqIbXvyUDcKA5UEdrYkHyQ0cn+eyCg+ZQ63WDY56zgTH8RXq/Bu14msNjGpqbDW
         i0Qq/PXA/cSxC+0NyBW+sCu+so1cQxF89fj4LRRTFSjKV4JXxqaCXonujdy2qbpZm+
         YPwayN//N/frA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RwN0537vyz4xGR;
        Wed, 27 Sep 2023 13:49:25 +1000 (AEST)
Date:   Wed, 27 Sep 2023 13:49:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mmc tree
Message-ID: <20230927134924.20dd7fb9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d8hLCsoFY+VhsMUmDIiEJOQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d8hLCsoFY+VhsMUmDIiEJOQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the arm-soc-fixes tree as a different
commit (but the same patch):

  298df10391f4 ("MAINTAINERS: aspeed: Update Andrew's email address")

This is commit

  9c888dbf2164 ("MAINTAINERS: aspeed: Update Andrew's email address")

in the arm-soc-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/d8hLCsoFY+VhsMUmDIiEJOQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUTpkQACgkQAVBC80lX
0GwtlQgAkAdhfppvK0LdZpJG2Z6dX9laz09O/1/eG9UEMdJyXNUC86KCgY/4Ngs/
RrWktj3EIUM0v7K7F2qLV2EJbHfNVxbM9i5VE78HttHKPdkHFPca+MuLrPn7QxJM
vegtgrrCX066ZL4EgnMP7KBJKNuo+fSYEu4Z9wniIqrIujISOKG+voDahnMMVVxW
XfQZ4fb3/mvuNjKESe2tZa/KWKImh9/9rc/UGVc8xGrUJkdp+ZKFphx2FqSmH6HM
ghQ/LWjcR9YQoEYxUAXjh1LrXE890H11JpOargsJcn22xke7QbLlTQg5GFxQUIKZ
k4OoVIt+xBgECb5amA7CANFIrjs47A==
=nmXx
-----END PGP SIGNATURE-----

--Sig_/d8hLCsoFY+VhsMUmDIiEJOQ--
