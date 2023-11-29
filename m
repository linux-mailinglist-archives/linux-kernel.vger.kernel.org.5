Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072307FCC4E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 02:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376707AbjK2BYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 20:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2BYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 20:24:06 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E5EF5;
        Tue, 28 Nov 2023 17:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701221048;
        bh=QFeXnaUEntX6sP5PG4BuqjYMFylnyscfrlT0xNz8UpM=;
        h=Date:From:To:Cc:Subject:From;
        b=oCG4vxwqncgmdGMjTZONLfbuI5aFzjaMonWMZjwsp3EOZ0VYpdbkl7D/7HDH7V+6W
         JUU8ERnXEAJYUfgMqsnCIwiHXhmzhfox/OXxZxb5+Js5URZJ2QfdUG62sJdKFtyoGF
         0YwJooY+jdZk4DfoRqQaGOBLhTLPK8S64jfqYPHEOhJXMvkF/EuVZbV2IllXfXy++W
         CEjxLbd++OmZkCalBMe9c3uyABTDK+GHtYRZWPb3XAo1xHlXucyFJn9sB2jMwKi6ad
         SjxnrVQYHe+92VvDkN09Hd1HMRBXqFS3xUDyuwSR8qZtmZp99vN9e6BmNXkY7PR4Gz
         Fu8/f19T8qyEA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sg1nM1lbQz4wcX;
        Wed, 29 Nov 2023 12:24:06 +1100 (AEDT)
Date:   Wed, 29 Nov 2023 12:24:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the char-misc tree
Message-ID: <20231129122405.27a5e54a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KaQD./.8r_dPiczMNRr44Tg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KaQD./.8r_dPiczMNRr44Tg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the powerpc tree as different commits
(but the same patches):

  bc1183a63057 ("misc: ocxl: main: Remove unnecessary =E2=80=980=E2=80=99 v=
alues from rc")
  29eb0dc7bd1e ("misc: ocxl: link: Remove unnecessary (void*) conversions")
  0e425d703c30 ("misc: ocxl: afu_irq: Remove unnecessary (void*) conversion=
s")
  62df29a542f9 ("misc: ocxl: context: Remove unnecessary (void*) conversion=
s")

These are commits

  29685ea5754f ("misc: ocxl: main: Remove unnecessary =E2=80=980=E2=80=99 v=
alues from rc")
  220f3ced8e42 ("misc: ocxl: link: Remove unnecessary (void*) conversions")
  84ba5d3675e2 ("misc: ocxl: afu_irq: Remove unnecessary (void*) conversion=
s")
  82d30723d58f ("misc: ocxl: context: Remove unnecessary (void*) conversion=
s")

in the powerpc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/KaQD./.8r_dPiczMNRr44Tg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVmkrUACgkQAVBC80lX
0Gy7rAf+L57K1PG/ZKUrhjtQoptSZBtEuopxNd5wmdeSNpwwjHpzGZaN3+dFezNX
o+ow6HdZ+5LDWM05IKRObZoEsqksqasPTRHuN9rx/+S+tTfICiyulZ/zOIwYjYlr
YR7pJelrlWtQcsq5vuPNbayFWKL4NC+WrtT2o/mHdHB8+A5zyqngcgrZIgMWzJaW
F5OVfP8vwpajmm7q7qdAp8DYYulNvgK9jyhkLGNUqyX18dlANkh1wRkEcYIuO48w
EU7KZDGkJnvhLc3VTSRu6/iX7owSIfmR5irkR6M6gzqtj32eIuCOgQODd0tAlif3
uQDUs7mksdZnkpRnir+de1yeZztGIA==
=awk6
-----END PGP SIGNATURE-----

--Sig_/KaQD./.8r_dPiczMNRr44Tg--
