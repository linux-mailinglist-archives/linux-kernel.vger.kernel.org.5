Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A407B2AF5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 06:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjI2E2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 00:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjI2E2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 00:28:16 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989471A2;
        Thu, 28 Sep 2023 21:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695961692;
        bh=vOAd88awm2mtuxr9ice8vH8hSrXdhDpsrnwfFbEKckc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Uu9VVYMVhkKEfdK7odWOx+uxILsT4BfMgVSv/3MODTNO6rGL0Y7P/8vqXKZAXEGBj
         9wJ0d9BLaCA+ZCCR2RMVEYpwqP9uPQXXHUwP8/KrYTGf6ct0R3fW9SUDI+OLyz8U9h
         wMfa4SgBqBbKwtQDFwB6EsO3UTeD7gXrsUgUsaXEYO95mfjnIO7CRumK90pTTb15V+
         KgXMmM5Bo1jwYADuTyXgWoEbvlvWqAmRzgwwKy4QfzUACieHRkf6XSUHSSLPg+84in
         m4EBKWwnp+A1vgD/8VT84q/DhGDuvaLLIh3e9UxN66WJP1dmyM2Bl5A3MAWX/cTk1x
         J2SFVwJq39UwQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rxclw0pC9z4x5j;
        Fri, 29 Sep 2023 14:28:12 +1000 (AEST)
Date:   Fri, 29 Sep 2023 14:28:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Sep 29
Message-ID: <20230929142811.0b5b7d65@canb.auug.org.au>
In-Reply-To: <20230929142549.1feca43f@canb.auug.org.au>
References: <20230929142549.1feca43f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1fqBsDZltoUMUeMqr1hUkPu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1fqBsDZltoUMUeMqr1hUkPu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

I forgot to mention that there will be no linux-next release on Monday.
--=20
Cheers,
Stephen Rothwell

--Sig_/1fqBsDZltoUMUeMqr1hUkPu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUWUlsACgkQAVBC80lX
0GxIfwf+JZGUXiW3pLM2b2gdwI7O1SeL4/t5oTlcpThOvZKyuEuaCdVEZmP688tH
+69C1jcrhzYgImI+YnPtTQrol7ho8BHXLvIM8bM8DPy2KJCVfOGMwwwnixku9DPu
NNs+LCrR1+GopqZ2h85ZzsciJC+HSVkpPalt4L2KC5APFt/BKb4TJMJxZQOxChOk
iu3FvqN9o/q7ub5PisElQMTUFat0vwiJA9mNPAa6Azi3nxF/lAvnOBpH5iybxRio
uo2OSKVjsSXVPTP6Wx1DMfvhUcM1LbNQyxp4ROGrnLTTfqY/GXmVXgyOvYAHtrOv
qJhCB13WRbfh65eUKd+N5nyDIdIJAQ==
=jvOW
-----END PGP SIGNATURE-----

--Sig_/1fqBsDZltoUMUeMqr1hUkPu--
