Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AC3791A1B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353171AbjIDOzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353154AbjIDOz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:55:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3573A9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 07:55:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36B4AB80E6A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 14:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F79C433C7;
        Mon,  4 Sep 2023 14:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693839322;
        bh=lSogzzno6crleiVA2VrKeMQYvVrENZwQWRFLzD0t5zk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=r00O1+cxAhpSXvL+ZVTK+TiHOtncmOR8xJX7ex72LTI5P8BwA7PjlI0k/NJ9nq/Ld
         pgwY0FBX1yjqY7gC7GgPb6svDlZryNmJvrWJtaRV9AnAIRadMeoZA5zIgEsHfvqErh
         jGio5NRPDPoG4ysGoypukk4Hl9VXnUcI/TmTDrMFnGsJeOmDDSc20VuFhwQCcggWxL
         3sO1CK+gB69p1r7FUq3EyO4WUeyYGKmIepB6mbWzs5wsJtcdaud9V1JmA6l4cR3UkY
         1FVa0zhXZ8DLO/yfyHa7HC062R7yAEQ5ic+tYFeUqHUp1LWZEnBc5nhwnyX5mCLbEV
         8IXBfByvaM4iw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Shubh <shubhisroking@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230902150807.133523-1-shubhisroking@gmail.com>
References: <20230902150807.133523-1-shubhisroking@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Add DMI entries to support Victus by HP
 Gaming Laptop 15-fb0xxx (8A3E)
Message-Id: <169383932048.34217.18361652872072310930.b4-ty@kernel.org>
Date:   Mon, 04 Sep 2023 15:55:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Sep 2023 20:38:07 +0530, Shubh wrote:
> This model requires an additional detection quirk to
> enable the internal microphone.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add DMI entries to support Victus by HP Gaming Laptop 15-fb0xxx (8A3E)
      commit: d1cf5d30b43f1a331032ebf3e11d9e366ab0f885

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

