Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1FE78B8F5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbjH1UBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjH1UBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:01:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34601BE;
        Mon, 28 Aug 2023 13:01:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F66764E49;
        Mon, 28 Aug 2023 20:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6E6FC4339A;
        Mon, 28 Aug 2023 20:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693252823;
        bh=mVb12YlTB6xVrBKuueakgwHjYap7/xn1tlPXAoVeLh0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=REUtadEdIKVwoDCJ/a1eUZkU83UaCBIfV2VMcN0SNO0fZjsvHR5Y7AUxuTnwYQ98B
         GJ3p6H8VamIr89XSQeew2xtU/3OGyjMnBol2wbYogiUvH/8I+yRAEX+dTxFub11xKN
         qTiDuxIVEXG6N2z56dErThkHom8jSe1xl7NUWqfRCVX+osReQFJ/fkAKiu4miVCuck
         UByd5jMsS7KfpJGB9t3xIYA4HoteaKWeL520eEEYKxO4yxaUOT0CqSNBeIi/EoIOB5
         rxUGSGSj4JUv4eYNIRu5cQfIEjm/IXI4jTaCKtDWlf0EbNs8fzVLLOokQPFVfiw2uv
         Ly0YPT6+rnBlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E8F4E33082;
        Mon, 28 Aug 2023 20:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8152: add vendor/device ID pair for D-Link
 DUB-E250
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169325282364.23387.4944546099448167756.git-patchwork-notify@kernel.org>
Date:   Mon, 28 Aug 2023 20:00:23 +0000
References: <CV200KJEEUPC.WPKAHXCQJ05I@mercurius>
In-Reply-To: <CV200KJEEUPC.WPKAHXCQJ05I@mercurius>
To:     Antonio Napolitano <anton@polit.no>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 26 Aug 2023 01:05:50 +0200 you wrote:
> The D-Link DUB-E250 is an RTL8156 based 2.5G Ethernet controller.
> 
> Add the vendor and product ID values to the driver. This makes Ethernet
> work with the adapter.
> 
> Signed-off-by: Antonio Napolitano <anton@polit.no>
> 
> [...]

Here is the summary with links:
  - [net-next] r8152: add vendor/device ID pair for D-Link DUB-E250
    https://git.kernel.org/netdev/net-next/c/72f93a3136ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


