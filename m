Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5B47AF99D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 06:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjI0Eno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 00:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjI0EnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:43:01 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816563C07;
        Tue, 26 Sep 2023 21:03:45 -0700 (PDT)
Received: from [192.168.68.112] (ppp118-210-175-231.adl-adc-lon-bras34.tpg.internode.on.net [118.210.175.231])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4336120216;
        Wed, 27 Sep 2023 12:03:39 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1695787422;
        bh=zvBQOZmBgJD19HJPXvR2HTEHcUJHGXV6N2am+FBFV7k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Xmg6eoznLCKs8tJqaKA+AskPm5tjbluyWwqapgB6OONEpL7MCScbawR38Qm0jq8JX
         DlBPcVs05DUXgsL5y3Lyd/uwkajLg6i9o/R6s4ZJfbQAG1iWROPeyO2tWGRPuVLUb5
         PtVJhlsQm7QLlHm9A1sCaGj/pZl4RY39f7UcHWRGfYoZeyCZ4xipVjj16e+bxH7hWY
         Ld2RllvmJYwgSRO2uQnTObk6hlIJh60QrBNqHREarvP6sAslkFyomp1KAlr/6Xos6/
         c9NOw9CV/saOEulPaK6IkoNTZ68u9qob3raJzvTRzFSE67ieYyxfaHeUQ79O3XDciN
         FlbPTkIMHLI3w==
Message-ID: <acf1fb48ca1d4c5d2811c54e04a9c1e2e65779b9.camel@codeconstruct.com.au>
Subject: Re: linux-next: duplicate patch in the mmc tree
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Wed, 27 Sep 2023 13:33:37 +0930
In-Reply-To: <20230927134924.20dd7fb9@canb.auug.org.au>
References: <20230927134924.20dd7fb9@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed, 2023-09-27 at 13:49 +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> The following commit is also in the arm-soc-fixes tree as a different
> commit (but the same patch):
>=20
>   298df10391f4 ("MAINTAINERS: aspeed: Update Andrew's email address")
>=20
> This is commit
>=20
>   9c888dbf2164 ("MAINTAINERS: aspeed: Update Andrew's email address")
>=20
> in the arm-soc-fixes tree.
>=20

Thanks. I alerted Ulf to Joel picking it up here:

https://lore.kernel.org/all/7a7d5a7f19fc793f157508fec7fbc09ca8c4cc4b.camel@=
codeconstruct.com.au/

Sorry for the noise.

Andrew
