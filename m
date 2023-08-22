Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D77784D48
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 01:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjHVXTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 19:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjHVXTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 19:19:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E254210C8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 16:18:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 564756492B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 23:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B86C433C8;
        Tue, 22 Aug 2023 23:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692746304;
        bh=sTJ+jv/Df/DVNxeO563Cx6UGOV/yGoERy1in88snvBc=;
        h=Date:From:To:Cc:Subject:From;
        b=oUtrA/C4wlvPJ52w3UUCu7KGJA0MfdleTtRxVAC9iXH0UMd+V1FeU66hbxX+WDDyL
         WUfGK+6+RH8Ue4DdxeDdry221wmfkT75sj9Ak+pJ/DTRqhFMd7xDxKH7VR0+okSW+S
         4XlRb4l6OHIHog8gQxstDEnMRAMs2K2ch+w05sl6tl1lo3F5N5H6+JCLgENPBiJcl0
         mAuasCGHf1F1wfbF2JTkL8CKyHEh4O2yU29PP5JkiOCsz6GKi1cqfdOGFiMt5sg474
         1lXvsSRKibitFJZdDk453pdA4zUqH5i7okQvjYKFr1QH/9xogf5WVR8CItFLe69ryp
         3Uu0Q9PSNKg2w==
Received: by mercury (Postfix, from userid 1000)
        id 7BE9610618A0; Wed, 23 Aug 2023 01:18:22 +0200 (CEST)
Date:   Wed, 23 Aug 2023 01:18:22 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] hsi changes for hsi-6.6
Message-ID: <20230822231822.tck3u67hxgndosnt@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dglscktfsc4cjjos"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dglscktfsc4cjjos
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.6

for you to fetch changes up to 7ebf243a201856adcac240e490596bb908ee5fcc:

  hsi: omap_ssi: Explicitly include correct DT includes (2023-07-31 23:17:57 +0200)

----------------------------------------------------------------
HSI changes for the 6.6 series

 * explicitly include correct DT includes

----------------------------------------------------------------
Rob Herring (1):
      hsi: omap_ssi: Explicitly include correct DT includes

 drivers/hsi/controllers/omap_ssi_core.c | 1 +
 1 file changed, 1 insertion(+)

--dglscktfsc4cjjos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmTlQj4ACgkQ2O7X88g7
+prseA//SRInMAqbviEobGBUj1ix4e4FearG5fRaZqeldxL4DhJtzGX9pCglEySX
B91rF8CL8U0Zzj6vOkPc5C8iKicULt85qBIxCLGAS/NtCVZ3tzWg7bqlGywqfKBp
/v61nRjZdAG716BGkTjkZ9JtCNcv+KftmwMxE92UDyH3BuFiop8pizSL2SQ5+H5W
wVXjv5bqr4cACOwUGzW5O665I4jlJ4IAFDfWvyJM7/ttBYjxuE8Bxhhr24xMZU2/
KsJZ9u7LriR4WqXWjH+We+hOe60BCZF5UbcHjzlQiBkqfjiZ+LecZYlVHWF65+f5
ZoItuXCsUyGV9lx8R6uD23xtuw3bi/ux0fUZGbQUv3G2Xq9m0ldKT3njV0xjXNyf
rKwMC6kMd1XsyZJbYzYja+qpg4jA+ybyv1UWvhXJBFRvWdvMkpTrnUsVvmMbVnvc
yGDl+FBD28q5QTkUze7zRVXFNnZH2yw67CpJybhuqEzhKq4FvSlHsF9m8DvHqeSA
9CMnfwgZmqeBL4iE0ArVcHXqWJJIwG7XO9K0j6Bem6nwgf+d3xEG2WQUrai6A5QL
U1AFj7e6OcBU9IK34gaUG4S0d44PZc0avqXZ/SWweLRMPVb/etVHimrxII94tAGe
N6d0k91AYz3OhmCKmpegRKkqmjOwasimgtpIVNeV8YxxzVHxt1Q=
=Y3rH
-----END PGP SIGNATURE-----

--dglscktfsc4cjjos--
