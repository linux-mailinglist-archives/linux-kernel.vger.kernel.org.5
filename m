Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F847AF65B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 00:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjIZWf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 18:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjIZWd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 18:33:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6305C2D60;
        Tue, 26 Sep 2023 14:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695762297;
        bh=gISLsjzu89ww8/LTd4agzVKFgjulkmN/xe1QqiE/XAQ=;
        h=Date:From:To:Cc:Subject:From;
        b=g27GZmnE9UTrH/DA8gxKXvd/8GXzKTzcbwz2ds9O7MsDQNl51oYZXaruX+VTVJSkS
         MYH7KP32BooY4qeXIJTfM0mzaGgR5fLT9tD88Bv+doFwrYuNmnaCD5I0GjWQMhGIb2
         RIcS3VOztUs1DoMKZlKzvd4KXcanobC1hybppj492mjOsTPvbsQg6f2ZRpZurUPY0i
         3vN8fSzgbZM7ZqqhP1xQeVclmuFWWcm85RH61J+3mbqlpyt8aqcfQlmN3a5hEeSYo9
         A9/PMGFQPisjt8E8dLbBy0s515thjXvb4uCmwmkfWVWi1JbJyfps7eUeyowIuZ2tav
         1Xr76yGN/X+2g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RwC1N6ylbz4xQS;
        Wed, 27 Sep 2023 07:04:56 +1000 (AEST)
Date:   Wed, 27 Sep 2023 07:04:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the arm-soc-fixes
 tree
Message-ID: <20230927070444.6e32666f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UKKWsB+fgoIqgqUDIVqhaHP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UKKWsB+fgoIqgqUDIVqhaHP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  4e7b558e320a ("soc: loongson: loongson2_pm: Populate children syscon node=
s")
  019d79fe6c3d ("dt-bindings: soc: loongson,ls2k-pmc: Allow syscon-reboot/s=
yscon-poweroff as child")
  59598d7ba6a8 ("soc: loongson: loongson2_pm: Drop useless of_device_id com=
patible")
  8e5f17483ab4 ("dt-bindings: soc: loongson,ls2k-pmc: Use fallbacks for ls2=
k-pmc compatible")
  9a7c9c7e34ac ("soc: loongson: loongson2_pm: Add dependency for INPUT")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/UKKWsB+fgoIqgqUDIVqhaHP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUTR2wACgkQAVBC80lX
0GwP3Af/ZB3Mwyrtq+Z5hfTR+IjkVMiXyhQDWDEukBn77zdg/OCfMAmKm9B9j9iZ
+ubOONuj9xYsizoXc5nO4ijOIYF3+uGZ/r49Zw74U0jeaEovyCP5EOYUt9FcMklM
1eBJGaYeRLodjYQVOdA7/bQE0CI665lN2LxYw46kTKllcf8cl3odbYL1Ie4zC6an
8DtCUWCYBYFoBRVEywrs3QtriWE6m26cHpaNruO/adQxMlQKSM1XR7eXIrduVRXw
BUHRWPD/ITQnJG8Now42pJgAYaV1d99qGY/sr2E9T8+fGbwjlh3O8P16To5IIu0K
9075aokTbVGyz8P/ebAouvhjf6tZWw==
=OpPu
-----END PGP SIGNATURE-----

--Sig_/UKKWsB+fgoIqgqUDIVqhaHP--
