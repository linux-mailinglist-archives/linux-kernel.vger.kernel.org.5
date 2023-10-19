Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ADA7D037D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346561AbjJSVGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjJSVGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:06:23 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A300DC2;
        Thu, 19 Oct 2023 14:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697749576;
        bh=xdo63SOzzVchMGQgIKwnulHQABOQaumrm7jZgY2UPf4=;
        h=Date:From:To:Cc:Subject:From;
        b=QgOb9Je5hBuFKffqo/q/mqupySIWWd/JG7QQcAeNYh4wTFwCezD/Hp3Iv5yTP8CM5
         hi0KhNdlGOFr7LbZ6/+wLEVAEcn5i6VQTGnJtGR3iyltcXSqDVfNPSCCCcAmCdCoNs
         btuZRmuvQMpYVE1lZeOzZMsGswXM8NavZ4JS2/nhbuZ1+I5rep10FYjh5E9fuOfUdz
         kTRYMboGdkxMEHMwbgbQfa48I40q4+KpuntWQACcR8Flpndv0/gEm9fHt/kNm9Zhix
         liLy5Lo3eUWA3oxlA8PPH9IdmVJdHJuR95SK4Fwz7ftb7WqFRrdTTyYz1vFAu9jpdj
         jBSrRnsfV/4pA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SBKyH6hqpz4xc1;
        Fri, 20 Oct 2023 08:06:15 +1100 (AEDT)
Date:   Fri, 20 Oct 2023 08:06:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mips tree
Message-ID: <20231020080613.0e257e5a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5CE+p+v4adeZT5ZKC7OuFDm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5CE+p+v4adeZT5ZKC7OuFDm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  83767a67e7b6 ("MIPS: KVM: Fix a build warning about variable set but not =
used")

This is commit

  e2145c99b53e ("KVM: MIPS: fix -Wunused-but-set-variable warning")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/5CE+p+v4adeZT5ZKC7OuFDm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUxmkUACgkQAVBC80lX
0GzGgwgAjQbXzYimVR7+rtrV9aO5BvSEQxFD8GXrZiUwBm6MVE4qSX4YBiTEHeq7
Y6Imdb+1+36N6uNnKR4ZkA4V+7phjoLbOeViF+k/MDkPQksmRb4LVGcvyKGMCbfa
K8CRL4vugv0bDexi4UN/c2E/PSHvtt4SV7tvQCCW6yqFz3Yt7IFNzGMP1iBZ7Xj0
pbLrug8/FrYVruOfjjWyqbf963S8Nege+8ekiylE9gOofrv4wytUMshMrEKwUfju
IXMlpMjaivHmpttuilPo+YzZR5Zbri7QtqQbBsPQP6l+7PmzhJ3I0/qy8lZ/p2Ow
HRwtSyfA3xf/PbIasMvwZpoqryarlw==
=H0QQ
-----END PGP SIGNATURE-----

--Sig_/5CE+p+v4adeZT5ZKC7OuFDm--
