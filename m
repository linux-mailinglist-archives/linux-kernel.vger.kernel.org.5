Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2E779C3D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241704AbjILDOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242149AbjILDOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:14:33 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A026693044;
        Mon, 11 Sep 2023 18:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694473788;
        bh=SPZkBkQK5gCnAGsU5Ak0Rh1EpGsLTAu/VUGJGlVD5KI=;
        h=Date:From:To:Cc:Subject:From;
        b=LMVhncbeze3ctHt4H7tocUFxHSW5+ZUj2dqsTBp3/UfQVMrQHlBrD1qSy6Zw/Y7CT
         AHy7ynlHZaZsf+KdeFG5hFqLPqMho6Y5O6wiTXYDdWo6hYFFipWprW8CiaQ0+gnIpw
         tkmKNwBq5wBlMuOeMonsnd2arnuhXVXV3EZb333Z4xQLMbgjZuvf+r1TFTGnVVUYMV
         1QC6jpr5kHrQk5m/MGg4e/BGh10jC5sNCLn4GKEQDSbNlGIRif8NCFX7MVGNpU+wmx
         RPoIQ+nntTa9Z3Bhw8AWbaGeYkcW448au236UM3E/KafL5ZgGKsWTdNtYLaiOJLwZd
         x5QV+41vCgEWQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rl2VN26H2z4xWH;
        Tue, 12 Sep 2023 09:09:48 +1000 (AEST)
Date:   Tue, 12 Sep 2023 09:09:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the scmi tree
Message-ID: <20230912090947.7a099d53@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_K6jicT0X1.B+akV=sbagA0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_K6jicT0X1.B+akV=sbagA0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  2326b2f5bfe9 ("power: vexpress: Fix -Wvoid-pointer-to-enum-cast warning")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/_K6jicT0X1.B+akV=sbagA0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT/njsACgkQAVBC80lX
0GwSDwf+LWs2fgc3wUo4dv3cCtNmgdR0+81eECOcyfbLZrcQ0ZuMGn3KAsFrSvGg
pEVRn9nXFM0qhuS3OpFJSxbngf7P42JOUG2YnAbMs6MU5BToZmEQKOWJ7qEf1ZSX
/lnQypyn+RZRHc+nbzqCTNS/7UB7UM8v1EzoS9s0JdumVHOXRr4qrKxBIXK4i1yD
xAwklpbXxhugL1d8sROxo0RmjCU02Bf2GXzTJWr2wPCtx3kyndH6jfPjpK88ysbE
mdGFhZbt0m7DU8twTGEvN3F10anX2v5W4F6aDq5QK/BeWltLpe77nMkrQvXMxl8+
tOCaHxh59F4c1DhBDG1IgndPuHS40g==
=NDvJ
-----END PGP SIGNATURE-----

--Sig_/_K6jicT0X1.B+akV=sbagA0--
