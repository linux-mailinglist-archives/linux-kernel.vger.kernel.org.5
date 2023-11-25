Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138797F882A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 04:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjKYDaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 22:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYDaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 22:30:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D90E10F0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 19:30:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EB48C433C9;
        Sat, 25 Nov 2023 03:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700883026;
        bh=lY6sBXiYG4cE/+ICfKFltmSOGZryOxK/ha8O52YXMOI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Y/5GoifKHbu6UQgI2m7EAm/tXHQLXt3HDrv4s8lMlgB2e9PCqfIQc78Gghmvx4mp/
         QVYquq6yiOj+FB4XeRrJaYRpNVCKkB/86WiH19LzOTIa4aE7ANoigY8GdjcrSpv1HD
         K+o9f6bJuGRsvYfT9S2rokH1KNvCsUROfYkghMhhC2AJFyUaurH1d+pAq0g3XKnC6y
         Jy/81pO3wCUg3bHroSfO/6FZq/4RlePGCBLdH0NDGk+37OXemg9K4GqmPwv0HUqqXu
         i1tPAp5LlmqOM/kkjPtPaIbZvqvQUa8bm4fr3Vl2AojwUVxLPXIBqZDV0ZFRFJwsTT
         3YAGzR9cBOjjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03259E00086;
        Sat, 25 Nov 2023 03:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] firmware_loader: Expand Firmware upload error
 codes with firmware invalid error
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170088302600.4689.10780084312021094522.git-patchwork-notify@kernel.org>
Date:   Sat, 25 Nov 2023 03:30:26 +0000
References: <20231122-feature_firmware_error_code-v3-1-04ec753afb71@bootlin.com>
In-Reply-To: <20231122-feature_firmware_error_code-v3-1-04ec753afb71@bootlin.com>
To:     =?utf-8?q?K=C3=B6ry_Maincent_=3Ckory=2Emaincent=40bootlin=2Ecom=3E?=@ci.codeaurora.org
Cc:     kuba@kernel.org, mcgrof@kernel.org, russ.weight@linux.dev,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        thomas.petazzoni@bootlin.com, linux-kernel@vger.kernel.org,
        conor@kernel.org, andrew@lunn.ch, netdev@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Nov 2023 14:52:43 +0100 you wrote:
> No error code are available to signal an invalid firmware content.
> Drivers that can check the firmware content validity can not return this
> specific failure to the user-space
> 
> Expand the firmware error code with an additional code:
> - "firmware invalid" code which can be used when the provided firmware
>   is invalid
> 
> [...]

Here is the summary with links:
  - [net-next,v3] firmware_loader: Expand Firmware upload error codes with firmware invalid error
    https://git.kernel.org/netdev/net-next/c/a066f906ba39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


