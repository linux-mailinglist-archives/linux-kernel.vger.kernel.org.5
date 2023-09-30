Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE657B3F2F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 10:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjI3IYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 04:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjI3IYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 04:24:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FF1193;
        Sat, 30 Sep 2023 01:24:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFDBC433C8;
        Sat, 30 Sep 2023 08:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696062288;
        bh=tVyUW2/Llb+W/qFET2JU3P/a6fBrTrB+I3rZznDnELI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YGXjldCK4f9fuf1rWsYQkkR0H8cpVMnXfH1lbGPgproW4DD+VfSJ6Lwd30DpF720P
         9Vp852znHxR4v95u1oSFSqD/VitZFL4KOKQJtdQZUxUyZsy6ZIW3pVgcbKWRIt/u3y
         K6nKK9HlXgdLU5HhhN4RqeddUqJrNr6mNY/qsCj7HsoxiBE3PK1eNbuRwFFtN3RBGw
         a41UeB01LT7VnNoYz2FbXiCRTy6nZ0iMB79aWpEhL4RNsjaxmjLxTeFaCV74T6hzYw
         ypEY/YlvmZK81YatUZ7oEYYOPYlNxuFAWhaJkBUCVycj8fWsJZ5Cwk39SWs77smuuo
         NJVLG6D9Yx96Q==
Date:   Sat, 30 Sep 2023 09:24:43 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Edward AD <twuufnxlz@gmail.com>, alex@ghiti.fr,
        alexghiti@rivosinc.com, aou@eecs.berkeley.edu, guoren@kernel.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        liushixin2@huawei.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com,
        syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] Test for riscv fixes
Message-ID: <20230930-quotable-feeble-2bd6513ca643@spud>
References: <2023092939-lagoon-punctual-e312@gregkh>
 <20230929230534.45142-2-twuufnxlz@gmail.com>
 <2023093049-next-confusion-b812@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cfF1eFtx8bOxDQy6"
Content-Disposition: inline
In-Reply-To: <2023093049-next-confusion-b812@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cfF1eFtx8bOxDQy6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 30, 2023 at 08:13:56AM +0200, Greg KH wrote:
> On Sat, Sep 30, 2023 at 07:05:35AM +0800, Edward AD wrote:
> > On Fri, 29 Sep 2023 08:04:57 +0200 Greg KH wrote:
> > > Where are you getting your odd cc: list from?  This has nothing to do
> > > with serial drivers...
> > https://lore.kernel.org/all/0000000000000170df0605ccf91a@google.com/raw
>=20
> I do not understand this answer.

AIUI, the original report from syzbot "blamed" the serial maintainers.
Not too sure how it determined that though, given the contents.

--cfF1eFtx8bOxDQy6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRfbIQAKCRB4tDGHoIJi
0ilzAQDi2+NPYGC/Is2pX+75UwVFobtEeyrz+G3SXBYYCT86vwEA6P59KUJ3EaIQ
Bm68KQVpPYmZ5JA9t15s6C2YUYa9Jwg=
=+zdT
-----END PGP SIGNATURE-----

--cfF1eFtx8bOxDQy6--
