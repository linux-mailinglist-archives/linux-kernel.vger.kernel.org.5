Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7ED877CBCF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbjHOLeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbjHOLeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:34:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0237F10E3;
        Tue, 15 Aug 2023 04:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692099242;
        bh=DtBm+/hYOvO1oRvd8aaePYEzTCG/3G53rxPgWq7IeeY=;
        h=Date:From:To:Cc:Subject:From;
        b=fAaVDoBUq6YyCdFH95YqeaMXPyoAgabuOLtXXpsjcIziDA0SsA6sTzOAdecd5ObJ7
         kRitWz2DoTmvyXhrnpTFSgWcL3VGFQe7UkK4PPgfOy3DdwyJMu/eU0NsIgbLggDZ/A
         6R4ebod4kteWvJJWx7Of4QySLx6LpI+nrvuJLcVfnWqGAuI+pQxm25q8VWXQWjHM79
         iqqJNrvEDIXdHVe7wH6NXyBiw9uCbp4sLw7CJrSoJFX+DSdug+SdSm9h9//RClbltZ
         73Zd30yWQ7MuA+NgC+IYCT87rC0LPo4KFNUig77yEDsrZSfiKfhBRlfiXWBGiwB4lQ
         ZAhyxdv9WeI1A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQ8L20KFCz4wZs;
        Tue, 15 Aug 2023 21:34:01 +1000 (AEST)
Date:   Tue, 15 Aug 2023 21:34:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the driver-core tree
Message-ID: <20230815213400.49afbd8f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nr8TfKcG9Wb6p3uz8e=4/P9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nr8TfKcG9Wb6p3uz8e=4/P9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the hid tree as different commits
(but the same patches):

  32944855bac7 ("HID: hidraw: make hidraw_class structure const")
  afdf5dd33a91 ("HID: roccat: make all 'class' structures const")

These are commits

  21168bdba6ea ("HID: hidraw: make hidraw_class structure const")
  fadfcf360161 ("HID: roccat: make all 'class' structures const")

in the hid tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/nr8TfKcG9Wb6p3uz8e=4/P9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTbYqkACgkQAVBC80lX
0GwO+wgAlVxMUJFN/q8FYVnAAw45mrispbHv50TcEbq49MoOq4mUMmKv+DxYBl0k
RxFi4GiKyIS9d04QmpUit9UqbCd994gJo+ZQj4ebOMWz0vPVTrNa91gDyLc3LwAv
03NsB9rUE7PAcwDOm01Z6uQnbJKcYNrm8MvnS6dxd0ZXgxNcRjB5J7Etavmeu6o/
A1obpHEAQz7JgjrFZDWG720PmjkWuevX+KTfYlsBsBFbSLtOJpqXDg8OC9JaRxv9
LSZYu8cJa4cxbIUaNY15yjJFNKz+Qg2/Aj5yWEvEF9IPwcmpDgb+4CijpGYevjS7
/QhBcGv+7Vt0pYakWwsCMc8dEsiFQw==
=ojLt
-----END PGP SIGNATURE-----

--Sig_/nr8TfKcG9Wb6p3uz8e=4/P9--
