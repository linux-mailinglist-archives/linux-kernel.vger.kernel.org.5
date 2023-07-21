Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB89775C083
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGUHz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGUHz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:55:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7096E0;
        Fri, 21 Jul 2023 00:55:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C8E161575;
        Fri, 21 Jul 2023 07:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD3DC433CB;
        Fri, 21 Jul 2023 07:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689926154;
        bh=W/RkNM0LA5FIGb1qUz9Yr77W0ObcTph4orlH2jwmqyY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=e+57HDZHTD0q/GUnjCakwBVBoc+qFkkhXjO3myoKj8mt7VlEBpr9veGJJlqhtofYN
         XXs3rdUG5Xy1EHVmlcSlCkVGihhAoOitrpKUDcaxJyYxkm0EhtmHKgL4KYnbFCHvCz
         bMhhDAJ5E1GCToR+vFk0vHL99MPim78UiOvv2Evt/FwRtDhd8xRjfl3gijXBA3b4mn
         vUZjAXPshYhaWLWl49u6IsZmhMnDjnrk6MoH4WN5UipTsX7WmXd5RSCny7arzN4429
         TBsm4TuZ1cANfF+00lhIH5cQ1ZGSxtkqL035SfvTvnW3Bnk1ZAUWUtPNXqJFqIB6V1
         zVeBLZfaVOwfQ==
From:   Lee Jones <lee@kernel.org>
To:     broonie@kernel.org, lee@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        vkoul@kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     robh+dt@kernel.org, conor+dt@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230619095623.1987742-5-ckeepax@opensource.cirrus.com>
References: <20230619095623.1987742-1-ckeepax@opensource.cirrus.com>
 <20230619095623.1987742-5-ckeepax@opensource.cirrus.com>
Subject: Re: (subset) [PATCH v5 4/6] pinctrl: cs42l43: Add support for the
 cs42l43
Message-Id: <168992615117.1924396.3669045288825154363.b4-ty@kernel.org>
Date:   Fri, 21 Jul 2023 08:55:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2023 10:56:21 +0100, Charles Keepax wrote:
> The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
> for portable applications. It provides a high dynamic range, stereo
> DAC for headphone output, two integrated Class D amplifiers for
> loudspeakers, and two ADCs for wired headset microphone input or
> stereo line input. PDM inputs are provided for digital microphones.
> 
> [...]

Applied, thanks!

[4/6] pinctrl: cs42l43: Add support for the cs42l43
      commit: 85f034dd7ff0a66aded653cc91dbc406fba7cf1a

--
Lee Jones [李琼斯]

