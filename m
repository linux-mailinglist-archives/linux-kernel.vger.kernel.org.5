Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEF076F4ED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjHCV5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjHCV5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:57:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8CB3C22;
        Thu,  3 Aug 2023 14:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691099846;
        bh=7HsyJ0n10cggudZoIG8F8WD+t+K7Nk0rtPPD9QZ2L4A=;
        h=Date:From:To:Cc:Subject:From;
        b=O91dQp9uAcZEm3OZaJwAcAbgbMH1WblU5mWBaue7kNoCqtWVE9H7x4RpILW0QDVmm
         bd9VymNWXPYyTnW0sSSm/M1Ti4CGCVbY5E+w+ttyGJHYOOUD5X7zJ/F/VbMF39T8MN
         2/92WJoo6lOtBaGxhov7SDeeXUiyQ2G5O8FWCYX9PvXdsCaizdmX7+CqCxecUICF64
         4RMrZJMmd2EuFv/97CORi44d7xygRLvvIGeG2XsIr1IDpcYlTSjG0fNaQ77DFB5yDQ
         u+lw/fi1UZGRcKp92MZ5Rvu7nYzblhsQEpPP5Gof8MSOsyniVFVqyWxD+SRPMqjKAI
         FHqd3S68ie9zw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RH2ks6SXMz4wb8;
        Fri,  4 Aug 2023 07:57:25 +1000 (AEST)
Date:   Fri, 4 Aug 2023 07:57:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the risc-v-fixes
 tree
Message-ID: <20230804075714.7033c7e4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5yQGLWpBZtfGvmHz5bMwCEp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5yQGLWpBZtfGvmHz5bMwCEp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  0ccd2e803745 ("riscv/kexec: load initrd high in available memory")
  1be0b05b3a80 ("riscv/kexec: handle R_RISCV_CALL_PLT relocation type")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/5yQGLWpBZtfGvmHz5bMwCEp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTMIroACgkQAVBC80lX
0GwtcAf9EWxsZ3V8aIKZz6iuEfns3xMbm9JtTsEgiokCGek0kRJyCVAnP/fNLxRI
YOiVelA/pD+4j7pOseAZKAc3hJsqCQDGwW5DqtJuuPdcVsBV0g8pYqfbUXIYBoHV
BpuFJsznS1eLAjfG7L4JbT7PT5tcs8/hgj7tbji3TBA7jKb3TU4LqQ9z9B4Lkw3y
k2vdNoKKDCt1XzHuX1EWeav5L2EIVaI5OLcPMAV5hKvlV3jX8mywzrJK8ffwhxoD
gRHmGqZcz9MC7zMROXdp1k0zS2dbLDOWKOnjGn3HMvOUg+0aQlf5FFf1WLyU9vqw
+Gk+hXcKk3k2W5I+GAD1hAM73rxHsQ==
=MRjY
-----END PGP SIGNATURE-----

--Sig_/5yQGLWpBZtfGvmHz5bMwCEp--
