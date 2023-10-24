Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85737D4C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbjJXJ1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbjJXJ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:26:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C24170D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:26:26 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 51CEE66072F6;
        Tue, 24 Oct 2023 10:26:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698139584;
        bh=eyPjnlFwB9ESs7GpmfTaYODwRkcUD8KIZ9RhyRcSESQ=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=hO+1C/+jaErCZfqqRqqHjQGulYk7w+MiPuEXZESWII4l4TeGM2pBldxFcFW19gn7B
         3YChhT37kbYsi+kfHnsit30kt4IUo9mBODAXgp78Wlzadhrwjvm1Hr5cOO/6yTC/bz
         N5vyzsgTOZ4Bh7A95FqPVDljYsgfape72asxOLXeDr19EIQwmAbxs/eH/1VYMZqvTp
         DGwamU3f8Ctw26km+JgtI8tRE38IGmSAEvbjzNSiE3NCltwidvqAMTg5mp9NLmnxAv
         lvsJGdFGEA78M9JGVMuOuh16RFwI7zRje8UKg67zYb9is2oAQzPjTjRmitabihpUpm
         5EeTQZD9eOUVQ==
Message-ID: <1d524b37-f95a-4f36-b78a-dcf865c1a922@collabora.com>
Date:   Tue, 24 Oct 2023 11:26:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ASoC: mediatek: mt7986: remove the
 mt7986_wm8960_priv structure
Content-Language: en-US
To:     Maso Huang <maso.huang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231024035019.11732-1-maso.huang@mediatek.com>
 <20231024035019.11732-3-maso.huang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231024035019.11732-3-maso.huang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/10/23 05:50, Maso Huang ha scritto:
> Remove the mt7986_wm8960_priv structure.
> 
> Signed-off-by: Maso Huang <maso.huang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

