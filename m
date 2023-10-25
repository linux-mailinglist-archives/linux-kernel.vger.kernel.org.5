Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9736E7D60D6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 06:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjJYEXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 00:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjJYEXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 00:23:47 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35229F;
        Tue, 24 Oct 2023 21:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698207824;
        bh=Nzk79lMPx1nolPvm6LlGPmfa8Zxn4EI8caIB70tC7Yk=;
        h=Date:From:To:Cc:Subject:From;
        b=sOtQ3v0sGqdeVbEGtT/WoTHLhZbaVtuDvqoWWUAZYde7Uxgi6SvtP6MbMNC7Cr3YM
         g+H7OWjPunVWtsWws6mJrfPnahBQ1Y4UEWJ75hkqnHLaok4x6rEE3GXLRV+d+QO8nE
         6WFLnu/jtpSomy3Z3yqnCI4n/1ACQ+KXnN89cn2QnlqiTUQ207adhwoqJnM4iEnU7m
         na/qimFUAsswonzbiMFjqPpwoodJTy50zbnwNf7vYEf3ch7i05p2uuhiAcI9fMO0Jl
         rrakig2bJ6qdO8yaih863QZ4AKRiN5+cfnxrak5HdBWjDfHHlSdq0q81xzkPil1TfC
         tyRLrhJ/B94UQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SFbQl4SyRz4wd2;
        Wed, 25 Oct 2023 15:23:43 +1100 (AEDT)
Date:   Wed, 25 Oct 2023 15:23:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the nvmem tree
Message-ID: <20231025152342.4be7be25@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MsMgbuzlUSqTLVSxTKyhFq=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MsMgbuzlUSqTLVSxTKyhFq=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the char-misc tree as different
commits (but the same patches):

  24bd074c417b ("nvmem: Use device_get_match_data()")
  8beb2ec54b65 ("dt-bindings: nvmem: u-boot,env: Add missing additionalProp=
erties on child node schemas")
  6d25308bb9de ("dt-bindings: nvmem: move deprecated cells binding to its o=
wn file")
  ee73a9fae540 ("nvmem: add explicit config option to read old syntax fixed=
 OF cells")
  c52b640214d7 ("nvmem: qfprom: Mark core clk as optional")

--=20
Cheers,
Stephen Rothwell

--Sig_/MsMgbuzlUSqTLVSxTKyhFq=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU4mE4ACgkQAVBC80lX
0GzsMwgAnnjDGbn6fyZorZMepTlmfvQdaGyd4C5jQXVwzqko8yeKS/EKC/Kuj4Jy
kMLTbQIKfM6aBaa79HAFY/yPXpmTQbImsJ2u29KjAQQjEmveAGmID2dX7Ociby6j
gPaykJQFbOVRHTUp54GW4cNWK//mTznv1Kp5JFRWQONWpsCnDyPOgTwU1Sgt9DfR
ky6XLVV0Tt2FrXtIfhJCzzSn9V8VOccSzC43rqeM6aoik6CbPH6SwXNLFopI/q7I
R2mIClp8MCwOz1RkASyZZtkTUJQvUcfUzKqRAeahVls4Dfvws3w/h/OaIbY0B62c
FGpGTWU7lYouMnyixRgX2G9d7zDoTw==
=v1+p
-----END PGP SIGNATURE-----

--Sig_/MsMgbuzlUSqTLVSxTKyhFq=--
