Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8297C78E55F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 06:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243963AbjHaETb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 00:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbjHaETa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 00:19:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD802A1;
        Wed, 30 Aug 2023 21:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693455566;
        bh=mo5NGKhfmAXW34U802n/wusP2RJWjjNPGulANsLsI3o=;
        h=Date:From:To:Cc:Subject:From;
        b=binyy3Yl510izIvuTlxdeCZ1T3Ds6e+Wn6W2W6IHFjQaXXJQTFqrF4FLtD8m3I0yY
         mZ8Bydqbk9VkiLEoXv5gf6JxDui4tpxz+qWCShLJzVz6fa0XDz/GloBdFhg/ZpzTvi
         n2c7qbL71fb1fv2GQ6Ylgbb52bPwnoLlDQBJEaEDa5fwJANiRNRkrIPwgqtXVYOSRU
         iDPaRxdCXafNWRFj3xUELhvZcpK5gDc2U7Ftmva2Sfa5gUkgM54BlkgNQe3GSgdTFz
         SQCu8noDBPQuiU3iOrPVFPOC752EOSBjFRzXgYZ/B3nWxzZWrHST0IFG5xIdUYb49b
         DSiPTTbT54Jgg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RbnxB37lCz4wy0;
        Thu, 31 Aug 2023 14:19:26 +1000 (AEST)
Date:   Thu, 31 Aug 2023 14:19:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: no releases tomorrow or Monday
Message-ID: <20230831141925.26f5eb1c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eETNxX+X8aBWi8Wtr7F1X5E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eETNxX+X8aBWi8Wtr7F1X5E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

There will be no linux-next releases tomorrow or Monday.  Back Tuesday.

--=20
Cheers,
Stephen Rothwell

--Sig_/eETNxX+X8aBWi8Wtr7F1X5E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTwFM0ACgkQAVBC80lX
0Gyxpwf/RcHyNyM7lyHo23VyUrLyg30wTDGbVrdaLhDPlCYD/9ZiERgXEAOHuTfB
lHB2z0oqm4s5zcvUBOzIPtXLn+IyMZ5OPwsyOq/qQw5DjvpjDfvK2PFaNaYV325O
sb8imUFxHDrkmi73SMGWRbsoZWdgaq4wx+qll+u3rM8mBzy+un8Y5v6Z4vlFQzpF
VPjSg1zUnpc2tlAFJeKwfkQ9Jp64lyXTw1McPB2vwoQepZ8NbqY6SOPngEH50Omn
rDbUBmyXRCJMzt/wI4kylSlOf6fxSxfY6IiG+oL6FKhMwRs7LA6XxopBFmQpsBQM
YhuLmofLKjWNLzy2YqZ+e/ns28Hbnw==
=REKt
-----END PGP SIGNATURE-----

--Sig_/eETNxX+X8aBWi8Wtr7F1X5E--
