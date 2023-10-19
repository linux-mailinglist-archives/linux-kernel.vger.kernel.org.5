Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594177CFF28
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbjJSQK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345037AbjJSQK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:10:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D54A124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:10:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9B79C433CC;
        Thu, 19 Oct 2023 16:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697731824;
        bh=BE/4wyJzn7vqO89mbnyTMDJ6LgXLjJtglZRTGIZ98Lk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=O0PDjHslPWAMHNN4aF8/IAecO1ZQWt/JoKB5AETbSUvQ96Og4SvHXWY3j91yqxw7f
         Bt6D358sBjNeI9D+WfCm8eiepZ5xoMjJV5J4Vi7ES4PqgV+YBVIERzBjztMT8Oi4VY
         uHO1lEOLmN5wjD/hiHMYMkFvjIQSlU4YW3Hnw52EiGkMNNblFCnJS0eXVSPDVGyjNo
         tYY+XknbRmrwn6Tq4zZD/LfaUf71s53f5nF8oIPT4ddUpmeXETE0KNqBuvlZ/7JaFU
         +XquT1KJb89B4kpOWHHTfP7z0Mig/D3uY352JBWIqxJ/6S1e74T/LM0GgfXAHVUs42
         qvq76xZbPAbMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2C9FC73FE4;
        Thu, 19 Oct 2023 16:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] i40e: Align devlink info versions with ice driver
 and add docs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169773182385.32102.13500484487081368542.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Oct 2023 16:10:23 +0000
References: <20231018123558.552453-1-ivecera@redhat.com>
In-Reply-To: <20231018123558.552453-1-ivecera@redhat.com>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     netdev@vger.kernel.org, jacob.e.keller@intel.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, corbet@lwn.net, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org
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

On Wed, 18 Oct 2023 14:35:55 +0200 you wrote:
> Align devlink info versions with ice driver so change 'fw.mgmt'
> version to be 2-digit version [major.minor], add 'fw.mgmt.build'
> that reports mgmt firmware build number and use '"fw.psid.api'
> for NVM format version instead of incorrect '"fw.psid'.
> Additionally add missing i40e devlink documentation.
> 
> Fixes: 5a423552e0d9 ("i40e: Add handler for devlink .info_get")
> Cc: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net-next] i40e: Align devlink info versions with ice driver and add docs
    https://git.kernel.org/netdev/net-next/c/f2cab25b0eb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


