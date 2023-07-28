Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D836766D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbjG1MbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjG1MbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:31:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDD0187;
        Fri, 28 Jul 2023 05:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B4426211C;
        Fri, 28 Jul 2023 12:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEFBC433C7;
        Fri, 28 Jul 2023 12:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690547467;
        bh=Nj0zw8vR3anl+klmVVcRaCA7lVBhFxRXifCuOKSv6Bo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OXPs84E3q2626NAIAoGnXlO52X437o+Zgx+ErQosWrGhEctxD70pXEHNAl+tbqLbB
         xilhSu/OGz3gOy4He5fuqkvb9tQ0f9P/qpHTNQkfvIJrmX4SxLNAKWrdn0gSX+EAHI
         jIP2yvu9vG/Xdyaj+68snbhb2lRpa/M7mEhP53rkPTIdo+VQh1vrdcgX05Olc7KPh9
         1ov92wT+iIzt4F7mexd8fVFPkcb5EiDq+DBnAUgpnm0XIu6uSViPAAUFeXeGcUBkA6
         m14NVli3gg4/fWRB+wuf9FO//plEeUQnQ/JoFfa8wwfgzLgBDjkhDpM6pm6JuOpzhK
         oI+ZGpST0kmHg==
Date:   Fri, 28 Jul 2023 13:31:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v13 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Message-ID: <67b74e69-f660-43e3-831f-47dbe0fea6fa@sirena.org.uk>
References: <20230613075834.5219-1-zhuyinbo@loongson.cn>
 <20230613075834.5219-3-zhuyinbo@loongson.cn>
 <3822f248-39dc-fb8d-321a-7b6c833cbb3e@loongson.cn>
 <2264c9bd-76fb-4a99-b655-f4c7bc2a1d45@sirena.org.uk>
 <8ad55123-fbf2-2b0f-faba-f71bb89c7fb1@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7U7txTj5uibwo7Uy"
Content-Disposition: inline
In-Reply-To: <8ad55123-fbf2-2b0f-faba-f71bb89c7fb1@loongson.cn>
X-Cookie: Ontogeny recapitulates phylogeny.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7U7txTj5uibwo7Uy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 11:36:48AM +0800, Yinbo Zhu wrote:
> =E5=9C=A8 2023/7/27 =E4=B8=8B=E5=8D=887:37, Mark Brown =E5=86=99=E9=81=93:
> > On Thu, Jul 27, 2023 at 11:09:16AM +0800, Yinbo Zhu wrote:

> > > Friendly ping ?

> > Please don't send content free pings and please allow a reasonable time
> > for review.  People get busy, go on holiday, attend conferences and so
> > on so unless there is some reason for urgency (like critical bug fixes)
> > please allow at least a couple of weeks for review.  If there have been
> > review comments then people may be waiting for those to be addressed.

> Sorry, my community experience is poor.  How many weeks does the
> community usually take to review ?  and this time that I waited for six
> weeks and then ping.

The delay here is probably fine - the above is a form letter that I send
whenever people ping so it tries to cover all eventualities.  How long
to leave things depends a bit on what the change is, an urgent bugfix is
going to be different from a spelling fix in a comment.

> > Sending content free pings adds to the mail volume (if they are seen at
> > all) which is often the problem and since they can't be reviewed
> > directly if something has gone wrong you'll have to resend the patches
> > anyway, so sending again is generally a better approach though there are
> > some other maintainers who like them - if in doubt look at how patches
> > for the subsystem are normally handled.

> Sorry, I don't got it, that free ping usually only needs to be sent to
> the subsystem maintainer?

> Not recommended to use free ping?  or resend the same patch.  If the
> patch does not need to be modified, does it require sending the same
> patch ?  And the version number remains the same?

I'm saying it's generally better to ping by resending the patch.
Typically keeping the same version number makes sense when doing that -
people normally say [PATCH RESEND vN] in the subject line.

--7U7txTj5uibwo7Uy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTDtQEACgkQJNaLcl1U
h9D8Igf/ZpPacjeh9QRNEG3bvMLlU/a3Vdbx4DdcpupG1gSpuhy2lizUJfwHaVK/
76xQ+6RxZFWPcDI+ByRA6BHOwAtTDL9GftStWiY5o5UlgKgZPiJmWMN6D3LzSGfo
F0vERJH+30RbApNL8/uRBI87BT91ntltfFGYHdy/p03HDbcW+QP8iq4SaxI9rJ/h
SXSWcqWMU+rs+5o1S/G+skY9mF4WFWNbKQ/WGgK96sunSwbUnOzzWveYjuPp57ye
Apo16/DPTT9sAzVTUD2VggxdJQ5W/aFrVpU/cfexHJ7MWaeClizbSRBq5LpGDwbS
wajz6MmqKfb1SDsu6z7z6TLvLGN9bg==
=66ff
-----END PGP SIGNATURE-----

--7U7txTj5uibwo7Uy--
