Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1607D77D562
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240385AbjHOVtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240400AbjHOVtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:49:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F911FDB;
        Tue, 15 Aug 2023 14:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692136143;
        bh=d5IsiqXRWLx1VKIbHEYqMpk/M7+uphSJGWI5OXEgIws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SHSO39eRn7aFzGKfmcMYQbUaqrF7D/4IthEkxFwMs958DpHNfWs5MDORAoNez3HxB
         qZ1EkXyQ1NiMjf47ayMe/sjJSaNwYbwNUMW/OwbObvjkgHOvsNRlFNfGhqz+LdYAy8
         kUzBxZT28nmKpZ2Ctkkv+1fcnG04O1rPu+Tsy0sPDzCvSflklgUeigxA2dYLLQCKHB
         WDQKS2IfhoNwOskNvOUbE39h4iWXsK7LqK5gGMioK3XfYUUp2qCJTmWHKgl2/wW4Nk
         PSiivbk04QQZTGMbbfZ8+4HOkqm/Voj8wdiQzY3EBrrPiO7dk6EJEWNetCHJ9gAzuw
         9sI0OnD0aE+rA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQPzf3fxsz4wZs;
        Wed, 16 Aug 2023 07:49:01 +1000 (AEST)
Date:   Wed, 16 Aug 2023 07:48:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: linux-next: manual merge of the i2c tree with the
 i2c-host-fixes tree
Message-ID: <20230816074845.1d976283@canb.auug.org.au>
In-Reply-To: <ZNslVp/UM1EUeOBi@shikoro>
References: <20230815115735.04151abc@canb.auug.org.au>
        <ZNslVp/UM1EUeOBi@shikoro>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pfu67BYw.H7F/utLAzWUXFt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pfu67BYw.H7F/utLAzWUXFt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Wolfram, Andi,

On Tue, 15 Aug 2023 09:12:22 +0200 Wolfram Sang <wsa@the-dreams.de> wrote:
>
> > from the i2c-host-fixes tree and commit: =20
>=20
> I think it makes sense to drop i2c-host-fixes and i2c-host from
> linux-next again. Andi kindly helped out while I was on an unplanned
> hiatus. But now I will populate my own branches again (with largely
> pulling in Andi's branches). Thank you for the quick inclusion of his
> branches and to Andi for helping out!

I have removed Andi's trees.  Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/pfu67BYw.H7F/utLAzWUXFt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTb8r0ACgkQAVBC80lX
0GxRSAgAga/WpmmksPxKfKbf2iPB24AIBagxSNsmQ6jwUKhyQwiKiGocORSAyL0z
b8Ok6XTlxsvGsPcg+ulJRk7Jjg10wtikG1AJksMy/7ORwhQuwsAInPKMzWy2wZgU
UUCvuYV4NDwObKFzlSqFFmS2Lp4SvWlMWV5nvQSh1Tqr7v0BkjXhpPvHe7llw0lV
qN9C+MEOE/wSO+0dYvVdlAEjpiZ8rXV8xBVqJY4ktbMe6s6DxBc5yiJzSaF4IERs
pwNwGIG1Lg7RkO3W6TrrQzakRT/m0xTqKJbksW4DYwx4p+1kJgjaKlhCGMnRCMyG
9It4KwH1rbLJ1/R27Y/+tgvlVMKidw==
=vi9w
-----END PGP SIGNATURE-----

--Sig_/pfu67BYw.H7F/utLAzWUXFt--
