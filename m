Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F080779892
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbjHKU3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjHKU3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:29:47 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA211AE;
        Fri, 11 Aug 2023 13:29:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 206164A2;
        Fri, 11 Aug 2023 20:29:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 206164A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1691785787; bh=mEUiyNT+Ns8Fvn0A6avXQeEEnfY1/ZuoD/njqfIEB4o=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EhFhf4zrtvW9dkB+/rsikF8gUp9/lIkLbxej+ZboAzozutgmsfvsRUItU8eTg+22p
         fx3NAXNeGk6GYN3HRYBwQYHBM+7pvAncuY1n6KPffTH5qIe6Vgr5dxQxRT+5gDZS1V
         vWMau+1JaZ865pOECR2KdIDTWCW1F2ij9V6cOjenZFvV06TogL0E7pjPLYxLg4mDDe
         k2aEfsOPHAwTApxrMdQl4chIB7xZ9h+WM/XVOPvP9L2uUWXodrlGz1+p7kV8J3BaYE
         ma12vd77vX50+5i7+FSc2lRwMcAwJwxEkdi+ZtPN125m3iVjqXmzJtkQWMppvi57Or
         TZEOvkrWzE5Qw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Min-Hua Chen <minhuadotchen@gmail.com>,
        Hu Haowen <src.res@email.cn>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: sparse: fix invalid link addresses
In-Reply-To: <20230804112320.35592-1-minhuadotchen@gmail.com>
References: <20230804112320.35592-1-minhuadotchen@gmail.com>
Date:   Fri, 11 Aug 2023 14:29:46 -0600
Message-ID: <87pm3txqyt.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Min-Hua Chen <minhuadotchen@gmail.com> writes:

> The http and git links are invalid, replace them with valid links.
>
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
> ---
>  Documentation/translations/zh_TW/sparse.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/translations/zh_TW/sparse.txt b/Documentation/=
translations/zh_TW/sparse.txt
> index c9acb2c926cb..6d2d088b1060 100644
> --- a/Documentation/translations/zh_TW/sparse.txt
> +++ b/Documentation/translations/zh_TW/sparse.txt
> @@ -66,11 +66,11 @@ __bitwise"=E9=A1=9E=E5=9E=8B=E3=80=82
>=20=20
>  =E4=BD=A0=E5=8F=AF=E4=BB=A5=E5=BE=9E Sparse =E7=9A=84=E4=B8=BB=E9=A0=81=
=E7=8D=B2=E5=8F=96=E6=9C=80=E6=96=B0=E7=9A=84=E7=99=BC=E5=B8=83=E7=89=88=E6=
=9C=AC=EF=BC=9A
>=20=20
> -	http://www.kernel.org/pub/linux/kernel/people/josh/sparse/
> +	https://www.kernel.org/pub/software/devel/sparse/dist/
>=20=20
>  =E6=88=96=E8=80=85=EF=BC=8C=E4=BD=A0=E4=B9=9F=E5=8F=AF=E4=BB=A5=E4=BD=BF=
=E7=94=A8 git =E5=85=8B=E9=9A=86=E6=9C=80=E6=96=B0=E7=9A=84 sparse =E9=96=
=8B=E7=99=BC=E7=89=88=E6=9C=AC=EF=BC=9A
>=20=20
> -	git://git.kernel.org/pub/scm/linux/kernel/git/josh/sparse.git
> +        git://git.kernel.org/pub/scm/devel/sparse/sparse.git

Applied, thanks.

jon
