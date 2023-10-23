Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA037D4187
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjJWVQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjJWVQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:16:25 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7BE10FE;
        Mon, 23 Oct 2023 14:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698095778;
        bh=D0yeEwspGZToug4I7VXU9FlsdciqujVRt9xPN/1plGY=;
        h=Date:From:To:Cc:Subject:From;
        b=sgAr1vkUsV9ffQaMOa/LFgd6o8m62W1M5pgscbs9OBssSqY1i3FfogdYJ1dwhgV9B
         pE807wl7OKmD/t+xOACig7k6tEXAptgMmQAAyq9I/lM7qWZsuMreQpQNTSFHLIqWP3
         hfvXfrFLKKmjNENJ1LncE2b1pybZBa3Je8XnjH8TYQgegUg5vK3sTvAMZ7lVUo9fSQ
         TBya1HDStcHdV9wtuH4FRoD8BMzqLB71kLeKzPoB+QqloC1LcdiTMEuaTEqqqtZjIs
         ZQtQRsGHpFAH7dWBi5MO5Wo6XtP9dd9xeZzzIHUMPV/pfE757JBXU4ELtas5AIAk8D
         263FGfSs4XAOw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SDp023PDtz4wcJ;
        Tue, 24 Oct 2023 08:16:18 +1100 (AEDT)
Date:   Tue, 24 Oct 2023 08:16:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the powerpc tree
Message-ID: <20231024081617.686c086f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0pV_NK7c99nPUcyLur.Kr.z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0pV_NK7c99nPUcyLur.Kr.z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  351a050f602d ("Revert "powerpc: add `cur_cpu_spec` symbol to vmcoreinfo"")

is missing a Signed-off-by from its author and committer.

Reverts are commits as well ...

--=20
Cheers,
Stephen Rothwell

--Sig_/0pV_NK7c99nPUcyLur.Kr.z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU24qEACgkQAVBC80lX
0GwGkQf/XJ4Mm38KSnnVJwtJ35imsiLP52PcHsITty5kXz/JMQrXjZYJv11bF1JN
HNt/iRC1RE440GhIlMgh9YvuewjAFfRAm1bCAXOqP3XuAYsV5twrN9hdIbyZnfWP
HWG0fnQpWzAGwyR8oMAz2aKyML6gFP4ITsFSeEd0p6EhIJkMlGoVYeqYLXX9b7QK
VXAsAsUZ/P8i8Dw54nbkGrqQKVifsAhXdbcskdsd/0Hwp+UmbPjsiRBF4VC65/aP
HmzSiUiSe/jwVDYBkgVcq0acFhVcucH6+Y+NdnboLfKpG/I744k00j8XpAWyr173
whitus6X0O8SFuqWu7GyDkkkhTq0Gw==
=VW7N
-----END PGP SIGNATURE-----

--Sig_/0pV_NK7c99nPUcyLur.Kr.z--
