Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B1B7CEA29
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjJRVnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjJRVnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:43:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECC0EA;
        Wed, 18 Oct 2023 14:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697665390;
        bh=q6vi5KJHQ6JEcdJXzArswH6XqumV3niz843YNou3/7w=;
        h=Date:From:To:Cc:Subject:From;
        b=GR0h+F+0Ggr8Hwdzv5Okq35FgurkX0YZT8hxMYI43+mFw/7lsyQJHk/K7v3+sOxj3
         W/UnSTfRu8aJGksAgbnxdsLuz4UCjIQA5FVX/I12Wsv5rmN2CUVIpr7H2XNDhhOi3R
         6YJRJ6n3adYT5cz15SLbCbvPhCWipHib3ww94gx+JCdLNtUmNqpi8R1xXHK30V/4st
         6hGlV4vMCQlflSJ/aEahvCOdm6TSPkqcHg3Q4nzWOXmGNOdTi451mV1ab1BhbR0jle
         OvcB4/zd4Qpp63P0OW/cz97t49T2RO2hEddKNgcHFqXOooSrT8ldXx+7iZSowxWmle
         Kr+xbiyN53gmQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9kqL3CQXz4x1x;
        Thu, 19 Oct 2023 08:43:10 +1100 (AEDT)
Date:   Thu, 19 Oct 2023 08:43:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the vhost tree
Message-ID: <20231019084309.3bda85c4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TB9OWHe6sSjKXM34uRe22Qz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TB9OWHe6sSjKXM34uRe22Qz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  34ad6689c509 ("vdpa/mlx5: Expose descriptor group mkey hw capability")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/TB9OWHe6sSjKXM34uRe22Qz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUwUW0ACgkQAVBC80lX
0GxYQAgAnsbPGWpMYrXFnaidDDYbpvEpOxA9I9f3GKpIeDb0+YPX1uOMdYSENwhm
y5slbz7vciQPZCn6QYMURa5WbLh9m0eownmkpxzExU0ECX6jBv82bkGeMauA3acg
0B/NKHrHbCRA6+e4nz3yK8Zpsqo/1lBgp88zV6dDCq2wiYuYfRNgaTEw61sE0/5h
nqTgiCHBKIiLiHqTZgdpw1y5Zi95FTPKt10QknaeAtFdm3W/sdg3Z8nT2MNE3pOa
k6yI2ex/THL8dnnpVfU2MSr85Vm9cB5kXG0s1v6a2Pcu2vYRaGT9j1XSLwcm6IF0
384/cruiGIxBeX2TI9oVoS996v/+4Q==
=KVlI
-----END PGP SIGNATURE-----

--Sig_/TB9OWHe6sSjKXM34uRe22Qz--
