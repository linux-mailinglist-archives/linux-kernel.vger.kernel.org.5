Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2757B5C3A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 22:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbjJBUsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 16:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjJBUsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 16:48:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE466C4;
        Mon,  2 Oct 2023 13:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696279678;
        bh=bec5dMn6q+l2mI6NdjHgpXfGiGBum0OM/W2zvWqM7cU=;
        h=Date:From:To:Cc:Subject:From;
        b=sWkrsdktpZSsbxYJDGIdAPnceTKEZtZS13EBJUOeEUzS8crdr12RbVIUaHFfoKhb1
         cxR3ltShLAnIPlH/c5Fb3sdqvzc2jjIpdEcmsioS40kyRhHnthlT7MJgqPStJjU4ZB
         K2k3FO9H/FgNj2V03QXGALl4rDv+WyypAlAzUIWChXvbHlWdBVub6wB6sahXiRh1uK
         xNl14tw0Z5RoehITGp4WRo0G/saPyGPwXWubYMBGA59+4dwcPaw/YdzupFauFmw2Ct
         j8ly+58fECHRafUk3UTFvvlLja/LM6B8DryU9XNR0Ft3CamDq7UBx4aecGfS1w8OAM
         HLEFtkEuhpTMA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RztM22ddkz4xPc;
        Tue,  3 Oct 2023 07:47:58 +1100 (AEDT)
Date:   Tue, 3 Oct 2023 07:47:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mm-hotfixes tree
Message-ID: <20231003074743.3960382e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TX.z1VT8Av8fNu=NSVvC3j.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TX.z1VT8Av8fNu=NSVvC3j.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  d6e3429602a0 ("i915: limit the length of an sg list to the requested leng=
th")

This is commit

  863a8eb3f270 ("i915: Limit the length of an sg list to the requested leng=
th")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/TX.z1VT8Av8fNu=NSVvC3j.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUbLG8ACgkQAVBC80lX
0Gykowf+KVeI2ODFKaG9w2RB+25rq49vqGcSgTnk0nHWW/Gs3zGVLP1KqPOwbyO4
/QYCkCCD7tMoPWTiXsp1fuTh9KFNo8SY71SZ4lEhPEqh18eIgpDwuQbIHHKHSOFW
w5vkY+dzPSiCefjX7kGzdnzEJayZiPYLINACXObtxzwulvKHRwbKqvPTUNvLcujO
+CfMu8LnG6pvIfWLFl9kz1dr3w0M3LY36iC4ZIdK+HQFjzw4uRy5lyegKODXVf7G
GtNe9bLoGdc4HCXSHTqzuMtBOwG5KKVz2TE99WEGRFpoldNutB1jQHH0e970UgJI
Ib7/ZWROIydOg9LQ4zss+bsaDzUdXQ==
=6wVR
-----END PGP SIGNATURE-----

--Sig_/TX.z1VT8Av8fNu=NSVvC3j.--
