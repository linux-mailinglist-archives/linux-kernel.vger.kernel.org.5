Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F12781BD2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjHTAgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjHTAgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:36:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCD3234611
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 11:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A19ED614F3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 18:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2D9EC433C8;
        Sat, 19 Aug 2023 18:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692470062;
        bh=Y4Zns78+cJfLS978OPLxTr9B/6Op6cnG5Zjax3Kt1Zg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=u9EzD78DeXlOj+JCB41gMuZxgbeVmUGOdwBrT8HrI/UD6IyLgtDaHI/zhez/PIj7w
         VoLcaAK/eb+pUcbQQI9e40CuKvkVwKBsP4bC0rX/lP8ASoVCjxAJQM4eq34GF3wn5u
         klxT0PbaauGrQV3CwQCfK1Tn9cNt/ugRbpTnZI4MD3MZujF7Mj9Bz/yfnrGZtIfVOb
         vWP62fbcTPDSb/E5nxdYiqA5oq5DTJiboeo+cORBqrmo133A2M7UTPjM6FeaYFjNi/
         J3zXRb2jHRZFyaIMifKg7CvT63R/ik+rw6XwYhNovS3YiPTQDjTv1e7rPtuixIgmFY
         y7eTv7p2AJWTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9B94C395DC;
        Sat, 19 Aug 2023 18:34:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: sfp: handle 100G/25G active optical cables in
 sfp_parse_support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169247006188.18695.13360615227785939934.git-patchwork-notify@kernel.org>
Date:   Sat, 19 Aug 2023 18:34:21 +0000
References: <20230818110556.10300-1-josua@solid-run.com>
In-Reply-To: <20230818110556.10300-1-josua@solid-run.com>
To:     Josua Mayer <josua@solid-run.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 18 Aug 2023 13:05:56 +0200 you wrote:
> Handle extended compliance code 0x1 (SFF8024_ECC_100G_25GAUI_C2M_AOC)
> for active optical cables supporting 25G and 100G speeds.
> 
> Since the specification makes no statement about transmitter range, and
> as the specific sfp module that had been tested features only 2m fiber -
> short-range (SR) modes are selected.
> 
> [...]

Here is the summary with links:
  - [v3] net: sfp: handle 100G/25G active optical cables in sfp_parse_support
    https://git.kernel.org/netdev/net/c/db1a6ad77c18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


