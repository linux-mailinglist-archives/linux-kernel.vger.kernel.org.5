Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A31E7530B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 06:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjGNEs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 00:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGNEsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:48:24 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA8226B3;
        Thu, 13 Jul 2023 21:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689310102;
        bh=M3lL3WHQDYxE+bFRWIvFm67fzAQGZlCTeaYweTGu04M=;
        h=Date:From:To:Cc:Subject:From;
        b=jkb/fFngNxB1tW6+G6M2Jn/bCL6sxJ4SNhZfGVAVPGao2RaJZAYGASCCAtjB5kpn0
         6oUJuPPd1fwMqdUZq46RPLvBf4lFeMsx04rfnlUkooRe9QQv7q+zqEXY2zQPmdHa9j
         +tadpVAzeO08U2RsD7jwTCpMsr4LZzOSyu80+bwXfQG/eqGUcwU3JS8Dg1bpi4bilb
         ppPCQCiC5Oz6BCZFDYe08ILbFxeErqlfqP4bFrxkK6Vor1ihicGgNjTnVWWmgUVFlA
         tyU8TQtuQ7b8hhu0ipU0o7oP+bN+lJo93/7Wbj8mCUNIUkbutxlmcBWAHwRR8Tu9zK
         EajGUeqaxAgHQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R2Jrj3ffPz4wb0;
        Fri, 14 Jul 2023 14:48:21 +1000 (AEST)
Date:   Fri, 14 Jul 2023 14:48:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the sysctl tree
Message-ID: <20230714144820.6724ce15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0CuX7tQI1O1Ka2iUMsuOqoF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0CuX7tQI1O1Ka2iUMsuOqoF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different
commit (but the same patch):

  5664eaac4dcf ("sysctl: fix unused proc_cap_handler() function warning")

This is commit

  554588e8e932 ("sysctl: fix unused proc_cap_handler() function warning")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/0CuX7tQI1O1Ka2iUMsuOqoF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSw05QACgkQAVBC80lX
0GwHugf/Zdw2+j/nXOpKwZqBRR8ux7tneyRAAjEwQNb6++GJuqvc3wfktBd7mfLV
SkmzeXX6ePzQgTjEpfyeItT67UXjlirYRBfCIKHByefIJnPDtsmahPY0XSFtrel5
+FHeXLYP0zlmAGrj51AJFCBJ8ly5xRnIpwLj4a4/IDgEY8FErbu/FhNzcTeLjTcV
fgyUkLB6EDbaN3mkVcCLFGv502xgDK87z6O9g86+ENkVsLuaVeA3xI2yFhoH9xPT
lzyRIccbOCjbrQcrK6UKkSFnJi+x2poiOqS+iK+a1hs66k2U3MRuvjlJeCgzGFt/
8I4suUb3GiZok0m/ACxHZ4RnUPG70A==
=RJsT
-----END PGP SIGNATURE-----

--Sig_/0CuX7tQI1O1Ka2iUMsuOqoF--
