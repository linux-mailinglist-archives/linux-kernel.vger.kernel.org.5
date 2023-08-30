Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB7178E20C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244313AbjH3WD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244304AbjH3WDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:03:24 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6113AFC;
        Wed, 30 Aug 2023 15:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693432907;
        bh=XPW4gDmHR0QRBMmj3ajV1TDh3EDHyNIyf06pPtJP2jU=;
        h=Date:From:To:Cc:Subject:From;
        b=Th+h13Lv1DyeQvxv0wDAf401woKUUvnNfFeyZ85B2XYOq6+s8nEaj59n7z2SxQJ7D
         YD+Mp5AHoCWkaFPtkZNbIPqPPRt7fQRsl5mqp/KZGTWoficpicyWjLoFsWrAxEbtBy
         AdiUJ/G0S7t63Ka2usCdlBsN2+5Jcl7lq0NQNtWFXLQJWm8bh27UJtJ9eGa8UW7wEk
         BYtrG0OC731fNcSzucXPZQWaiLlVXXlG2i/MmU2Pr3u8SVbRev23W18A3ckw85yfl7
         H5CauVgkbwk2eXB00BHNHC96XGFPHPQhIHJkkFxo5ubfSyRCEhGijiFJ544KSmrCbF
         XZerfJiwA26TQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RbdYR3ZBzz4wxN;
        Thu, 31 Aug 2023 08:01:47 +1000 (AEST)
Date:   Thu, 31 Aug 2023 08:01:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the risc-v tree
Message-ID: <20230831080146.172c21d9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Yihs2j7ozXNwmJvsjA1qRJ0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Yihs2j7ozXNwmJvsjA1qRJ0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  3aaad36808b5 ("riscv: include asm/cacheflush.h in asm/hugetlb.h")

This is commit

  33a9fb09836a ("riscv: include asm/cacheflush.h in asm/hugetlb.h")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Yihs2j7ozXNwmJvsjA1qRJ0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTvvEoACgkQAVBC80lX
0Gwulwf9HTA5CY+R4SOSk3P0EsvtJ8xsUuESsqNkD4uuXeSEZIVcC4PHKSKwUxoE
2O+XMhoKQMnbD9/gVl59R2wxqpmiNWt+ekC51wLVkVStajslvXgHMFdG9xNTiO8Z
YeBBGMVr2/iuxsXlsOom8bI/wsg737KvHK0iweUeDvGH7f9L6IjkJsUTlMvjO/LT
pVUtMf7uEM1vJTBd+pw0S5VSmurkOJlsDDtY1R0vMFXpHNX6YQP44tbI5bEp4LPy
UZiwjKXlsHEfJQzbLwlCiIQc8kgFDH/ieOas/ymabwwMQFiynelp4M5F6bbdJK4W
5NwKpmkw5o6p349rNGMB6m6WcVGoXw==
=3CFA
-----END PGP SIGNATURE-----

--Sig_/Yihs2j7ozXNwmJvsjA1qRJ0--
