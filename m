Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79319784D41
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 01:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjHVXRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 19:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjHVXRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 19:17:34 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7185FE4D;
        Tue, 22 Aug 2023 16:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692746250;
        bh=R5YB23V+48Wa69gXW1dOSK+mey4fsBVisc9o73Lrm4s=;
        h=Date:From:To:Cc:Subject:From;
        b=mkFkp2uOAq2XZAlT7Bd7BHhRPLddQ2cM0QhslujA24jWL8jGVdgLqXo/Q854jtHsr
         gTDtZtMXwLLEhukGO9RDFFGUgPPubV+YULk9AC4mWSZQf6VQOaqG/qvZninlIzI+tw
         6KNpq6SD4JobbDu6UvT/D6KpebM9/dK8kqY0p3TrFKmt9qdWJ/L+S5FqJzINFGrNDR
         cCF65qW7QhV6yZfj61DcmZP5if2+2prsfgW7eO4XPtZLgDZbtCBoNgui8Ia3B7KkLz
         EVD6AWFGqmT8ytRP+FOFy0lwuLNJZQth3kesyNOYHqSIuW4Dm8z0AJQs6vnaeKnNrk
         Sou7c1KhoPsLw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RVlcS6y9Sz4wxQ;
        Wed, 23 Aug 2023 09:17:28 +1000 (AEST)
Date:   Wed, 23 Aug 2023 09:17:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the stm32 tree
Message-ID: <20230823091726.21d6419c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dWWIxtJuvZDrtRJJx0e.vtR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dWWIxtJuvZDrtRJJx0e.vtR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the arm-soc tree as a different commit
(but the same patch):

  0b5198b3421d ("ARM: multi_v7_defconfig: Add SCMI regulator support")

This is commit

  8d6b4927936d ("ARM: multi_v7_defconfig: Add SCMI regulator support")

in the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/dWWIxtJuvZDrtRJJx0e.vtR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTlQgYACgkQAVBC80lX
0GzztQf+PflmHz3LRaJMwgPht960OpffE7ps7CoHAbQqF4pELUh+o1wBR5n/Tf9O
TZsr2b8F0WLD9BT9klS/iqm2jehIgcDG9zuZVAO7O0TYB6IHtlDySUT6ftoLAID3
vRzBYLaHl0xCPRxLdAuvmZFcik6gA9CRLo0/drYnFwIJdjTnJCq/7z5Qv45ST442
2ia+Cf0mzRCVn1Rm69FNgs0yVXl03P+JTZ723PST142fV8U6/a9wiwHrgFCa1nzh
lrT719bH+URW1bJBTwHf/qAUHLT07TMvCY7i2VPBpmfRpzLLujhn5zliV4F88H3K
OLA4x42o4w/wdnOkCxVyCegOrqWZLQ==
=iEtW
-----END PGP SIGNATURE-----

--Sig_/dWWIxtJuvZDrtRJJx0e.vtR--
