Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A31784946
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjHVSL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHVSLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:11:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E9C91;
        Tue, 22 Aug 2023 11:11:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B24C5624AA;
        Tue, 22 Aug 2023 18:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11332C433C8;
        Tue, 22 Aug 2023 18:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692727883;
        bh=PpEsCO451SAL/xtdgVeiHvsyVVds+JoKDN1u144B4hY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hzp/PAQkovjoO9CNCdIPuXGgmlAPQOPrljEGU/GfK5CSe/Bm+JWGx05bCw+CHmHVZ
         1thC5d6f1KimAc9zzcz97IHsL6iMR2pD7TNBYxYUNij58svjwoORpheWm4OnFG8GBR
         yZrh2mWLDnZuu8bl7HAeXrC8CzRDepXyxfCviLsiEG9ONb2ZCGJeDrEdyEgEEAwL8D
         Aj0iHLbpLoV2Y2Uo1xMTgW/Qft3EbiDcmlXc/kn+gJP2ysn+jAtV+xQOYiaABxk07O
         Ac1ki3uBn/tqORwpwlV6f+7sI19/aPFxUvcvvJToHfUEUbbbT4HCaMY8ZyIQObcwVY
         eOnQzKrmA2vTQ==
Message-ID: <90bfac48e9b6b074420a213923119535.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230816101120.885812-1-abel.vesa@linaro.org>
References: <20230816101120.885812-1-abel.vesa@linaro.org>
Subject: Re: [GIT PULL] clk: imx: Updates for v6.6
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>
Date:   Tue, 22 Aug 2023 11:11:20 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2023-08-16 03:11:20)
> The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaa=
a5:
>=20
>   Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/=
clk-imx-6.6
>=20
> for you to fetch changes up to 72d00e560d10665e6139c9431956a87ded6e9880:
>=20
>   clk: imx: pll14xx: dynamically configure PLL for 393216000/361267200Hz =
(2023-08-14 12:52:32 +0300)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next
