Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877FA7D437F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjJWX6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJWX6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:58:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040FEDC;
        Mon, 23 Oct 2023 16:58:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784EEC433C7;
        Mon, 23 Oct 2023 23:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698105485;
        bh=/t/tBGw5PRdlAGp7oDynoHWPG06FsY5NVcPfGEH77OQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TKeotJMbAQ+apLrDuy59PDPaS7VRhTsTf0BY0u6qYQInHmK4S/D00eXlitNjJAK7S
         UrJKbE3v5QtrNMH9vHGHRN+UveWpVOfGdLeu4Qvya6pe1HLSH9rUCJDv0v19YfBGgr
         FOVnJ+ZlifQiaeLeiXHETlqsm2rnczIcQGdEipBJ9m4ZF2HJs7bNvRO/o9tTjcmrac
         mF8tBvlsSNh/wvTYFYSTHulgnKuIqtK5iBIDqNF+5Jjx7AwLeEUURLFF4+Uhq6P0NM
         wGurqC77IPE/N5nFSMoLT9xKd6hcwcF0kImV0ZpiZTSAfVOaMxkv17knl9Y2A4jNn/
         8MQblUdhg/rjg==
Message-ID: <c2f1d7094e6076bed14d4be5a4ed1828.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231020153711.1979439-1-abel.vesa@linaro.org>
References: <20231020153711.1979439-1-abel.vesa@linaro.org>
Subject: Re: [GIT PULL] clk: imx: Updates for v6.7
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>
Date:   Mon, 23 Oct 2023 16:58:03 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2023-10-20 08:37:11)
> The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d=
1d:
>=20
>   Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/=
clk-imx-6.7
>=20
> for you to fetch changes up to 2838820800dcaa60f32bef715c7e2e87e049aebc:
>=20
>   clk: imx: imx8qm/qxp: add more resources to whitelist (2023-10-04 15:44=
:19 +0300)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next
