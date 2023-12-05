Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1148C80558E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345191AbjLENLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbjLENLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:11:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150BE194
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:11:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AB5C433C7;
        Tue,  5 Dec 2023 13:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701781916;
        bh=Z6h5KHVxXcZwqHJ9jYxohUKf3Szok2IEy9KLPl804z4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AkvoYi7rwPmXQztcDTJXAx9e+WnZuqjVic1N58LVCOgq96vWWcFKbYSadK7vToQq8
         cBk6dhtxSu8cU/bWwkzY/pW6NMtENaVWUvIRBHexZdGt10E9PgrADtv6gg0GDP2GzJ
         k1IwJoamsVLpzQXcbg62lD8UPOKjO1sK/qBRF4sbEyvvFd1vfcSk+AKp6i02rFiSMO
         2BCuhrreNOL10weBA99XVKa8TD8YWPd9Bs2+CgD2V3WdZrSgj2eJWjolhqJa6MyQwL
         LSDPMCZ8NqLVfSp9UlxLdJB0M4y7+EywCapfe0KRzN5TQW0QlqUxd0+Adzt5m65XDD
         vV8W/sdXPywOg==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     kai.vehmanen@linux.intel.com, cezary.rojewski@intel.com,
        ranjani.sridharan@linux.intel.com, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20231204135614.2169624-1-rf@opensource.cirrus.com>
References: <20231204135614.2169624-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH v3] ASoC: Intel: soc-acpi-intel-tgl-match: add cs42l43
 and cs35l56 support
Message-Id: <170178191427.32878.1882562725490078312.b4-ty@kernel.org>
Date:   Tue, 05 Dec 2023 13:11:54 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Dec 2023 13:56:14 +0000, Richard Fitzgerald wrote:
> This is a test configuration for UpExtreme with Cirrus Logic
> CS35L56-EIGHT-C board.
> 
> The codec layout is configured as:
>     - Link3: CS42L43 Jack
>     - Link0: 2x CS35L56 Speaker (amps 1 and 2)
>     - Link1: 2x CS35L56 Speaker (amps 7 and 8)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: soc-acpi-intel-tgl-match: add cs42l43 and cs35l56 support
      commit: e17999750649c4bd4ba945419b406d1d1a3e92e2

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

