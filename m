Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B10F767A7F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 03:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbjG2BKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 21:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjG2BKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 21:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7EB35A3;
        Fri, 28 Jul 2023 18:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3551F62227;
        Sat, 29 Jul 2023 01:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CEF0C433CA;
        Sat, 29 Jul 2023 01:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690593021;
        bh=0bXB1gjnWbl77v7JpiMO5Sd7N2sWFuDWIVG3G+aBWvE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QY8pFa1mKlxRsEMydCMNm6a1yf/gtlpq5jwqUrnX5d8vapnceixgL9yj2DEaBmI1H
         ggMtcoVg96n7szvYvlgxTDqMva2ObrJhm+El6V1iJO8nUJTiFrdgQhnjMAYemLzRKl
         XmvFRrE84BYxrRkkhUrNwSU25kml0SBkQkbgOIfxrbFbuKK0YaMJTsVkVbORmaoKRw
         HoJQMV8eDDEu4NyiQhVqF/5X/nS3CXfEnWr5Lk/l3h5W5F8topd/y0Id5QJTnPyucj
         XW4OSKwe3TvCLL167ZaqA/Ipu5g3UBsy4Wof6EMsNX9CUQyoz/8b71zXh7Cj/nacoo
         o44uYkCWt1UHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A69BE1CF31;
        Sat, 29 Jul 2023 01:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] r8152: reduce control transfer
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169059302149.26009.9262284677356277688.git-patchwork-notify@kernel.org>
Date:   Sat, 29 Jul 2023 01:10:21 +0000
References: <20230726030808.9093-417-nic_swsd@realtek.com>
In-Reply-To: <20230726030808.9093-417-nic_swsd@realtek.com>
To:     Hayes Wang <hayeswang@realtek.com>
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        nic_swsd@realtek.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 11:08:06 +0800 you wrote:
> v2:
> For patch #1, fix the typo of the commit message.
> 
> v1:
> The two patches are used to reduce the number of control transfer when
> access the registers in bulk.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] r8152: adjust generic_ocp_write function
    https://git.kernel.org/netdev/net-next/c/57df0fb9d511
  - [net-next,v2,2/2] r8152: set bp in bulk
    https://git.kernel.org/netdev/net-next/c/e5c266a61186

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


