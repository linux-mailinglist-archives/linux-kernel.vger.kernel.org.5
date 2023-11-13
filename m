Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9952F7EA3F6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 20:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjKMTmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 14:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjKMTkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 14:40:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54846173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 11:40:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094DCC433BD;
        Mon, 13 Nov 2023 19:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699904437;
        bh=RVxhWwg82afEMJHueW4OaWFavI/1nAFsbaehh8o1Yz4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=um6Jo+WtEH+iX8Oww51WgbJ9ClcSvtmbfJGPo6SQZMDlmITSdk969ICO54+rFj5li
         Rk8AfupR+mzUrq3QmAZ5sDuY9DBRkPRukn73WdCilLXipKwz4Ub0vHADNJ2Odwz3yK
         w18IhnZBgQLXmObpaaMGl9gwruOaKor5kNd0jQIOjbMANAKTHCWRKxE4LQwFGAlPxP
         tUk6M29vgJ/GuVElRxmqlkD8eFIw18CuNboL8bu0/D80qA6oRqPeiwLQF6B7fiRGef
         HSmh3JMbN06clPuK7ZeeKNsGLWNUAOlmBK20ZT8UXUHNOefU/jR0qGukI9V8fR5TOl
         m3EewF57gh3kQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20231109073925.98783-1-jiapeng.chong@linux.alibaba.com>
References: <20231109073925.98783-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] regulator: stpmic1: Fix kernel-doc notation warnings
Message-Id: <169990443535.3294075.12856282804446124490.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 19:40:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Nov 2023 15:39:25 +0800, Jiapeng Chong wrote:
> No functional modification involved.
> 
> drivers/regulator/stpmic1_regulator.c:31: warning: expecting prototype for struct stpmic1. Prototype was for struct stpmic1_regulator_cfg instead.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: stpmic1: Fix kernel-doc notation warnings
      commit: e1eb745006ac484427fca14feb27d79a71c3770d

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

