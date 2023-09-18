Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428917A54ED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 23:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjIRVUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 17:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjIRVUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:20:05 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C9710D;
        Mon, 18 Sep 2023 14:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695071994;
        bh=Rm/0o9a0tGeUe0ahn3Vijua6du2SXzDCcrETGxHaasI=;
        h=Date:From:To:Cc:Subject:From;
        b=nFCGlZ3a5SOA0/29QqGDXONLHmG7aUJ50WrbCdRY8uA//BGHHMywf3dLfh6+o7GGJ
         JQfmUR0VXHex5w0A3WoIJiJvBHiuFbdn3y6OlD0tO0URWLZnAaKas84yvzoJ7cmkfX
         sRljxxoU9YZx41KskuWwS7fwFF1BOpOCHzfvOC+zAcgAqU2NehaB5zn0h5Cvgudetm
         lHJ+K7UEysWl7codlpidVfEDLHdLcq7s9Nr2gK1uhrOXS5iDerNV5Yth3CLpmsJAuv
         qvDWN6a4bfcgGvuB0gnS0M1MUZ3qd5P6DTZEoLk1m5cxBBAXEbEX2+hapofLjaj0RX
         2wgZdtiSq/jpA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RqHkL1smHz4x3G;
        Tue, 19 Sep 2023 07:19:54 +1000 (AEST)
Date:   Tue, 19 Sep 2023 07:19:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: added the kvm-ppc tree
Message-ID: <20230919071942.396c7513@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wCTZZGLgSXst=79RQ7gL4.k";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wCTZZGLgSXst=79RQ7gL4.k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

I have added the kvm-ppc tree today from

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
	branch topic/ppc-kvm

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/wCTZZGLgSXst=79RQ7gL4.k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUIvu4ACgkQAVBC80lX
0GxJoAf9Hz/mEtw7TWG7FPW/vv/9Sae4b+J+RFyas0Q3Vp+zyLsQgO+DMP8zsAId
Z05RVhiqT2wE7rBvVXFllZh/9j/K9dckYsV692WuIcqRjdV6YUhRVXkW9UX7a8ZW
NyOxd1vopmiku+Je5oY9KFOtSUczxif4gjcTffJBiYaX6dUrUMEgkJzyNgxbMyGI
sgdiuEcwN5IxpOdYhgBIyekYbjc2/o1AMMvPfJ5mvPJxyk7j6VBRCgZ0yEmifg0Q
/7fLBCpveZkI4I1elw36ix9gPz4O+q3fEK9cDrxWKCaeoRa7UtJy+VXnv4syMYsW
b5pJsPbLD7w5lXnjynqlBHyaz99+hw==
=iESh
-----END PGP SIGNATURE-----

--Sig_/wCTZZGLgSXst=79RQ7gL4.k--
