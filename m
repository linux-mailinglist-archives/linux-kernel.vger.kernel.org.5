Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2A4760172
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjGXVnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGXVnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:43:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B601AE5C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690234987;
        bh=NrzVc/i4T2s/8qcDDh2tQgZ3WQeRPTW+25Vf8UWH/yU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V93OTEf46JPwxMlRtoLomdtcCrjD0hHoWwLgUGRHrnuyiuMRcYYQPiJPCIQVzAMsp
         ZB5dnKLUdPaFOchq+tooxI/ujIFBQswer41kfpt19ERafcmQF33xOu7/WZI46P+F8Z
         PNRk31vDnjakBQk/3p9krydksR3t9CArYCZEhAwGTTbTTCn21/OLpR+yugHv0CAVEj
         tDVNvbqaXR0Sv03YZGMgS/LDMkWcJ/vx3UnfglcBfw3ol3k0+u2an7x57EaI/Ntm1W
         S1aqAN4T77jEkOrohSMvxRJES0588O1dAqxLUspCKhQhhXsOXpf/gDICoV/UJ+yEhS
         3ucTvzmHtWsWA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R8tty3SLGz4wqX;
        Tue, 25 Jul 2023 07:43:06 +1000 (AEST)
Date:   Tue, 25 Jul 2023 07:42:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     paulmck@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Upcoming nolibc pull request for the next merge window
Message-ID: <20230725074250.6de92c7b@canb.auug.org.au>
In-Reply-To: <5cc3d6df-42b0-8275-705f-405dc48f3711@linuxfoundation.org>
References: <7afafb6c-9664-44a1-bc8f-d20239db1dd5@paulmck-laptop>
        <20230722130120.6e4c0eab@canb.auug.org.au>
        <2c54d017-226e-41c3-a767-a607942ecba5@paulmck-laptop>
        <5d9f724d-4c45-f843-04b3-60a907b9b127@linuxfoundation.org>
        <b15fa4c4-cb1f-4bf6-af04-5d549f326f95@paulmck-laptop>
        <5cc3d6df-42b0-8275-705f-405dc48f3711@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EJPS3mLBbOH5VHxuv=K6dHH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EJPS3mLBbOH5VHxuv=K6dHH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Mon, 24 Jul 2023 09:37:51 -0600 Shuah Khan <skhan@linuxfoundation.org> w=
rote:
>
> Stephen, would you like me to send a formal request to add
> linux-kselftest nolibc to next?

Yes, please, just so I am clear about the git URL and who should be the
contacts in case of issues.

--=20
Cheers,
Stephen Rothwell

--Sig_/EJPS3mLBbOH5VHxuv=K6dHH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS+8FoACgkQAVBC80lX
0Gz+GggAn+Jx6fRONFGmjlBTP9fWSrEsjXk1opD9ihMMbXG592jSmuxZq7+Zkhe0
O5VF9yi5B5MnlrR6bsvN/2a8QOsLe3lnqU2mH6etLk4JxId9JWLI0a0INdF7vi+O
Ns4r//v7hAAxFsU9gO8d54VVSflIQz0Z+ETh/shSb//0h2v/SGbz6HIEbG+WudQK
1xvOjiLOY90xgashoyTP37kBFhH3Hf0Sy/c+LsBA5twBnnVuRS/dTEm3X22DQvct
5eqXWW/TDozxpgaM7vcWd8gZl6OtLrogEnRmSl/ezmEbF/GLysfoF21HA7FSJmS5
cWb16U/+vMPChWomHm/7Dx1ztdR9Vw==
=t0dW
-----END PGP SIGNATURE-----

--Sig_/EJPS3mLBbOH5VHxuv=K6dHH--
