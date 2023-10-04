Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A2B7B769E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 04:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbjJDCdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 22:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjJDCdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 22:33:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D239AC;
        Tue,  3 Oct 2023 19:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696386788;
        bh=JzrQrv8Zf7NOIYh0RJOeFHtXquOahUcLeF1fcCrAuKE=;
        h=Date:From:To:Cc:Subject:From;
        b=IlC0iaMwApXSV/qbqkr9p9cuRUdnBsGGTE3FnGL9pIW73l/TTeOzqfNbZBqQRXmZA
         6HkmCfgdwWRm/wG/KtfsQNY53YvP06B4aDqdT8n5RJUNIfyqe52ciYrFaoFJu+Mjek
         nnoucE5yGqlyDj0LGSsh2NTOiqxjuRJzXEWw9D50ylkqaBSH2GNyjzFAODrbvFIiez
         fiCqkdXlOCNvCuLSkYtf7A2s1J15p49TTr8jkwY9yHXPnz029WmbJqurCOsMjaI/7L
         IdsfcFC6pJA5suUb/XZQt4huuo3BjOgnDT80oqSKQSvHFmjafb++9BW3wfoSgufRNq
         DOfO8DgMBDkzg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S0dyq4yTbz4xQT;
        Wed,  4 Oct 2023 13:33:07 +1100 (AEDT)
Date:   Wed, 4 Oct 2023 13:33:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jianlin Li <ljianlin99@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the tip tree
Message-ID: <20231004133306.3285d8de@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7r=e_5vTFARqEtAR87ECHq/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7r=e_5vTFARqEtAR87ECHq/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the jc_docs tree as a different commit
(but the same patch):

  c53cbc54ccff ("x86/iommu/docs: Update AMD IOMMU specification document UR=
L")

This is commit

  73c5f76ecbdb ("x86/iommu/docs: Update AMD IOMMU specification document UR=
L")

in the jc_docs tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/7r=e_5vTFARqEtAR87ECHq/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUczuIACgkQAVBC80lX
0GycPggAo09fJ/GO1yCFcBwETCAYYZNdbHCeAYNpW5ybvUiHgxgnCvK9SglExbry
+iBHN7y27QWG26zzkB8uQpfrSYfw2nPyjSw9Z5F3523TStgEyNv0L9LcWajyx0aZ
APwQ85uoHPxCMBkt/tP8GuUBvre4XZ9GRu9jhzH+ZwiRyJnjmkdOCzcJVDBK5Eps
sipqtTeQL0gRfoEn1lIWWWvIQGhFtkCWjWtkpFKctkLNy6oYesUe0VpaAPRGrJXG
ilhtxOLTFMg/6d9Am3vEr9HyNaA3cNtXqScN1zc4Z28ceRQ1kiFUatyOBS0JybsP
rX1CVBAIdU8+tudG/tQbHgiYEznb/A==
=TJa7
-----END PGP SIGNATURE-----

--Sig_/7r=e_5vTFARqEtAR87ECHq/--
