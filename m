Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723297B5C45
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 22:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjJBUza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 16:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjJBUz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 16:55:28 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77A9D3;
        Mon,  2 Oct 2023 13:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696280124;
        bh=y2OXY0D77gDpusn0pdcUxBp+k38uQBFf7cuGXud5fhk=;
        h=Date:From:To:Cc:Subject:From;
        b=Y41WGGKF/uDTD5kx7uw7Ou2i5gwP3EkgnGYLf8XCkRJD47Zq2hCtS5U6aWRGFyKrw
         ++vHBKgr/POC2aJt88M6Eo0D7Hag/k7axUY+CO0wOcSoDtOaUmA99A4l0yldVaofq7
         0VF+pa5GTl/unRyDZfLyZ3TJsoLsOSJAr8nnAft3PwrYoJcRmOQqmm7iaxd0Ma7TpB
         e007CjV0vO+3F8DwG8m1PF2G4Pf+LlNrE1dZJL+stm4+4m6Psi37PZG8LXrL2TkLrn
         8YbN0avoHa4cMlR9VQwU56ng6bhHp61nfkzmRVyDUnT1fAFJTJ/CV0mE+2kmCIeL9Z
         QrTkmvq6CEpkA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RztWb3pq4z4xQ0;
        Tue,  3 Oct 2023 07:55:23 +1100 (AEDT)
Date:   Tue, 3 Oct 2023 07:55:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mm tree
Message-ID: <20231003075522.0284d2b1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pOA6icad+fBJPYJ+YMJKuzd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pOA6icad+fBJPYJ+YMJKuzd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  e47f255f6365 ("mm-kmem-add-direct-objcg-pointer-to-task_struct-fix")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/pOA6icad+fBJPYJ+YMJKuzd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUbLjoACgkQAVBC80lX
0Gz3DAf/Uj7cQYHJGp3B6jJviWEizU5bLIOzsqrsoCqu4OIlDyY8khfYrsmaPmrc
h+qMIiVphSDu+bwLOqFQLcXscq3fEIe5CmFwy4aWT+NkDPP3jKegdsO8nHICNgsK
MyxDJPoSQ+BBaMwy+FCTnxPPVQQqe/lBJr+pN2ihb08CcYBCxkaHoHsYUbEmjNg1
zs7f0wpXqCjiCcYe1ObkCNmKDc++SfWrN/Kob+/fHOWhpbouGHWljP2m/P+zqhQK
+o+6u6IC7izkXigqSiKqat1P8xdu+XKT8urRXFE+E3FCGTHKs0emHlw0k6Q4vIWI
uSuRvyWL/emuEikh2xOe77iYOkAUGg==
=bQIk
-----END PGP SIGNATURE-----

--Sig_/pOA6icad+fBJPYJ+YMJKuzd--
