Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860BB7557F9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 23:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjGPV6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 17:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjGPV6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:58:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08D7420E;
        Sun, 16 Jul 2023 14:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689544547;
        bh=bLb+FBPLIr0nP7ot9E/P9XaP1FCuz12sXy/ptqijBRw=;
        h=Date:From:To:Cc:Subject:From;
        b=aqUXlBlYgsA4f6IHE3f76UBDn9wdAu01ydlpFbZ9OUY+bT+P13JmQO8mQ4ckpX0Gb
         Jq9G+CnWP/FZG/8wSzPfwzgHFQk9FmDMmy7Doz3GY6u5r379S0EjUKJ7cnfpfTUPIi
         NGL+V8XRJ4RKYJWUKxR3u4T7pNPKmlnhezdYUJMcNU2hmfIRxVwgdm3SQ+k/GVYIPe
         yol3IMFzG9pwTgGwf+NsRkoRQv4SdEiaJJb1XC88gMKnFeSgiA+YdE399GaaE67Es/
         5zndPbHbA4nQO7HqB/tyF0PQYHtaZ91FrurKYBED9INLgE8n4W9UBrVAEerzPSGNR4
         4l8jl7Jt24Nfw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R3zYG6V15z4wyL;
        Mon, 17 Jul 2023 07:55:46 +1000 (AEST)
Date:   Mon, 17 Jul 2023 07:55:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>
Cc:     Mahmoud Adam <mngyadam@amazon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the crypto tree
Message-ID: <20230717075545.28f93630@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//.eB+WlZw4O2_AHYMbaV7q.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//.eB+WlZw4O2_AHYMbaV7q.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  a0459d277b1b ("KEYS: use kfree_sensitive with key")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_//.eB+WlZw4O2_AHYMbaV7q.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS0Z2IACgkQAVBC80lX
0GxlgAf+KLN4hqJTHWyLjgChlDaSdDSeDDcCQxHJlByaRefUWDd7Q1zmj+XdAIy2
Nn6UwaWaZh0rPbdS9SAikub3gWTzCzsY1HC95lotkwJqiGJeR+h3zJMsLm2BOgbc
h74S+gtXIm/D9gbDgk7OVkeBje5acy4AgI4qBKuaReQwS4qp3iAeB+tA1hut6vC5
bkWMBu5J4mZT1no6FwcWQEaHuxmQq5eRQAX8SQIDtQE+CbAylOoPTMeIs0SPPyKU
rT5A8vam9t3yctMg/+SKMpv4hS2vm+Rot71vs+3dYFNU+zCjFR+rvu9uqTn6u/Nq
IDbfVcoeAltv8vAOrsARMya8n1Pmcw==
=4mKc
-----END PGP SIGNATURE-----

--Sig_//.eB+WlZw4O2_AHYMbaV7q.--
