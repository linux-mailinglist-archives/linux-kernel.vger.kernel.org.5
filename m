Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9D080635B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346650AbjLFAV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346609AbjLFAVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:21:25 -0500
X-Greylist: delayed 2250 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 16:21:31 PST
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8DC1A4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 16:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=buserror.net; s=rsa_sel; h=Subject:MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Message-ID:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DZwB2POqwrd8X6LbQpzFj2/aL40ImBLV+vaLjDHtH1M=; b=M0POUctnsUN+d+fmAwVUWHXBZI
        5cVOFDODT4LsXnFWH4p8fm7f9RTqfvx7c/ndxpBWs2ZFEmItFqCE7nCLVoN09h58QrrBwrG3T/aVg
        OtEG1VtOWltsPlZjxZvZj7aKCwDjifGwxZrJl2iSaHFQR9AydQJE3g9e1yzPU24yPYkDIYbV7Gy9Q
        DaYUw7hr01kGbbb8sjkq3qNXAhDrkhWild/BIzcLpJBMm81Fp51M+ZutxsMM5ehvctK5BPzuCbuxL
        3nV0+J0flMFjbLvVajQW165IB34K2cd8Vyg3IN1GNykHmfr0+14F0yDB3aFrQpCupO6ZPYYwhwnns
        sHtUcyDQ==;
Received: from [2601:447:c601:5610::fed3]
        by baldur.buserror.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <oss@buserror.net>)
        id 1rAf0o-004kJT-0C;
        Tue, 05 Dec 2023 17:39:34 -0600
Message-ID: <ab212d9a4f35450e6575a0fe3aae01fb8e4709c4.camel@buserror.net>
From:   Crystal Wood <oss@buserror.net>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, christophe.leroy@csgroup.eu
Date:   Tue, 05 Dec 2023 17:39:32 -0600
In-Reply-To: <20231205051239.737384-1-mpe@ellerman.id.au>
References: <20231205051239.737384-1-mpe@ellerman.id.au>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2601:447:c601:5610::fed3
X-SA-Exim-Rcpt-To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, christophe.leroy@csgroup.eu
X-SA-Exim-Mail-From: oss@buserror.net
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH] MAINTAINERS: powerpc: Transfer PPC83XX to Christophe
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-12-05 at 16:12 +1100, Michael Ellerman wrote:
> Christophe volunteered[1] to maintain PPC83XX.
>=20
> 1:
> https://lore.kernel.org/all/7b1bf4dc-d09d-35b8-f4df-16bf00429b6d@csgroup.=
eu/
>=20
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
> =C2=A0MAINTAINERS | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 562d048863ee..d4efe48cc36a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12287,21 +12287,21 @@ S:=C2=A0=C2=A0=C2=A0=C2=A0Orphan
> =C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0arch/powerpc/platforms/40x/
> =C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0arch/powerpc/platforms/44x/
> =C2=A0
> -LINUX FOR POWERPC EMBEDDED PPC83XX AND PPC85XX
> +LINUX FOR POWERPC EMBEDDED PPC85XX
> =C2=A0M:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Scott Wood <oss@buserror.net>
> =C2=A0L:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0linuxppc-dev@lists.ozlabs.org
> =C2=A0S:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Odd fixes
> =C2=A0T:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git
> git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
> =C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Documentation/devicetree/bindings/c=
ache/freescale-l2cache.txt
> =C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Documentation/devicetree/bindings/p=
owerpc/fsl/
> -F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0arch/powerpc/platforms/83xx/
> =C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0arch/powerpc/platforms/85xx/
> =C2=A0
> -LINUX FOR POWERPC EMBEDDED PPC8XX
> +LINUX FOR POWERPC EMBEDDED PPC8XX AND PPC83XX
> =C2=A0M:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Christophe Leroy <christophe.leroy@=
csgroup.eu>
> =C2=A0L:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0linuxppc-dev@lists.ozlabs.org
> =C2=A0S:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Maintained
> =C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0arch/powerpc/platforms/8xx/
> +F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0arch/powerpc/platforms/83xx/

Acked-by: Crystal Wood <oss@buserror.net>

-Crystal

