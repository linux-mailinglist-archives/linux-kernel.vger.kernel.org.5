Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F367EAF51
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjKNLjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjKNLjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:39:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61330D9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 03:39:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE51C433C7;
        Tue, 14 Nov 2023 11:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699961947;
        bh=whBGpcG47xVNRfzEEzDm3fJ5D0wWUem1/axCjyGCLGI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eJx97K7FXBh/W6uOU3lXCslzPXCfkDabOUXMKzpdNQAet6sVCJoGaMnx6OuWkPCxA
         QTqWg3EvseZkQInBprXqqWFrEOXou56XHRuu+iZU1ZqAFT+5THj3U7d0yKAXCTLZp+
         3z6bjc1dgOXecF99Q2fQ2qDN+verUSjl/06p0VmSDGg3oBpQhq8g40K0wkrkhvSEni
         FNZih164O3iRJ+TIyFsQKpa5ncdfS9x2HuYo8poIxs56lsrQh9zbfxzUw14Nq5jlqJ
         1TuWDnWhaa3BAQvC6R4i17glDK00uGm6pqZ2OhnGx2tXbOfAVIOXV2/KJCaQUzFeU5
         0DfQnquWzpVvw==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, mario.limonciello@amd.com,
        richgong@amd.com, posteuca@mutex.one,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20231113123345.2196504-1-Syed.SabaKareem@amd.com>
References: <20231113123345.2196504-1-Syed.SabaKareem@amd.com>
Subject: Re: [PATCH V2 1/2] ASoC: amd: acp: add Kconfig options for acp7.0
 based platform driver
Message-Id: <169996194304.29934.12872019600831589638.b4-ty@kernel.org>
Date:   Tue, 14 Nov 2023 11:39:03 +0000
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

On Mon, 13 Nov 2023 18:03:42 +0530, Syed Saba Kareem wrote:
> ACP7.0 based platform legacy drivers can be built by selecting
> necessary kernel config option. This patch enables build support
> of the same.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: amd: acp: add Kconfig options for acp7.0 based platform driver
      commit: d3534684ada99ef8c0899eb28c62b4462483ee19
[2/2] ASoC: amd: acp: add pm ops support for renoir platform
      (no commit info)

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

